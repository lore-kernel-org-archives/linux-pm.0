Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F1E55A
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861754; cv=none; b=JJ1eAKp2qXJkUeElck8LJyZpqs4pLksfQhQFY9i2s/4XHGf0W2s7e4mQ4nDwRiTLigKppuo4ImZAe1FFfaBSD+jPcrHqlSxSLVjy+lCR6MSIWKQ/CcPNRWpUCVP0QcyGSoG+SNHyUKzBqWAUV0RG8Nvp5SGo6CEewc5AShJM7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861754; c=relaxed/simple;
	bh=JQihTuDZk3+nc/YPmPPLAwGlG960fxY2pl58o0hl/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU3kIyB18PecJpggx9jl10dhV+Y0dVfMvdgeFsl6bJdjCmRKlczb3tasUqWqpzmOaHHW5lkBR0BkaG/5YowZi5dKqgWp8uhkoe6aCOZiHe7hyAjaisTwRQ6Wh2YADD9FzCBZIJvUilINtnaFtMc4O8zwbSxqkAUZb7ZSFWqsulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DtNf/N82; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IXmFVw6b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCvYFhse; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pMqNhA4S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DtNf/N82";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IXmFVw6b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCvYFhse";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pMqNhA4S"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEA525BE82;
	Mon, 30 Mar 2026 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774861743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5PaY2hrfAz2CGiz9vtoAmCmoW8nbolKAZDz9HmqAwY=;
	b=DtNf/N827yyn4or+PixC0R2pYclA5BklQIqF5adsgeZTGnDOd2xpEeYzYWxki5//L2FMiI
	kzD6LCXzMuTxN2GGhoWIo9JH0hTA8pBSuFbiysMUGkzw2SkgOJtDNtEGMAHoDip0CBIB9h
	DTqZlSIuRNC7RkLwte5o/nXffB34gpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774861743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5PaY2hrfAz2CGiz9vtoAmCmoW8nbolKAZDz9HmqAwY=;
	b=IXmFVw6bENdXvtAmtzas4ITiHv+jNXQCly7frU7ddCZMG/C6DEyRj9XcSVTmrhX9b9wC+L
	y3TwwqXgut4CcFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774861741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5PaY2hrfAz2CGiz9vtoAmCmoW8nbolKAZDz9HmqAwY=;
	b=wCvYFhseIuTeD47wd613GVRb4cwDNUgBg8O7cvn15dsaqBoRNc1CZKYgRL1mpmxNBw45y3
	+cPE+PLHIBIanV+vACF5nSrCW1ryzuliNOw4N3QM/RSqtJheTZk/6tQlRYOCBWZo/UCgpL
	RBy8JEX/hFqwBQ/TPpnOO5HBsBZ+548=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774861741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5PaY2hrfAz2CGiz9vtoAmCmoW8nbolKAZDz9HmqAwY=;
	b=pMqNhA4SBmeue4eBhm1CV9bWosEXSLxqvC3yFGnu6Ffno4uAgyGBgZiJQN2oWmuyOiOfqN
	p5Qeohs9zpUd5VBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A20E4A0B0;
	Mon, 30 Mar 2026 09:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qBmOFK09ymnvDAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 09:09:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Li Wang <liwang@redhat.com>,
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
	automated-testing@lists.yoctoproject.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 1/2] Remove now unsupported power management tests
Date: Mon, 30 Mar 2026 11:08:42 +0200
Message-ID: <20260330090844.79598-2-pvorel@suse.cz>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,pm_cpu_consolidation.py:url,runpwtests_exclusive03.sh:url,check_cpufreq_sysfs_files.sh:url,pm_include.sh:url,change_govr.sh:url,runpwtests_exclusive05.sh:url,runpwtests_exclusive01.sh:url,runpwtests_exclusive02.sh:url,runpwtests03.sh:url,infradead.org:email,imap1.dmz-prg2.suse.org:helo,runpwtests_exclusive04.sh:url,change_freq.sh:url,test.sh:url,pm_ilb_test.py:url,runpwtests04.sh:url,runpwtests02.sh:url,runpwtests.sh:url,runpwtests06.sh:url,runpwtests01.sh:url,pm_sched_domain.py:url,runpwtests05.sh:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

From: Cyril Hrubis <chrubis@suse.cz>

The sched_mc_power_savings and sched_smt_power_savings sysfs knobs
were removed from kernel in:

