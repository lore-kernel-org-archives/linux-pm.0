From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date: Tue, 20 Nov 2018 11:14:51 -0500
Message-ID: <20181120161451.21149-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v3:
-update changelog
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
