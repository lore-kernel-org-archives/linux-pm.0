From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 52/70] cpufreq: interactive: fix show_target_loads and show_above_hispeed_delay
Date: Tue, 27 Oct 2015 18:30:40 +0100
Message-ID: <1445967059-6897-52-git-send-email-czoborbalint@gmail.com>
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

Remove a trailing whitespace from target_loads and above_hispeed_delay.=
 Problem
happens when user-space program tried to restore parameters that saved =
before
changing parameters. In this case was returned error(EINVAL).

Change-Id: I5a74e3824602cd6f2b74651adda5ec1b627e61e9
Signed-off-by: Minsung Kim <ms925.kim@samsung.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 90958fd..a66748e 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -742,7 +742,7 @@ static ssize_t show_target_loads(
 		ret +=3D sprintf(buf + ret, "%u%s", target_loads[i],
 			       i & 0x1 ? ":" : " ");
=20
-	ret +=3D sprintf(buf + ret, "\n");
+	ret +=3D sprintf(buf + --ret, "\n");
 	spin_unlock_irqrestore(&target_loads_lock, flags);
 	return ret;
 }
@@ -785,7 +785,7 @@ static ssize_t show_above_hispeed_delay(
 		ret +=3D sprintf(buf + ret, "%u%s", above_hispeed_delay[i],
 			       i & 0x1 ? ":" : " ");
=20
-	ret +=3D sprintf(buf + ret, "\n");
+	ret +=3D sprintf(buf + --ret, "\n");
 	spin_unlock_irqrestore(&above_hispeed_delay_lock, flags);
 	return ret;
 }
--=20
1.7.9.5
