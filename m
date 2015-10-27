From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 54/70] cpufreq: interactive: Move definition of cpufreq_gov_interactive downwards
Date: Tue, 27 Oct 2015 18:30:42 +0100
Message-ID: <1445967059-6897-54-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Viresh Kumar <viresh.kumar@linaro.org>

This moves definition of cpufreq_gov_interactive towards the bottom of =
file, so
that we don't have to add prototype of cpufreq_governor_interactive() i=
n the
beginning of file.

Change-Id: I04bd1004954eb36502c5cd7e35d3d7274cddaf95
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 378835b..b0685c7 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -117,19 +117,6 @@ static int timer_slack_val =3D DEFAULT_TIMER_SLACK=
;
=20
 static bool io_is_busy;
=20
-static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
-		unsigned int event);
-
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_interactive =3D {
-	.name =3D "interactive",
-	.governor =3D cpufreq_governor_interactive,
-	.max_transition_latency =3D 10000000,
-	.owner =3D THIS_MODULE,
-};
-
 static inline cputime64_t get_cpu_idle_time_jiffy(unsigned int cpu,
 						  cputime64_t *wall)
 {
@@ -1182,6 +1169,16 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 	return 0;
 }
=20
+#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_INTERACTIVE
+static
+#endif
+struct cpufreq_governor cpufreq_gov_interactive =3D {
+	.name =3D "interactive",
+	.governor =3D cpufreq_governor_interactive,
+	.max_transition_latency =3D 10000000,
+	.owner =3D THIS_MODULE,
+};
+
 static void cpufreq_interactive_nop_timer(unsigned long data)
 {
 }
--=20
1.7.9.5
