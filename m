From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/5] PM / devfreq: make devfreq-event explicitly non-modular
Date: Tue, 21 Jun 2016 01:14:58 -0400
Message-ID: <20160621051501.18396-3-paul.gortmaker@windriver.com>
References: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40543 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbcFUFPR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 01:15:17 -0400
In-Reply-To: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

menuconfig PM_DEVFREQ_EVENT
	bool "DEVFREQ-Event device Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

This code wasn't using module_init, so we don't need to be concerned
with altering the initcall level here.

We don't replace module.h with init.h since the file already has that.
But we do add export.h since this file does export some symbols.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/devfreq-event.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 39b048eda2ce..9aea2c7ecbe6 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/of.h>
@@ -481,13 +481,3 @@ static int __init devfreq_event_init(void)
 	return 0;
 }
 subsys_initcall(devfreq_event_init);
-
-static void __exit devfreq_event_exit(void)
-{
-	class_destroy(devfreq_event_class);
-}
-module_exit(devfreq_event_exit);
-
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_DESCRIPTION("DEVFREQ-Event class support");
-MODULE_LICENSE("GPL");
-- 
2.8.4

