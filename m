From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 09/32] cpufreq: Use cpuhp_setup_state_nocalls_cpuslocked()
Date: Wed, 24 May 2017 10:15:20 +0200
Message-ID: <20170524081547.731628408@linutronix.de>
References: <20170524081511.203800767@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpufreq_Use_cpuhp_setup_state_nocalls_cpuslocked().patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

cpufreq holds get_online_cpus() while invoking cpuhp_setup_state_nocalls()
to make subsys_interface_register() and the registration of hotplug calls
atomic versus cpu hotplug.

cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
correct, but prevents the conversion of the hotplug locking to a percpu
rwsem.

Use cpuhp_setup/remove_state_nocalls_cpuslocked() to avoid the nested
call. Convert *_online_cpus() to the new interfaces while at it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>

---
 drivers/cpufreq/cpufreq.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -887,7 +887,7 @@ static ssize_t store(struct kobject *kob
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
-	get_online_cpus();
+	cpus_read_lock();
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
@@ -895,7 +895,7 @@ static ssize_t store(struct kobject *kob
 		up_write(&policy->rwsem);
 	}
 
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -2441,7 +2441,7 @@ int cpufreq_register_driver(struct cpufr
 	pr_debug("trying to register driver %s\n", driver_data->name);
 
 	/* Protect against concurrent CPU online/offline. */
-	get_online_cpus();
+	cpus_read_lock();
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	if (cpufreq_driver) {
@@ -2473,9 +2473,10 @@ int cpufreq_register_driver(struct cpufr
 		goto err_if_unreg;
 	}
 
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
-					cpuhp_cpufreq_online,
-					cpuhp_cpufreq_offline);
+	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
+						   "cpufreq:online",
+						   cpuhp_cpufreq_online,
+						   cpuhp_cpufreq_offline);
 	if (ret < 0)
 		goto err_if_unreg;
 	hp_online = ret;
@@ -2493,7 +2494,7 @@ int cpufreq_register_driver(struct cpufr
 	cpufreq_driver = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 out:
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_register_driver);
@@ -2516,17 +2517,17 @@ int cpufreq_unregister_driver(struct cpu
 	pr_debug("unregistering driver %s\n", driver->name);
 
 	/* Protect against concurrent cpu hotplug */
-	get_online_cpus();
+	cpus_read_lock();
 	subsys_interface_unregister(&cpufreq_interface);
 	remove_boost_sysfs_file();
-	cpuhp_remove_state_nocalls(hp_online);
+	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	cpufreq_driver = NULL;
 
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return 0;
 }
