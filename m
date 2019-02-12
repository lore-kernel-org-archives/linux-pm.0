From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date: Tue, 12 Feb 2019 16:36:04 +0530
Message-ID: <7fcdface56ccc5df0e50738253eb3e696b2f8980.1549969209.git.viresh.kumar@linaro.org>
References: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core doesn't remove the cpufreq policy anymore on CPU
offline operation, rather that happens when the CPU device gets
unregistered from the kernel. This allows faster recovery when the CPU
comes back online. This is also very useful during system wide
suspend/resume where we offline all non-boot CPUs during suspend and
then bring them back on resume.

This commit takes the same idea a step ahead to allow drivers to do
light weight tear-down and bring-up during CPU offline and online
operations.

A new set of callbacks is introduced, online/offline(). online() gets
called when the first CPU of an inactive policy is brought up and
offline() gets called when all the CPUs of a policy are offlined.

The existing init/exit() callback get called on policy
creation/destruction. They also get called instead of online/offline()
callbacks if the online/offline() callbacks aren't provided.

This also moves around some code to get executed only for the new-policy
case going forward.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Use != instead of ^

 drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++++--------------
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96a69c67a545..55e9795801a4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1201,28 +1201,39 @@ static int cpufreq_online(unsigned int cpu)
 			return -ENOMEM;
 	}
 
-	cpumask_copy(policy->cpus, cpumask_of(cpu));
+	if (!new_policy && cpufreq_driver->online) {
+		ret = cpufreq_driver->online(policy);
+		if (ret) {
+			pr_debug("%s: %d: initialization failed\n", __func__,
+				 __LINE__);
+			goto out_exit_policy;
+		}
 
-	/* call driver. From then on the cpufreq must be able
-	 * to accept all calls to ->verify and ->setpolicy for this CPU
-	 */
-	ret = cpufreq_driver->init(policy);
-	if (ret) {
-		pr_debug("initialization failed\n");
-		goto out_free_policy;
-	}
+		/* Recover policy->cpus using related_cpus */
+		cpumask_copy(policy->cpus, policy->related_cpus);
+	} else {
+		cpumask_copy(policy->cpus, cpumask_of(cpu));
 
-	ret = cpufreq_table_validate_and_sort(policy);
-	if (ret)
-		goto out_exit_policy;
+		/*
+		 * Call driver. From then on the cpufreq must be able
+		 * to accept all calls to ->verify and ->setpolicy for this CPU.
+		 */
+		ret = cpufreq_driver->init(policy);
+		if (ret) {
+			pr_debug("%s: %d: initialization failed\n", __func__,
+				 __LINE__);
+			goto out_free_policy;
+		}
 
-	down_write(&policy->rwsem);
+		ret = cpufreq_table_validate_and_sort(policy);
+		if (ret)
+			goto out_exit_policy;
 
-	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
+	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1421,11 +1432,12 @@ static int cpufreq_offline(unsigned int cpu)
 		cpufreq_exit_governor(policy);
 
 	/*
-	 * Perform the ->exit() even during light-weight tear-down,
-	 * since this is a core component, and is essential for the
-	 * subsequent light-weight ->init() to succeed.
+	 * Perform the ->offline() during light-weight tear-down, as
+	 * that allows fast recovery when the CPU comes back.
 	 */
-	if (cpufreq_driver->exit) {
+	if (cpufreq_driver->offline) {
+		cpufreq_driver->offline(policy);
+	} else if (cpufreq_driver->exit) {
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
@@ -1454,8 +1466,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus))
+	if (cpumask_empty(policy->real_cpus)) {
+		/* We did light-weight exit earlier, do full tear down now */
+		if (cpufreq_driver->offline)
+			cpufreq_driver->exit(policy);
+
 		cpufreq_policy_free(policy);
+	}
 }
 
 /**
@@ -2488,7 +2505,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 		    driver_data->target) ||
 	     (driver_data->setpolicy && (driver_data->target_index ||
 		    driver_data->target)) ||
-	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate))
+	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
+	     (!driver_data->online != !driver_data->offline))
 		return -EINVAL;
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9db074ecbbd7..b160e98076e3 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -325,6 +325,8 @@ struct cpufreq_driver {
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
+	int		(*online)(struct cpufreq_policy *policy);
+	int		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
 	void		(*stop_cpu)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
-- 
2.20.1.321.g9e740568ce00
