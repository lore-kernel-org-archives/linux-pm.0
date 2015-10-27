From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 11/70] cpufreq: interactive: remove unused target_validate_time_in_idle
Date: Tue, 27 Oct 2015 18:29:59 +0100
Message-ID: <1445967059-6897-11-git-send-email-czoborbalint@gmail.com>
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

Change-Id: I37c5085b91318242612440dfd775ad762996612f
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 1387cd5..90db2c3 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -49,7 +49,6 @@ struct cpufreq_interactive_cpuinfo {
 	u64 target_set_time;
 	u64 target_set_time_in_idle;
 	u64 target_validate_time;
-	u64 target_validate_time_in_idle;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int target_freq;
@@ -236,7 +235,6 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		}
 	}
=20
-	pcpu->target_validate_time_in_idle =3D now_idle;
 	pcpu->target_validate_time =3D pcpu->timer_run_time;
=20
 	if (pcpu->target_freq =3D=3D new_freq) {
@@ -510,8 +508,7 @@ static void cpufreq_interactive_boost(void)
 		 * allowing speed to drop).
 		 */
=20
-		pcpu->target_validate_time_in_idle =3D
-			get_cpu_idle_time_us(i, &pcpu->target_validate_time);
+		pcpu->target_validate_time =3D ktime_to_us(ktime_get());
 	}
=20
 	spin_unlock_irqrestore(&up_cpumask_lock, flags);
@@ -776,8 +773,6 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 					     &pcpu->target_set_time);
 			pcpu->target_validate_time =3D
 				pcpu->target_set_time;
-			pcpu->target_validate_time_in_idle =3D
-				pcpu->target_set_time_in_idle;
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
 		}
--=20
1.7.9.5
