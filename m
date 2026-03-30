Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5AE55A
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861762; cv=none; b=GwRGjU4WFPHVgaJl9TfjMsIyYjVxn8wy0UghCRo6/WdsNH03b+HB0d48ImKcYxkDtuZSYmbmuaFwXcRt9haRZ1nmNHwa4XOz6o47RrlDRGK5BxKXojB0hvf+j9fEKHad27RtH3gdEmJU8KCoP3bdQbq5nDFq5HjwNOE6xYzL3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861762; c=relaxed/simple;
	bh=Z/kENBths+/FjXyKOTgI6TkuADM3jv+FC2b+0aB93O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jONGE1bORQ40LfQpoAdKExCRGY6cepR43u+zNEw85lQWtVPnAWky/i+H5zHnNfrE8Z85v4ZBrjWopf+FmlxqzZv+omEuBuz4UZLVD64FEF4F49YDy0eWdxWGzLvKO8GEByPEj28yUrDLhq2I0b8uOrH7+l+1RMa3J7bYub28r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2LhHrXga; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VWF1YwuT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qG41MlWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZT+08ekH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2LhHrXga";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VWF1YwuT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qG41MlWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZT+08ekH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E8745BCFF;
	Mon, 30 Mar 2026 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774861743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhHxD+GWynE6a9go1xJ4ogKLVqhoWN5r9VLsM9t9HGM=;
	b=2LhHrXgat+Y3GovD3li3MXvXGj2VYbkLsgB5NZcihWOrBNqd/y0F2l5Rsh8BpB0oykDFxA
	3G0RpuzqdJdvWc9fuVXUGuJfOT+tO1CXYpg0yR5A9Ad+Rb4JWokl34M6jFO4ye4fuivcLr
	43vLojQxX6f66ko8r8Qqq5EJ1b3FDi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774861743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhHxD+GWynE6a9go1xJ4ogKLVqhoWN5r9VLsM9t9HGM=;
	b=VWF1YwuTHKwoLUI5VlrlpX+jvyMCCymfmy3nLmfVqEXpRH5J5miVBEcQBmT2Xd0rFNHPa/
	wxnem9ZM3vOf0WDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qG41MlWe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZT+08ekH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774861742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhHxD+GWynE6a9go1xJ4ogKLVqhoWN5r9VLsM9t9HGM=;
	b=qG41MlWeIRVVvzMhXGDWcbycqkukKNQbhDvOxWgRGOe76F1VDNYdd95X7ndRYRlmeFeK51
	eOh3eNBkT4mzAfX51sM8xtfN6pQaTa7G9INgJv3iqcoQrVSnNvWng5Pl7I+Kr/9oB360PN
	bqGqlxC9Vw2L9MrjEd5uLZVA5bGQutI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774861742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhHxD+GWynE6a9go1xJ4ogKLVqhoWN5r9VLsM9t9HGM=;
	b=ZT+08ekHXNQQCoO1CMT4ukpUshozfws/1rFrMOnP9G9PbAnOyDGLZdETZOd5vp+9ni5ePw
	mXgb24Pl97hIymDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E69FC4A0B1;
	Mon, 30 Mar 2026 09:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2BtnNq09ymnvDAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 09:09:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	helena.anna.dubel@intel.com,
	tomasz.ossowski@intel.com,
	Piotr Kubaj <piotr.kubaj@intel.com>,
	automated-testing@lists.yoctoproject.org
