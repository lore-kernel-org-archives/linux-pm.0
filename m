From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 03/70] cpufreq: interactive: apply intermediate load to max speed not current
Date: Tue, 27 Oct 2015 18:29:51 +0100
Message-ID: <1445967059-6897-3-git-send-email-czoborbalint@gmail.com>
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

Evaluate spikes in load (below go_hispeed_load) against the maximum
speed supported by the device, not the current speed (which tends to
make it too difficult to raise speed to intermediate levels until
very busy).

Change-Id: Ib937006abf8bedb60891a739acd733e89b732ae0
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 62e7456..e3bbe82 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -171,7 +171,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		else
 			new_freq =3D pcpu->policy->max * cpu_load / 100;
 	} else {
-		new_freq =3D pcpu->policy->cur * cpu_load / 100;
+		new_freq =3D pcpu->policy->max * cpu_load / 100;
 	}
=20
 	if (cpufreq_frequency_table_target(pcpu->policy, pcpu->freq_table,
--=20
1.7.9.5
