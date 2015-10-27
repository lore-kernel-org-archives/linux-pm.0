From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 39/70] cpufreq: interactive: don't handle transition notification if not enabled
Date: Tue, 27 Oct 2015 18:30:27 +0100
Message-ID: <1445967059-6897-39-git-send-email-czoborbalint@gmail.com>
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

If multiple governors are in use then avoid processing frequency transi=
tion
notifications for CPUs on which the interactive governor is not enabled=
=2E

Change-Id: Ibd75255b921d887501a64774a8c4f62302f2d4e4
Reported-by: Francisco Franco <francisco.franco@cloudcar.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index c8358a3..51c34bf 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -552,6 +552,12 @@ static int cpufreq_interactive_notifier(
=20
 	if (val =3D=3D CPUFREQ_POSTCHANGE) {
 		pcpu =3D &per_cpu(cpuinfo, freq->cpu);
+		if (!down_read_trylock(&pcpu->enable_sem))
+			return 0;
+		if (!pcpu->governor_enabled) {
+			up_read(&pcpu->enable_sem);
+			return 0;
+		}
=20
 		for_each_cpu(cpu, pcpu->policy->cpus) {
 			struct cpufreq_interactive_cpuinfo *pjcpu =3D
@@ -560,8 +566,9 @@ static int cpufreq_interactive_notifier(
 			update_load(cpu);
 			spin_unlock(&pjcpu->load_lock);
 		}
-	}
=20
+		up_read(&pcpu->enable_sem);
+	}
 	return 0;
 }
=20
--=20
1.7.9.5
