From: Laura Abbott <labbott@redhat.com>
Subject: [PATCH] cpupower: Correct return type of cpu_power_is_cpu_online in cpufreq
Date: Fri,  9 Sep 2016 10:25:19 -0700
Message-ID: <1473441919-7809-1-git-send-email-labbott@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35457 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbcIIRZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 13:25:28 -0400
Received: by mail-yw0-f173.google.com with SMTP id j1so51008807ywb.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 10:25:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: Laura Abbott <labbott@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When converting to a shared library in ac5a181d065d ("cpupower: Add
cpuidle parts into library"), cpu_freq_cpu_exists was converted to
cpupower_is_cpu_online. cpu_req_cpu_exists returned 0 on success and
-ENOSYS on failure whereas cpupower_is_cpu_online returns 1 on success.
Check for the correct return value in cpufreq-set.

See https://bugzilla.redhat.com/show_bug.cgi?id=1374212

Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
Reported-by: Julian Seward <jseward@acm.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 tools/power/cpupower/utils/cpufreq-set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index b4bf769..8971d71 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -296,7 +296,7 @@ int cmd_freq_set(int argc, char **argv)
 			struct cpufreq_affected_cpus *cpus;
 
 			if (!bitmask_isbitset(cpus_chosen, cpu) ||
-			    cpupower_is_cpu_online(cpu))
+			    cpupower_is_cpu_online(cpu) != 1)
 				continue;
 
 			cpus = cpufreq_get_related_cpus(cpu);
@@ -316,7 +316,7 @@ int cmd_freq_set(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpupower_is_cpu_online(cpu))
+		    cpupower_is_cpu_online(cpu) != 1)
 			continue;
 
 		if (cpupower_is_cpu_online(cpu) != 1)
-- 
2.10.0

