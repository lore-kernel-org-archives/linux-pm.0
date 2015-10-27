From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 61/70] cpufreq: interactive: restructure CPUFREQ_GOV_LIMITS
Date: Tue, 27 Oct 2015 18:30:49 +0100
Message-ID: <1445967059-6897-61-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36221 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965253AbbJ0Rdw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:33:52 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Badhri Jagan Sridharan <Badhri@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Badhri Jagan Sridharan <Badhri@google.com>

The cpufreq_interactive_timer gets cancelled and rescheduled
whenever the cpufreq_policy is changed. When the cpufreq policy is
changed at a rate faster than the sampling_rate of the interactive
governor, then the governor misses to change the target frequency
for long duration. The patch removes the need of cancelling the
timers when policy->min is changed.

Signed-off-by: Badhri Jagan Sridharan <Badhri@google.com>
Change-Id: Ibd98d151e1c73b8bd969484583ff98ee9f1135ef
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   48 ++++++++++++++++++++++++-=
--------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 786fd01..0e3e45e 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -44,8 +44,10 @@ struct cpufreq_interactive_cpuinfo {
 	u64 cputime_speedadj_timestamp;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
+	spinlock_t target_freq_lock; /*protects target freq */
 	unsigned int target_freq;
 	unsigned int floor_freq;
+	unsigned int max_freq;
 	u64 floor_validate_time;
 	u64 hispeed_validate_time;
 	struct rw_semaphore enable_sem;
@@ -358,6 +360,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	if (WARN_ON_ONCE(!delta_time))
 		goto rearm;
=20
+	spin_lock_irqsave(&pcpu->target_freq_lock, flags);
 	do_div(cputime_speedadj, delta_time);
 	loadadjfreq =3D (unsigned int)cputime_speedadj * 100;
 	cpu_load =3D loadadjfreq / pcpu->target_freq;
@@ -383,6 +386,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		trace_cpufreq_interactive_notyet(
 			data, cpu_load, pcpu->target_freq,
 			pcpu->policy->cur, new_freq);
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
 		goto rearm;
 	}
=20
@@ -390,8 +394,10 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
=20
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
 					   new_freq, CPUFREQ_RELATION_L,
-					   &index))
+					   &index)) {
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
 		goto rearm;
+	}
=20
 	new_freq =3D pcpu->freq_table[index].frequency;
=20
@@ -405,6 +411,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 			trace_cpufreq_interactive_notyet(
 				data, cpu_load, pcpu->target_freq,
 				pcpu->policy->cur, new_freq);
+			spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
 			goto rearm;
 		}
 	}
@@ -426,6 +433,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		trace_cpufreq_interactive_already(
 			data, cpu_load, pcpu->target_freq,
 			pcpu->policy->cur, new_freq);
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
 		goto rearm_if_notmax;
 	}
=20
@@ -433,6 +441,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 					 pcpu->policy->cur, new_freq);
=20
 	pcpu->target_freq =3D new_freq;
+	spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
 	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
 	cpumask_set_cpu(data, &speedchange_cpumask);
 	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
@@ -576,16 +585,17 @@ static void cpufreq_interactive_boost(void)
 {
 	int i;
 	int anyboost =3D 0;
-	unsigned long flags;
+	unsigned long flags[2];
 	struct cpufreq_interactive_cpuinfo *pcpu;
 	struct cpufreq_interactive_tunables *tunables;
=20
-	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
+	spin_lock_irqsave(&speedchange_cpumask_lock, flags[0]);
=20
 	for_each_online_cpu(i) {
 		pcpu =3D &per_cpu(cpuinfo, i);
 		tunables =3D pcpu->policy->governor_data;
=20
+		spin_lock_irqsave(&pcpu->target_freq_lock, flags[1]);
 		if (pcpu->target_freq < tunables->hispeed_freq) {
 			pcpu->target_freq =3D tunables->hispeed_freq;
 			cpumask_set_cpu(i, &speedchange_cpumask);
@@ -601,9 +611,10 @@ static void cpufreq_interactive_boost(void)
=20
 		pcpu->floor_freq =3D tunables->hispeed_freq;
 		pcpu->floor_validate_time =3D ktime_to_us(ktime_get());
+		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags[1]);
 	}
=20
-	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags);
+	spin_unlock_irqrestore(&speedchange_cpumask_lock, flags[0]);
=20
 	if (anyboost)
 		wake_up_process(speedchange_task);
@@ -1114,6 +1125,7 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 	struct cpufreq_interactive_cpuinfo *pcpu;
 	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_interactive_tunables *tunables;
+	unsigned long flags;
=20
 	if (have_governor_per_policy())
 		tunables =3D policy->governor_data;
@@ -1215,6 +1227,7 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 				ktime_to_us(ktime_get());
 			pcpu->hispeed_validate_time =3D
 				pcpu->floor_validate_time;
+			pcpu->max_freq =3D policy->max;
 			down_write(&pcpu->enable_sem);
 			del_timer_sync(&pcpu->cpu_timer);
 			del_timer_sync(&pcpu->cpu_slack_timer);
@@ -1250,29 +1263,37 @@ static int cpufreq_governor_interactive(struct =
cpufreq_policy *policy,
 		for_each_cpu(j, policy->cpus) {
 			pcpu =3D &per_cpu(cpuinfo, j);
=20
-			/* hold write semaphore to avoid race */
-			down_write(&pcpu->enable_sem);
+			down_read(&pcpu->enable_sem);
 			if (pcpu->governor_enabled =3D=3D 0) {
-				up_write(&pcpu->enable_sem);
+				up_read(&pcpu->enable_sem);
 				continue;
 			}
=20
-			/* update target_freq firstly */
+			spin_lock_irqsave(&pcpu->target_freq_lock, flags);
 			if (policy->max < pcpu->target_freq)
 				pcpu->target_freq =3D policy->max;
 			else if (policy->min > pcpu->target_freq)
 				pcpu->target_freq =3D policy->min;
=20
-			/* Reschedule timer.
+			spin_unlock_irqrestore(&pcpu->target_freq_lock, flags);
+			up_read(&pcpu->enable_sem);
+
+			/* Reschedule timer only if policy->max is raised.
 			 * Delete the timers, else the timer callback may
 			 * return without re-arm the timer when failed
 			 * acquire the semaphore. This race may cause timer
 			 * stopped unexpectedly.
 			 */
-			del_timer_sync(&pcpu->cpu_timer);
-			del_timer_sync(&pcpu->cpu_slack_timer);
-			cpufreq_interactive_timer_start(tunables, j);
-			up_write(&pcpu->enable_sem);
+
+			if (policy->max > pcpu->max_freq) {
+				down_write(&pcpu->enable_sem);
+				del_timer_sync(&pcpu->cpu_timer);
+				del_timer_sync(&pcpu->cpu_slack_timer);
+				cpufreq_interactive_timer_start(tunables, j);
+				up_write(&pcpu->enable_sem);
+			}
+
+			pcpu->max_freq =3D policy->max;
 		}
 		break;
 	}
@@ -1308,6 +1329,7 @@ static int __init cpufreq_interactive_init(void)
 		init_timer(&pcpu->cpu_slack_timer);
 		pcpu->cpu_slack_timer.function =3D cpufreq_interactive_nop_timer;
 		spin_lock_init(&pcpu->load_lock);
+		spin_lock_init(&pcpu->target_freq_lock);
 		init_rwsem(&pcpu->enable_sem);
 	}
=20
--=20
1.7.9.5

