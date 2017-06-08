From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] intel_pstate: skip scheduler hook when in "performance" mode.
Date: Wed,  7 Jun 2017 19:39:15 -0700
Message-ID: <1ecfadf4193fbd8873d4bcda9e9faec5825bcafb.1496889051.git.len.brown@intel.com>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496889556-17923-1-git-send-email-lenb@kernel.org>
In-Reply-To: <f9250362b5eb66bc34402c1fd175f9db7a841532.1496889051.git.len.brown@intel.com>
References: <f9250362b5eb66bc34402c1fd175f9db7a841532.1496889051.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, srinivas.pandruvada@linux.intel.com, hpa@linux.intel.com, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When the governor is set to "performance", intel_pstate does not
need the scheduler hook for doing any calculations.  Under these
conditions, its only purpose is to continue to maintain
cpufreq/scaling_cur_freq.

But the cpufreq/scaling_cur_freq sysfs attribute is now provided by
the x86 cpufreq core on all modern x86 systems, including
all systems supported by the intel_pstate driver.

So in "performance" governor mode, the scheduler hook can be skipped.
This applies to both in Software and Hardware P-state control modes.

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5d67780..0ff3a4b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2025,10 +2025,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
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
