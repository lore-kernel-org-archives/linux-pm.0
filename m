From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 59/70] cpufreq: interactive: Use generic get_cpu_idle_time() from cpufreq.c
Date: Tue, 27 Oct 2015 18:30:47 +0100
Message-ID: <1445967059-6897-59-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jon Medhurst <tixy@linaro.org>, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Viresh Kumar <viresh.kumar@linaro.org>

Now that a generic version of get_cpu_idle_time() is available, use tha=
t for the interactive governor.

[toddpoynor@google.com: commit text changes]
Change-Id: Ia38b57085aac99ec3d415fe44471d5dfde519c2c
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   40 -------------------------=
--------
 1 file changed, 40 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 8297ac6..ff77b30 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -30,8 +30,6 @@
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
-#include <linux/kernel_stat.h>
-#include <asm/cputime.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/cpufreq_interactive.h>
@@ -119,44 +117,6 @@ struct cpufreq_interactive_tunables *common_tunabl=
es;
=20
 static struct attribute_group *get_sysfs_attr(void);
=20
-static inline cputime64_t get_cpu_idle_time_jiffy(unsigned int cpu,
-						  cputime64_t *wall)
-{
-	u64 idle_time;
-	u64 cur_wall_time;
-	u64 busy_time;
-
-	cur_wall_time =3D jiffies64_to_cputime64(get_jiffies_64());
-
-	busy_time  =3D kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
-	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
-	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
-	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
-	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-	busy_time +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
-
-	idle_time =3D cur_wall_time - busy_time;
-	if (wall)
-		*wall =3D jiffies_to_usecs(cur_wall_time);
-
-	return jiffies_to_usecs(idle_time);
-}
-
-static inline cputime64_t get_cpu_idle_time(
-	unsigned int cpu,
-	cputime64_t *wall,
-	bool io_is_busy)
-{
-	u64 idle_time =3D get_cpu_idle_time_us(cpu, wall);
-
-	if (idle_time =3D=3D -1ULL)
-		idle_time =3D get_cpu_idle_time_jiffy(cpu, wall);
-	else if (!io_is_busy)
-		idle_time +=3D get_cpu_iowait_time_us(cpu, wall);
-
-	return idle_time;
-}
-
 static void cpufreq_interactive_timer_resched(
 	struct cpufreq_interactive_cpuinfo *pcpu)
 {
--=20
1.7.9.5
