From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 64/70] cpufreq: interactive: prevents the frequency to directly raise above the hispeed_freq from a lower frequency.
Date: Tue, 27 Oct 2015 18:30:52 +0100
Message-ID: <1445967059-6897-64-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ruchi Kandoi <kandoiruchi@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Ruchi Kandoi <kandoiruchi@google.com>

When the load was below go_hispeed_load, there is a possibility that
choose_freq() would return a frequency which would be higher than the
hispeed_freq. According to the policy we should first jump to the
hispeed_freq, stay there for above_hispeed_delay and then be allowed to
raise higher than that.

Added a check to prevent the frequency to be directly raised to
something higher than the hispeed_freq.

Change-Id: Icda5d848dd9beadcc18835082ddf269732c75bd0
Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 6c4b6a8..f0e6fe2 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -377,6 +377,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 		}
 	} else {
 		new_freq =3D choose_freq(pcpu, loadadjfreq);
+		if (new_freq > tunables->hispeed_freq &&
+				pcpu->target_freq < tunables->hispeed_freq)
+			new_freq =3D tunables->hispeed_freq;
 	}
=20
 	if (pcpu->target_freq >=3D tunables->hispeed_freq &&
--=20
1.7.9.5
