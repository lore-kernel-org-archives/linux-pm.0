From: Steven Noonan <steven@uplinklabs.net>
Subject: [PATCH] cpupower: fix frequency-set check for online CPUs
Date: Sun,  4 Sep 2016 15:44:04 -0700
Message-ID: <20160904224404.29863-1-steven@uplinklabs.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36161 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbcIDWoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Sep 2016 18:44:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id a143so5429707pfa.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Sep 2016 15:44:17 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Steven Noonan <steven@uplinklabs.net>

It used to look at whether the cpuN directory existed (a function which
returned 0 on success, nonzero on failure), but the cpupower_is_cpu_online
function returns 1 when the CPU is online. This caused it to skip all online
CPUs since it was expecting 0 to mean 'online'.

We also had a redundant (and also wrong) check on cpupower_is_cpu_online when
iterating over the bitmask to run the set operations.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
---
 tools/power/cpupower/utils/cpufreq-set.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index b4bf769..ec7d7da 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -296,7 +296,7 @@ int cmd_freq_set(int argc, char **argv)
 			struct cpufreq_affected_cpus *cpus;
 
 			if (!bitmask_isbitset(cpus_chosen, cpu) ||
-			    cpupower_is_cpu_online(cpu))
+			    cpupower_is_cpu_online(cpu) != 1)
 				continue;
 
 			cpus = cpufreq_get_related_cpus(cpu);
@@ -315,8 +315,7 @@ int cmd_freq_set(int argc, char **argv)
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
-		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpupower_is_cpu_online(cpu))
+		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
 		if (cpupower_is_cpu_online(cpu) != 1)
-- 
2.9.3

