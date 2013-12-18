From: Jason Baron <jbaron@akamai.com>
Subject: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Wed, 18 Dec 2013 20:31:02 +0000 (GMT)
Message-ID: <20131218203102.9F9692036@prod-mail-relay06.akamai.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
'intel_pstate' driver, I found that the default is not honored. For example,
configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
powersave

However, I can do:

echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

and it takes properly.

Fix by setting the default governor, if its either 'powersave' or 'performance'.
Otherwise, fall back to what the driver originally set via its 'init' routine.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..931fa67 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -826,8 +826,19 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_policy new_policy;
 	int ret = 0;
+	int init_policy;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
+
+	/* honor the default governor policy, unless its invalid */
+	if (cpufreq_driver->setpolicy) {
+		init_policy = new_policy.policy;
+		if (cpufreq_parse_governor(policy->governor->name,
+				&new_policy.policy, &new_policy.governor)) {
+			new_policy.policy = init_policy;
+		}
+	}
+
 	/* assure that the starting sequence is run in cpufreq_set_policy */
 	policy->governor = NULL;
 
-- 
1.8.2.rc2

