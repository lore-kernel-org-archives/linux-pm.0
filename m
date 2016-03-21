From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: Introduce cpufreq_update_current_freq()
Date: Mon, 21 Mar 2016 15:46:25 +0100
Message-ID: <4711274.maD9A8j7Lu@vostro.rjw.lan>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1780622.pJaGsuQWcI@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the part of cpufreq_update_policy() that obtains the current
frequency from the driver and updates policy->cur if necessary to
a separate function, cpufreq_get_current_freq().

That should not introduce functional changes and subsequent change
set will need it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1555,6 +1555,24 @@ unsigned int cpufreq_get(unsigned int cp
 }
 EXPORT_SYMBOL(cpufreq_get);
 
+static unsigned int cpufreq_update_current_freq(struct cpufreq_policy *policy)
+{
+	unsigned int new_freq;
+
+	new_freq = cpufreq_driver->get(policy->cpu);
+	if (!new_freq)
+		return 0;
+
+	if (!policy->cur) {
+		pr_debug("cpufreq: Driver did not initialize current freq\n");
+		policy->cur = new_freq;
+	} else if (policy->cur != new_freq && has_target()) {
+		cpufreq_out_of_sync(policy, new_freq);
+	}
+
+	return new_freq;
+}
+
 static struct subsys_interface cpufreq_interface = {
 	.name		= "cpufreq",
 	.subsys		= &cpu_subsys,
@@ -2264,19 +2282,11 @@ int cpufreq_update_policy(unsigned int c
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		new_policy.cur = cpufreq_driver->get(cpu);
+		new_policy.cur = cpufreq_update_current_freq(policy);
 		if (WARN_ON(!new_policy.cur)) {
 			ret = -EIO;
 			goto unlock;
 		}
-
-		if (!policy->cur) {
-			pr_debug("Driver did not initialize current freq\n");
-			policy->cur = new_policy.cur;
-		} else {
-			if (policy->cur != new_policy.cur && has_target())
-				cpufreq_out_of_sync(policy, new_policy.cur);
-		}
 	}
 
 	ret = cpufreq_set_policy(policy, &new_policy);
