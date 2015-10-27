From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 30/70] cpufreq: interactive: remove load since last speed change
Date: Tue, 27 Oct 2015 18:30:18 +0100
Message-ID: <1445967059-6897-30-git-send-email-czoborbalint@gmail.com>
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

The longer-term load since last speed change isn't terribly useful,
may delay recognition of dropping load, and would need forthcoming
changes to adjust load for changing CPU speeds.  Drop it.

Change-Id: Ic3cbb0542cc3484617031787e03ed9bdd632dec1
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   34 ++++---------------------=
--------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 6ea77a0..3d8e7b4 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -43,8 +43,6 @@ struct cpufreq_interactive_cpuinfo {
 	int timer_idlecancel;
 	u64 time_in_idle;
 	u64 time_in_idle_timestamp;
-	u64 target_set_time;
-	u64 target_set_time_in_idle;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int target_freq;
@@ -238,7 +236,6 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	unsigned int delta_idle;
 	unsigned int delta_time;
 	int cpu_load;
-	int load_since_change;
 	struct cpufreq_interactive_cpuinfo *pcpu =3D
 		&per_cpu(cpuinfo, data);
 	u64 now_idle;
@@ -266,23 +263,6 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
 	else
 		cpu_load =3D 100 * (delta_time - delta_idle) / delta_time;
=20
-	delta_idle =3D (unsigned int)(now_idle - pcpu->target_set_time_in_idl=
e);
-	delta_time =3D (unsigned int)(now - pcpu->target_set_time);
-
-	if ((delta_time =3D=3D 0) || (delta_idle > delta_time))
-		load_since_change =3D 0;
-	else
-		load_since_change =3D
-			100 * (delta_time - delta_idle) / delta_time;
-
-	/*
-	 * Choose greater of short-term load (since last idle timer
-	 * started or timer function re-armed itself) or long-term load
-	 * (since last frequency change).
-	 */
-	if (load_since_change > cpu_load)
-		cpu_load =3D load_since_change;
-
 	if ((cpu_load >=3D go_hispeed_load || boost_val) &&
 	    pcpu->target_freq < hispeed_freq)
 		new_freq =3D hispeed_freq;
@@ -335,8 +315,6 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
=20
 	trace_cpufreq_interactive_target(data, cpu_load, pcpu->target_freq,
 					 pcpu->policy->cur, new_freq);
-	pcpu->target_set_time_in_idle =3D now_idle;
-	pcpu->target_set_time =3D now;
=20
 	pcpu->target_freq =3D new_freq;
 	spin_lock_irqsave(&speedchange_cpumask_lock, flags);
@@ -500,9 +478,8 @@ static void cpufreq_interactive_boost(void)
 		if (pcpu->target_freq < hispeed_freq) {
 			pcpu->target_freq =3D hispeed_freq;
 			cpumask_set_cpu(i, &speedchange_cpumask);
-			pcpu->target_set_time_in_idle =3D
-				get_cpu_idle_time_us(i, &pcpu->target_set_time);
-			pcpu->hispeed_validate_time =3D pcpu->target_set_time;
+			pcpu->hispeed_validate_time =3D
+				ktime_to_us(ktime_get());
 			anyboost =3D 1;
 		}
=20
@@ -815,14 +792,11 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 			pcpu->policy =3D policy;
 			pcpu->target_freq =3D policy->cur;
 			pcpu->freq_table =3D freq_table;
-			pcpu->target_set_time_in_idle =3D
-				get_cpu_idle_time_us(j,
-					     &pcpu->target_set_time);
 			pcpu->floor_freq =3D pcpu->target_freq;
 			pcpu->floor_validate_time =3D
-				pcpu->target_set_time;
+				ktime_to_us(ktime_get());
 			pcpu->hispeed_validate_time =3D
-				pcpu->target_set_time;
+				pcpu->floor_validate_time;
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
 			pcpu->cpu_timer.expires =3D
--=20
1.7.9.5
