From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: Make cpufreq_update_policy() void
Date: Fri, 18 Nov 2016 13:59:21 +0100
Message-ID: <1530666.Sy9rOD7LaC@vostro.rjw.lan>
References: <1975886.qL3AyWerjl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1975886.qL3AyWerjl@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The return value of cpufreq_update_policy() is never used, so make
it void.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/9436381/

---
 drivers/cpufreq/cpufreq.c |   21 +++++++--------------
 include/linux/cpufreq.h   |    2 +-
 2 files changed, 8 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2257,21 +2257,18 @@ static int cpufreq_set_policy(struct cpu
  *	Useful for policy notifiers which have different necessities
  *	at different times.
  */
-int cpufreq_update_policy(unsigned int cpu)
+void cpufreq_update_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cpufreq_policy new_policy;
-	int ret;
 
 	if (!policy)
-		return -ENODEV;
+		return;
 
 	down_write(&policy->rwsem);
 
-	if (policy_is_inactive(policy)) {
-		ret = -ENODEV;
+	if (policy_is_inactive(policy))
 		goto unlock;
-	}
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
@@ -2283,24 +2280,20 @@ int cpufreq_update_policy(unsigned int c
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		if (cpufreq_suspended) {
-			ret = -EAGAIN;
+		if (cpufreq_suspended)
 			goto unlock;
-		}
+
 		new_policy.cur = cpufreq_update_current_freq(policy);
-		if (WARN_ON(!new_policy.cur)) {
-			ret = -EIO;
+		if (WARN_ON(!new_policy.cur))
 			goto unlock;
-		}
 	}
 
-	ret = cpufreq_set_policy(policy, &new_policy);
+	cpufreq_set_policy(policy, &new_policy);
 
 unlock:
 	up_write(&policy->rwsem);
 
 	cpufreq_cpu_put(policy);
-	return ret;
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -175,7 +175,7 @@ void disable_cpufreq(void);
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
-int cpufreq_update_policy(unsigned int cpu);
+void cpufreq_update_policy(unsigned int cpu);
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);

