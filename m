From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 51/70] cpufreq: interactive: resched timer if max freq raised
Date: Tue, 27 Oct 2015 18:30:39 +0100
Message-ID: <1445967059-6897-51-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38396 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965558AbbJ0RdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:33:18 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <a22439@motorola.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Lianwei Wang <a22439@motorola.com>

When the policy max freq is raised, and before the timer is
rescheduled in idle callback, the cpu freq may stuck at a
lower freq.

The target_freq shall be updated too, else on a high load
situation, the new_freq is always equal to target_freq and
which will cause freq stuck at a lower freq too.

Reschedule the timer on gov limits callback.

Change-Id: I6c187001ab43e859731429b64f75a74eebc37a24
Signed-off-by: Lianwei Wang <a22439@motorola.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   64 +++++++++++++++++++++++++=
++------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 691923d..90958fd 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -189,6 +189,32 @@ static void cpufreq_interactive_timer_resched(
 	spin_unlock_irqrestore(&pcpu->load_lock, flags);
 }
=20
+/* The caller shall take enable_sem write semaphore to avoid any timer=
 race.
+ * The cpu_timer and cpu_slack_timer must be deactivated when calling =
this
+ * function.
+ */
+static void cpufreq_interactive_timer_start(int cpu)
+{
+	struct cpufreq_interactive_cpuinfo *pcpu =3D &per_cpu(cpuinfo, cpu);
+	unsigned long expires =3D jiffies + usecs_to_jiffies(timer_rate);
+	unsigned long flags;
+
+	pcpu->cpu_timer.expires =3D expires;
+	add_timer_on(&pcpu->cpu_timer, cpu);
+	if (timer_slack_val >=3D 0 && pcpu->target_freq > pcpu->policy->min) =
{
+		expires +=3D usecs_to_jiffies(timer_slack_val);
+		pcpu->cpu_slack_timer.expires =3D expires;
+		add_timer_on(&pcpu->cpu_slack_timer, cpu);
+	}
+
+	spin_lock_irqsave(&pcpu->load_lock, flags);
+	pcpu->time_in_idle =3D
+		get_cpu_idle_time(cpu, &pcpu->time_in_idle_timestamp);
+	pcpu->cputime_speedadj =3D 0;
+	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
+	spin_unlock_irqrestore(&pcpu->load_lock, flags);
+}
+
 static unsigned int freq_to_above_hispeed_delay(unsigned int freq)
 {
 	int i;
@@ -1058,8 +1084,6 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 			hispeed_freq =3D policy->max;
=20
 		for_each_cpu(j, policy->cpus) {
-			unsigned long expires;
-
 			pcpu =3D &per_cpu(cpuinfo, j);
 			pcpu->policy =3D policy;
 			pcpu->target_freq =3D policy->cur;
@@ -1070,14 +1094,7 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 			pcpu->hispeed_validate_time =3D
 				pcpu->floor_validate_time;
 			down_write(&pcpu->enable_sem);
-			expires =3D jiffies + usecs_to_jiffies(timer_rate);
-			pcpu->cpu_timer.expires =3D expires;
-			add_timer_on(&pcpu->cpu_timer, j);
-			if (timer_slack_val >=3D 0) {
-				expires +=3D usecs_to_jiffies(timer_slack_val);
-				pcpu->cpu_slack_timer.expires =3D expires;
-				add_timer_on(&pcpu->cpu_slack_timer, j);
-			}
+			cpufreq_interactive_timer_start(j);
 			pcpu->governor_enabled =3D 1;
 			up_write(&pcpu->enable_sem);
 		}
@@ -1136,6 +1153,33 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 		else if (policy->min > policy->cur)
 			__cpufreq_driver_target(policy,
 					policy->min, CPUFREQ_RELATION_L);
+		for_each_cpu(j, policy->cpus) {
+			pcpu =3D &per_cpu(cpuinfo, j);
+
+			/* hold write semaphore to avoid race */
+			down_write(&pcpu->enable_sem);
+			if (pcpu->governor_enabled =3D=3D 0) {
+				up_write(&pcpu->enable_sem);
+				continue;
+			}
+
+			/* update target_freq firstly */
+			if (policy->max < pcpu->target_freq)
+				pcpu->target_freq =3D policy->max;
+			else if (policy->min > pcpu->target_freq)
+				pcpu->target_freq =3D policy->min;
+
+			/* Reschedule timer.
+			 * Delete the timers, else the timer callback may
+			 * return without re-arm the timer when failed
+			 * acquire the semaphore. This race may cause timer
+			 * stopped unexpectedly.
+			 */
+			del_timer_sync(&pcpu->cpu_timer);
+			del_timer_sync(&pcpu->cpu_slack_timer);
+			cpufreq_interactive_timer_start(j);
+			up_write(&pcpu->enable_sem);
+		}
 		break;
 	}
 	return 0;
--=20
1.7.9.5

