From: Saumya Ranjan Kuanr <saumyakuanr@gmail.com>
Subject: [PATCH] cpu-idle: cpuidle-ux500: fixed a coding style issue
Date: Sat, 19 Oct 2013 00:28:48 -0700
Message-ID: <1382167729-21232-1-git-send-email-saumyakuanr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, saumyakuanr@gmail.com
List-Id: linux-pm@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Saumya Ranjan Kuanr<saumyakuanr@gmail.com>
---
 drivers/cpuidle/cpuidle-ux500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
index e056465..746d716 100644
--- a/drivers/cpuidle/cpuidle-ux500.c
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -102,7 +102,7 @@ static struct cpuidle_driver ux500_idle_driver = {
 			.exit_latency	  = 70,
 			.target_residency = 260,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID |
-			                    CPUIDLE_FLAG_TIMER_STOP,
+						CPUIDLE_FLAG_TIMER_STOP,
 			.name		  = "ApIdle",
 			.desc		  = "ARM Retention",
 		},
--
1.7.9.5
