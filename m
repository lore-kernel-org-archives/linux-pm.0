From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 48/70] cpufreq: interactive: reduce chance of zero time delta on load eval
Date: Tue, 27 Oct 2015 18:30:36 +0100
Message-ID: <1445967059-6897-48-git-send-email-czoborbalint@gmail.com>
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

Reschedule load sampling timer after timestamp of sample start taken,
hold spinlock across entire sequence to avoid preemption.  Avoid the
WARN for zero time delta in the load sampling timer function.

Change-Id: Idc10a756f09141decb6df92669521a1ebf0dbc10
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 1b5d930..b4d12b2 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -169,21 +169,23 @@ static inline cputime64_t get_cpu_idle_time(unsig=
ned int cpu,
 static void cpufreq_interactive_timer_resched(
 	struct cpufreq_interactive_cpuinfo *pcpu)
 {
-	unsigned long expires =3D jiffies + usecs_to_jiffies(timer_rate);
+	unsigned long expires;
 	unsigned long flags;
=20
-	mod_timer_pinned(&pcpu->cpu_timer, expires);
-	if (timer_slack_val >=3D 0 && pcpu->target_freq > pcpu->policy->min) =
{
-		expires +=3D usecs_to_jiffies(timer_slack_val);
-		mod_timer_pinned(&pcpu->cpu_slack_timer, expires);
-	}
-
 	spin_lock_irqsave(&pcpu->load_lock, flags);
 	pcpu->time_in_idle =3D
 		get_cpu_idle_time(smp_processor_id(),
 				     &pcpu->time_in_idle_timestamp);
 	pcpu->cputime_speedadj =3D 0;
 	pcpu->cputime_speedadj_timestamp =3D pcpu->time_in_idle_timestamp;
+	expires =3D jiffies + usecs_to_jiffies(timer_rate);
+	mod_timer_pinned(&pcpu->cpu_timer, expires);
+
+	if (timer_slack_val >=3D 0 && pcpu->target_freq > pcpu->policy->min) =
{
+		expires +=3D usecs_to_jiffies(timer_slack_val);
+		mod_timer_pinned(&pcpu->cpu_slack_timer, expires);
+	}
+
 	spin_unlock_irqrestore(&pcpu->load_lock, flags);
 }
=20
--=20
1.7.9.5
