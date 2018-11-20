From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: big.LITTLE: add of_node_put()
Date: Tue, 20 Nov 2018 08:00:12 -0500
Message-ID: <20181120130012.19471-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpuidle/cpuidle-big_little.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..a3b8bc09bac8 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -174,8 +174,10 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
-		return -ENODEV;
+	if (!of_match_node(compatible_machine_match, root)){
+		ret = -ENODEV;
+		goto out_release_node;
+	}
 
 	if (!mcpm_is_available())
 		return -EUNATCH;
@@ -222,6 +224,8 @@ static int __init bl_idle_init(void)
 	kfree(bl_idle_big_driver.cpumask);
 out_uninit_little:
 	kfree(bl_idle_little_driver.cpumask);
+out_release_node:
+	of_node_put(root);
 
 	return ret;
 }
-- 
2.17.0
