From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ARM: cpuidle: Delete an error message for a failed memory
 allocation in arm_idle_init_cpu()
Date: Thu, 15 Feb 2018 16:46:24 +0100
Message-ID: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 16:40:38 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpuidle/cpuidle-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index ddee1b601b89..e07bc7ace774 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -129,7 +129,6 @@ static int __init arm_idle_init_cpu(int cpu)
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
-		pr_err("Failed to allocate cpuidle device\n");
 		ret = -ENOMEM;
 		goto out_unregister_drv;
 	}
-- 
2.16.1
