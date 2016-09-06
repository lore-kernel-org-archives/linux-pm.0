From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/21] cpufreq: Convert to hotplug state machine
Date: Tue,  6 Sep 2016 19:04:48 +0200
Message-ID: <20160906170457.32393-13-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Install the callbacks via the state machine.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/cpufreq.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3dd4884c6f9e..e0bc632a259e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1358,7 +1358,7 @@ static int cpufreq_add_dev(struct device *dev, struct=
 subsys_interface *sif)
 	return add_cpu_dev_symlink(policy, cpu);
 }
=20
-static void cpufreq_offline(unsigned int cpu)
+static int cpufreq_offline(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
 	int ret;
@@ -1368,7 +1368,7 @@ static void cpufreq_offline(unsigned int cpu)
 	policy =3D cpufreq_cpu_get_raw(cpu);
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return;
+		return 0;
 	}
=20
 	down_write(&policy->rwsem);
@@ -1417,6 +1417,7 @@ static void cpufreq_offline(unsigned int cpu)
=20
 unlock:
 	up_write(&policy->rwsem);
+	return 0;
 }
=20
 /**
@@ -2332,28 +2333,6 @@ int cpufreq_update_policy(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
=20
-static int cpufreq_cpu_callback(struct notifier_block *nfb,
-					unsigned long action, void *hcpu)
-{
-	unsigned int cpu =3D (unsigned long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		cpufreq_online(cpu);
-		break;
-
-	case CPU_DOWN_PREPARE:
-		cpufreq_offline(cpu);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __refdata cpufreq_cpu_notifier =3D {
-	.notifier_call =3D cpufreq_cpu_callback,
-};
-
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
@@ -2455,6 +2434,7 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
 /*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
  *********************************************************************/
+static enum cpuhp_state hp_online;
=20
 /**
  * cpufreq_register_driver - register a CPU Frequency driver
@@ -2517,7 +2497,13 @@ int cpufreq_register_driver(struct cpufreq_driver *d=
river_data)
 		goto err_if_unreg;
 	}
=20
-	register_hotcpu_notifier(&cpufreq_cpu_notifier);
+	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
+					cpufreq_online,
+					cpufreq_offline);
+	if (ret < 0)
+		goto err_if_unreg;
+	hp_online =3D ret;
+
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
=20
@@ -2556,7 +2542,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *=
driver)
 	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
 	remove_boost_sysfs_file();
-	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_online);
=20
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
=20
--=20
2.9.3
