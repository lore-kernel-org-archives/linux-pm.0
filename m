From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][PATCH] cpufreq: Do not hold driver module references for additional policy CPUs
Date: Thu, 01 Aug 2013 22:53:59 +0200
Message-ID: <2298639.F0Qv2QqRnZ@vostro.rjw.lan>
References: <2362640.pUofnXyzOi@vostro.rjw.lan> <51FAC46D.1000703@linux.vnet.ibm.com> <1757496.qSuJuAun9Z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1757496.qSuJuAun9Z@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: Do not hold driver module references for additional policy CPUs

The cpufreq core is a little inconsistent in the way it uses the
driver module refcount.

Namely, if __cpufreq_add_dev() is called for a CPU that doesn't
share the policy object with any other CPUs, the driver module
refcount it grabs to start with will be dropped by it before
returning and will be equal to 0 afterward.

However, if the given CPU does share the policy object with other
CPUs, either cpufreq_add_policy_cpu() is called to link the new CPU
to the existing policy, or cpufreq_add_dev_symlink() is used to link
the other CPUs sharing the policy with it to the just created policy
object.  In that case, because both cpufreq_add_policy_cpu() and
cpufreq_add_dev_symlink() call cpufreq_cpu_get() for the given
policy (the latter possibly many times) without the balancing
cpufreq_cpu_put() (unless there is an error), the driver module
refcount will be left by __cpufreq_add_dev() with a nonzero value.

To remove that inconsistency make cpufreq_add_policy_cpu() execute
cpufreq_cpu_put() for the given policy before returning, which
decrements the driver module refcount so that it will be 0 after
__cpufreq_add_dev() returns.  Moreover, remove the cpufreq_cpu_get()
call from cpufreq_add_dev_symlink(), since both the policy refcount
and the driver module refcount are nonzero when it is called and they
don't need to be bumped up by it.

Accordingly, drop the cpufreq_cpu_put() from __cpufreq_remove_dev(),
since it is only necessary to balance the cpufreq_cpu_get() called
by cpufreq_add_policy_cpu() or cpufreq_add_dev_symlink().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -818,14 +818,11 @@ static int cpufreq_add_dev_symlink(struc
 			continue;
 
 		pr_debug("Adding link for CPU: %u\n", j);
-		cpufreq_cpu_get(policy->cpu);
 		cpu_dev = get_cpu_device(j);
 		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
 					"cpufreq");
-		if (ret) {
-			cpufreq_cpu_put(policy);
-			return ret;
-		}
+		if (ret)
+			break;
 	}
 	return ret;
 }
@@ -908,7 +905,8 @@ static int cpufreq_add_policy_cpu(unsign
 	unsigned long flags;
 
 	policy = cpufreq_cpu_get(sibling);
-	WARN_ON(!policy);
+	if (WARN_ON_ONCE(!policy))
+		return -ENODATA;
 
 	if (has_target)
 		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
@@ -930,16 +928,10 @@ static int cpufreq_add_policy_cpu(unsign
 	}
 
 	/* Don't touch sysfs links during light-weight init */
-	if (frozen) {
-		/* Drop the extra refcount that we took above */
-		cpufreq_cpu_put(policy);
-		return 0;
-	}
-
-	ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
-	if (ret)
-		cpufreq_cpu_put(policy);
+	if (!frozen)
+		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 
+	cpufreq_cpu_put(policy);
 	return ret;
 }
 #endif
@@ -1298,12 +1290,6 @@ static int __cpufreq_remove_dev(struct d
 		if (!frozen)
 			cpufreq_policy_free(data);
 	} else {
-
-		if (!frozen) {
-			pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
-			cpufreq_cpu_put(data);
-		}
-
 		if (cpufreq_driver->target) {
 			__cpufreq_governor(data, CPUFREQ_GOV_START);
 			__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);

