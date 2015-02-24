From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/2] drivers: cpuidle: remove stale irq disabling call in cpuidle_enter_freeze()
Date: Tue, 24 Feb 2015 17:58:49 +0000
Message-ID: <1424800730-32059-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On return from cpuidle_enter_freeze() irqs are re-enabled by the function
caller (ie cpuidle_idle_call) in the idle loop. This patch removes a stale
local_irq_disable() call and its stale comment in cpuidle_enter_freeze(),
since they disagree and do not serve a useful purpose.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/cpuidle.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 4d53458..f47edc6c 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -144,9 +144,6 @@ void cpuidle_enter_freeze(void)
 		cpuidle_enter(drv, dev, index);
 	else
 		arch_cpu_idle();
-
-	/* Interrupts are enabled again here. */
-	local_irq_disable();
 }
 
 /**
-- 
2.2.1
