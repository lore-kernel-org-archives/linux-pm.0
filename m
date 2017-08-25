From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v4 02/10] cpufreq: provide default frequency-invariance setter function
Date: Fri, 25 Aug 2017 15:31:58 +0100
Message-ID: <20170825143206.30467-3-dietmar.eggemann@arm.com>
References: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754632AbdHYOcc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Aug 2017 10:32:32 -0400
In-Reply-To: <20170825143206.30467-1-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

Frequency-invariant accounting support based on the ratio of current
frequency and maximum supported frequency is an optional feature an arch
can implement.

Since there are cpufreq drivers (e.g. cpufreq-dt) which can be build for
different arch's a default implementation of the frequency-invariance
setter function arch_set_freq_scale() is needed.

This default implementation is an empty weak function which will be
overwritten by a strong function in case the arch provides one.

The setter function passes the cpumask of related (to the frequency
change) cpus (online and offline cpus), the (new) current frequency and
the maximum supported frequency.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 include/linux/cpufreq.h   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9bf97a366029..ced8d539d0d5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -161,6 +161,12 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 
+__weak void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+		unsigned long max_freq)
+{
+}
+EXPORT_SYMBOL_GPL(arch_set_freq_scale);
+
 /*
  * This is a generic cpufreq init() routine which can be used by cpufreq
  * drivers of SMP systems. It will do following:
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f10a9b3761cd..e38acc1a4d47 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -899,6 +899,9 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
 
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
+extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+				unsigned long max_freq);
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.11.0
