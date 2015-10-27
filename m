From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 47/70] cpufreq: interactive: handle errors from cpufreq_frequency_table_target
Date: Tue, 27 Oct 2015 18:30:35 +0100
Message-ID: <1445967059-6897-47-git-send-email-czoborbalint@gmail.com>
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

Add checks for error return from cpufreq_frequency_table_target, and be
less noisy on the existing call with an error check.  CPU hotplug and
system shutdown may cause this call to return -EINVAL.

Bug: 8613560
Change-Id: Id78d8829920462c0db1c7e14e717d91740d6cb44
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   30 +++++++++++++++----------=
-----
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index baf8740..1b5d930 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -246,9 +246,10 @@ static unsigned int choose_freq(
 		 * than or equal to the target load.
 		 */
=20
-		cpufreq_frequency_table_target(
-			pcpu->policy, pcpu->freq_table, loadadjfreq / tl,
-			CPUFREQ_RELATION_L, &index);
+		if (cpufreq_frequency_table_target(
+			    pcpu->policy, pcpu->freq_table, loadadjfreq / tl,
+			    CPUFREQ_RELATION_L, &index))
+			break;
 		freq =3D pcpu->freq_table[index].frequency;
=20
 		if (freq > prevfreq) {
@@ -260,10 +261,11 @@ static unsigned int choose_freq(
 				 * Find the highest frequency that is less
 				 * than freqmax.
 				 */
-				cpufreq_frequency_table_target(
-					pcpu->policy, pcpu->freq_table,
-					freqmax - 1, CPUFREQ_RELATION_H,
-					&index);
+				if (cpufreq_frequency_table_target(
+					    pcpu->policy, pcpu->freq_table,
+					    freqmax - 1, CPUFREQ_RELATION_H,
+					    &index))
+					break;
 				freq =3D pcpu->freq_table[index].frequency;
=20
 				if (freq =3D=3D freqmin) {
@@ -286,10 +288,11 @@ static unsigned int choose_freq(
 				 * Find the lowest frequency that is higher
 				 * than freqmin.
 				 */
-				cpufreq_frequency_table_target(
-					pcpu->policy, pcpu->freq_table,
-					freqmin + 1, CPUFREQ_RELATION_L,
-					&index);
+				if (cpufreq_frequency_table_target(
+					    pcpu->policy, pcpu->freq_table,
+					    freqmin + 1, CPUFREQ_RELATION_L,
+					    &index))
+					break;
 				freq =3D pcpu->freq_table[index].frequency;
=20
 				/*
@@ -388,11 +391,8 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
=20
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
 					   new_freq, CPUFREQ_RELATION_L,
-					   &index)) {
-		pr_warn_once("timer %d: cpufreq_frequency_table_target error\n",
-			     (int) data);
+					   &index))
 		goto rearm;
-	}
=20
 	new_freq =3D pcpu->freq_table[index].frequency;
=20
--=20
1.7.9.5
