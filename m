From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 49/70] cpufreq: interactive: avoid underflow on active time calculation
Date: Tue, 27 Oct 2015 18:30:37 +0100
Message-ID: <1445967059-6897-49-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Minsung Kim <ms925.kim@samsung.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Minsung Kim <ms925.kim@samsung.com>

Check for idle time delta less than elapsed time delta, avoid
underflow computing active time.

Change-Id: I3e4c6ef1ad794eec49ed379c0c50fa727fd6ad28
Signed-off-by: Minsung Kim <ms925.kim@samsung.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index b4d12b2..7303f50 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -325,7 +325,12 @@ static u64 update_load(int cpu)
 	now_idle =3D get_cpu_idle_time(cpu, &now);
 	delta_idle =3D (unsigned int)(now_idle - pcpu->time_in_idle);
 	delta_time =3D (unsigned int)(now - pcpu->time_in_idle_timestamp);
-	active_time =3D delta_time - delta_idle;
+
+	if (delta_time <=3D delta_idle)
+		active_time =3D 0;
+	else
+		active_time =3D delta_time - delta_idle;
+
 	pcpu->cputime_speedadj +=3D active_time * pcpu->policy->cur;
=20
 	pcpu->time_in_idle =3D now_idle;
--=20
1.7.9.5
