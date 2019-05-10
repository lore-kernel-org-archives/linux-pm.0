From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Explain the kobject_put() in cpufreq_policy_alloc()
Date: Fri, 10 May 2019 12:35:53 +0200
Message-ID: <2270903.5qkiGuZaYc@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It may not be particularly clear why the kobject_put() after
failing kobject_init_and_add() in cpufreq_policy_alloc() is not
redundant, so add a comment to explain that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1133,6 +1133,11 @@ static struct cpufreq_policy *cpufreq_po
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		/*
+		 * The entire policy object will be freed below, but the extra
+		 * memory allocated for the kobject name needs to be freed by
+		 * releasing the kobject.
+		 */
 		kobject_put(&policy->kobj);
 		goto err_free_real_cpus;
 	}
