From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] PowerCap: Error with option -Werror=format-security
Date: Mon,  4 Nov 2013 08:53:10 -0800
Message-ID: <1383583990-9618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: keescook@chromium.org, fengguang.wu@intel.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Fix compile error with gcc option: -Werror=format-security for
dev_set_name(&control_type->dev, name)
Changed to
dev_set_name(&control_type->dev, "%s", name);

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/powercap_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 21814f9..8d0fe43 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -625,7 +625,7 @@ struct powercap_control_type *powercap_register_control_type(
 	control_type->ops = ops;
 	INIT_LIST_HEAD(&control_type->node);
 	control_type->dev.class = &powercap_class;
-	dev_set_name(&control_type->dev, name);
+	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
 		if (control_type->allocated)
-- 
1.7.11.7
