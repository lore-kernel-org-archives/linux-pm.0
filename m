From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
Date: Tue, 20 Nov 2018 10:46:17 -0500
Message-ID: <20181120154617.20903-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The of_node_put() is missing.So we call the of_node_put() to release
the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2
-update changelog
-do that right after its last use 
 to also cover error handling.
---
 drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..650f063ef809 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	if (!of_match_node(compatible_machine_match, root)){
+		of_node_put(root);
 		return -ENODEV;
+	}
+
+	of_node_put(root);
 
 	if (!mcpm_is_available())
 		return -EUNATCH;
-- 
2.17.0
