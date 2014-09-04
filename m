From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/15] power_supply: Don't iterate over devices to return -EPROBE_DEFER
Date: Thu,  4 Sep 2014 17:31:36 +0530
Message-ID: <e3ff2a09590e8a0e2d249d11ce3badc8ea3976e4.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:41831 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMDV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:03:21 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so19896047pad.40
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:03:21 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

This piece of code was added so that we return -EPROBE_DEFER when no devices are
registered. But even if class_for_each_device() returns 0, we are going to
return -EPROBE_DEFER only.

And so this code isn't required at all. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 81177e2..6cb7fe5 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -179,19 +179,6 @@ static int  __power_supply_find_supply_from_node(struct device *dev,
 static int power_supply_find_supply_from_node(struct device_node *supply_node)
 {
 	int error;
-	struct device *dev;
-	struct class_dev_iter iter;
-
-	/*
-	 * Use iterator to see if any other device is registered.
-	 * This is required since class_for_each_device returns 0
-	 * if there are no devices registered.
-	 */
-	class_dev_iter_init(&iter, power_supply_class, NULL, NULL);
-	dev = class_dev_iter_next(&iter);
-
-	if (!dev)
-		return -EPROBE_DEFER;
 
 	/*
 	 * class_for_each_device() either returns its own errors or values
-- 
2.0.3.693.g996b0fd

