From: Laura Abbott <labbott@redhat.com>
Subject: [RESEND][PATCHv2] cpupower: Correct return type of cpu_power_is_cpu_online in cpufreq
Date: Wed, 19 Oct 2016 15:53:52 -0700
Message-ID: <1476917632-7831-1-git-send-email-labbott@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: Laura Abbott <labbott@redhat.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

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
v2: Drop another redundant cpupower_is_cpu_online

Resend because I've heard nothing about this patch and it's still broken
as far as I can tell.
---
 tools/power/cpupower/utils/cpufreq-set.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index b4bf769..1eef0ae 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -296,7 +296,7 @@ int cmd_freq_set(int argc, char **argv)
 			struct cpufreq_affected_cpus *cpus;
 
 			if (!bitmask_isbitset(cpus_chosen, cpu) ||
-			    cpupower_is_cpu_online(cpu))
+			    cpupower_is_cpu_online(cpu) != 1)
 				continue;
 
 			cpus = cpufreq_get_related_cpus(cpu);
@@ -316,10 +316,7 @@ int cmd_freq_set(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpupower_is_cpu_online(cpu))
-			continue;
-
-		if (cpupower_is_cpu_online(cpu) != 1)
+		    cpupower_is_cpu_online(cpu) != 1)
 			continue;
 
 		printf(_("Setting cpu: %d\n"), cpu);
-- 
2.7.4