commit 8e7fbcbc22c12414bcc9dfdd683637f58fb32759
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 9 11:28:35 2012 +0100

    sched: Remove stale power aware scheduling remnants and dysfunctional knobs

That went into kernel 3.5 and the minimal kernel version LTP currently
supports is 3.10.

This has been discussed in:

https://github.com/linux-test-project/ltp/pull/1016

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/power_management_tests                |   3 -
 runtest/power_management_tests_exclusive      |   6 -
 testcases/kernel/power_management/.gitignore  |   1 -
 testcases/kernel/power_management/README      |  29 ----
 .../power_management/pm_cpu_consolidation.py  | 143 ------------------
 .../power_management/pm_get_sched_values.c    |  36 -----
 .../kernel/power_management/runpwtests01.sh   |  71 ---------
 .../kernel/power_management/runpwtests02.sh   |  68 ---------
 .../kernel/power_management/runpwtests05.sh   |  76 ----------
 .../runpwtests_exclusive01.sh                 |  97 ------------
 .../runpwtests_exclusive02.sh                 |  68 ---------
 .../runpwtests_exclusive03.sh                 |  95 ------------
 .../runpwtests_exclusive04.sh                 |  58 -------
 .../runpwtests_exclusive05.sh                 |  97 ------------
 14 files changed, 848 deletions(-)
 delete mode 100644 runtest/power_management_tests_exclusive
 delete mode 100644 testcases/kernel/power_management/.gitignore
 delete mode 100755 testcases/kernel/power_management/pm_cpu_consolidation.py
 delete mode 100644 testcases/kernel/power_management/pm_get_sched_values.c
 delete mode 100755 testcases/kernel/power_management/runpwtests01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests05.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive01.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive02.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive03.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive04.sh
 delete mode 100755 testcases/kernel/power_management/runpwtests_exclusive05.sh

diff --git a/runtest/power_management_tests b/runtest/power_management_tests
index 884e615cd8..b670da6ecf 100644
--- a/runtest/power_management_tests
+++ b/runtest/power_management_tests
@@ -1,7 +1,4 @@
 #POWER_MANAGEMENT
-runpwtests01 runpwtests01.sh
-runpwtests02 runpwtests02.sh
 runpwtests03 runpwtests03.sh
 runpwtests04 runpwtests04.sh
-#runpwtests05 runpwtests05.sh
 runpwtests06 runpwtests06.sh
diff --git a/runtest/power_management_tests_exclusive b/runtest/power_management_tests_exclusive
deleted file mode 100644
index 0eb0122476..0000000000
--- a/runtest/power_management_tests_exclusive
+++ /dev/null
@@ -1,6 +0,0 @@
-#POWER_MANAGEMENT exclusive
-runpwtests_exclusive01 runpwtests_exclusive01.sh
-runpwtests_exclusive02 runpwtests_exclusive02.sh
-runpwtests_exclusive03 runpwtests_exclusive03.sh
-runpwtests_exclusive04 runpwtests_exclusive04.sh
-runpwtests_exclusive05 runpwtests_exclusive05.sh
diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
deleted file mode 100644
index 0c2a3ed4bd..0000000000
--- a/testcases/kernel/power_management/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-pm_get_sched_values
diff --git a/testcases/kernel/power_management/README b/testcases/kernel/power_management/README
index b8d6c316e8..1b82782d85 100644
--- a/testcases/kernel/power_management/README
+++ b/testcases/kernel/power_management/README
@@ -38,13 +38,6 @@ CONFIG_CPU_IDLE
 CONFIG_CPU_IDLE_GOV_LADDER
 CONFIG_CPU_IDLE_GOV_MENU
 
-for SCHED_MC tests:
-
-CONFIG_SCHED_MC
-
-The power management test automation suite helps run the power management functionality
-(e.g: cpu frequency, cpu idle etc..) tests and report results.
-
 Test Scripts for CPU FREQUENCY:
 change_freq.sh
 change_govr.sh
@@ -53,9 +46,6 @@ check_cpufreq_sysfs_files.sh
 Test Scripts for CPU IDLE:
 will be added soon
 
-Test Scripts for SCHED_MC:
-test_sched_mc.sh
-
 Common functionality:
 pm_include.sh
 check_kv_arch.c
