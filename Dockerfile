FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim

COPY /app /app
COPY *.jpg /

WORKDIR /app
RUN apt update &&\
    apt install -y tesseract-ocr g++ cmake libmagickwand-dev libgl1-mesa-glx &&\
    pip install --upgrade pip &&\
    pip install -r requirement.txt

WORKDIR /app/imgtxtenh
RUN cmake CMakeLists.txt -DCMAKE_BUILD_TYPE=Release &&\
    make

WORKDIR /
ENTRYPOINT ["sh","start.sh"]