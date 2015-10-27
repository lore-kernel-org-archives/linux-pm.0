From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 06/70] cpufreq: interactive: configurable delay before raising above hispeed
Date: Tue, 27 Oct 2015 18:29:54 +0100
Message-ID: <1445967059-6897-6-git-send-email-czoborbalint@gmail.com>
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

Change-Id: I4d6ac40b23a3790d48e30c37408284e9f955e8fa
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   41 +++++++++++++++++++++++++=
++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 59e7779a..154f7bd 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -83,6 +83,13 @@ static unsigned long min_sample_time;
 #define DEFAULT_TIMER_RATE 20 * USEC_PER_MSEC
 static unsigned long timer_rate;
=20
+/*
+ * Wait this long before raising speed above hispeed, by default a sin=
gle
+ * timer interval.
+ */
+#define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
+static unsigned long above_hispeed_delay_val;
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event);
=20
@@ -174,6 +181,16 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
=20
 			if (new_freq < hispeed_freq)
 				new_freq =3D hispeed_freq;
+
+			if (pcpu->target_freq =3D=3D hispeed_freq &&
+			    new_freq > hispeed_freq &&
+			    pcpu->timer_run_time - pcpu->target_set_time
+			    < above_hispeed_delay_val) {
+				trace_cpufreq_interactive_notyet(data, cpu_load,
+								 pcpu->target_freq,
+								 new_freq);
+				goto rearm;
+			}
 		}
 	} else {
 		new_freq =3D pcpu->policy->max * cpu_load / 100;
@@ -515,6 +532,28 @@ static ssize_t store_min_sample_time(struct kobjec=
t *kobj,
 static struct global_attr min_sample_time_attr =3D __ATTR(min_sample_t=
ime, 0644,
 		show_min_sample_time, store_min_sample_time);
=20
+static ssize_t show_above_hispeed_delay(struct kobject *kobj,
+					struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", above_hispeed_delay_val);
+}
+
+static ssize_t store_above_hispeed_delay(struct kobject *kobj,
+					 struct attribute *attr,
+					 const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	above_hispeed_delay_val =3D val;
+	return count;
+}
+
+define_one_global_rw(above_hispeed_delay);
+
 static ssize_t show_timer_rate(struct kobject *kobj,
 			struct attribute *attr, char *buf)
 {
@@ -540,6 +579,7 @@ static struct global_attr timer_rate_attr =3D __ATT=
R(timer_rate, 0644,
 static struct attribute *interactive_attributes[] =3D {
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
+	&above_hispeed_delay.attr,
 	&min_sample_time_attr.attr,
 	&timer_rate_attr.attr,
 	NULL,
@@ -660,6 +700,7 @@ static int __init cpufreq_interactive_init(void)
=20
 	go_hispeed_load =3D DEFAULT_GO_HISPEED_LOAD;
 	min_sample_time =3D DEFAULT_MIN_SAMPLE_TIME;
+	above_hispeed_delay_val =3D DEFAULT_ABOVE_HISPEED_DELAY;
 	timer_rate =3D DEFAULT_TIMER_RATE;
=20
 	/* Initalize per-cpu timers */
--=20
1.7.9.5
