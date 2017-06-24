From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] intel_pstate: skip scheduler hook when in "performance" mode.
Date: Fri, 23 Jun 2017 22:11:54 -0700
Message-ID: <68516d288d3968fe22d6c8984a7bcbdcdbed351d.1498280509.git.len.brown@intel.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498281114-3868-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
References: <e3f0ab4d677eb1337999731f1a98022caa8a796a.1498280509.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When the governor is set to "performance", intel_pstate does not
need the scheduler hook for doing any calculations.  Under these
conditions, its only purpose is to continue to maintain
cpufreq/scaling_cur_freq.

The cpufreq/scaling_cur_freq sysfs attribute is now provided by
shared x86 cpufreq code on modern x86 systems, including
all systems supported by the intel_pstate driver.

So in "performance" governor mode, the scheduler hook can be skipped.
This applies to both in Software and Hardware P-state control modes.

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4ec5668..4538182 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2031,10 +2031,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_max_within_limits(cpu);
+	} else {
+		intel_pstate_set_update_util_hook(policy->cpu);
 	}
 
-	intel_pstate_set_update_util_hook(policy->cpu);
-
 	if (hwp_active)
 		intel_pstate_hwp_set(policy->cpu);
 
-- 
2.7.4
