From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 27/70] cpufreq: interactive: change speed according to current speed and target load
Date: Tue, 27 Oct 2015 18:30:15 +0100
Message-ID: <1445967059-6897-27-git-send-email-czoborbalint@gmail.com>
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

Add a target_load attribute that specifies how aggressively the governo=
r is
to adjust speed to meet the observed load.  New target speed is calcula=
ted
as the current actual speed (may be higher than target speed on SMP) ti=
mes
the CPU load (as a fraction) divided by target load (fraction).

cpufreq_frequency_table_target() call use CPUFREQ_RELATION_L to set
the next higher speed rather than next lower speed.

Change-Id: If432451da82f5fed12e15c9421d7d27792376150
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   35 +++++++++++++++++++++++++=
+++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 2b4aad9..c4293c5 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -68,6 +68,10 @@ static unsigned int hispeed_freq;
 #define DEFAULT_GO_HISPEED_LOAD 85
 static unsigned long go_hispeed_load;
=20
+/* Target load.  Lower values result in higher CPU speeds. */
+#define DEFAULT_TARGET_LOAD 90
+static unsigned long target_load =3D DEFAULT_TARGET_LOAD;
+
 /*
  * The minimum amount of time to spend at a frequency before we can ra=
mp down.
  */
@@ -177,7 +181,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		    hispeed_freq < pcpu->policy->max) {
 			new_freq =3D hispeed_freq;
 		} else {
-			new_freq =3D pcpu->policy->max * cpu_load / 100;
+			new_freq =3D pcpu->policy->cur * cpu_load / target_load;
=20
 			if (new_freq < hispeed_freq)
 				new_freq =3D hispeed_freq;
@@ -193,14 +197,14 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 			}
 		}
 	} else {
-		new_freq =3D hispeed_freq * cpu_load / 100;
+		new_freq =3D pcpu->policy->cur * cpu_load / target_load;
 	}
=20
 	if (new_freq <=3D hispeed_freq)
 		pcpu->hispeed_validate_time =3D now;
=20
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
-					   new_freq, CPUFREQ_RELATION_H,
+					   new_freq, CPUFREQ_RELATION_L,
 					   &index)) {
 		pr_warn_once("timer %d: cpufreq_frequency_table_target error\n",
 			     (int) data);
@@ -420,6 +424,30 @@ static void cpufreq_interactive_boost(void)
 		wake_up_process(speedchange_task);
 }
=20
+static ssize_t show_target_load(
+	struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", target_load);
+}
+
+static ssize_t store_target_load(
+	struct kobject *kobj, struct attribute *attr, const char *buf,
+	size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D strict_strtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	target_load =3D val;
+	return count;
+}
+
+static struct global_attr target_load_attr =3D
+	__ATTR(target_load, S_IRUGO | S_IWUSR,
+		show_target_load, store_target_load);
+
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
 {
@@ -581,6 +609,7 @@ static struct global_attr boostpulse =3D
 	__ATTR(boostpulse, 0200, NULL, store_boostpulse);
=20
 static struct attribute *interactive_attributes[] =3D {
+	&target_load_attr.attr,
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
 	&above_hispeed_delay.attr,
--=20
1.7.9.5
