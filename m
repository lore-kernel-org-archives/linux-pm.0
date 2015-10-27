From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 43/70] cpufreq: interactive: add io_is_busy interface
Date: Tue, 27 Oct 2015 18:30:31 +0100
Message-ID: <1445967059-6897-43-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <lian-wei.wang@motorola.com>, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Lianwei Wang <lian-wei.wang@motorola.com>

Previously the idle time returned from get_cpu_idle_time_us included th=
e
iowait time. So the iowait time was always calculated as idle time.

But now the idle time returned from get_cpu_idle_time_us does not inclu=
de
the iowait time anymore because of below commit which cause the iowait =
time
always calculated as busy time:
    6beea0c nohz: Fix update_ts_time_stat idle accounting

Add the io_is_busy interface, as does the ondemand governor, and let th=
e user
configure the iowait time as busy or idle through the io_is_busy sysfs
interface.

By default, io_is_busy is disabled.

[toddpoynor@google.com: minor updates]
Change-Id: If7d70ff864c43bc9c8d7fd7cfc66f930d339f9b4
Signed-off-by: Lianwei Wang <lian-wei.wang@motorola.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   66 +++++++++++++++++++++++++=
+++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 620b46c..7c734fa 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -30,6 +30,7 @@
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/kernel_stat.h>
 #include <asm/cputime.h>
=20
 #define CREATE_TRACE_POINTS
@@ -114,6 +115,8 @@ static u64 boostpulse_endtime;
 #define DEFAULT_TIMER_SLACK (4 * DEFAULT_TIMER_RATE)
 static int timer_slack_val =3D DEFAULT_TIMER_SLACK;
=20
+static bool io_is_busy;
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
=20
@@ -127,6 +130,42 @@ struct cpufreq_governor cpufreq_gov_interactive =3D=
 {
 	.owner =3D THIS_MODULE,
 };
=20
+static inline cputime64_t get_cpu_idle_time_jiffy(unsigned int cpu,
+						  cputime64_t *wall)
+{
+	u64 idle_time;
+	u64 cur_wall_time;
+	u64 busy_time;
+
+	cur_wall_time =3D jiffies64_to_cputime64(get_jiffies_64());
+
+	busy_time  =3D kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
+	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
+	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
+	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
+	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
+	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+
+	idle_time =3D cur_wall_time - busy_time;
+	if (wall)
+		*wall =3D jiffies_to_usecs(cur_wall_time);
+
+	return jiffies_to_usecs(idle_time);
+}
+
+static inline cputime64_t get_cpu_idle_time(unsigned int cpu,
+					    cputime64_t *wall)
+{
+	u64 idle_time =3D get_cpu_idle_time_us(cpu, wall);
+
+	if (idle_time =3D=3D -1ULL)
+		idle_time =3D get_cpu_idle_time_jiffy(cpu, wall);
+	else if (!io_is_busy)
+		idle_time +=3D get_cpu_iowait_time_us(cpu, wall);
+
+	return idle_time;
+}
+
 static void cpufreq_interactive_timer_resched(
 	struct cpufreq_interactive_cpuinfo *pcpu)
 {
@@ -141,7 +180,7 @@ static void cpufreq_interactive_timer_resched(
=20
 	spin_lock_irqsave(&pcpu->load_lock, flags);
 	pcpu->time_in_idle =3D
-		get_cpu_idle_time_us(smp_processor_id(),
+		get_cpu_idle_time(smp_processor_id(),
 				     &pcpu->time_in_idle_timestamp);
 	pcpu->cputime_speedadj =3D 0;
 	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
@@ -278,7 +317,7 @@ static u64 update_load(int cpu)
 	unsigned int delta_time;
 	u64 active_time;
=20
-	now_idle =3D get_cpu_idle_time_us(cpu, &now);
+	now_idle =3D get_cpu_idle_time(cpu, &now);
 	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
 	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
 	active_time =3D delta_time - delta_idle;
@@ -924,6 +963,28 @@ static ssize_t store_boostpulse_duration(
=20
 define_one_global_rw(boostpulse_duration);
=20
+static ssize_t show_io_is_busy(struct kobject *kobj,
+			struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", io_is_busy);
+}
+
+static ssize_t store_io_is_busy(struct kobject *kobj,
+			struct attribute *attr, const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	io_is_busy =3D val;
+	return count;
+}
+
+static struct global_attr io_is_busy_attr =3D __ATTR(io_is_busy, 0644,
+		show_io_is_busy, store_io_is_busy);
+
 static struct attribute *interactive_attributes[] =3D {
 	&target_loads_attr.attr,
 	&above_hispeed_delay_attr.attr,
@@ -935,6 +996,7 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&boost.attr,
 	&boostpulse.attr,
 	&boostpulse_duration.attr,
+	&io_is_busy_attr.attr,
 	NULL,
 };
=20
--=20
1.7.9.5
