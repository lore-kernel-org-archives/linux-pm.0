From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] ARM: cpuidle: replace cpuidle_get_driver with cpuidle_get_cpu_driver
Date: Mon,  4 Sep 2017 14:52:14 +0800
Message-ID: <1504507934-14218-2-git-send-email-leo.yan@linaro.org>
References: <1504507934-14218-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504507934-14218-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-pm@vger.kernel.org

commit d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
supports multiple CPU idle driver so every CPU has its own driver. When
the initialization fails, the failure handling releases the resources
for every previous CPU; so it needs to retrieve every CPU device and
driver handler and unregister them. But the function
cpuidle_get_driver() can only return current CPU driver handler but not
the iterated CPU driver handler, so it cannot release resource properly.

This patch is to replace cpuidle_get_driver() with
cpuidle_get_cpu_driver(), every CPU has its own device handler so this
function can get back correct driver handler for the CPU according to
the CPU device handler. By using this CPU driver handler we can release
resource properly.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
---
 drivers/cpuidle/cpuidle-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index f419f6a..ef34780 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -161,9 +161,9 @@ static int __init arm_idle_init(void)
 
 	while (--cpu >= 0) {
 		dev = per_cpu(cpuidle_devices, cpu);
+		drv = cpuidle_get_cpu_driver(dev);
 		cpuidle_unregister_device(dev);
 		kfree(dev);
-		drv = cpuidle_get_driver();
 		cpuidle_unregister_driver(drv);
 		kfree(drv);
 	}
-- 
2.7.4
