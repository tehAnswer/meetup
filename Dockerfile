FROM ruby:2.5.0-alpine
RUN \
  apk update && \
  apk add libffi-dev build-base
RUN mkdir -p /opt/meetup
WORKDIR /opt/meetup
ADD . ./
RUN bundle install
ENV COORDINATES "53.339428, -6.257664"
RUN rake invite[100]