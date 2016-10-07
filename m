From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Fri, 07 Oct 2016 21:21:34 +0000
Message-ID: <bug-176411-137361-KUupSxSdng@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbcJGVVj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Oct 2016 17:21:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E165E200F3
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 21:21:37 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 209FC201D3
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 21:21:35 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #12 from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> ---
Same as Doug.

./perf report --header
Error:
The perf.data file has no samples!
# ========
# captured on: Fri Oct  7 14:08:08 2016
# hostname : stravinsky
# os release : 4.8.0-1-ARCH
# perf version : 4.7.g523d93
# arch : x86_64
# nrcpus online : 12
# nrcpus avail : 12
# cpudesc : Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz
# cpuid : GenuineIntel,6,63,2
# total memory : 32844308 kB
# cmdline : /usr/bin/perf record -a --event=power:pstate_sample sleep 300 
# event : name = power:pstate_sample, , type = 2, size = 112, config = 0x184, {
sample_period, sa
# HEADER_CPU_TOPOLOGY info available, use -I to display
# HEADER_NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: cpu = 4, intel_bts = 6, uncore_imc_4 = 17, uncore_sbox_1 = 26,
uncore_cbox_5 = 24
# HEADER_CACHE info available, use -I to display
# ========
#


No samples collected. I guess intel_pstate sched_util not called.

-Please also attach your .config

In addition do this step:
# echo -n 'file intel_pstate.c +p' > /sys/kernel/debug/dynamic_debug/control 
# cd /sys/device/system/cpu/cpu1
# echo 0 > online
# echo 1 > online
Take dmesg and send output

-- 
You are receiving this mail because:
You are the assignee for the bug.
