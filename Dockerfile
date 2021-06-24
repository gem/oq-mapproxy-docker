# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4
# vim: syntax=dockerfile
#
# oq-mapproxy-docker
# Copyright (C) 2018-2022 GEM Foundation
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

FROM fedora:31
LABEL maintainer="GEM Foundation <devops@openquake.org>"

ARG uid=1000
ARG pkg=MapProxy

RUN dnf install -y proj python3-pip && dnf clean all && \
    mkdir /opt/mapproxy && \
    pip3 --disable-pip-version-check install \
        https://wheelhouse.openquake.org/v3/linux/py37/setproctitle-1.1.10-cp37-cp37m-manylinux1_x86_64.whl \
        gunicorn \
        $pkg

USER $uid

WORKDIR /opt/mapproxy
ADD run-mapproxy.sh .
ADD config.py .

EXPOSE 8080 

CMD ["./run-mapproxy.sh"]
