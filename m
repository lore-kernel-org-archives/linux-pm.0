From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 13/70] cpufreq: interactive: set floor for boosted speed
Date: Tue, 27 Oct 2015 18:30:01 +0100
Message-ID: <1445967059-6897-13-git-send-email-czoborbalint@gmail.com>
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

Allow speed to drop to flooor frequency but not below, don't pin
to speed at last boost.

Change-Id: I0147c2b7a2e61ba16820605af6baaf09570be787
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 07b7caf..fcd5b1d 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -47,10 +47,11 @@ struct cpufreq_interactive_cpuinfo {
 	int idling;
 	u64 target_set_time;
 	u64 target_set_time_in_idle;
-	u64 target_validate_time;
 	struct cpufreq_policy *policy;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int target_freq;
+	unsigned int floor_freq;
+	u64 floor_validate_time;
 	int governor_enabled;
 };
=20
@@ -228,10 +229,10 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	new_freq =3D pcpu->freq_table[index].frequency;
=20
 	/*
-	 * Do not scale down unless we have been at this frequency for the
-	 * minimum sample time since last validated.
+	 * Do not scale below floor_freq unless we have been at or above the
+	 * floor frequency for the minimum sample time since last validated.
 	 */
-	if (new_freq < pcpu->target_freq) {
+	if (new_freq < pcpu->floor_freq) {
 		if (pcpu->timer_run_time - pcpu->target_validate_time
 		    < min_sample_time) {
 			trace_cpufreq_interactive_notyet(data, cpu_load,
@@ -240,7 +241,8 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		}
 	}
=20
-	pcpu->target_validate_time =3D pcpu->timer_run_time;
+	pcpu->floor_freq =3D new_freq;
+	pcpu->floor_validate_time =3D pcpu->timer_run_time;
=20
 	if (pcpu->target_freq =3D=3D new_freq) {
 		trace_cpufreq_interactive_already(data, cpu_load,
@@ -508,12 +510,12 @@ static void cpufreq_interactive_boost(void)
 		}
=20
 		/*
-		 * Refresh time at which current (possibly being
-		 * boosted) speed last validated (reset timer for
-		 * allowing speed to drop).
+		 * Set floor freq and (re)start timer for when last
+		 * validated.
 		 */
=20
-		pcpu->target_validate_time =3D ktime_to_us(ktime_get());
+		pcpu->floor_freq =3D hispeed_freq;
+		pcpu->floor_validate_time =3D ktime_to_us(ktime_get());
 	}
=20
 	spin_unlock_irqrestore(&up_cpumask_lock, flags);
@@ -811,7 +813,8 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pcpu->target_set_time_in_idle =3D
 				get_cpu_idle_time_us(j,
 					     &pcpu->target_set_time);
-			pcpu->target_validate_time =3D
+			pcpu->floor_freq =3D pcpu->target_freq;
+			pcpu->floor_validate_time =3D
 				pcpu->target_set_time;
 			pcpu->governor_enabled =3D 1;
 			smp_wmb();
--=20
1.7.9.5
