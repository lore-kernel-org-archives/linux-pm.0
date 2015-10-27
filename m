From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 63/70] cpufreq: interactive: remove compilation error from commit 49cc72365fb7ee87762a7ccc6a32ef68627216c5
Date: Tue, 27 Oct 2015 18:30:51 +0100
Message-ID: <1445967059-6897-63-git-send-email-czoborbalint@gmail.com>
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

Change-Id: I068b18281d03ac879ef64d8ff36ed43367293767
Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 3daca21..6c4b6a8 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -908,7 +908,7 @@ static ssize_t store_boost(struct cpufreq_interacti=
ve_tunables *tunables,
 		trace_cpufreq_interactive_boost("on");
 		cpufreq_interactive_boost();
 	} else {
-		boostpulse_endtime =3D ktime_to_us(ktime_get());
+		tunables->boostpulse_endtime =3D ktime_to_us(ktime_get());
 		trace_cpufreq_interactive_unboost("off");
 	}
=20
--=20
1.7.9.5
