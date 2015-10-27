From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 70/70] cpufreq: interactive: Round up timer_rate to match jiffy
Date: Tue, 27 Oct 2015 18:30:58 +0100
Message-ID: <1445967059-6897-70-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Junjie Wu <junjiew@codeaurora.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Junjie Wu <junjiew@codeaurora.org>

Timers are scheduled in unit of jiffies. Round up timer_rate so that
it matches the actual sampling period.

Change-Id: I88386a5a448e40333f9a9b9f0cf72af58cb54656
Signed-off-by: Junjie Wu <junjiew@codeaurora.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 95525b3..a2fc98a 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -852,12 +852,18 @@ static ssize_t store_timer_rate(struct cpufreq_in=
teractive_tunables *tunables,
 		const char *buf, size_t count)
 {
 	int ret;
-	unsigned long val;
+	unsigned long val, val_round;
=20
 	ret =3D kstrtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
-	tunables->timer_rate =3D val;
+
+	val_round =3D jiffies_to_usecs(usecs_to_jiffies(val));
+	if (val !=3D val_round)
+		pr_warn("timer_rate not aligned to jiffy. Rounded up to %lu\n",
+			val_round);
+
+	tunables->timer_rate =3D val_round;
 	return count;
 }
=20
--=20
1.7.9.5
