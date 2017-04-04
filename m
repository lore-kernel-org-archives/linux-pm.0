From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Date: Tue,  4 Apr 2017 17:49:57 +0200
Message-ID: <20170404154957.19678-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdDDPuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 11:50:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

It is pure mystery to me why we need to be on a specific CPU while
looking up a value in an array.
My best shot at this is that before commit d4019f0a92ab ("cpufreq: move
freq change notifications to cpufreq core") it was required to invoke
cpufreq_notify_transition() on a special CPU.

Since it looks like a waste, remove it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpufreq/loongson2_cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson=
2_cpufreq.c
index 6bbdac1065ff..9ac27b22476c 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -51,19 +51,12 @@ static int loongson2_cpu_freq_notifier(struct notifier_=
block *nb,
 static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
-	unsigned int cpu =3D policy->cpu;
-	cpumask_t cpus_allowed;
 	unsigned int freq;
=20
-	cpus_allowed =3D current->cpus_allowed;
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-
 	freq =3D
 	    ((cpu_clock_freq / 1000) *
 	     loongson2_clockmod_table[index].driver_data) / 8;
=20
-	set_cpus_allowed_ptr(current, &cpus_allowed);
-
 	/* setting the cpu frequency */
 	clk_set_rate(policy->clk, freq * 1000);
=20
--=20
2.11.0
