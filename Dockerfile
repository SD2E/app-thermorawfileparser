FROM mono:6.6.0

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN git clone -b master --single-branch https://github.com/compomics/ThermoRawFileParser /src && \
    cd /src && \
    msbuild && \
    sed -i 's/\/home\/biodocker\/bin/\/src/' /src/ThermoRawFileParser && \
    chmod +x /src/ThermoRawFileParser

ENV PATH "/src:$PATH"

CMD ["ThermoRawFileParser", "-h"]


