From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 21/70] cpufreq: interactive: always limit initial speed bump to hispeed
Date: Tue, 27 Oct 2015 18:30:09 +0100
Message-ID: <1445967059-6897-21-git-send-email-czoborbalint@gmail.com>
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

=46irst bump speed up to hispeed_freq whenever the current speed is bel=
ow
hispeed_freq, instead of only when the current speed is the minimum spe=
ed.
The previous code made it too difficult to use hispeed_freq as a common
intermediate speed on systems that frequently run at speeds between
minimum and hispeed_freq.

Change-Id: I04ec30bafabf5741e267ff289209b8c2d846824b
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 4b60b6e..f85fbbd 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -178,7 +178,8 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		cpu_load =3D load_since_change;
=20
 	if (cpu_load >=3D go_hispeed_load || boost_val) {
-		if (pcpu->target_freq <=3D pcpu->policy->min) {
+		if (pcpu->target_freq < hispeed_freq &&
+		    hispeed_freq < pcpu->policy->max) {
 			new_freq =3D hispeed_freq;
 		} else {
 			new_freq =3D pcpu->policy->max * cpu_load / 100;
--=20
1.7.9.5
