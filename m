From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 24/70] cpufreq: interactive: use deferrable timer by default
Date: Tue, 27 Oct 2015 18:30:12 +0100
Message-ID: <1445967059-6897-24-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <a22439@motorola.com>, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Lianwei Wang <a22439@motorola.com>

Avoid wakeups only to handle the governor timer when the system is othe=
rwise
idle.

=46or platforms where the power cost of remaining in idle at higher CPU
speed may outweigh the cost of a governor wakeup from idle to lower the=
 speed,
set parameter cpufreq_interactive.governidle=3D1.

Change-Id: Id6c43eb35caecf9b0574fcdd5b769711bc7e6de6
Signed-off-by: LianWei WANG <a22439@motorola.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index e53eae2..71887ca 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -92,6 +93,11 @@ static unsigned long above_hispeed_delay_val;
=20
 static int boost_val;
=20
+static bool governidle;
+module_param(governidle, bool, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(governidle,
+	"Set to 1 to wake up CPUs from idle to reduce speed (default 0)");
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
=20
@@ -240,10 +246,11 @@ rearm_if_notmax:
 rearm:
 	if (!timer_pending(&pcpu->cpu_timer)) {
 		/*
-		 * If already at min, cancel the timer if that CPU goes idle.
-		 * We don't need to re-evaluate speed until the next idle exit.
+		 * If governing speed in idle and already at min, cancel the
+		 * timer if that CPU goes idle.  We don't need to re-evaluate
+		 * speed until the next idle exit.
 		 */
-		if (pcpu->target_freq =3D=3D pcpu->policy->min)
+		if (governidle && pcpu->target_freq =3D=3D pcpu->policy->min)
 			pcpu->timer_idlecancel =3D 1;
=20
 		pcpu->time_in_idle =3D get_cpu_idle_time_us(
@@ -268,7 +275,6 @@ static void cpufreq_interactive_idle_start(void)
 	pending =3D timer_pending(&pcpu->cpu_timer);
=20
 	if (pcpu->target_freq !=3D pcpu->policy->min) {
-#ifdef CONFIG_SMP
 		/*
 		 * Entering idle while not at lowest speed.  On some
 		 * platforms this can hold the other CPU(s) at that speed
@@ -285,8 +291,7 @@ static void cpufreq_interactive_idle_start(void)
 				&pcpu->cpu_timer,
 				jiffies + usecs_to_jiffies(timer_rate));
 		}
-#endif
-	} else {
+	} else if (governidle) {
 		/*
 		 * If at min speed and entering idle after load has
 		 * already been evaluated, and a timer has been set just in
@@ -708,7 +713,10 @@ static int __init cpufreq_interactive_init(void)
 	/* Initalize per-cpu timers */
 	for_each_possible_cpu(i) {
 		pcpu =3D &per_cpu(cpuinfo, i);
-		init_timer(&pcpu->cpu_timer);
+		if (governidle)
+			init_timer(&pcpu->cpu_timer);
+		else
+			init_timer_deferrable(&pcpu->cpu_timer);
 		pcpu->cpu_timer.function =3D cpufreq_interactive_timer;
 		pcpu->cpu_timer.data =3D i;
 	}
--=20
1.7.9.5
