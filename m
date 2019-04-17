From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [PATCH] drivers: cpuidle: This patch fix the following checkpatch warning.
Date: Wed, 17 Apr 2019 10:06:14 +0300
Message-ID: <1555484774-5866-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use pr_debug instead of printk

WARNING: Prefer [subsystem eg: netdev]_dbg([subsystem]dev, ...
then dev_dbg(dev, ... then pr_debug(...  to printk(KERN_DEBUG ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..a9c1db8 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -282,7 +282,7 @@ static int __init pseries_processor_idle_init(void)
 	pseries_cpuidle_driver_init();
 	retval = cpuidle_register(&pseries_idle_driver, NULL);
 	if (retval) {
-		printk(KERN_DEBUG "Registration of pseries driver failed.\n");
+		pr_debug("Registration of pseries driver failed.\n");
 		return retval;
 	}
 
@@ -294,7 +294,7 @@ static int __init pseries_processor_idle_init(void)
 					   "cpuidle/pseries:DEAD", NULL,
 					   pseries_cpuidle_cpu_dead);
 	WARN_ON(retval < 0);
-	printk(KERN_DEBUG "pseries_idle_driver registered\n");
+	pr_debug("pseries_idle_driver registered\n");
 	return 0;
 }
 
-- 
2.7.4