@@ -66,22 +56,3 @@ To run your tests you can execute the runpwtests.sh
 To run the tests individually :
 
 P.S. As of now the supporting architecture(s) are x86,x86_64
-
-Support of system:
------------------
-If you see some thing like following,
-
-Power Management    1  FAIL  :  Required kernel configuration for SCHED_MC NOT set
-or
-Power Management    1  FAIL  :  Required kernel configuration for CPU_FREQ NOT set
-
-Then either configuration is not set or the system won't support.
-
-For CPU consolidation verification ebizzy is included in utils directory of LTP.
-To run cpu consolidation test user has to provide -w <workload> -l <sched_mc_level>.
-Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for details of ebizzy.
-
-To test CPU consolidation for sched_mc 2 kernbench has to run. Kernbench needs linux kernel source as input in /root directory . For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2. If Linux kernel source not found kernbench wiil  not execute.
-CPU consolidation testcases will not execute if number of CPU's in package is less then 2. If system is hyper threaded but number of CPU is 1 only sched_smt testcases will be excuted. For better coverage of testcases select a system which is at least quad core and then hyper threaded so that you will observe 8 CPU's in each package.
-
-Timer migration interface test will execute on kernel versions 2.6.31 and above. Timer migration functionality verification testcases will be executed only on suitable architecture like quad core or the number of CPU's in each package should be at least 4 and above
diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
deleted file mode 100755
index a01db004cb..0000000000
--- a/testcases/kernel/power_management/pm_cpu_consolidation.py
+++ /dev/null
@@ -1,143 +0,0 @@
-#!/usr/bin/env python3
-''' This Python script interprets various sched stats values.
-    Validates cpu consolidation for given sched_mc_power_saving value
-'''
-
-import os
-import sys
-import time
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
-    parser.add_option("-v", "--variation_test", dest="vary_mc_smt",
-        default=False, action="store_true", help="Vary sched_mc & sched_smt. \
-            -c and -t inputs are initial value of sched_mc & sched_smt")
-    parser.add_option("-c", "--mc_value", dest="mc_value",
-        default=0, help="Sched mc power saving value 0/1/2")
-    parser.add_option("-t", "--smt_value", dest="smt_value",
-        default=0, help="Sched smt power saving value 0/1/2")
-    parser.add_option("-w", "--workload", dest="work_ld",
-        default="ebizzy", help="Workload can be ebizzy/kernbench")
-    parser.add_option("-s", "--stress", dest="stress",
-        default="partial", help="Load on system is full/partial [i.e 50%]/thread")
-    parser.add_option("-p", "--performance", dest="perf_test",
-        default=False, action="store_true", help="Enable performance test")
-    (options, args) = parser.parse_args()
-
-    try:
-        count_num_cpu()
-        count_num_sockets()
-        if is_hyper_threaded():
-            generate_sibling_list()
-
-        # User should set option -v to test cpu consolidation
-        # resets when sched_mc &(/) sched_smt is disabled when
-        # workload is already running in the system
-
-        if options.vary_mc_smt:
-
-            # Since same code is used for testing package consolidation and core
-            # consolidation is_multi_socket & is_hyper_threaded check is done
-            if is_multi_socket() and is_multi_core() and options.mc_value:
-                set_sched_mc_power(options.mc_value)
-
-            if is_hyper_threaded() and options.smt_value:
-                set_sched_smt_power(options.smt_value)
-
-            #Generate arguments for trigger workload, run workload in background
-            map_cpuid_pkgid()
-            background="yes"
-            duration=360
-            pinned="no"
-            if int(options.mc_value) < 2 and int(options.smt_value) < 2:
-                trigger_ebizzy (options.smt_value, "partial", duration, background, pinned)
-                work_ld="ebizzy"
-                #Wait for 120 seconds and then validate cpu consolidation works
-                #When sched_mc & sched_smt is set
-                import time
-                time.sleep(120)
-            else:
-                #Wait for 120 seconds and then validate cpu consolidation works
-                #When sched_mc & sched_smt is set
-                trigger_kernbench (options.smt_value, "partial", background, pinned, "no")
-                work_ld="kernbench"
-                import time
-                time.sleep(300)
-
-            generate_report()
-            status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
-            if status == 0:
-                print("INFO: Consolidation worked sched_smt &(/) sched_mc is set")
-                #Disable sched_smt & sched_mc interface values
-                if options.vary_mc_smt and options.mc_value > 0:
-                    set_sched_mc_power(0)
-                    mc_value = options.mc_value
-                else:
-                    mc_value = 0
-                if options.vary_mc_smt and options.smt_value > 0 and is_hyper_threaded():
-                    set_sched_smt_power(0)
-                    smt_value = options.smt_value
-                else:
-                    smt_value = 0
-
-                if work_ld == "kernbench":
-                    time.sleep(240)
-                else:
-                    time.sleep(120)
-
-                generate_report()
-                status = validate_cpu_consolidation("partial", work_ld, mc_value, smt_value)
-                if background == "yes":
-                    stop_wkld(work_ld)
-                #CPU consolidation should fail as sched_mc &(/) sched_smt is disabled
-                if status == 1:
-                    return(0)
-                else:
-                    return(1)
-            else:
-                print("INFO: CPU consolidation failed when sched_mc &(/) \
-sched_smt was enabled. This is pre-requisite to proceed")
-                return(status)
-        else:
-            #The else part of the code validates behaviour of sched_mc
-            # and sched_smt set to 0, 1 & 2
-            if is_multi_socket():
-                set_sched_mc_power(options.mc_value)
-            if is_hyper_threaded():
-                set_sched_smt_power(options.smt_value)
-            map_cpuid_pkgid()
-            print("INFO: Created table mapping cpu to package")
-            background="no"
-            duration=60
-            pinned ="no"
-
-            if options.perf_test:
-                perf_test="yes"
-            else:
-                perf_test="no"
-
-            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned, perf_test)
-            generate_report()
-            status = validate_cpu_consolidation(options.stress, options.work_ld,options.mc_value, options.smt_value)
-            reset_schedmc()
-            if is_hyper_threaded():
-                reset_schedsmt()
-            return(status)
-    except Exception as details:
-        print("INFO: CPU consolidation failed", details)
-        return(1)
-
-if __name__ == "__main__":
-    sys.exit(main())
diff --git a/testcases/kernel/power_management/pm_get_sched_values.c b/testcases/kernel/power_management/pm_get_sched_values.c
deleted file mode 100644
index e75c5852e5..0000000000
--- a/testcases/kernel/power_management/pm_get_sched_values.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/************************************************************************
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-***************************************************************************/
-#include <stdio.h>
-#include "test.h"
-
-const char *TCID = "pm_get_sched_values";
-
-int main(int argc, char **argv)
-{
-	char *param;
-	if (argc == 0)
-		return 1;
-	else {
-		param = argv[1];
-		if (strcmp(param, "sched_mc") == 0)
-			return 2;
-		if (strcmp(param, "sched_smt") == 0)
-			return 2;
-	}
-
-	return 1;
-}
diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
deleted file mode 100755
index 2caf9eab51..0000000000
--- a/testcases/kernel/power_management/runpwtests01.sh
+++ /dev/null
@@ -1,71 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management01"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-test_sched_mc() {
-	get_kernel_version
-	get_valid_input $kernel_version
-
-	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-	2000000000000000000000000000000000000000000000000000000000000000000
-	ox324 -0xfffffffffffffffffffff"
-	test_file="/sys/devices/system/cpu/sched_mc_power_savings"
-	if [ ! -f ${test_file} ] ; then
-		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
-	fi
-
-	RC=0
-	echo "${0}: ---Valid test cases---"
-	check_input "${valid_input}" valid $test_file
-	RC=$?
-	echo "${0}: ---Invalid test cases---"
-	check_input "${invalid_input}" invalid $test_file
-	RC=$(( RC | $? ))
-	return $RC
-}
-
-# Checking test environment
-check_arch
-
-# Checking sched_mc sysfs interface
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
-		"NOT set"
-else
-	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
-		tst_brkm TCONF "sched_mc_power_savings interface in system" \
-			"which is not a multi socket &(/) multi core"
-	fi
-fi
-
-if test_sched_mc ; then
-	tst_resm TPASS "SCHED_MC sysfs tests"
-else
-	tst_resm TFAIL "SCHED_MC sysfs tests"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
deleted file mode 100755
index 805befb033..0000000000
--- a/testcases/kernel/power_management/runpwtests02.sh
+++ /dev/null
@@ -1,68 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management02"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-test_sched_smt() {
-	get_kernel_version
-	get_valid_input $kernel_version
-
-	invalid_input="3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
-	2000000000000000000000000000000000000000000000000000000000000000000000
-	ox324 -0xfffffffffffffffffffff"
-	test_file="/sys/devices/system/cpu/sched_smt_power_savings"
-	if [ ! -f ${test_file} ] ; then
-		tst_brkm TBROK "MISSING_FILE: missing file ${test_file}"
-	fi
-
-	echo "${0}: ---Valid test cases---"
-	check_input "${valid_input}" valid $test_file
-	RC=$?
-	echo "${0}: ---Invalid test cases---"
-	check_input "${invalid_input}" invalid $test_file
-	RC=$(( RC | $? ))
-	return $RC
-}
-
-# Checking test environment
-check_arch
-
-# Check sched_smt_power_savings interface on HT machines
-hyper_threaded=$(is_hyper_threaded)
-if [ ! -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_SMT NOT set"
-else
-	if [ $hyper_threaded -ne 0 ]; then
-		tst_brkm TCONF "sched_smt_power_saving interface in system" \
-			"not hyper-threaded"
-	fi
-fi
-
-if test_sched_smt ; then
-	tst_resm TPASS "SCHED_SMT sysfs test"
-else
-	tst_resm TFAIL "SCHED_SMT sysfs test"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
deleted file mode 100755
index 03b6752bf3..0000000000
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management05"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_mc=2
-max_sched_smt=2
-
-tst_require_cmds python3
-
-if ! grep sched_debug -qw /proc/cmdline ; then
-	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
-		"CPU Consolidation test cannot run"
-fi
-
-hyper_threaded=$(is_hyper_threaded)
-if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings \
-	-o $hyper_threaded -ne 0 ] ; then
-	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
-		"NOT set, or sched_mc_power_savings interface in system" \
-		"which is not hyper-threaded"
-fi
-
-# sched_domain test
-echo "max sched mc $max_sched_mc"
-RC=0
-for sched_mc in `seq 0 $max_sched_mc`; do
-	pm_sched_domain.py -c $sched_mc; ret=$?
-	analyze_sched_domain_result $sched_mc $ret; RC=$?
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "Sched_domain test for sched_mc"
-else
-	tst_resm TFAIL "Sched_domain test for sched_mc"
-fi
-
-# Testcase to validate sched_domain tree
-RC=0
-for sched_mc in `seq 0 $max_sched_mc`; do
-	pm_get_sched_values sched_smt; max_sched_smt=$?
-	for sched_smt in `seq 0 $max_sched_smt`; do
-		pm_sched_domain.py -c $sched_mc -t $sched_smt; ret=$?
-		analyze_sched_domain_result $sched_mc $ret $sched_smt; RC=$?
-	done
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "Sched_domain test for sched_mc & sched_smt"
-else
-	tst_resm TFAIL "Sched_domain test for sched_mc & sched_smt"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
deleted file mode 100755
index f309d7c196..0000000000
--- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
+++ /dev/null
@@ -1,97 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management_exclusive01"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_mc=2
-max_sched_smt=2
-
-tst_require_cmds python3
-
-hyper_threaded=$(is_hyper_threaded)
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
-	$hyper_threaded -ne 0 ]; then
-	tst_brkm TCONF "System is not a multi socket & multi core" \
-		"& hyper-threaded"
-fi
-
-# Test CPU consolidation
-RC=0
-for sched_mc in `seq 0  $max_sched_mc`; do
-	sched_mc_pass_cnt=0
-	if [ $sched_mc -eq 2 ]; then
-		work_load="kernbench"
-	else
-		work_load="ebizzy"
-	fi
-	for repeat_test in `seq 1  10`; do
-		#Testcase to validate CPU consolidation for sched_mc
-		if pm_cpu_consolidation.py -c $sched_mc -w $work_load ; then
-		: $(( sched_mc_pass_cnt += 1 ))
-		fi
-	done
-	analyze_package_consolidation_result $sched_mc \
-		$sched_mc_pass_cnt; RC=$?
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "CPU consolidation test for sched_mc"
-else
-	tst_resm TFAIL "CPU consolidation test for sched_mc"
-fi
-
-RC=0
-for sched_mc in `seq 0  $max_sched_mc`; do
-	if [ $sched_mc -eq 2 ]; then
-		work_load="kernbench"
-	else
-		work_load="ebizzy"
-	fi
-	for sched_smt in `seq 0 $max_sched_smt`; do
-		sched_mc_smt_pass_cnt=0
-		for repeat_test in `seq 1  10`; do
-			# Testcase to validate CPU consolidation for
-			# for sched_mc & sched_smt with stress=50%
-			if pm_cpu_consolidation.py -c $sched_mc -t $sched_smt \
-				-w $work_load ; then
-				: $(( sched_mc_smt_pass_cnt += 1 ))
-			fi
-		done
-		analyze_package_consolidation_result $sched_mc \
-			$sched_mc_smt_pass_cnt $sched_smt; RC=$?
-	done
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "CPU consolidation test for sched_mc &" \
-		"sched_smt with stress=50%"
-else
-	tst_resm TFAIL "CPU consolidation test for sched_mc &" \
-		"sched_smt with stress=50%"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
deleted file mode 100755
index 547e88feaf..0000000000
--- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
+++ /dev/null
@@ -1,68 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management_exclusive02"
-export TST_TOTAL=1
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_smt=2
-
-tst_require_cmds python3
-
-hyper_threaded=$(is_hyper_threaded)
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 \
-	-o $multi_core -eq 0 ]; then
-	tst_brkm TCONF "System is a multi core but not multi" \
-		"socket & hyper-threaded"
-fi
-
-#Testcase to validate consolidation at core level
-RC=0
-for sched_smt in `seq 0 $max_sched_smt`; do
-	if [ $sched_smt -eq 2 ]; then
-		work_load="kernbench"
-	else
-		work_load="ebizzy"
-	fi
-	sched_smt_pass_cnt=0
-	stress="thread"
-	for repeat_test in `seq 1  10`; do
-		if pm_cpu_consolidation.py -t $sched_smt -w $work_load \
-			-s $stress; then
-			: $(( sched_smt_pass_cnt += 1 ))
-		fi
-	done
-	analyze_core_consolidation_result $sched_smt \
-		$sched_smt_pass_cnt; RC=$?
-done
-if [ $RC -eq 0 ]; then
-    tst_resm TPASS "Consolidation test at core level for sched_smt"
-else
-    tst_resm TFAIL "Consolidation test at core level for sched_smt"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
deleted file mode 100755
index 67c7243e8f..0000000000
--- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
+++ /dev/null
@@ -1,95 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management_exclusive03"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_mc=2
-max_sched_smt=2
-
-tst_require_cmds python3
-
-hyper_threaded=$(is_hyper_threaded)
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
-	$hyper_threaded -ne 0 ]; then
-	tst_brkm TCONF "System is not a multi socket & multi core" \
-		"& hyper-threaded"
-fi
-
-# Verify threads consolidation stops when sched_mc &(/) sched_smt
-# is disabled.
-# Vary sched_mc from 1/2 to 0 when workload is running and
-# ensure that tasks do not consolidate to single package when
-# sched_mc is set to 0.
-RC=0
-for sched_mc in `seq 1  $max_sched_mc`; do
-	if pm_cpu_consolidation.py -v -c $sched_mc; then
-		echo "Test PASS: CPU consolidation test by varying" \
-			"sched_mc $sched_mc to 0"
-	else
-		RC=1
-		echo "Test FAIL: CPU consolidation test by varying" \
-			"sched_mc $sched_mc to 0"
-	fi
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "CPU consolidation test by varying sched_mc"
-else
-	tst_resm TFAIL "CPU consolidation test by varying sched_mc"
-fi
-
-# Vary sched_mc & sched_smt from 1 to 0 & 2 to 0 when workload
-# is running and ensure that tasks do not consolidate to single
-# package when sched_mc is set to 0.
-RC=0
-for sched_mc in `seq 1  $max_sched_mc`; do
-	for sched_smt in `seq 1  $max_sched_smt`; do
-		if [ $sched_smt -eq $sched_mc ]; then
-			if pm_cpu_consolidation.py -v -c $sched_mc \
-				-t $sched_smt; then
-				echo "Test PASS: CPU consolidation test by" \
-					"varying sched_mc & sched_smt from" \
-					"$sched_mc to 0"
-			else
-				RC=1
-				echo "Test FAIL: CPU consolidation test by" \
-					"varying sched_mc & sched_smt from" \
-					"$sched_mc to 0"
-			fi
-		fi
-	done
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "CPU consolidation test by varying" \
-		"sched_mc & sched_smt"
-else
-	tst_resm TFAIL "CPU consolidation test by varying" \
-		"sched_mc & sched_smt"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
deleted file mode 100755
index 46985b3be5..0000000000
--- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management_exclusive04"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-tst_require_cmds python3
-
-hyper_threaded=$(is_hyper_threaded)
-multi_socket=$(is_multi_socket)
-if [ $hyper_threaded -ne 0 -o $multi_socket -ne 0 ]; then
-	tst_brkm TCONF "System is not a multi socket & hyper-threaded"
-fi
-
-# Verify threads consolidation stops when sched_smt is
-# disabled in HT systems.
-# Vary only sched_smt from 1 to 0 when workload is running
-# and ensure that tasks do not consolidate to single core
-# when sched_smt is set to 0.
-if pm_cpu_consolidation.py -v -t 1; then
-	tst_resm TPASS "CPU consolidation test by varying sched_smt from 1 to 0"
-else
-	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 1 to 0"
-fi
-
-# Vary only sched_smt from 2 to 0 when workload is running
-# and ensure that tasks do not consolidate to single core
-# when sched_smt is set to 0.
-if pm_cpu_consolidation.py -v -t 2; then
-	tst_resm TPASS "CPU consolidation test by varying sched_smt from 2 to 0"
-else
-	tst_resm TFAIL "CPU consolidation test by varying sched_smt from 2 to 0"
-fi
-
-tst_exit
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
deleted file mode 100755
index 38450d1fdf..0000000000
--- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
+++ /dev/null
@@ -1,97 +0,0 @@
-#! /bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2001
-# Author: Nageswara R Sastry <nasastry@in.ibm.com>
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software Foundation,
-# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-export TCID="Power_Management_exclusive05"
-export TST_TOTAL=2
-
-. test.sh
-. pm_include.sh
-
-# Checking test environment
-check_arch
-
-max_sched_mc=2
-max_sched_smt=2
-
-tst_require_cmds python3
-
-hyper_threaded=$(is_hyper_threaded)
-multi_socket=$(is_multi_socket)
-multi_core=$(is_multi_core)
-if [ $multi_socket -ne 0 -o $multi_core -ne 0 -o \
-	$hyper_threaded -ne 0 ]; then
-	tst_brkm TCONF "System is not a multi socket & multi core" \
-		"& hyper-threaded"
-fi
-
-# Verify ILB runs in same package as workload.
-RC=0
-for sched_mc in `seq 1 $max_sched_mc`; do
-	if [ $sched_mc -eq 2 ]; then
-		work_load="kernbench"
-	else
-		work_load="ebizzy"
-	fi
-
-	pm_ilb_test.py -c $sched_mc -w $work_load
-	if [ $? -eq 0 ]; then
-		echo "Test PASS: ILB & workload in same package for" \
-			"sched_mc=$sched_mc"
-	else
-		RC=1
-		echo "Test FAIL: ILB & workload did not run in same package" \
-			"for sched_mc=$sched_mc. Ensure CONFIG_NO_HZ is set"
-	fi
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "ILB & workload test in same package for sched_mc"
-else
-	tst_resm TFAIL "ILB & workload test in same package for sched_mc"
-fi
-
-RC=0
-for sched_mc in `seq 1 $max_sched_mc`; do
-	if [ $sched_mc -eq 2 ]; then
-		work_load="kernbench"
-	else
-		work_load="ebizzy"
-	fi
-	for sched_smt in `seq 1 $max_sched_smt`; do
-		pm_ilb_test.py -c $sched_mc -t sched_smt -w $work_load
-		if [ $? -eq 0 ]; then
-			echo "Test PASS: ILB & workload in same package for" \
-				"sched_mc=$sched_mc & sched_smt=$sched_smt"
-		else
-			RC=1
-			echo "Test FAIL: ILB & workload did not execute in" \
-				"same package for sched_mc=$sched_mc &" \
-				"sched_smt=$sched_smt. Ensure CONFIG_NO_HZ is set"
-		fi
-	done
-done
-if [ $RC -eq 0 ]; then
-	tst_resm TPASS "ILB & workload test in same package for" \
-		"sched_mc & sched_smt"
-else
-	tst_resm TFAIL "ILB & workload test in same package for" \
-		"sched_mc & sched_smt"
-fi
-
-tst_exit
-- 
2.53.0

