From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date: Wed, 17 Apr 2019 17:52:34 +0300
Message-ID: <1555512754-6450-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, benh@kernel.crashing.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ... then
dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe..7cf9835 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -401,7 +401,7 @@ static int __init powernv_processor_idle_init(void)
 	powernv_cpuidle_driver_init();
 	retval = cpuidle_register(&powernv_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of powernv driver failed.\n");
+		pr_debug("Registration of powernv driver failed.\n");
 		return retval;
 	}
 
@@ -413,7 +413,7 @@ static int __init powernv_processor_idle_init(void)
 					   "cpuidle/powernv:dead", NULL,
 					   powernv_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "powernv_idle_driver registered\n");
+	pr_debug("powernv_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4
