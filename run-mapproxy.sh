#!/bin/bash
# -*- coding: utf-8 -*-
# vim: tabstop=4 shiftwidth=4 softtabstop=4
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

if [ "$MAPPROXY_DEV" ]; then
    exec mapproxy-util serve-multiapp-develop -b :8080 /io/conf
else
    exec gunicorn -k ${MAPPROXY_WORKER:-gthread} -t 300 -w ${MAPPROXY_CPU:-`grep -c ^processor /proc/cpuinfo`} -b :8080 config:application --no-sendfile
fi
