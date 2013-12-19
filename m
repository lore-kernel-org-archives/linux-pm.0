From: Jason Baron <jbaron@akamai.com>
Subject: [PATCH v2] cpufreq: Use CONFIG_CPU_FREQ_DEFAULT_* to set initial policy for setpolicy drivers
Date: Thu, 19 Dec 2013 22:50:50 +0000 (GMT)
Message-ID: <20131219225050.E82C91FF9@prod-mail-relay06.akamai.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com, dirk.brandewie@gmail.com
List-Id: linux-pm@vger.kernel.org

When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
intel_pstate driver, the desired default policy is not properly set. For
example, setting 'CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE' ended up with the
'powersave' policy being set.

Fix by configuring the correct default policy, if either 'powersave' or
'performance' are requested. Otherwise, fallback to what the driver originally
set via its 'init' routine.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---

v2: simplify logic

 drivers/cpufreq/cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..42e1ea4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -828,6 +828,12 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	int ret = 0;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
+
+	/* Use the default policy if its valid. */
+	if (cpufreq_driver->setpolicy)
+		cpufreq_parse_governor(policy->governor->name,
+					&new_policy.policy, NULL);
+
 	/* assure that the starting sequence is run in cpufreq_set_policy */
 	policy->governor = NULL;
 
-- 
1.8.2.rc2

