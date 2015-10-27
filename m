From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 50/70] cpufreq: interactive: fix race on cpufreq TRANSITION notifier
Date: Tue, 27 Oct 2015 18:30:38 +0100
Message-ID: <1445967059-6897-50-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <a22439@motorola.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Lianwei Wang <a22439@motorola.com>

The cpufreq TRANSTION notifier callback does not check the
governor_enabled state on affected CPUS, which will case
kernel panic in update_load because the policy object maybe
NULL or invalid when governor_enabled is false.

Change-Id: Ie0f1718124f61e2f9b5da57abc6981ada5b83908
Signed-off-by: Lianwei Wang <a22439@motorola.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 7303f50..691923d 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -634,9 +634,19 @@ static int cpufreq_interactive_notifier(
 		for_each_cpu(cpu, pcpu->policy->cpus) {
 			struct cpufreq_interactive_cpuinfo *pjcpu =3D
 				&per_cpu(cpuinfo, cpu);
+			if (cpu !=3D freq->cpu) {
+				if (!down_read_trylock(&pjcpu->enable_sem))
+					continue;
+				if (!pjcpu->governor_enabled) {
+					up_read(&pjcpu->enable_sem);
+					continue;
+				}
+			}
 			spin_lock_irqsave(&pjcpu->load_lock, flags);
 			update_load(cpu);
 			spin_unlock_irqrestore(&pjcpu->load_lock, flags);
+			if (cpu !=3D freq->cpu)
+				up_read(&pjcpu->enable_sem);
 		}
=20
 		up_read(&pcpu->enable_sem);
--=20
1.7.9.5
