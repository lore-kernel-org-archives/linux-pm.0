From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 31/70] cpufreq: interactive: adjust load for changes in speed
Date: Tue, 27 Oct 2015 18:30:19 +0100
Message-ID: <1445967059-6897-31-git-send-email-czoborbalint@gmail.com>
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

Add notifier for speed transitions.  Keep a count of CPU active
microseconds times current frequency, converted to a percentage relativ=
e
to the current frequency when load is evaluated.

Change-Id: I5c27adb11081c50490219784ca57cc46e97fc28c
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   87 +++++++++++++++++++++++++=
++------
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 3d8e7b4..d0d51ee 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -41,8 +41,11 @@ static atomic_t active_count =3D ATOMIC_INIT(0);
 struct cpufreq_interactive_cpuinfo {
 	struct timer_list cpu_timer;
 	int timer_idlecancel;
+	spinlock_t load_lock; /* protects the next 4 fields */
 	u64 time_in_idle;
 	u64 time_in_idle_timestamp;
+	u64 cputime_speedadj;
+	u64 cputime_speedadj_timestamp;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int target_freq;
@@ -121,9 +124,13 @@ static void cpufreq_interactive_timer_resched(
 {
 	mod_timer_pinned(&pcpu->cpu_timer,
 			 jiffies + usecs_to_jiffies(timer_rate));
+	spin_lock(&pcpu->load_lock);
 	pcpu->time_in_idle =3D
 		get_cpu_idle_time_us(smp_processor_id(),
 				     &pcpu->time_in_idle_timestamp);
+	pcpu->cputime_speedadj =3D 0;
+	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
+	spin_unlock(&pcpu->load_lock);
 }
=20
 static unsigned int freq_to_targetload(unsigned int freq)
@@ -148,10 +155,9 @@ static unsigned int freq_to_targetload(unsigned in=
t freq)
  */
=20
 static unsigned int choose_freq(
-	struct cpufreq_interactive_cpuinfo *pcpu, unsigned int curload)
+	struct cpufreq_interactive_cpuinfo *pcpu, unsigned int loadadjfreq)
 {
 	unsigned int freq =3D pcpu->policy->cur;
-	unsigned int loadadjfreq =3D freq * curload;
 	unsigned int prevfreq, freqmin, freqmax;
 	unsigned int tl;
 	int index;
@@ -230,16 +236,36 @@ static unsigned int choose_freq(
 	return freq;
 }
=20
-static void cpufreq_interactive_timer(unsigned long data)
+static u64 update_load(int cpu)
 {
+	struct cpufreq_interactive_cpuinfo *pcpu =3D &per_cpu(cpuinfo, cpu);
 	u64 now;
+	u64 now_idle;
 	unsigned int delta_idle;
 	unsigned int delta_time;
+	u64 active_time;
+
+	now_idle =3D get_cpu_idle_time_us(cpu, &now);
+	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
+	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
+	active_time =3D delta_time - delta_idle;
+	pcpu->cputime_speedadj +=3D active_time * pcpu->policy->cur;
+
+	pcpu->time_in_idle =3D now_idle;
+	pcpu->time_in_idle_timestamp =3D now;
+	return now;
+}
+
+static void cpufreq_interactive_timer(unsigned long data)
+{
+	u64 now;
+	unsigned int delta_time;
+	u64 cputime_speedadj;
 	int cpu_load;
 	struct cpufreq_interactive_cpuinfo *pcpu =3D
 		&per_cpu(cpuinfo, data);
-	u64 now_idle;
 	unsigned int new_freq;
+	unsigned int loadadjfreq;
 	unsigned int index;
 	unsigned long flags;
=20
@@ -248,26 +274,24 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	if (!pcpu->governor_enabled)
 		goto exit;
=20
-	now_idle =3D get_cpu_idle_time_us(data, &now);
-	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
-	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
+	spin_lock(&pcpu->load_lock);
+	now =3D update_load(data);
+	delta_time =3D (unsigned int)(now - pcpu->cputime_speedadj_timestamp)=
;
+	cputime_speedadj =3D pcpu->cputime_speedadj;
+	spin_unlock(&pcpu->load_lock);
=20
-	/*
-	 * If timer ran less than 1ms after short-term sample started, retry.
-	 */
-	if (delta_time < 1000)
+	if (WARN_ON_ONCE(!delta_time))
 		goto rearm;
=20
-	if (delta_idle > delta_time)
-		cpu_load =3D 0;
-	else
-		cpu_load =3D 100 * (delta_time - delta_idle) / delta_time;
+	do_div(cputime_speedadj, delta_time);
+	loadadjfreq =3D (unsigned int)cputime_speedadj * 100;
+	cpu_load =3D loadadjfreq / pcpu->target_freq;
=20
 	if ((cpu_load >=3D go_hispeed_load || boost_val) &&
 	    pcpu->target_freq < hispeed_freq)
 		new_freq =3D hispeed_freq;
 	else
-		new_freq =3D choose_freq(pcpu, cpu_load);
+		new_freq =3D choose_freq(pcpu, loadadjfreq);
=20
 	if (pcpu->target_freq >=3D hispeed_freq &&
 	    new_freq > pcpu->target_freq &&
@@ -498,6 +522,32 @@ static void cpufreq_interactive_boost(void)
 		wake_up_process(speedchange_task);
 }
=20
+static int cpufreq_interactive_notifier(
+	struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq =3D data;
+	struct cpufreq_interactive_cpuinfo *pcpu;
+	int cpu;
+
+	if (val =3D=3D CPUFREQ_POSTCHANGE) {
+		pcpu =3D &per_cpu(cpuinfo, freq->cpu);
+
+		for_each_cpu(cpu, pcpu->policy->cpus) {
+			struct cpufreq_interactive_cpuinfo *pjcpu =3D
+				&per_cpu(cpuinfo, cpu);
+			spin_lock(&pjcpu->load_lock);
+			update_load(cpu);
+			spin_unlock(&pjcpu->load_lock);
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_notifier_block =3D {
+	.notifier_call =3D cpufreq_interactive_notifier,
+};
+
 static ssize_t show_target_loads(
 	struct kobject *kobj, struct attribute *attr, char *buf)
 {
@@ -817,6 +867,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			return rc;
=20
 		idle_notifier_register(&cpufreq_interactive_idle_nb);
+		cpufreq_register_notifier(
+			&cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 		break;
=20
 	case CPUFREQ_GOV_STOP:
@@ -830,6 +882,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 		if (atomic_dec_return(&active_count) > 0)
 			return 0;
=20
+		cpufreq_unregister_notifier(
+			&cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 		idle_notifier_unregister(&cpufreq_interactive_idle_nb);
 		sysfs_remove_group(cpufreq_global_kobject,
 				&interactive_attr_group);
@@ -868,6 +922,7 @@ static int __init cpufreq_interactive_init(void)
 			init_timer_deferrable(&pcpu->cpu_timer);
 		pcpu->cpu_timer.function =3D cpufreq_interactive_timer;
 		pcpu->cpu_timer.data =3D i;
+		spin_lock_init(&pcpu->load_lock);
 	}
=20
 	spin_lock_init(&target_loads_lock);
--=20
1.7.9.5
