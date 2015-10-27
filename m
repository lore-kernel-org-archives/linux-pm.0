From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 28/70] cpufreq: interactive: apply above_hispeed_delay to each step above hispeed
Date: Tue, 27 Oct 2015 18:30:16 +0100
Message-ID: <1445967059-6897-28-git-send-email-czoborbalint@gmail.com>
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

Apply above_hispeed_delay whenever increasing speed to a new speed abov=
e
hispeed (not just the first step above hispeed).

Change-Id: Ibb7add7db47f2a4306a9458c4e1ebabb60698636
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   36 ++++++++++++-------------=
--------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index c4293c5..17c42cc 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -176,32 +176,22 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	if (load_since_change > cpu_load)
 		cpu_load =3D load_since_change;
=20
-	if (cpu_load >=3D go_hispeed_load || boost_val) {
-		if (pcpu->target_freq < hispeed_freq &&
-		    hispeed_freq < pcpu->policy->max) {
-			new_freq =3D hispeed_freq;
-		} else {
-			new_freq =3D pcpu->policy->cur * cpu_load / target_load;
-
-			if (new_freq < hispeed_freq)
-				new_freq =3D hispeed_freq;
-
-			if (pcpu->target_freq =3D=3D hispeed_freq &&
-			    new_freq > hispeed_freq &&
-			    now - pcpu->hispeed_validate_time
-			    < above_hispeed_delay_val) {
-				trace_cpufreq_interactive_notyet(
-					data, cpu_load, pcpu->target_freq,
-					pcpu->policy->cur, new_freq);
-				goto rearm;
-			}
-		}
-	} else {
+	if ((cpu_load >=3D go_hispeed_load || boost_val) &&
+	    pcpu->target_freq < hispeed_freq)
+		new_freq =3D hispeed_freq;
+	else
 		new_freq =3D pcpu->policy->cur * cpu_load / target_load;
+
+	if (pcpu->target_freq >=3D hispeed_freq &&
+	    new_freq > pcpu->target_freq &&
+	    now - pcpu->hispeed_validate_time < above_hispeed_delay_val) {
+		trace_cpufreq_interactive_notyet(
+			data, cpu_load, pcpu->target_freq,
+			pcpu->policy->cur, new_freq);
+		goto rearm;
 	}
=20
-	if (new_freq <=3D hispeed_freq)
-		pcpu->hispeed_validate_time =3D now;
+	pcpu->hispeed_validate_time =3D now;
=20
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
 					   new_freq, CPUFREQ_RELATION_L,
--=20
1.7.9.5
