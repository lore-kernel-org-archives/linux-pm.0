From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 06/24] cpufreq: Use cpuhp_setup_state_nocalls_cpuslocked()
Date: Tue, 18 Apr 2017 19:04:48 +0200
Message-ID: <20170418170552.865966021@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757674AbdDRTuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 15:50:22 -0400
Content-Disposition: inline;
 filename=cpufreq-Use-cpuhp_setup_state_nocalls_locked.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

cpufreq holds get_online_cpus() while invoking cpuhp_setup_state_nocalls()
to make subsys_interface_register() and the registration of hotplug calls
atomic versus cpu hotplug.

cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
correct, but prevents the conversion of the hotplug locking to a percpu
rwsem.

Use cpuhp_setup/remove_state_nocalls_cpuslocked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

---
 drivers/cpufreq/cpufreq.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
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
@@ -2519,7 +2520,7 @@ int cpufreq_unregister_driver(struct cpu
 	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	remove_boost_sysfs_file();
-	cpuhp_remove_state_nocalls(hp_online);
+	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 
