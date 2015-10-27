From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 34/70] cpufreq: interactive: fix boosting logic
Date: Tue, 27 Oct 2015 18:30:22 +0100
Message-ID: <1445967059-6897-34-git-send-email-czoborbalint@gmail.com>
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

35a84de cpufreq: interactive: apply above_hispeed_delay to each step ab=
ove hispeed

caused the speed choice logic to osciallate between boosting and not bo=
osting.
Add back code to ensure speed does not drop below boost frequency while
boosting.

Change-Id: Id420068480fcc7f5c4989ff523e2a8d22e2f4db2
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 690be16..f8e9ee9 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -298,11 +298,18 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	cpu_load =3D loadadjfreq / pcpu->target_freq;
 	boosted =3D boost_val || now < boostpulse_endtime;
=20
-	if ((cpu_load >=3D go_hispeed_load || boosted) &&
-	    pcpu->target_freq < hispeed_freq)
-		new_freq =3D hispeed_freq;
-	else
+	if (cpu_load >=3D go_hispeed_load || boosted) {
+		if (pcpu->target_freq < hispeed_freq) {
+			new_freq =3D hispeed_freq;
+		} else {
+			new_freq =3D choose_freq(pcpu, loadadjfreq);
+
+			if (new_freq < hispeed_freq)
+				new_freq =3D hispeed_freq;
+		}
+	} else {
 		new_freq =3D choose_freq(pcpu, loadadjfreq);
+	}
=20
 	if (pcpu->target_freq >=3D hispeed_freq &&
 	    new_freq > pcpu->target_freq &&
--=20
1.7.9.5
