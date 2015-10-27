From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 68/70] subsystem: CPU FREQUENCY DRIVERS- Set cpu_load calculation on current frequency
Date: Tue, 27 Oct 2015 18:30:56 +0100
Message-ID: <1445967059-6897-68-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>, "rahul.khandelwal" <rahul.khandelwal@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

In timer, cpu_load is calcuated on target_freq.
cpu_load =3D loadadjfreq / pcpu->target_freq;
But cpu is actually running on current freq i.e. pcpu->policy->cur. So =
cpu_load
should be calculated on current frequency.
cpu_load =3D loadadjfreq / pcpu->policy->cur;

Change-Id: I89db6b68e9f82aa52077f6bf7d819dab74265790
Signed-off-by: rahul.khandelwal <rahul.khandelwal@spreadtrum.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 2055266..064ab56 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -363,7 +363,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	spin_lock_irqsave(&pcpu->target_freq_lock, flags);
 	do_div(cputime_speedadj, delta_time);
 	loadadjfreq =3D (unsigned int)cputime_speedadj * 100;
-	cpu_load =3D loadadjfreq / pcpu->target_freq;
+	cpu_load =3D loadadjfreq / pcpu->policy->cur;
 	boosted =3D tunables->boost_val || now < tunables->boostpulse_endtime=
;
=20
 	if (cpu_load >=3D tunables->go_hispeed_load || boosted) {
--=20
1.7.9.5
