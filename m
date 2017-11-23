From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] cpufreq: Fix governor module removal race
Date: Thu, 23 Nov 2017 01:29:37 +0100
Message-ID: <2007526.uAUpsoPmOG@aspire.rjw.lan>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is possible to remove a cpufreq governor module after
cpufreq_parse_governor() has returned success in
store_scaling_governor() and before cpufreq_set_policy()
acquires a reference to it, because the governor list is
not protected during that period and nothing prevents the
governor from being unregistered then.  The pointer to the
governor structure coming from cpufreq_parse_governor() may
become stale as a result of that.

Prevent that from happening by acquiring an extra reference
to the governor module temporarily in cpufreq_parse_governor(),
under cpufreq_governor_mutex, and dropping it in
store_scaling_governor(), when cpufreq_set_policy() returns.

Note that the second cpufreq_parse_governor() call site is fine,
because it only cares about the policy member of new_policy.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -607,11 +607,13 @@ static int cpufreq_parse_governor(char *
 	if (cpufreq_driver->setpolicy) {
 		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+			policy->governor = NULL;
 			return 0;
 		}
 
 		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
 			policy->policy = CPUFREQ_POLICY_POWERSAVE;
+			policy->governor = NULL;
 			return 0;
 		}
 	} else {
@@ -633,6 +635,8 @@ static int cpufreq_parse_governor(char *
 
 			t = find_governor(str_governor);
 		}
+		if (t && !try_module_get(t->owner))
+			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 
@@ -766,6 +770,10 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
 
