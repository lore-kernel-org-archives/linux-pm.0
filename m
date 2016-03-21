From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] cpufreq: Introduce cpufreq_start_governor()
Date: Mon, 21 Mar 2016 15:45:24 +0100
Message-ID: <5659583.gVxCIrvT16@vostro.rjw.lan>
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

Starting a governor in cpufreq always follows the same pattern
involving two calls to cpufreq_governor(), one with the event
argument set to CPUFREQ_GOV_START and one with that argument set to
CPUFREQ_GOV_LIMITS.

Introduce cpufreq_start_governor() that will carry out those two
operations and make all places where governors are started use it.

That slightly modifies the behavior of cpufreq_set_policy() which
now also will go back to the old governor if the second call to
cpufreq_governor() (the one with event equal to CPUFREQ_GOV_LIMITS)
fails, but that really is how it should work in the first place.

Also cpufreq_resume() will now pring an error message if the
CPUFREQ_GOV_LIMITS call to cpufreq_governor() fails, but that
makes it follow cpufreq_add_policy_cpu() and cpufreq_offline()
in that respect.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -76,6 +76,7 @@ static inline bool has_target(void)
 /* internal prototypes */
 static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
+static int cpufreq_start_governor(struct cpufreq_policy *policy);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -1015,10 +1016,7 @@ static int cpufreq_add_policy_cpu(struct
 	cpumask_set_cpu(cpu, policy->cpus);
 
 	if (has_target()) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
-		if (!ret)
-			ret = cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
-
+		ret = cpufreq_start_governor(policy);
 		if (ret)
 			pr_err("%s: Failed to start governor\n", __func__);
 	}
@@ -1376,10 +1374,7 @@ static void cpufreq_offline(unsigned int
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
-			ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
-			if (!ret)
-				ret = cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
-
+			ret = cpufreq_start_governor(policy);
 			if (ret)
 				pr_err("%s: Failed to start governor\n", __func__);
 		}
@@ -1659,9 +1654,7 @@ void cpufreq_resume(void)
 				policy);
 		} else {
 			down_write(&policy->rwsem);
-			ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
-			if (!ret)
-				cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+			ret = cpufreq_start_governor(policy);
 			up_write(&policy->rwsem);
 
 			if (ret)
@@ -2047,6 +2040,14 @@ static int cpufreq_governor(struct cpufr
 	return ret;
 }
 
+static int cpufreq_start_governor(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
+	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+}
+
 int cpufreq_register_governor(struct cpufreq_governor *governor)
 {
 	int err;
@@ -2183,8 +2184,10 @@ static int cpufreq_set_policy(struct cpu
 		return cpufreq_driver->setpolicy(new_policy);
 	}
 
-	if (new_policy->governor == policy->governor)
-		goto out;
+	if (new_policy->governor == policy->governor) {
+		pr_debug("cpufreq: governor limits update\n");
+		return cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	}
 
 	pr_debug("governor switch\n");
 
@@ -2212,10 +2215,11 @@ static int cpufreq_set_policy(struct cpu
 	policy->governor = new_policy->governor;
 	ret = cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
 	if (!ret) {
-		ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
-		if (!ret)
-			goto out;
-
+		ret = cpufreq_start_governor(policy);
+		if (!ret) {
+			pr_debug("cpufreq: governor change\n");
+			return 0;
+		}
 		cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 	}
 
@@ -2226,14 +2230,10 @@ static int cpufreq_set_policy(struct cpu
 		if (cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
 			policy->governor = NULL;
 		else
-			cpufreq_governor(policy, CPUFREQ_GOV_START);
+			cpufreq_start_governor(policy);
 	}
 
 	return ret;
-
- out:
-	pr_debug("governor: change or update limits\n");
-	return cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 }
 
 /**
