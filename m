From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] cpufreq: Add kerneldoc comments for two core functions
Date: Wed, 20 Feb 2019 00:22:51 +0100
Message-ID: <3161414.QiNJczLRHX@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add kerneldoc comments describing cpufreq_set_policy() and
cpufreq_update_policy() as they have not been properly documented
so far and they really need to be documented.

While at it, fix white space around the cpufreq_set_policy() header.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2218,12 +2218,25 @@ int cpufreq_get_policy(struct cpufreq_po
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
-/*
- * policy : current policy.
- * new_policy: policy to be set.
+/**
+ * cpufreq_set_policy - Modify cpufreq policy parameters.
+ * @policy: Policy object to modify.
+ * @new_policy: New policy data.
+ *
+ * Pass @new_policy to the cpufreq driver's ->verify() callback, run the
+ * installed policy notifiers for it with the CPUFREQ_ADJUST value, pass it to
+ * the driver's ->verify() callback again and run the notifiers for it again
+ * with the CPUFREQ_NOTIFY value.  Next, copy the min and max parameters
+ * of @new_policy to @policy and either invoke the driver's ->setpolicy()
+ * callback (if present) or carry out a governor update for @policy.  That is,
+ * run the current governor's ->limits() callback (if the governor field in
+ * @new_policy points to the same object as the one in @policy) or replace the
+ * governor for @policy with the new one stored in @new_policy.
+ *
+ * The cpuinfo part of @policy is not updated by this function.
  */
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
-				struct cpufreq_policy *new_policy)
+			      struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
 	int ret;
@@ -2319,11 +2332,14 @@ static int cpufreq_set_policy(struct cpu
 }
 
 /**
- *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
- *	@cpu: CPU which shall be re-evaluated
+ * cpufreq_update_policy - Re-evaluate an existing cpufreq policy.
+ * @cpu: CPU to re-evaluate the policy for.
  *
- *	Useful for policy notifiers which have different necessities
- *	at different times.
+ * Update the current frequency for the cpufreq policy of @cpu and use
+ * cpufreq_set_policy() to re-apply the min and max limits saved in the
+ * user_policy sub-structure of that policy, which triggers the evaluation
+ * of policy notifiers and the cpufreq driver's ->verify() callback for the
+ * policy in question, among other things.
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
