From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / wakeup: Drop redundant check from device_set_wakeup_enable()
Date: Tue, 26 Dec 2017 01:50:20 +0100
Message-ID: <2570001.kK8602TLGU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:63664 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZAvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Dec 2017 19:51:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since both device_wakeup_enable() and device_wakeup_disable() check
if dev is not NULL and whether or not power.can_wakeup is set for it,
device_set_wakeup_enable() doesn't have to do that, so drop that
check from it.

No intentional changes in functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -464,9 +464,6 @@ EXPORT_SYMBOL_GPL(device_init_wakeup);
  */
 int device_set_wakeup_enable(struct device *dev, bool enable)
 {
-	if (!dev || !dev->power.can_wakeup)
-		return -EINVAL;
-
 	return enable ? device_wakeup_enable(dev) : device_wakeup_disable(dev);
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
