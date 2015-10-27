From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 16/70] cpufreq: interactive: restart above_hispeed_delay at each hispeed load
Date: Tue, 27 Oct 2015 18:30:04 +0100
Message-ID: <1445967059-6897-16-git-send-email-czoborbalint@gmail.com>
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

Change-Id: I2e5b91d45e8806b0ab94ca2301ed671c9af9ab13
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 7cb2e64..a4ed750 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -52,6 +52,7 @@ struct cpufreq_interactive_cpuinfo {
 	unsigned int target_freq;
 	unsigned int floor_freq;
 	u64 floor_validate_time;
+	u64 hispeed_validate_time;
 	int governor_enabled;
 };
=20
@@ -206,7 +207,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
=20
 			if (pcpu->target_freq =3D=3D hispeed_freq &&
 			    new_freq > hispeed_freq &&
-			    pcpu->timer_run_time - pcpu->target_set_time
+			    pcpu->timer_run_time - pcpu->hispeed_validate_time
 			    < above_hispeed_delay_val) {
 				trace_cpufreq_interactive_notyet(data, cpu_load,
 								 pcpu->target_freq,
@@ -218,6 +219,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		new_freq =3D pcpu->policy->max * cpu_load / 100;
 	}
=20
+	if (new_freq <=3D hispeed_freq)
+		pcpu->hispeed_validate_time =3D pcpu->timer_run_time;
+
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
 					   new_freq, CPUFREQ_RELATION_H,
 					   &index)) {
@@ -505,6 +509,7 @@ static void cpufreq_interactive_boost(void)
 			cpumask_set_cpu(i, &up_cpumask);
 			pcpu->target_set_time_in_idle =3D
 				get_cpu_idle_time_us(i, &pcpu->target_set_time);
+			pcpu->hispeed_validate_time =3D pcpu->target_set_time;
 			anyboost =3D 1;
 		}
=20
@@ -838,6 +843,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pcpu->floor_freq =3D pcpu->target_freq;
 			pcpu->floor_validate_time =3D
 				pcpu->target_set_time;
+			pcpu->hispeed_validate_time =3D
+				pcpu->target_set_time;
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
 		}
--=20
1.7.9.5
