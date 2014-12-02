From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 03/10] cpufreq: Architecture specific callback for frequency changes
Date: Tue,  2 Dec 2014 14:06:25 +0000
Message-ID: <1417529192-11579-4-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39627 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbaLBOG6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 09:06:58 -0500
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <Morten.Rasmussen@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

From: Morten Rasmussen <Morten.Rasmussen@arm.com>

Architectures that don't have any other means for tracking cpu frequency
changes need a callback from cpufreq to implement a scaling factor to
enable scale-invariant per-entity load-tracking in the scheduler.

To compute the scale invariance correction factor the architecture would
need to know both the max frequency and the current frequency. This
patch defines weak functions for setting both from cpufreq.

Related architecture specific functions use weak function definitions.
The same approach is followed here.

These callbacks can be used to implement frequency scaling of cpu
capacity later.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/cpufreq/cpufreq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 644b54e..1b17608 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -278,6 +278,10 @@ static inline void adjust_jiffies(unsigned long val, s=
truct cpufreq_freqs *ci)
 }
 #endif
=20
+void __weak arch_scale_set_curr_freq(int cpu, unsigned long freq) {}
+
+void __weak arch_scale_set_max_freq(int cpu, unsigned long freq) {}
+
 static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
 =09=09struct cpufreq_freqs *freqs, unsigned int state)
 {
@@ -315,6 +319,7 @@ static void __cpufreq_notify_transition(struct cpufreq_=
policy *policy,
 =09=09pr_debug("FREQ: %lu - CPU: %lu\n",
 =09=09=09 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
 =09=09trace_cpu_frequency(freqs->new, freqs->cpu);
+=09=09arch_scale_set_curr_freq(freqs->cpu, freqs->new);
 =09=09srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 =09=09=09=09CPUFREQ_POSTCHANGE, freqs);
 =09=09if (likely(policy) && likely(policy->cpu =3D=3D freqs->cpu))
@@ -2164,7 +2169,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *=
policy,
 =09=09=09=09struct cpufreq_policy *new_policy)
 {
 =09struct cpufreq_governor *old_gov;
-=09int ret;
+=09int ret, cpu;
=20
 =09pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
 =09=09 new_policy->cpu, new_policy->min, new_policy->max);
@@ -2202,6 +2207,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *=
policy,
 =09policy->min =3D new_policy->min;
 =09policy->max =3D new_policy->max;
=20
+=09for_each_cpu(cpu, policy->cpus)
+=09=09arch_scale_set_max_freq(cpu, policy->max);
+
 =09pr_debug("new min and max freqs are %u - %u kHz\n",
 =09=09 policy->min, policy->max);
=20
--=20
1.9.1


