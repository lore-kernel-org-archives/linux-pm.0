From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/22] cpufreq/acpi-cpufreq: Convert to hotplug state machine
Date: Sun, 27 Nov 2016 00:13:29 +0100
Message-ID: <20161126231350.10321-2-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbcKZXOW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2016 18:14:22 -0500
In-Reply-To: <20161126231350.10321-1-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Install the callbacks via the state machine.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/acpi-cpufreq.c | 93 ++++++++++++++++++++------------------=
----
 1 file changed, 45 insertions(+), 48 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 297e9128fe9f..2c29cbaca7b5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -536,46 +536,33 @@ static void free_acpi_perf_data(void)
 	free_percpu(acpi_perf_data);
 }
=20
-static int boost_notify(struct notifier_block *nb, unsigned long action,
-		      void *hcpu)
+static int cpufreq_boost_online(unsigned int cpu)
+{
+	const struct cpumask *cpumask;
+
+	cpumask =3D get_cpu_mask(cpu);
+	/*
+	 * On the CPU_UP path we simply keep the boost-disable flag
+	 * in sync with the current global state.
+	 */
+	boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
+	return 0;
+}
+
+static int cpufreq_boost_down_prep(unsigned int cpu)
 {
-	unsigned cpu =3D (long)hcpu;
 	const struct cpumask *cpumask;
=20
 	cpumask =3D get_cpu_mask(cpu);
=20
 	/*
 	 * Clear the boost-disable bit on the CPU_DOWN path so that
-	 * this cpu cannot block the remaining ones from boosting. On
-	 * the CPU_UP path we simply keep the boost-disable flag in
-	 * sync with the current global state.
+	 * this cpu cannot block the remaining ones from boosting.
 	 */
-
-	switch (action) {
-	case CPU_DOWN_FAILED:
-	case CPU_DOWN_FAILED_FROZEN:
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-		boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
-		break;
-
-	case CPU_DOWN_PREPARE:
-	case CPU_DOWN_PREPARE_FROZEN:
-		boost_set_msrs(1, cpumask);
-		break;
-
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
+	boost_set_msrs(1, cpumask);
+	return 0;
 }
=20
-
-static struct notifier_block boost_nb =3D {
-	.notifier_call          =3D boost_notify,
-};
-
 /*
  * acpi_cpufreq_early_init - initialize ACPI P-States library
  *
@@ -922,37 +909,47 @@ static struct cpufreq_driver acpi_cpufreq_driver =3D {
 	.attr		=3D acpi_cpufreq_attr,
 };
=20
+static enum cpuhp_state acpi_cpufreq_online;
+
 static void __init acpi_cpufreq_boost_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)) {
-		msrs =3D msrs_alloc();
+	int ret;
=20
-		if (!msrs)
-			return;
+	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
+		return;
=20
-		acpi_cpufreq_driver.set_boost =3D set_boost;
-		acpi_cpufreq_driver.boost_enabled =3D boost_state(0);
+	msrs =3D msrs_alloc();
=20
-		cpu_notifier_register_begin();
+	if (!msrs)
+		return;
=20
-		/* Force all MSRs to the same value */
-		boost_set_msrs(acpi_cpufreq_driver.boost_enabled,
-			       cpu_online_mask);
+	acpi_cpufreq_driver.set_boost =3D set_boost;
+	acpi_cpufreq_driver.boost_enabled =3D boost_state(0);
=20
-		__register_cpu_notifier(&boost_nb);
-
-		cpu_notifier_register_done();
+	/*
+	 * This calls the online callback on all online cpu and forces all
+	 * MSRs to the same value.
+	 */
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cpufreq/acpi:online",
+				cpufreq_boost_online, cpufreq_boost_down_prep);
+	if (ret < 0) {
+		pr_err("acpi_cpufreq: failed to register hotplug callbacks\n");
+		msrs_free(msrs);
+		return;
 	}
+	acpi_cpufreq_online =3D ret;
 }
=20
 static void acpi_cpufreq_boost_exit(void)
 {
-	if (msrs) {
-		unregister_cpu_notifier(&boost_nb);
+	if (!msrs)
+		return;
=20
-		msrs_free(msrs);
-		msrs =3D NULL;
-	}
+	if (acpi_cpufreq_online >=3D 0)
+		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
+
+	msrs_free(msrs);
+	msrs =3D NULL;
 }
=20
 static int __init acpi_cpufreq_init(void)
--=20
2.10.2

