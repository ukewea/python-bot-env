FROM python:3.9-alpine AS initial

MAINTAINER wuuker <https://github.com/ukewea>

# Install NumPy, TA-Lib
RUN apk update && \
  apk add musl-dev wget git build-base linux-headers libstdc++ && \
  \
  pip install cython && \
  ln -s /usr/include/locale.h /usr/include/xlocale.h && \
  pip install numpy
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ARCH=`uname -m` && \
  if [ "$ARCH" == "aarch64" ]; then \
    ./configure --prefix=/usr --build=arm-linux; \
  else \
    ./configure --prefix=/usr; \
  fi && \
  make && \
  make install
RUN pip install TA-Lib python-binance unicorn-binance-websocket-api python-telegram-bot pygsheets pandas backtrader
RUN cd .. && rm -rf ta-lib-0.4.0-src.tar.gz ta-lib
RUN apk del musl-dev wget git build-base linux-headers

FROM python:3.9-alpine
COPY --from=initial / /

WORKDIR /app
CMD ["/app/get_data.py"]
ENTRYPOINT ["python"]

