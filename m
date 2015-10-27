From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 05/70] cpufreq: interactive: don't drop speed if recently at higher load
Date: Tue, 27 Oct 2015 18:29:53 +0100
Message-ID: <1445967059-6897-5-git-send-email-czoborbalint@gmail.com>
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

Apply min_sample_time to the last time the current target speed
was originally requested or re-validated as appropriate for the
current load, not to the time since the current speed was
originally set.  Avoids periodic dips in speed during bursty
loads.

Change-Id: I250bda657985de60373f9897cc41f480664d51a1
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   38 +++++++++++++++----------=
--------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 12345c7b..59e7779a 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -44,8 +44,8 @@ struct cpufreq_interactive_cpuinfo {
 	u64 idle_exit_time;
 	u64 timer_run_time;
 	int idling;
-	u64 freq_change_time;
-	u64 freq_change_time_in_idle;
+	u64 target_set_time;
+	u64 target_set_time_in_idle;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int target_freq;
@@ -148,8 +148,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	else
 		cpu_load =3D 100 * (delta_time - delta_idle) / delta_time;
=20
-	delta_idle =3D (unsigned int)(now_idle - pcpu->freq_change_time_in_id=
le);
-	delta_time =3D (unsigned int)(pcpu->timer_run_time - pcpu->freq_chang=
e_time);
+	delta_idle =3D (unsigned int)(now_idle - pcpu->target_set_time_in_idl=
e);
+	delta_time =3D (unsigned int)(pcpu->timer_run_time -
+				    pcpu->target_set_time);
=20
 	if ((delta_time =3D=3D 0) || (delta_idle > delta_time))
 		load_since_change =3D 0;
@@ -188,19 +189,12 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
=20
 	new_freq =3D pcpu->freq_table[index].frequency;
=20
-	if (pcpu->target_freq =3D=3D new_freq)
-	{
-		trace_cpufreq_interactive_already(data, cpu_load,
-						  pcpu->target_freq, new_freq);
-		goto rearm_if_notmax;
-	}
-
 	/*
 	 * Do not scale down unless we have been at this frequency for the
 	 * minimum sample time.
 	 */
 	if (new_freq < pcpu->target_freq) {
-		if (pcpu->timer_run_time - pcpu->freq_change_time
+		if (pcpu->timer_run_time - pcpu->target_set_time
 		    < min_sample_time) {
 			trace_cpufreq_interactive_notyet(data, cpu_load,
 					 pcpu->target_freq, new_freq);
@@ -208,6 +202,15 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
 		}
 	}
=20
+	pcpu->target_set_time_in_idle =3D now_idle;
+	pcpu->target_set_time =3D pcpu->timer_run_time;
+
+	if (pcpu->target_freq =3D=3D new_freq) {
+		trace_cpufreq_interactive_already(data, cpu_load,
+						  pcpu->target_freq, new_freq);
+		goto rearm_if_notmax;
+	}
+
 	trace_cpufreq_interactive_target(data, cpu_load, pcpu->target_freq,
 					 new_freq);
=20
@@ -394,10 +397,6 @@ static int cpufreq_interactive_up_task(void *data)
 							max_freq,
 							CPUFREQ_RELATION_H);
 			mutex_unlock(&set_speed_lock);
-
-			pcpu->freq_change_time_in_idle =3D
-				get_cpu_idle_time_us(cpu,
-						     &pcpu->freq_change_time);
 			trace_cpufreq_interactive_up(cpu, pcpu->target_freq,
 						     pcpu->policy->cur);
 		}
@@ -443,9 +442,6 @@ static void cpufreq_interactive_freq_down(struct wo=
rk_struct *work)
 						CPUFREQ_RELATION_H);
=20
 		mutex_unlock(&set_speed_lock);
-		pcpu->freq_change_time_in_idle =3D
-			get_cpu_idle_time_us(cpu,
-					     &pcpu->freq_change_time);
 		trace_cpufreq_interactive_down(cpu, pcpu->target_freq,
 					       pcpu->policy->cur);
 	}
@@ -575,9 +571,9 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pcpu->policy =3D policy;
 			pcpu->target_freq =3D policy->cur;
 			pcpu->freq_table =3D freq_table;
-			pcpu->freq_change_time_in_idle =3D
+			pcpu->target_set_time_in_idle =3D
 				get_cpu_idle_time_us(j,
-					     &pcpu->freq_change_time);
+					     &pcpu->target_set_time);
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
 		}
--=20
1.7.9.5
