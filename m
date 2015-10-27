From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 04/70] cpufreq: interactive: set at least hispeed when above hispeed load
Date: Tue, 27 Oct 2015 18:29:52 +0100
Message-ID: <1445967059-6897-4-git-send-email-czoborbalint@gmail.com>
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

If load is above go_hispeed_load, always go to at least hispeed_freq,
even when reducing speed from a higher speed, not just when jumping
up from minimum speed.  Avoids running at a lower than intended
speed after a burst of even higher load.

Change-Id: I5b9d2a15ba25ce609b21bac7c724265cf6838dee
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index e3bbe82..12345c7b 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -166,10 +166,14 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 		cpu_load =3D load_since_change;
=20
 	if (cpu_load >=3D go_hispeed_load) {
-		if (pcpu->policy->cur =3D=3D pcpu->policy->min)
+		if (pcpu->policy->cur =3D=3D pcpu->policy->min) {
 			new_freq =3D hispeed_freq;
-		else
+		} else {
 			new_freq =3D pcpu->policy->max * cpu_load / 100;
+
+			if (new_freq < hispeed_freq)
+				new_freq =3D hispeed_freq;
+		}
 	} else {
 		new_freq =3D pcpu->policy->max * cpu_load / 100;
 	}
--=20
1.7.9.5
