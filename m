From: Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: enable HWP after resumed
Date: Mon, 29 Jan 2018 10:27:57 +0800
Message-ID: <7ddf56d88ed43701cd498fd42d1ae75e4eea1340.1517192577.git.yu.c.chen@intel.com>
References: <d71a6cf7352de5595ac1419000bd72b6d068cce1.1517192577.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d71a6cf7352de5595ac1419000bd72b6d068cce1.1517192577.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

When maxcpus=1 is appended the BP is responsible
for re-enabling the HWP - because currently only
the APs invoke intel_pstate_hwp_enable() during
their online process - which might put the system
into unstable state after resume.

Fix this by enabling the HWP explicitly on BP during
resume.

Reported-by: Doug Smythies <dsmythies@telus.net>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a0e88bef76..89f637e8439c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -779,6 +779,8 @@ static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
 	if (!hwp_active)
@@ -786,6 +788,8 @@ static int intel_pstate_resume(struct cpufreq_policy *policy)
 
 	mutex_lock(&intel_pstate_limits_lock);
 
+	if (!policy->cpu)
+		intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
 	all_cpu_data[policy->cpu]->epp_policy = 0;
 	intel_pstate_hwp_set(policy->cpu);
 
-- 
2.13.6