Subject: [PATCH v2 2/2] power_management: Remove unused tools
Date: Mon, 30 Mar 2026 11:08:43 +0200
Message-ID: <20260330090844.79598-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330090844.79598-1-pvorel@suse.cz>
References: <20260330090844.79598-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[to_ip_from(RL9hby1rshmenoep4g4mwnfqt6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm_include.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email,test.sh:url]
X-Rspamd-Queue-Id: 6E8745BCFF
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Remove now unneeded tools and functions from pm_include.sh (see previous commit).
Also move functions from pm_include.sh used only in single shell script to it.

This removes the rest of python code in power management tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/power_management/Makefile    |   2 +-
 .../kernel/power_management/lib/Makefile      |  25 -
 .../power_management/lib/pm_sched_mc.py       | 835 ------------------
 .../kernel/power_management/pm_ilb_test.py    |  57 --
 .../kernel/power_management/pm_include.sh     | 311 +------
 .../power_management/pm_sched_domain.py       |  54 --
 .../kernel/power_management/runpwtests03.sh   |  10 +
 .../kernel/power_management/runpwtests06.sh   |  31 +
 8 files changed, 43 insertions(+), 1282 deletions(-)
 delete mode 100644 testcases/kernel/power_management/lib/Makefile
 delete mode 100755 testcases/kernel/power_management/lib/pm_sched_mc.py
 delete mode 100755 testcases/kernel/power_management/pm_ilb_test.py
 delete mode 100755 testcases/kernel/power_management/pm_sched_domain.py

diff --git a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile
index 935f47eea1..4357bd9c29 100644
--- a/testcases/kernel/power_management/Makefile
+++ b/testcases/kernel/power_management/Makefile
@@ -26,4 +26,4 @@ INSTALL_TARGETS 	:= *.py *.sh
 
 MAKE_DEPS		+= $(APICMDS_DIR)/tst_kvercmp
 
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/power_management/lib/Makefile b/testcases/kernel/power_management/lib/Makefile
deleted file mode 100644
index 2aadac0a5b..0000000000
--- a/testcases/kernel/power_management/lib/Makefile
+++ /dev/null
@@ -1,25 +0,0 @@
-#
-# Copyright (c) 2015 Fujitsu Ltd.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-
-top_srcdir 		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS 	:= *.py
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/power_management/lib/pm_sched_mc.py b/testcases/kernel/power_management/lib/pm_sched_mc.py
deleted file mode 100755
index 743b6debf3..0000000000
--- a/testcases/kernel/power_management/lib/pm_sched_mc.py
+++ /dev/null
@@ -1,835 +0,0 @@
-#!/usr/bin/env python3
-''' Reusable functions related to sched mc FVT are put together
-'''
-
-import os
-import sys
-import re
-from time import time
-
-__author__ = "Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>"
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-
-cpu_map = {}
-stats_start = {}
-stats_stop = {}
-stats_percentage = {}
-intr_start = []
-intr_stop = []
-cpu_count = 0
-socket_count = 0
-cpu1_max_intr = 0
-cpu2_max_intr = 0
-intr_stat_timer_0 = []
-siblings_list = []
-
-def clear_dmesg():
-    '''
-       Clears dmesg
-    '''
-    try:
-        os.system('dmesg -c >/dev/null')
-    except OSError as e:
-        print('Clearing dmesg failed', e)
-        sys.exit(1)
-
-def count_num_cpu():
-    ''' Returns number of cpu's in system
-    '''
-    try:
-        cpuinfo = open('/proc/cpuinfo', 'r')
-        global cpu_count
-        for line in cpuinfo:
-            if line.startswith('processor'):
-                cpu_count += 1
-        cpuinfo.close()
-    except IOError as e:
-        print("Could not get cpu count", e)
-        sys.exit(1)
-
-def count_num_sockets():
-    ''' Returns number of cpu's in system
-    '''
-    socket_list = []
-    global socket_count
-    try:
-        for i in range(0, cpu_count):
-            phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
-            phy_pkg_file += '/topology/physical_package_id'
-            socket_id = open(phy_pkg_file).read().rstrip()
-            if socket_id not in socket_list:
-                socket_list.append(socket_id)
-                socket_count = socket_count + 1
-    except Exception as details:
-        print("INFO: Failed to get number of sockets in system", details)
-        sys.exit(1)
-
-def is_multi_socket():
-    '''Return 1 if the system is multi socket else return 0
-    '''
-    try:
-        if socket_count > 1:
-            return 1
-        else:
-            return 0
-    except Exception:
-        print("Failed to check if system is multi socket system")
-        sys.exit(1)
-
-def is_hyper_threaded():
-    '''Return 1 if the system is hyper threaded else return 0
-    '''
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-        if int( siblings[1] ) / int( cpu_cores[1] )> 1:
-            file_cpuinfo.close()
-            return 1
-        else:
-            return 0
-    except Exception:
-        print("Failed to check if system is hyper-threaded")
-        sys.exit(1)
-
-def is_multi_core():
-    ''' Return true if system has sockets has multiple cores
-    '''
-
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-
-        if int( siblings[1] ) == int( cpu_cores[1] ):
-            if int( cpu_cores[1] ) > 1:
-                multi_core = 1
-            else:
-                multi_core = 0
-        else:
-            num_of_cpus = int(siblings[1]) / int(cpu_cores[1])
-            if num_of_cpus > 1:
-                multi_core = 1
-            else:
-                multi_core = 0
-        file_cpuinfo.close()
-        return multi_core
-    except Exception:
-        print("Failed to check if system is multi core system")
-        sys.exit(1)
-
-def get_hyper_thread_count():
-    ''' Return number of threads in CPU. For eg for x3950 this function
-        would return 2. In future if 4 threads are supported in CPU, this
-        routine would return 4
-    '''
-    try:
-        file_cpuinfo = open("/proc/cpuinfo", 'r')
-        for line in file_cpuinfo:
-            if line.startswith('siblings'):
-                siblings = line.split(":")
-            if line.startswith('cpu cores'):
-                cpu_cores = line.split(":")
-                break
-        return( int( siblings[1] ) / int( cpu_cores[1] ) )
-    except Exception:
-        print("Failed to check if system is hyper-threaded")
-        sys.exit(1)
-
-def map_cpuid_pkgid():
-    ''' Routine to map physical package id to cpu id
-    '''
-    if is_hyper_threaded():
-        core_info = {}
-        try:
-            for i in range(0, cpu_count):
-                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' % i
-                phy_pkg_file += '/topology/physical_package_id'
-                core_file = '/sys/devices/system/cpu/cpu%s' % i
-                core_file += '/topology/core_id'
-                core_id = open(core_file).read().rstrip()
-                cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in list(cpu_map.keys()):
-                    core_info = {}
-                else:
-                    core_info = cpu_map[cpu_phy_id]
-                if not core_id in list(core_info.keys()):
-                    core_info[core_id] = [i]
-                else:
-                    core_info[core_id].append(i)
-                cpu_map[cpu_phy_id] = core_info
-        except Exception as details:
-            print("Package, core & cpu map table creation failed", e)
-            sys.exit(1)
-    else:
-        for i in range(0, cpu_count):
-            try:
-                phy_pkg_file = '/sys/devices/system/cpu/cpu%s' %i
-                phy_pkg_file += '/topology/physical_package_id'
-                cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in list(cpu_map.keys()):
-                    cpu_map[cpu_phy_id] = [i]
-                else:
-                    cpu_map[cpu_phy_id].append(i)
-            except IOError as e:
-                print("Mapping of CPU to pkg id failed", e)
-                sys.exit(1)
-
-
-def generate_sibling_list():
-    ''' Routine to generate siblings list
-    '''
-    try:
-        for i in range(0, cpu_count):
-            siblings_file = '/sys/devices/system/cpu/cpu%s' % i
-            siblings_file += '/topology/thread_siblings_list'
-            threads_sibs = open(siblings_file).read().rstrip()
-            thread_ids = threads_sibs.split("-")
-
-            if not thread_ids in siblings_list:
-                siblings_list.append(thread_ids)
-    except Exception as details:
-        print("Exception in generate_siblings_list", details)
-        sys.exit(1)
-
-def get_siblings(cpu_id):
-    ''' Return siblings of cpu_id
-    '''
-    try:
-        cpus = ""
-        for i in range(0, len(siblings_list)):
-            for cpu in siblings_list[i]:
-                if cpu_id == cpu:
-                    for j in siblings_list[i]:
-                        # Exclude cpu_id in the list of siblings
-                        if j != cpu_id:
-                            cpus += j
-                    return cpus
-        return cpus
-    except Exception as details:
-        print("Exception in get_siblings", details)
-        sys.exit(1)
-
-def get_proc_data(stats_list):
-    ''' Read /proc/stat info and store in dictionary
-    '''
-    try:
-        file_procstat = open("/proc/stat", 'r')
-        for line in file_procstat:
-            if line.startswith('cpu'):
-                data = line.split()
-                stats_list[data[0]] = data
-        file_procstat.close()
-    except OSError as e:
-        print("Could not read statistics", e)
-        sys.exit(1)
-
-def get_proc_loc_count(loc_stats):
-    ''' Read /proc/interrupts info and store in list
-    '''
-    try:
-        file_procstat = open("/proc/interrupts", 'r')
-        for line in file_procstat:
-            if line.startswith(' LOC:') or line.startswith('LOC:'):
-                data = line.split()
-                for i in range(0, cpu_count):
-                    # To skip LOC
-                    loc_stats.append(data[i+1])
-                file_procstat.close()
-                return
-    except Exception as details:
-        print("Could not read interrupt statistics", details)
-        sys.exit(1)
-
-
-def set_sched_mc_power(sched_mc_level):
-    ''' Routine to set sched_mc_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null'
-            % sched_mc_level)
-
-        get_proc_data(stats_start)
-    except OSError as e:
-        print("Could not set sched_mc_power_savings to", sched_mc_level, e)
-    sys.exit(1)
-
-def set_sched_smt_power(sched_smt_level):
-    ''' Routine to set sched_smt_power_savings to required level
-    '''
-    try:
-        os.system('echo %s > \
-            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null'
-            % sched_smt_level)
-
-        get_proc_data(stats_start)
-    except OSError as e:
-        print("Could not set sched_smt_power_savings to", sched_smt_level, e)
-    sys.exit(1)
-
-def set_timer_migration_interface(value):
-    ''' Set value of timer migration interface to a value
-        passed as argument
-    '''
-    try:
-        os.system('echo %s > \
-            /proc/sys/kernel/timer_migration 2>/dev/null' % value)
-    except OSError as e:
-        print("Could not set timer_migration to ", value, e)
-        sys.exit(1)
-
-def get_job_count(stress, workload, sched_smt):
-    ''' Returns number of jobs/threads to be triggered
-    '''
-
-    try:
-        if stress == "thread":
-            threads = get_hyper_thread_count()
-        if stress == "partial":
-            threads = cpu_count / socket_count
-            if is_hyper_threaded():
-                if workload == "ebizzy" and int(sched_smt) ==0:
-                    threads = threads / get_hyper_thread_count()
-                if workload == "kernbench" and int(sched_smt) < 2:
-                    threads = threads / get_hyper_thread_count()
-        if stress == "full":
-            threads = cpu_count
-        if stress == "single_job":
-            threads = 1
-            duration = 180
-        return threads
-    except Exception as details:
-        print("get job count failed ", details)
-        sys.exit(1)
-
-def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
-    ''' Triggers ebizzy workload for sched_mc=1
-        testing
-    '''
-    try:
-        threads = get_job_count(stress, "ebizzy", sched_smt)
-        workload = "ebizzy"
-        olddir = os.getcwd()
-        path = '%s/testcases/bin' % os.environ['LTPROOT']
-        os.chdir(path)
-        workload_file = ""
-        for file_name in os.listdir('.'):
-            if file_name == workload:
-                workload_file = file_name
-                break
-        if workload_file == "":
-            print("INFO: ebizzy benchmark not found")
-            os.chdir(olddir)
-            sys.exit(1)
-        get_proc_data(stats_start)
-        get_proc_loc_count(intr_start)
-        try:
-            if background == "yes":
-                succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
-                    % (threads, duration))
-            else:
-                if pinned == "yes":
-                    succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null'
-                        % (cpu_count -1, threads, duration))
-                else:
-                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
-                        % (threads, duration))
-
-            if succ == 0:
-                print("INFO: ebizzy workload triggerd")
-                os.chdir(olddir)
-                #Commented bcoz it doesnt make sense to capture it when workload triggered
-                #in background
-                #get_proc_loc_count(intr_stop)
-                #get_proc_data(stats_stop)
-            else:
-                print("INFO: ebizzy workload triggerd failed")
-                os.chdir(olddir)
-                sys.exit(1)
-        except Exception as details:
-            print("Ebizzy workload trigger failed ", details)
-            sys.exit(1)
-    except Exception as details:
-        print("Ebizzy workload trigger failed ", details)
-        sys.exit(1)
-
-def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
-    ''' Trigger load on system like kernbench.
-        Copys existing copy of LTP into as LTP2 and then builds it
-        with make -j
-    '''
-    olddir = os.getcwd()
-    try:
-        threads = get_job_count(stress, "kernbench", sched_smt)
-
-        dst_path = "/root"
-        workload = "kernbench"
-        olddir = os.getcwd()
-        path = '%s/testcases/bin' % os.environ['LTPROOT']
-        os.chdir(path)
-        workload_file = ""
-        for file_name in os.listdir('.'):
-            if file_name == workload:
-                workload_file = file_name
-                break
-        if workload_file != "":
-            benchmark_path = path
-        else:
-            print("INFO: kernbench benchmark not found")
-            os.chdir(olddir)
-            sys.exit(1)
-
-        os.chdir(dst_path)
-        linux_source_dir=""
-        for file_name in os.listdir('.'):
-            if file_name.find("linux-2.6") != -1 and os.path.isdir(file_name):
-                linux_source_dir=file_name
-                break
-        if linux_source_dir != "":
-            os.chdir(linux_source_dir)
-        else:
-            print("INFO: Linux kernel source not found in /root. Workload\
-               Kernbench cannot be executed")
-            sys.exit(1)
-
-        get_proc_data(stats_start)
-        get_proc_loc_count(intr_start)
-        if pinned == "yes":
-            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 \
-                >/dev/null 2>&1 &' % (cpu_count-1, benchmark_path, threads))
-
-            # We have to delete import in future
-            import time
-            time.sleep(240)
-            stop_wkld("kernbench")
-        else:
-            if background == "yes":
-                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
-                    % (benchmark_path, threads))
-            else:
-                if perf_test == "yes":
-                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
-                        % (benchmark_path, threads))
-                else:
-                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
-                        % (benchmark_path, threads))
-                    # We have to delete import in future
-                    import time
-                    time.sleep(240)
-                    stop_wkld("kernbench")
-
-        print("INFO: Workload kernbench triggerd")
-        os.chdir(olddir)
-    except Exception as details:
-        print("Workload kernbench trigger failed ", details)
-        sys.exit(1)
-
-def trigger_workld(sched_smt, workload, stress, duration, background, pinned, perf_test):
-    ''' Triggers workload passed as argument. Number of threads
-        triggered is based on stress value.
-    '''
-    try:
-        if workload == "ebizzy":
-            trigger_ebizzy (sched_smt, stress, duration, background, pinned)
-        if workload == "kernbench":
-            trigger_kernbench (sched_smt, stress, background, pinned, perf_test)
-    except Exception as details:
-        print("INFO: Trigger workload failed", details)
-        sys.exit(1)
-
-def generate_report():
-    ''' Generate report of CPU utilization
-    '''
-    cpu_labels = ('cpu', 'user', 'nice', 'system', 'idle', 'iowait', 'irq',
-	'softirq', 'x', 'y')
-    if (not os.path.exists('/procstat')):
-        os.mkdir('/procstat')
-
-    get_proc_data(stats_stop)
-
-    reportfile = open('/procstat/cpu-utilisation', 'a')
-    debugfile = open('/procstat/cpu-utilisation.debug', 'a')
-    for l in stats_stop:
-        percentage_list = []
-        total = 0
-        for i in range(1, len(stats_stop[l])):
-            stats_stop[l][i] =  int(stats_stop[l][i]) - int(stats_start[l][i])
-            total += stats_stop[l][i]
-        percentage_list.append(l)
-        for i in range(1, len(stats_stop[l])):
-            percentage_list.append(float(stats_stop[l][i])*100/total)
-
-        stats_percentage[l] = percentage_list
-
-    for i in range(0, len(cpu_labels)):
-        print(cpu_labels[i], '\t', end=' ', file=debugfile)
-    print(file=debugfile)
-    for l in sorted(stats_stop.keys()):
-        print(l, '\t', end=' ', file=debugfile)
-        for i in range(1, len(stats_stop[l])):
-            print(stats_stop[l][i], '\t', end=' ', file=debugfile)
-        print(file=debugfile)
-
-    for i in range(0, len(cpu_labels)):
-        print(cpu_labels[i], '\t', end=' ', file=reportfile)
-    print(file=reportfile)
-    for l in sorted(stats_percentage.keys()):
-        print(l, '\t', end=' ', file=reportfile)
-        for i in range(1, len(stats_percentage[l])):
-            print(" %3.4f" % stats_percentage[l][i], end=' ', file=reportfile)
-        print(file=reportfile)
-
-    #Now get the package ID information
-    try:
-        print("cpu_map: ", cpu_map, file=debugfile)
-        keyvalfile = open('/procstat/keyval', 'a')
-        print("nr_packages=%d" % len(cpu_map), file=keyvalfile)
-        print("system-idle=%3.4f" % (stats_percentage['cpu'][4]), file=keyvalfile)
-        for pkg in sorted(cpu_map.keys()):
-            if is_hyper_threaded():
-                for core in sorted(cpu_map[pkg].keys()):
-                    total_idle = 0
-                    total = 0
-                    for cpu in cpu_map[pkg][core]:
-                        total_idle += stats_stop["cpu%d" % cpu][4]
-                        for i in range(1, len(stats_stop["cpu%d" % cpu])):
-                            total += stats_stop["cpu%d" % cpu][i]
-            else:
-                total_idle = 0
-                total = 0
-                for cpu in cpu_map[pkg]:
-                    total_idle += stats_stop["cpu%d" % cpu][4]
-                    for i in range(1, len(stats_stop["cpu%d" % cpu])):
-                        total += stats_stop["cpu%d" % cpu][i]
-            print("Package: ", pkg, "Idle %3.4f%%" \
-	        % (float(total_idle)*100/total), file=reportfile)
-            print("package-%s=%3.4f" % \
-		(pkg, (float(total_idle)*100/total)), file=keyvalfile)
-    except Exception as details:
-        print("Generating utilization report failed: ", details)
-        sys.exit(1)
-
-    #Add record delimiter '\n' before closing these files
-    print(file=debugfile)
-    debugfile.close()
-    print(file=reportfile)
-    reportfile.close()
-    print(file=keyvalfile)
-    keyvalfile.close()
-
-def generate_loc_intr_report():
-    ''' Generate interrupt report of CPU's
-    '''
-    try:
-        if (not os.path.exists('/procstat')):
-            os.mkdir('/procstat')
-
-        get_proc_loc_count(intr_stop)
-
-        reportfile = open('/procstat/cpu-loc_interrupts', 'a')
-        print("==============================================", file=reportfile)
-        print("     Local timer interrupt stats              ", file=reportfile)
-        print("==============================================", file=reportfile)
-
-        for i in range(0, cpu_count):
-            intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
-            print("CPU%s: %s" %(i, intr_stop[i]), file=reportfile)
-        print(file=reportfile)
-        reportfile.close()
-    except Exception as details:
-        print("Generating interrupt report failed: ", details)
-        sys.exit(1)
-
-def record_loc_intr_count():
-    ''' Record Interrupt statistics when timer_migration
-        was disabled
-    '''
-    try:
-        global intr_start, intr_stop
-        for i in range(0, cpu_count):
-            intr_stat_timer_0.append(intr_stop[i])
-        intr_start = []
-        intr_stop = []
-    except Exception as details:
-        print("INFO: Record interrupt statistics when timer_migration=0",details)
-
-def expand_range(range_val):
-    '''
-       Expand the range of value into actual numbers
-    '''
-    ids_list = list()
-    try:
-        sep_comma = range_val.split(",")
-        for i in range(0, len(sep_comma)):
-            hyphen_values = sep_comma[i].split("-")
-            if len(hyphen_values) == 1:
-                ids_list.append(int(hyphen_values[0]))
-            else:
-                for j in range(int(hyphen_values[0]), int(hyphen_values[1])+1):
-                    ids_list.append(j)
-        return(ids_list)
-    except Exception as details:
-        print("INFO: expand_pkg_grps failed ", details)
-
-def is_quad_core():
-    '''
-       Read /proc/cpuinfo and check if system is Quad core
-    '''
-    try:
-        cpuinfo = open('/proc/cpuinfo', 'r')
-        for line in cpuinfo:
-            if line.startswith('cpu cores'):
-                cores = line.split("cpu cores")
-                num_cores = cores[1].split(":")
-                cpuinfo.close()
-                if int(num_cores[1]) == 4:
-                    return(1)
-                else:
-                    return(0)
-    except IOError as e:
-        print("Failed to get cpu core information", e)
-        sys.exit(1)
-
-def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
-    '''
-       Verify if cpugrp belong to same package
-    '''
-    modi_cpu_grp = cpu_group[:]
-    try:
-        if is_hyper_threaded():
-            for pkg in sorted(cpu_map.keys()):
-                # if CPU utilized is across package this condition will be true
-                if len(modi_cpu_grp) != len(cpu_group):
-                    break
-                for core in sorted(cpu_map[pkg].keys()):
-                    core_cpus = cpu_map[pkg][core]
-                    if core_cpus == modi_cpu_grp:
-                        return 0
-                    else:
-                        #if CPUs used across the cores
-                        for i in range(0, len(core_cpus)):
-                            if core_cpus[i] in modi_cpu_grp:
-                                modi_cpu_grp.remove(core_cpus[i])
-                                if len(modi_cpu_grp) == 0:
-                                    return 0
-                            #This code has to be deleted
-                            #else:
-                                # If sched_smt == 0 then its oky if threads run
-                                # in different cores of same package
-                                #if sched_smt_level > 0 :
-                                    #return 1
-        else:
-            for pkg in sorted(cpu_map.keys()):
-                pkg_cpus = cpu_map[pkg]
-                if len(cpu_group) == len(pkg_cpus):
-                    if pkg_cpus == cpu_group:
-                        return(0)
-                else:
-                    if int(cpus_utilized[0]) in cpu_map[pkg] or int(cpus_utilized[1]) in cpu_map[pkg]:
-                        return(0)
-
-        return(1)
-
-    except Exception as details:
-        print("Exception in validate_cpugrp_map: ", details)
-        sys.exit(1)
-
-
-def verify_sched_domain_dmesg(sched_mc_level, sched_smt_level):
-    '''
-       Read sched domain information from dmesg.
-    '''
-    cpu_group = list()
-    try:
-        dmesg_info = os.popen('dmesg').read()
-        if dmesg_info != "":
-            lines = dmesg_info.split('\n')
-            for i in range(0, len(lines)):
-                if lines[i].endswith('CPU'):
-                    groups = lines[i+1].split("groups:")
-                    group_info = groups[1]
-                    if group_info.find("(") != -1:
-                        openindex=group_info.index("(")
-                        closeindex=group_info.index(")")
-                        group_info=group_info.replace\
-                            (group_info[openindex:closeindex+1],"")
-
-                    subgroup = group_info.split(",")
-                    for j in range(0, len(subgroup)):
-                        cpu_group = expand_range(subgroup[j])
-                        status = validate_cpugrp_map(cpu_group, sched_mc_level,\
-                        sched_smt_level)
-                        if status == 1:
-                            if is_quad_core() == 1:
-                                if int(sched_mc_level) == 0:
-                                    return(0)
-                                else:
-                                    return(1)
-                            else:
-                                return(1)
-            return(0)
-        else:
-            return(1)
-    except Exception as details:
-        print("Reading dmesg failed", details)
-        sys.exit(1)
-
-def get_cpu_utilization(cpu):
-    ''' Return cpu utilization of cpu_id
-    '''
-    try:
-        for l in sorted(stats_percentage.keys()):
-            if cpu == stats_percentage[l][0]:
-                return stats_percentage[l][1]
-        return -1
-    except Exception as details:
-        print("Exception in get_cpu_utilization", details)
-        sys.exit(1)
-
-def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level):
-    ''' Verify if cpu's on which threads executed belong to same
-    package
-    '''
-    cpus_utilized = list()
-    threads = get_job_count(stress, work_ld, sched_smt_level)
-    try:
-        for l in sorted(stats_percentage.keys()):
-            #modify threshold
-            cpu_id = stats_percentage[l][0].split("cpu")
-            if cpu_id[1] == '':
-                continue
-            if int(cpu_id[1]) in cpus_utilized:
-                continue
-            if is_hyper_threaded():
-                if work_ld == "kernbench" and sched_smt_level < sched_mc_level:
-                    siblings = get_siblings(cpu_id[1])
-                    if siblings != "":
-                        sib_list = siblings.split()
-                        utilization = int(stats_percentage[l][1])
-                        for i in range(0, len(sib_list)):
-                            utilization += int(get_cpu_utilization("cpu%s" %sib_list[i]))
-                    else:
-                        utilization = stats_percentage[l][1]
-                    if utilization > 40:
-                        cpus_utilized.append(int(cpu_id[1]))
-                        if siblings != "":
-                            for i in range(0, len(sib_list)):
-                                cpus_utilized.append(int(sib_list[i]))
-                else:
-                    # This threshold wuld be modified based on results
-                    if stats_percentage[l][1] > 40:
-                        cpus_utilized.append(int(cpu_id[1]))
-            else:
-                if work_ld == "kernbench" :
-                    if stats_percentage[l][1] > 50:
-                        cpus_utilized.append(int(cpu_id[1]))
-                else:
-                    if stats_percentage[l][1] > 70:
-                        cpus_utilized.append(int(cpu_id[1]))
-            cpus_utilized.sort()
-        print("INFO: CPU's utilized ", cpus_utilized)
-
-        # If length of CPU's utilized is not = number of jobs exit with 1
-        if len(cpus_utilized) < threads:
-            return 1
-
-        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
-            sched_smt_level)
-        if status == 1:
-            print("INFO: CPUs utilized is not in same package or core")
-
-        return(status)
-    except Exception as details:
-        print("Exception in validate_cpu_consolidation: ", details)
-        sys.exit(1)
-
-def get_cpuid_max_intr_count():
-    '''Return the cpu id's of two cpu's with highest number of intr'''
-    try:
-        highest = 0
-        second_highest = 0
-        cpus_utilized = []
-
-        #Skipping CPU0 as it is generally high
-        for i in range(1, cpu_count):
-            if int(intr_stop[i]) > int(highest):
-                if highest != 0:
-                    second_highest = highest
-                    cpu2_max_intr = cpu1_max_intr
-                highest = int(intr_stop[i])
-                cpu1_max_intr = i
-            else:
-                if int(intr_stop[i]) > int(second_highest):
-                    second_highest = int(intr_stop[i])
-                    cpu2_max_intr = i
-        cpus_utilized.append(cpu1_max_intr)
-        cpus_utilized.append(cpu2_max_intr)
-
-        for i in range(1, cpu_count):
-            if i != cpu1_max_intr and i != cpu2_max_intr:
-                diff = second_highest - intr_stop[i]
-                ''' Threshold of difference has to be manipulated '''
-                if diff < 10000:
-                    print("INFO: Diff in interrupt count is below threshold")
-                    cpus_utilized = []
-                    return cpus_utilized
-        print("INFO: Interrupt count in other CPU's low as expected")
-        return cpus_utilized
-    except Exception as details:
-        print("Exception in get_cpuid_max_intr_count: ", details)
-        sys.exit(1)
-
-def validate_ilb (sched_mc_level, sched_smt_level):
-    ''' Validate if ilb is running in same package where work load is running
-    '''
-    try:
-        cpus_utilized = get_cpuid_max_intr_count()
-        if not cpus_utilized:
-            return 1
-
-        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
-        return status
-    except Exception as details:
-        print("Exception in validate_ilb: ", details)
-        sys.exit(1)
-
-def reset_schedmc():
-    ''' Routine to reset sched_mc_power_savings to Zero level
-    '''
-    try:
-        os.system('echo 0 > \
-            /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null')
-    except OSError as e:
-        print("Could not set sched_mc_power_savings to 0", e)
-        sys.exit(1)
-
-def reset_schedsmt():
-    ''' Routine to reset sched_smt_power_savings to Zero level
-    '''
-    try:
-        os.system('echo 0 > \
-            /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null')
-    except OSError as e:
-        print("Could not set sched_smt_power_savings to 0", e)
-        sys.exit(1)
-
-def stop_wkld(work_ld):
-    ''' Kill workload triggered in background
-    '''
-    try:
-        os.system('pkill %s 2>/dev/null' %work_ld)
-        if work_ld == "kernbench":
-            os.system('pkill make 2>/dev/null')
-    except OSError as e:
-        print("Exception in stop_wkld", e)
-        sys.exit(1)
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
deleted file mode 100755
index f20717090b..0000000000
--- a/testcases/kernel/power_management/pm_ilb_test.py
+++ /dev/null
@@ -1,57 +0,0 @@
-#!/usr/bin/env python3
-''' This Python script interprets interrupt values.
-    Validates Ideal load balancer runs in same package where workload is running
-'''
-
-import os
-import sys
-from optparse import OptionParser
-from pm_sched_mc import *
-
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-class Usage(Exception):
-    def __init__(self, msg):
-        self.msg = msg
-
-def main(argv=None):
-    if argv is None:
-        argv = sys.argv
-
-    usage = "-w"
-    parser = OptionParser(usage)
-    parser.add_option("-c", "--mc_level", dest="mc_level",
-        default=0, help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_level", dest="smt_level",
-        default=0, help="Sched smt power saving value 0/1/2")
-    parser.add_option("-w", "--workload", dest="work_ld",
-        default="ebizzy", help="Workload can be ebizzy/kernbench")
-    (options, args) = parser.parse_args()
-
-    try:
-        count_num_cpu()
-        count_num_sockets()
-        if is_multi_socket():
-            set_sched_mc_power(options.mc_level)
-        if is_hyper_threaded():
-            set_sched_smt_power(options.smt_level)
-        map_cpuid_pkgid()
-        print("INFO: Created table mapping cpu to package")
-        background="no"
-        duration=120
-        pinned="yes"
-
-        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned, "no")
-        generate_loc_intr_report()
-        status = validate_ilb(options.mc_level, options.smt_level)
-        reset_schedmc()
-        if is_hyper_threaded():
-            reset_schedsmt()
-        return(status)
-
-    except Exception as details:
-        print("INFO: Idle Load Balancer test failed", details)
-        return(1)
-
-if __name__ == "__main__":
-    sys.exit(main())
diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
index b83324f607..4cc75aa9ac 100755
--- a/testcases/kernel/power_management/pm_include.sh
+++ b/testcases/kernel/power_management/pm_include.sh
@@ -1,19 +1,4 @@
-#!/bin/bash
-
-TMPDIR=/tmp
-
-PASS=0
-FAIL=1
-NOSUPPORT=2
-MISSING_FILE=3
-UNTESTED=4
-YES=0
-
-cleanup() {
-	if [ -f ${1} ] ; then
-		rm -f ${1}
-	fi
-}
+#!/bin/sh
 
 check_arch() {
 	case "$(uname -m)" in
@@ -24,297 +9,3 @@ check_arch() {
 		;;
 	esac
 }
-
-check_config_options() {
-	if ( ! ${3} "${1}" ${2} | grep -v "#" > /dev/null ) ; then
-		tst_brkm TCONF "NOSUPPORT: current system dosen't support ${1}"
-	fi
-}
-
-get_topology() {
-	declare -a cpus
-	declare -a phyid
-
-	total_cpus=`tst_ncpus`
-	(( total_cpus-=1 ))
-	for cpu in $(seq 0 "${total_cpus}" )
-	do
-		cpus[$cpu]=cpu${cpu}
-		phyid[$cpu]=$(cat \
-		/sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
-	done
-	j=0
-	while [ "${j}" -lt "${total_cpus}" ]
-	do
-		(( k = $j + 1 ))
-		if [ ${phyid[$j]} -eq ${phyid[$k]} ] ; then
-			echo "${cpus[$j]} -P ${cpus[$k]}" | sed -e "s/cpu//g"
-		fi
-		(( j+=1 ))
-	done
-}
-
-check_cpufreq() {
-	total_cpus=`tst_ncpus`
-	(( total_cpus-=1 ))
-
-	for cpu in $(seq 0 "${total_cpus}" )
-	do
-		if [ ! -d /sys/devices/system/cpu/cpu${cpu}/cpufreq ] ; then
-			tst_brkm TCONF "NOSUPPORT: cpufreq support not " \
-				"found please check Kernel configuration " \
-				"or BIOS settings"
-		fi
-	done
-}
-
-get_supporting_freq() {
-	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies \
-		| uniq
-}
-
-get_supporting_govr() {
-	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors \
-		| uniq
-}
-
-is_hyper_threaded() {
-	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
-	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
-	[ $siblings -gt $cpu_cores ]; echo $?
-}
-
-check_input() {
-	validity_check=${2:-valid}
-	testfile=$3
-	if [ "${validity_check}" = "invalid" ] ; then
-		PASS="Testcase FAIL - Able to execute"
-		FAIL="Testcase PASS - Unable to execute"
-	else
-		PASS="Testcase PASS"
-		FAIL="Testcase FAIL"
-	fi
-	RC=0
-	for input in ${1}
-	do
-		echo ${input} > ${test_file} 2>/dev/null
-		return_value=$?
-		output=$(cat ${test_file})
-		if [ "${return_value}" = "0" -a "${input}" = "${output}" ] ; then
-			echo "${0}: ${PASS}: echo ${input} > ${test_file}"
-			if [ "${validity_check}" = "invalid" ] ; then
-				RC=1
-			fi
-		else
-			echo "${0}: ${FAIL}: echo ${input} > ${test_file}"
-			if [ "${validity_check}" = "valid" ] ; then
-				RC=1
-			fi
-		fi
-	done
-	return $RC
-}
-
-is_multi_socket() {
-	no_of_sockets=`cat \
-		/sys/devices/system/cpu/cpu*/topology/physical_package_id \
-		| sort -u | wc -l`
-	[ $no_of_sockets -gt 1 ] ; echo $?
-}
-
-is_multi_core() {
-	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
-	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
-	if [ $siblings -eq $cpu_cores ]; then
-		[ $cpu_cores -gt 1 ]; echo $?
-	else
-		: $(( num_of_cpus = siblings / cpu_cores ))
-		[ $num_of_cpus -gt 1 ]; echo $?
-	fi
-}
-
-is_dual_core() {
-	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
-	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq \
-			| cut -f2 -d':'`
-        if [ $siblings -eq $cpu_cores ]; then
-                [ $cpu_cores -eq 2 ]; echo $?
-        else
-                : $(( num_of_cpus = siblings / cpu_cores ))
-                [ $num_of_cpus -eq 2 ]; echo $?
-        fi
-}
-
-get_kernel_version() {
-	# Get kernel minor version
-	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' \
-		| cut -f1 -d'-'`
-}
-
-get_valid_input() {
-	kernel_version=$1
-	case "$kernel_version" in
-	'2.6.26' | '2.6.27' | '2.6.28')
-			export valid_input="0 1" ;;
-		*) export valid_input="0 1 2" ;;
-	esac
-}
-
-analyze_result_hyperthreaded() {
-	sched_mc=$1
-    pass_count=$2
-    sched_smt=$3
-	PASS="Test PASS"
-	FAIL="Test FAIL"
-
-	RC=0
-	case "$sched_mc" in
-	0)
-		case "$sched_smt" in
-		0)
-			if [ $pass_count -lt 5 ]; then
-				echo "${PASS}: cpu consolidation failed for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			else
-				RC=1
-				echo "${FAIL}: cpu consolidation passed for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			fi
-			;;
-		*)
-			if [ $pass_count -lt 5 ]; then
-				RC=1
-				echo "${FAIL}: cpu consolidation for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			else
-				echo "${PASS}: cpu consolidation for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			fi
-			;;
-		esac ;;
-	*)
-		if [ $pass_count -lt 5 ]; then
-			RC=1
-			echo "${FAIL}: cpu consolidation for" \
-				"sched_mc=$sched_mc & sched_smt=$sched_smt"
-		else
-			echo "${PASS}: cpu consolidation for" \
-				"sched_mc=$sched_mc & sched_smt=$sched_smt"
-		fi
-		;;
-	esac
-	return $RC
-}
-
-analyze_package_consolidation_result() {
-	sched_mc=$1
-    pass_count=$2
-
-	if [ $# -gt 2 ]
-	then
-		sched_smt=$3
-	else
-		sched_smt=-1
-	fi
-
-	PASS="Test PASS"
-	FAIL="Test FAIL"
-
-	RC=0
-	if [ $hyper_threaded -eq $YES -a $sched_smt -gt -1 ]; then
-		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
-	else
-		case "$sched_mc" in
-	    0)
-    	    if [ $pass_count -lt 5 ]; then
-				echo "${PASS}: cpu consolidation failed for" \
-					"sched_mc=$sched_mc"
-        	else
-				RC=1
-				echo "${FAIL}: cpu consolidation passed for" \
-					"sched_mc=$sched_mc"
-			fi
-			;;
-    	*)
-			if [ $pass_count -lt 5 ]; then
-				RC=1
-				echo "${FAIL}: consolidation at package level" \
-					"failed for sched_mc=$sched_mc"
-			else
-				echo "${PASS}: consolidation at package level" \
-					"passed for sched_mc=$sched_mc"
-			fi
-        	;;
-    	esac
-	fi
-	return $RC
-}
-
-analyze_core_consolidation_result() {
-	sched_smt=$1
-	pass_count=$2
-	PASS="Test PASS"
-	FAIL="Test FAIL"
-
-	RC=0
-	case "$sched_smt" in
-	0)
-		if [ $pass_count -lt 5 ]; then
-			echo "${PASS}: consolidation at core level failed" \
-				"when sched_smt=$sched_smt"
-		else
-			RC=1
-			echo "${FAIL}: consolidation at core level passed for" \
-				"sched_smt=$sched_smt"
-		fi ;;
-	*)
-		if [ $pass_count -lt 5 ]; then
-			RC=1
-			echo "${FAIL}: consolidation at core level failed for" \
-				"sched_smt=$sched_smt"
-		else
-			echo "${PASS}: consolidation at core level passed for" \
-				"sched_smt=$sched_smt"
-		fi ;;
-	esac
-	return $RC
-}
-
-analyze_sched_domain_result(){
-	sched_mc=$1
-	result=$2
-	sched_smt=$3
-	PASS="Test PASS"
-	FAIL="Test FAIL"
-
-	RC=0
-	if [ $hyper_threaded -eq $YES ]; then
-		if [ $sched_smt ]; then
-			if [ "$result" = 0 ];then
-				echo "${PASS}: sched domain test for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			else
-				RC=1
-				echo "${FAIL}: sched domain test for" \
-					"sched_mc=$sched_mc & sched_smt=$sched_smt"
-			fi
-		else
-			if [ "$result" = 0 ];then
-				echo "${PASS}: sched domain test for" \
-					"sched_mc=$sched_mc"
-			else
-				RC=1
-				echo "${FAIL}: sched domain test for" \
-					"sched_mc=$sched_mc"
-			fi
-		fi
-	else
-		if [ "$result" = 0 ];then
-			echo "${PASS}: sched domain test for sched_mc=$sched_mc"
-		else
-			RC=1
-			echo "${FAIL}: sched domain test for sched_mc=$sched_mc"
-		fi
-	fi
-	return $RC
-}
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
deleted file mode 100755
index dddc481690..0000000000
--- a/testcases/kernel/power_management/pm_sched_domain.py
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/usr/bin/env python3
-''' This Python script validates sched domain information in dmesg
-    with information in sysfs topology
-'''
-
-import os
-import sys
-from pm_sched_mc import *
-from optparse import OptionParser
-
-__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
-
-class Usage(Exception):
-    def __init__(self, msg):
-        self.msg = msg
-
-def main(argv=None):
-    if argv is None:
-        argv = sys.argv
-
-    usage = "-w"
-    parser = OptionParser(usage)
-    parser.add_option("-c", "--mc_level", dest="mc_level", default=-1,
-        help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_level", dest="smt_level", default=-1,
-        help="Sched smt power saving value 0/1/2")
-    (options, args) = parser.parse_args()
-
-    try:
-        clear_dmesg()
-        count_num_cpu()
-        map_cpuid_pkgid()
-
-        if is_hyper_threaded() and int(options.smt_level) >= 0:
-            set_sched_smt_power(options.smt_level)
-
-        if int(options.mc_level) >= 0:
-            set_sched_mc_power(options.mc_level)
-        if int(options.smt_level) >= 0 or int(options.mc_level) >= 0:
-            status = verify_sched_domain_dmesg(options.mc_level, options.smt_level)
-            reset_schedmc()
-            if is_hyper_threaded():
-                reset_schedsmt()
-                return(status)
-        else:
-            print("INFO: Invalid arguments given")
-            return 1
-    except Exception as details:
-        print("INFO: sched domain test failed: ", details)
-        return(1)
-
-# Run test based on the command line arguments
-if __name__ == "__main__":
-    sys.exit(main())
diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index ebd0957e64..78e0a1b9a7 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -24,6 +24,16 @@ export TST_TOTAL=4
 . test.sh
 . pm_include.sh
 
+get_supporting_freq() {
+	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies \
+		| uniq
+}
+
+get_supporting_govr() {
+	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors \
+		| uniq
+}
+
 check_cpufreq_sysfs_files() {
 	total_cpus=`expr $(tst_ncpus) - 1`
 	RC=0
diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
index 16e50a670b..1638aaaf82 100755
--- a/testcases/kernel/power_management/runpwtests06.sh
+++ b/testcases/kernel/power_management/runpwtests06.sh
@@ -24,6 +24,37 @@ export TST_TOTAL=1
 . test.sh
 . pm_include.sh
 
+check_input() {
+	validity_check=${2:-valid}
+	testfile=$3
+	if [ "${validity_check}" = "invalid" ] ; then
+		PASS="Testcase FAIL - Able to execute"
+		FAIL="Testcase PASS - Unable to execute"
+	else
+		PASS="Testcase PASS"
+		FAIL="Testcase FAIL"
+	fi
+	RC=0
+	for input in ${1}
+	do
+		echo ${input} > ${test_file} 2>/dev/null
+		return_value=$?
+		output=$(cat ${test_file})
+		if [ "${return_value}" = "0" -a "${input}" = "${output}" ] ; then
+			echo "${0}: ${PASS}: echo ${input} > ${test_file}"
+			if [ "${validity_check}" = "invalid" ] ; then
+				RC=1
+			fi
+		else
+			echo "${0}: ${FAIL}: echo ${input} > ${test_file}"
+			if [ "${validity_check}" = "valid" ] ; then
+				RC=1
+			fi
+		fi
+	done
+	return $RC
+}
+
 test_timer_migration() {
 	valid_input="0 1"
 	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-- 
2.53.0

