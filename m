From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 67/70] cpufreq: interactive: Put global cpufreq kobject on failure
Date: Tue, 27 Oct 2015 18:30:55 +0100
Message-ID: <1445967059-6897-67-git-send-email-czoborbalint@gmail.com>
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

=46ix failure recovery path in cpufreq_governor_interactive(). Call
cpufreq_put_global_kobject() to release cpufreq global kobject upon
governor init failure.

Change-Id: I7a977070b7a3c75c90acccd2c117064ed1a10d0e
Signed-off-by: Junjie Wu <junjiew@codeaurora.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 9faa189..2055266 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1180,8 +1180,10 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 		if (rc) {
 			kfree(tunables);
 			policy->governor_data =3D NULL;
-			if (!have_governor_per_policy())
+			if (!have_governor_per_policy()) {
 				common_tunables =3D NULL;
+				cpufreq_put_global_kobject();
+			}
 			return rc;
 		}
=20
--=20
1.7.9.5
