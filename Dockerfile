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
FROM fedora:27
MAINTAINER Daniele Viganò <daniele@openquake.org>

ARG uid=1000

RUN useradd -u $uid mapproxy
USER mapproxy
ENV PATH /home/mapproxy/.local/bin:$PATH

RUN pip3 --disable-pip-version-check install --user \
        http://cdn.ftp.openquake.org/wheelhouse/linux/py36/setproctitle-1.1.10-cp36-cp36m-manylinux1_x86_64.whl
        http://cdn.ftp.openquake.org/wheelhouse/linux/py36/PyYAML-3.12-cp36-cp36m-manylinux1_x86_64.whl \
        http://cdn.ftp.openquake.org/wheelhouse/linux/py36/pyproj-1.9.5.1-cp36-cp36m-manylinux1_x86_64.whl \
        gunicorn \
        MapProxy

ADD run-mapproxy.sh .
ADD config.py .
EXPOSE 8080 
CMD ["./run-mapproxy.sh"]
