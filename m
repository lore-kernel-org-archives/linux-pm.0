From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 32/70] cpufreq: interactive: specify duration of CPU speed boost pulse
Date: Tue, 27 Oct 2015 18:30:20 +0100
Message-ID: <1445967059-6897-32-git-send-email-czoborbalint@gmail.com>
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

Sysfs attribute boostpulse_duration specifies the duration of boosting =
CPU
speed in response to bootpulse events.  Duration is specified in usecs,
default 80ms.

Change-Id: Ifd41625574891a44f1787a4e85d1e7b4f2afb52b
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   52 +++++++++++++++++++++++++=
+++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index d0d51ee..8b44a82 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -95,11 +95,12 @@ static unsigned long timer_rate;
 #define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
 static unsigned long above_hispeed_delay_val;
=20
-/*
- * Non-zero means longer-term speed boost active.
- */
-
+/* Non-zero means indefinite speed boost active */
 static int boost_val;
+/* Duration of a boot pulse in usecs */
+static int boostpulse_duration_val =3D DEFAULT_MIN_SAMPLE_TIME;
+/* End time of boost pulse in ktime converted to usecs */
+static u64 boostpulse_endtime;
=20
 static bool governidle;
 module_param(governidle, bool, S_IWUSR | S_IRUGO);
@@ -268,6 +269,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	unsigned int loadadjfreq;
 	unsigned int index;
 	unsigned long flags;
+	bool boosted;
=20
 	smp_rmb();
=20
@@ -286,8 +288,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	do_div(cputime_speedadj, delta_time);
 	loadadjfreq =3D (unsigned int)cputime_speedadj * 100;
 	cpu_load =3D loadadjfreq / pcpu->target_freq;
+	boosted =3D boost_val || now < boostpulse_endtime;
=20
-	if ((cpu_load >=3D go_hispeed_load || boost_val) &&
+	if ((cpu_load >=3D go_hispeed_load || boosted) &&
 	    pcpu->target_freq < hispeed_freq)
 		new_freq =3D hispeed_freq;
 	else
@@ -327,8 +330,18 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
 		}
 	}
=20
-	pcpu->floor_freq =3D new_freq;
-	pcpu->floor_validate_time =3D now;
+	/*
+	 * Update the timestamp for checking whether speed has been held at
+	 * or above the selected frequency for a minimum of min_sample_time,
+	 * if not boosted to hispeed_freq.  If boosted to hispeed_freq then w=
e
+	 * allow the speed to drop as soon as the boostpulse duration expires
+	 * (or the indefinite boost is turned off).
+	 */
+
+	if (!boosted || new_freq > hispeed_freq) {
+		pcpu->floor_freq =3D new_freq;
+		pcpu->floor_validate_time =3D now;
+	}
=20
 	if (pcpu->target_freq =3D=3D new_freq) {
 		trace_cpufreq_interactive_already(
@@ -774,6 +787,7 @@ static ssize_t store_boostpulse(struct kobject *kob=
j, struct attribute *attr,
 	if (ret < 0)
 		return ret;
=20
+	boostpulse_endtime =3D ktime_to_us(ktime_get()) + boostpulse_duration=
_val;
 	trace_cpufreq_interactive_boost("pulse");
 	cpufreq_interactive_boost();
 	return count;
@@ -782,6 +796,29 @@ static ssize_t store_boostpulse(struct kobject *ko=
bj, struct attribute *attr,
 static struct global_attr boostpulse =3D
 	__ATTR(boostpulse, 0200, NULL, store_boostpulse);
=20
+static ssize_t show_boostpulse_duration(
+	struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", boostpulse_duration_val);
+}
+
+static ssize_t store_boostpulse_duration(
+	struct kobject *kobj, struct attribute *attr, const char *buf,
+	size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	boostpulse_duration_val =3D val;
+	return count;
+}
+
+define_one_global_rw(boostpulse_duration);
+
 static struct attribute *interactive_attributes[] =3D {
 	&target_loads_attr.attr,
 	&hispeed_freq_attr.attr,
@@ -791,6 +828,7 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&timer_rate_attr.attr,
 	&boost.attr,
 	&boostpulse.attr,
+	&boostpulse_duration.attr,
 	NULL,
 };
=20
--=20
1.7.9.5
