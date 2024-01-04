FROM python:3

RUN adduser --uid 1000 antonio

USER antonio

RUN pip3 install ansible ansible-lint ansible-navigator

ENV PATH="/home/antonio/.local/bin:$PATH"
 
ENTRYPOINT ["/bin/bash", "-c"]