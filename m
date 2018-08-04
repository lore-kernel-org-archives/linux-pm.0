From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy() interface for no_turbo"
Date: Sat,  4 Aug 2018 17:29:32 +0200
Message-ID: <20180804152932.3861-1-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc: lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

This change does not take into account that some BIOSes change
MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
If the turbo is disabled when the system boots, policy.max_freq
is set to pstate.max_pstate. However, if the BIOS later enables
the turbo, the CPU will never be able to run at pstate.turbo_pstate.

Since now intel_pstate_set_policy() does its calculations using
pstate.max_freq and pstate.turbo_freq, we can always calculate
cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
speed when the turbo is enabled.

This reverts commit 983e600e88835f0321d1a0ea06f52d48b7b5a544.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c3971256130..4043aae2d611 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2068,9 +2068,8 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
-	policy->cpuinfo.max_freq = global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
+	policy->cpuinfo.max_freq =
+		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
-- 
2.18.0
