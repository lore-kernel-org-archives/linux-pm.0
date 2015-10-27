From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 33/70] cpufreq: interactive: add timer slack to limit idle at speed > min
Date: Tue, 27 Oct 2015 18:30:21 +0100
Message-ID: <1445967059-6897-33-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

Always use deferrable timer for load sampling.

Set a non-deferrable timer to an additional slack time to allow prior t=
o
waking up from idle to drop speed when not at minimum speed.  Slack val=
ue
-1 avoids wakeups to drop speed.  Default is 80ms.

Remove the governidle module param and its timer management in idle.  F=
or
platforms on which holding speed above mimum in idle costs power, use t=
he
new timer slack to select how long to wait before waking up to drop spe=
ed.

Change-Id: I270b3980667e2c70a68e5bff534124b4411dbad5
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |  101 ++++++++++++++++++++-----=
--------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 8b44a82..690be16 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -40,7 +40,7 @@ static atomic_t active_count =3D ATOMIC_INIT(0);
=20
 struct cpufreq_interactive_cpuinfo {
 	struct timer_list cpu_timer;
-	int timer_idlecancel;
+	struct timer_list cpu_slack_timer;
 	spinlock_t load_lock; /* protects the next 4 fields */
 	u64 time_in_idle;
 	u64 time_in_idle_timestamp;
@@ -102,10 +102,12 @@ static int boostpulse_duration_val =3D DEFAULT_MI=
N_SAMPLE_TIME;
 /* End time of boost pulse in ktime converted to usecs */
 static u64 boostpulse_endtime;
=20
-static bool governidle;
-module_param(governidle, bool, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(governidle,
-	"Set to 1 to wake up CPUs from idle to reduce speed (default 0)");
+/*
+ * Max additional time to wait in idle, beyond timer_rate, at speeds a=
bove
+ * minimum before wakeup to reduce speed, or -1 if unnecessary.
+ */
+#define DEFAULT_TIMER_SLACK (4 * DEFAULT_TIMER_RATE)
+static int timer_slack_val =3D DEFAULT_TIMER_SLACK;
=20
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
@@ -123,8 +125,14 @@ struct cpufreq_governor cpufreq_gov_interactive =3D=
 {
 static void cpufreq_interactive_timer_resched(
 	struct cpufreq_interactive_cpuinfo *pcpu)
 {
-	mod_timer_pinned(&pcpu->cpu_timer,
-			 jiffies + usecs_to_jiffies(timer_rate));
+	unsigned long expires =3D jiffies + usecs_to_jiffies(timer_rate);
+
+	mod_timer_pinned(&pcpu->cpu_timer, expires);
+	if (timer_slack_val >=3D 0 && pcpu->target_freq > pcpu->policy->min) =
{
+		expires +=3D usecs_to_jiffies(timer_slack_val);
+		mod_timer_pinned(&pcpu->cpu_slack_timer, expires);
+	}
+
 	spin_lock(&pcpu->load_lock);
 	pcpu->time_in_idle =3D
 		get_cpu_idle_time_us(smp_processor_id(),
@@ -368,17 +376,8 @@ rearm_if_notmax:
 		goto exit;
=20
 rearm:
-	if (!timer_pending(&pcpu->cpu_timer)) {
-		/*
-		 * If governing speed in idle and already at min, cancel the
-		 * timer if that CPU goes idle.  We don't need to re-evaluate
-		 * speed until the next idle exit.
-		 */
-		if (governidle && pcpu->target_freq =3D=3D pcpu->policy->min)
-			pcpu->timer_idlecancel =3D 1;
-
+	if (!timer_pending(&pcpu->cpu_timer))
 		cpufreq_interactive_timer_resched(pcpu);
-	}
=20
 exit:
 	return;
@@ -404,21 +403,8 @@ static void cpufreq_interactive_idle_start(void)
 		 * min indefinitely.  This should probably be a quirk of
 		 * the CPUFreq driver.
 		 */
-		if (!pending) {
-			pcpu->timer_idlecancel =3D 0;
+		if (!pending)
 			cpufreq_interactive_timer_resched(pcpu);
-		}
-	} else if (governidle) {
-		/*
-		 * If at min speed and entering idle after load has
-		 * already been evaluated, and a timer has been set just in
-		 * case the CPU suddenly goes busy, cancel that timer.  The
-		 * CPU didn't go busy; we'll recheck things upon idle exit.
-		 */
-		if (pending && pcpu->timer_idlecancel) {
-			del_timer(&pcpu->cpu_timer);
-			pcpu->timer_idlecancel =3D 0;
-		}
 	}
=20
 }
@@ -433,11 +419,10 @@ static void cpufreq_interactive_idle_end(void)
=20
 	/* Arm the timer for 1-2 ticks later if not already. */
 	if (!timer_pending(&pcpu->cpu_timer)) {
-		pcpu->timer_idlecancel =3D 0;
 		cpufreq_interactive_timer_resched(pcpu);
-	} else if (!governidle &&
-		   time_after_eq(jiffies, pcpu->cpu_timer.expires)) {
+	} else if (time_after_eq(jiffies, pcpu->cpu_timer.expires)) {
 		del_timer(&pcpu->cpu_timer);
+		del_timer(&pcpu->cpu_slack_timer);
 		cpufreq_interactive_timer(smp_processor_id());
 	}
 }
@@ -747,6 +732,29 @@ static ssize_t store_timer_rate(struct kobject *ko=
bj,
 static struct global_attr timer_rate_attr =3D __ATTR(timer_rate, 0644,
 		show_timer_rate, store_timer_rate);
=20
+static ssize_t show_timer_slack(
+	struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", timer_slack_val);
+}
+
+static ssize_t store_timer_slack(
+	struct kobject *kobj, struct attribute *attr, const char *buf,
+	size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	timer_slack_val =3D val;
+	return count;
+}
+
+define_one_global_rw(timer_slack);
+
 static ssize_t show_boost(struct kobject *kobj, struct attribute *attr=
,
 			  char *buf)
 {
@@ -826,6 +834,7 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&above_hispeed_delay.attr,
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
+	&timer_slack.attr,
 	&boost.attr,
 	&boostpulse.attr,
 	&boostpulse_duration.attr,
@@ -876,6 +885,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			hispeed_freq =3D policy->max;
=20
 		for_each_cpu(j, policy->cpus) {
+			unsigned long expires;
+
 			pcpu =3D &per_cpu(cpuinfo, j);
 			pcpu->policy =3D policy;
 			pcpu->target_freq =3D policy->cur;
@@ -887,9 +898,15 @@ static int cpufreq_governor_interactive(struct cpu=
freq_policy *policy,
 				pcpu->floor_validate_time;
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
-			pcpu->cpu_timer.expires =3D
-				jiffies + usecs_to_jiffies(timer_rate);
+			expires =3D jiffies + usecs_to_jiffies(timer_rate);
+			pcpu->cpu_timer.expires =3D expires;
 			add_timer_on(&pcpu->cpu_timer, j);
+
+			if (timer_slack_val >=3D 0) {
+				expires +=3D usecs_to_jiffies(timer_slack_val);
+				pcpu->cpu_slack_timer.expires =3D expires;
+				add_timer_on(&pcpu->cpu_slack_timer, j);
+			}
 		}
=20
 		/*
@@ -915,6 +932,7 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pcpu->governor_enabled =3D 0;
 			smp_wmb();
 			del_timer_sync(&pcpu->cpu_timer);
+			del_timer_sync(&pcpu->cpu_slack_timer);
 		}
=20
 		if (atomic_dec_return(&active_count) > 0)
@@ -940,6 +958,10 @@ static int cpufreq_governor_interactive(struct cpu=
freq_policy *policy,
 	return 0;
 }
=20
+static void cpufreq_interactive_nop_timer(unsigned long data)
+{
+}
+
 static int __init cpufreq_interactive_init(void)
 {
 	unsigned int i;
@@ -954,12 +976,11 @@ static int __init cpufreq_interactive_init(void)
 	/* Initalize per-cpu timers */
 	for_each_possible_cpu(i) {
 		pcpu =3D &per_cpu(cpuinfo, i);
-		if (governidle)
-			init_timer(&pcpu->cpu_timer);
-		else
-			init_timer_deferrable(&pcpu->cpu_timer);
+		init_timer_deferrable(&pcpu->cpu_timer);
 		pcpu->cpu_timer.function =3D cpufreq_interactive_timer;
 		pcpu->cpu_timer.data =3D i;
+		init_timer(&pcpu->cpu_slack_timer);
+		pcpu->cpu_slack_timer.function =3D cpufreq_interactive_nop_timer;
 		spin_lock_init(&pcpu->load_lock);
 	}
=20
--=20
1.7.9.5
