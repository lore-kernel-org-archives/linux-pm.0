From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/5] PM / devfreq: make devfreq explicitly non-modular
Date: Sat, 25 Jun 2016 14:43:47 -0400
Message-ID: <20160625184351.5045-2-paul.gortmaker@windriver.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61880 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcFYSoM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2016 14:44:12 -0400
In-Reply-To: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

menuconfig PM_DEVFREQ
      bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

This code wasn't using module_init, so we don't need to be concerned
with altering the initcall level here.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We don't replace module.h with init.h since the file already has that.
But we do add export.h since this file does export some symbols.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/devfreq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e92418facc92..3cc558df8295 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_opp.h>
@@ -1199,13 +1199,6 @@ static int __init devfreq_init(void)
 }
 subsys_initcall(devfreq_init);
 
-static void __exit devfreq_exit(void)
-{
-	class_destroy(devfreq_class);
-	destroy_workqueue(devfreq_wq);
-}
-module_exit(devfreq_exit);
-
 /*
  * The followings are helper functions for devfreq user device drivers with
  * OPP framework.
@@ -1471,7 +1464,3 @@ void devm_devfreq_unregister_notifier(struct device *dev,
 			       devm_devfreq_dev_match, devfreq));
 }
 EXPORT_SYMBOL(devm_devfreq_unregister_notifier);
-
-MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
-MODULE_DESCRIPTION("devfreq class support");
-MODULE_LICENSE("GPL");
-- 
2.8.4

