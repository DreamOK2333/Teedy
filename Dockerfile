FROM sismics/ubuntu-jetty:9.4.36
LABEL maintainer="b.gamard@sismics.com"

ENV DEBIAN_FRONTEND=noninteractive

# 更换镜像源为阿里云的 Ubuntu 镜像源
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirrors.aliyun.com/ubuntu/|g' /etc/apt/sources.list

# 更新和安装初始包
RUN apt-get update && \
    apt-get -y -q --no-install-recommends install ffmpeg mediainfo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装 tesseract-ocr 和其他 OCR 语言包
RUN apt-get update && \
    apt-get -y -q --no-install-recommends install tesseract-ocr && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 安装其他语言包
RUN apt-get update && \
    apt-get -y -q --no-install-recommends install \
    tesseract-ocr-ara \
    tesseract-ocr-ces \
    tesseract-ocr-chi-sim \
    tesseract-ocr-chi-tra && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get -y -q --no-install-recommends install \
    tesseract-ocr-dan \
    tesseract-ocr-deu \
    tesseract-ocr-fin \
    tesseract-ocr-fra && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 继续安装其余的 OCR 语言包
RUN apt-get update && \
    apt-get -y -q --no-install-recommends install \
    tesseract-ocr-heb \
    tesseract-ocr-hin \
    tesseract-ocr-hun \
    tesseract-ocr-ita \
    tesseract-ocr-jpn \
    tesseract-ocr-kor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get -y -q --no-install-recommends install \
    tesseract-ocr-lav \
    tesseract-ocr-nld \
    tesseract-ocr-nor \
    tesseract-ocr-pol \
    tesseract-ocr-por \
    tesseract-ocr-rus \
    tesseract-ocr-spa \
    tesseract-ocr-swe \
    tesseract-ocr-tha \
    tesseract-ocr-tur \
    tesseract-ocr-ukr \
    tesseract-ocr-vie && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 删除嵌入的 javax.mail jar 文件
RUN rm -f /opt/jetty/lib/mail/javax.mail.glassfish-*.jar

# 添加 web 应用程序文件
ADD docs.xml /opt/jetty/webapps/docs.xml
ADD docs-web/target/docs-web-*.war /opt/jetty/webapps/docs.war

ENV JAVA_OPTIONS -Xmx1g
