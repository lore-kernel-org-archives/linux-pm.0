From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 08/70] cpufreq: interactive: base hispeed bump on target freq, not actual
Date: Tue, 27 Oct 2015 18:29:56 +0100
Message-ID: <1445967059-6897-8-git-send-email-czoborbalint@gmail.com>
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

=46or systems that set a common speed for all CPUs, checking current
speed here could bypass the intermediate hispeed bump decision for
this CPU when another CPU was already at hispeed.  This could
result in an overly high setting (for all CPUs) in situations
where all CPUs were about to drop to load levels that map to
hispeed or below.

Change-Id: I186f23dcfc5e2b6336cab8b0327f0c8a9a4482bc
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index bf8d772..b78174f 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -174,7 +174,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		cpu_load =3D load_since_change;
=20
 	if (cpu_load >=3D go_hispeed_load) {
-		if (pcpu->policy->cur =3D=3D pcpu->policy->min) {
+		if (pcpu->target_freq <=3D pcpu->policy->min) {
 			new_freq =3D hispeed_freq;
 		} else {
 			new_freq =3D pcpu->policy->max * cpu_load / 100;
--=20
1.7.9.5
