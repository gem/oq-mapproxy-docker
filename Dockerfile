# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4
# vim: syntax=dockerfile
#
# oq-mapproxy-docker
# Copyright (C) 2018-2021 GEM Foundation
#
# oq-mapproxy-docker is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# oq-mapproxy-docker is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM python:3.9-slim
LABEL maintainer="GEM Foundation <devops@openquake.org>"

ARG uid=1000
ARG pkg=MapProxy

RUN apt update && apt install -y proj-bin && apt clean \
    && mkdir /opt/mapproxy \
    && pip3 --disable-pip-version-check install \
          setproctitle \
          gunicorn \
          pyproj \
          $pkg

USER $uid

WORKDIR /opt/mapproxy
ADD run-mapproxy.sh .
ADD config.py .

EXPOSE 8080 

CMD ["./run-mapproxy.sh"]
