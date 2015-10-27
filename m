From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 22/70] cpufreq: interactive: run at fraction of hispeed_freq when load is low
Date: Tue, 27 Oct 2015 18:30:10 +0100
Message-ID: <1445967059-6897-22-git-send-email-czoborbalint@gmail.com>
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

When load is below go_hispeed_load, apply the percentage of CPU load to
a max frequency of hispeed_freq instead of the max speed.  This avoids
jumping too quickly to hispeed_freq when it is a relatively low
percentage of max speed.  This also allows go_hispeed_load to be set to
a high percentage relative to hispeed_freq (as a percentage of max spee=
d,
again useful when hispeed_freq is a low fraction of max speed), to cap
larger loads at hispeed_freq.  For example, a load of 60% will typicall=
y
move to 60% of hispeed_freq, not 60% of max speed.  This causes the
governor to apply two different speed caps, depending on whether load i=
s
below or above go_hispeed_load.

Also fix the type of hispeed_freq, which was u64, to match other
speed data types (and avoid overhead and allow division).

Change-Id: Ie2d0668be161c074aaad77db2037505431457b3a
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index f85fbbd..16bd23b 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -63,7 +63,7 @@ static cpumask_t speedchange_cpumask;
 static spinlock_t speedchange_cpumask_lock;
=20
 /* Hi speed to bump to from lo speed when load burst (default max) */
-static u64 hispeed_freq;
+static unsigned int hispeed_freq;
=20
 /* Go to hi speed when CPU load at or above this value. */
 #define DEFAULT_GO_HISPEED_LOAD 85
@@ -198,7 +198,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 			}
 		}
 	} else {
-		new_freq =3D pcpu->policy->max * cpu_load / 100;
+		new_freq =3D hispeed_freq * cpu_load / 100;
 	}
=20
 	if (new_freq <=3D hispeed_freq)
@@ -465,7 +465,7 @@ static void cpufreq_interactive_boost(void)
 static ssize_t show_hispeed_freq(struct kobject *kobj,
 				 struct attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", hispeed_freq);
+	return sprintf(buf, "%u\n", hispeed_freq);
 }
=20
 static ssize_t store_hispeed_freq(struct kobject *kobj,
@@ -473,9 +473,9 @@ static ssize_t store_hispeed_freq(struct kobject *k=
obj,
 				  size_t count)
 {
 	int ret;
-	u64 val;
+	long unsigned int val;
=20
-	ret =3D strict_strtoull(buf, 0, &val);
+	ret =3D strict_strtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 	hispeed_freq =3D val;
--=20
1.7.9.5
