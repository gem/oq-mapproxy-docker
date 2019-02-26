# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4
# vim: syntax=dockerfile
#
# oq-mapproxy-docker
# Copyright (C) 2018 GEM Foundation
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

# Stay on F29 since we want Python 3.6 (MapProxy 1.11 not working with Python 3.7)
FROM fedora:29
MAINTAINER Daniele Viganò <daniele@openquake.org>

ARG uid=1000

RUN mkdir /opt/mapproxy && \
    pip3 --disable-pip-version-check install \
        http://cdn.ftp.openquake.org/wheelhouse/linux/py37/setproctitle-1.1.10-cp37-cp37m-manylinux1_x86_64.whl \
        http://cdn.ftp.openquake.org/wheelhouse/linux/py37/pyproj-1.9.5.1-cp37-cp37m-manylinux1_x86_64.whl \
        http://cdn.ftp.openquake.org/wheelhouse/linux/py37/PyYAML-3.13-cp37-cp37m-manylinux1_x86_64.whl \
        gunicorn \
        https://github.com/mapproxy/mapproxy/archive/master.zip

USER $uid

WORKDIR /opt/mapproxy
ADD run-mapproxy.sh .
ADD config.py .

EXPOSE 8080 

CMD ["./run-mapproxy.sh"]
