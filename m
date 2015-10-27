From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 25/70] cpufreq: interactive: kick timer on idle exit past expiry
Date: Tue, 27 Oct 2015 18:30:13 +0100
Message-ID: <1445967059-6897-25-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37361 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965644AbbJ0Rk1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:40:27 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Todd Poynor <toddpoynor@google.com>

The deferrable timer list isn't checked on all idle exits, such as when
hi-res timers expire or ISRs schedule workers.  If the idle loop is
exited and it's past time to run the governor load polling timer,
run it immediately.  This ensures we handle load spikes caused by actvi=
ty
that does not run the normal timer list.

Rename the field that timestamps the "time_in_idle" value to be more
accurate.

Change-Id: Ied590ecbefc83c9a9ec5eb9e31903557f6fa1614
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   43 +++++++++++++++----------=
--------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 71887ca..8153769 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -42,7 +42,7 @@ struct cpufreq_interactive_cpuinfo {
 	struct timer_list cpu_timer;
 	int timer_idlecancel;
 	u64 time_in_idle;
-	u64 idle_exit_time;
+	u64 time_in_idle_timestamp;
 	u64 target_set_time;
 	u64 target_set_time_in_idle;
 	struct cpufreq_policy *policy;
@@ -111,6 +111,16 @@ struct cpufreq_governor cpufreq_gov_interactive =3D=
 {
 	.owner =3D THIS_MODULE,
 };
=20
+static void cpufreq_interactive_timer_resched(
+	struct cpufreq_interactive_cpuinfo *pcpu)
+{
+	mod_timer_pinned(&pcpu->cpu_timer,
+			 jiffies + usecs_to_jiffies(timer_rate));
+	pcpu->time_in_idle =3D
+		get_cpu_idle_time_us(smp_processor_id(),
+				     &pcpu->time_in_idle_timestamp);
+}
+
 static void cpufreq_interactive_timer(unsigned long data)
 {
 	u64 now;
@@ -118,8 +128,6 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	unsigned int delta_time;
 	int cpu_load;
 	int load_since_change;
-	u64 time_in_idle;
-	u64 idle_exit_time;
 	struct cpufreq_interactive_cpuinfo *pcpu =3D
 		&per_cpu(cpuinfo, data);
 	u64 now_idle;
@@ -132,11 +140,9 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
 	if (!pcpu->governor_enabled)
 		goto exit;
=20
-	time_in_idle =3D pcpu->time_in_idle;
-	idle_exit_time =3D pcpu->idle_exit_time;
 	now_idle =3D get_cpu_idle_time_us(data, &now);
-	delta_idle =3D (unsigned int)(now_idle - time_in_idle);
-	delta_time =3D (unsigned int)(now - idle_exit_time);
+	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
+	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
=20
 	/*
 	 * If timer ran less than 1ms after short-term sample started, retry.
@@ -253,10 +259,7 @@ rearm:
 		if (governidle && pcpu->target_freq =3D=3D pcpu->policy->min)
 			pcpu->timer_idlecancel =3D 1;
=20
-		pcpu->time_in_idle =3D get_cpu_idle_time_us(
-			data, &pcpu->idle_exit_time);
-		mod_timer_pinned(&pcpu->cpu_timer,
-				 jiffies + usecs_to_jiffies(timer_rate));
+		cpufreq_interactive_timer_resched(pcpu);
 	}
=20
 exit:
@@ -284,12 +287,8 @@ static void cpufreq_interactive_idle_start(void)
 		 * the CPUFreq driver.
 		 */
 		if (!pending) {
-			pcpu->time_in_idle =3D get_cpu_idle_time_us(
-				smp_processor_id(), &pcpu->idle_exit_time);
 			pcpu->timer_idlecancel =3D 0;
-			mod_timer_pinned(
-				&pcpu->cpu_timer,
-				jiffies + usecs_to_jiffies(timer_rate));
+			cpufreq_interactive_timer_resched(pcpu);
 		}
 	} else if (governidle) {
 		/*
@@ -316,15 +315,13 @@ static void cpufreq_interactive_idle_end(void)
=20
 	/* Arm the timer for 1-2 ticks later if not already. */
 	if (!timer_pending(&pcpu->cpu_timer)) {
-		pcpu->time_in_idle =3D
-			get_cpu_idle_time_us(smp_processor_id(),
-					     &pcpu->idle_exit_time);
 		pcpu->timer_idlecancel =3D 0;
-		mod_timer_pinned(
-			&pcpu->cpu_timer,
-			jiffies + usecs_to_jiffies(timer_rate));
+		cpufreq_interactive_timer_resched(pcpu);
+	} else if (!governidle &&
+		   time_after_eq(jiffies, pcpu->cpu_timer.expires)) {
+		del_timer(&pcpu->cpu_timer);
+		cpufreq_interactive_timer(smp_processor_id());
 	}
-
 }
=20
 static int cpufreq_interactive_speedchange_task(void *data)
--=20
1.7.9.5

