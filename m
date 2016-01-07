From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PM / clk: don't leave clocks enabled when driver not bound
Date: Thu,  7 Jan 2016 12:49:31 +0200
Message-ID: <1452163771-73303-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16369 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbcAGKtf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jan 2016 05:49:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a new notification BUS_NOTIFY_DRIVER_NOT_BOUND that is issued when
driver fails during binding. In such case pm_clk_notify(), when PM_CLK=n,
leaves clocks enabled. Undo operations that has been done in
BUS_NOTIFY_BIND_DRIVER case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/clock_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 60ee559..c39b861 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -473,6 +473,7 @@ static int pm_clk_notify(struct notifier_block *nb,
 			enable_clock(dev, NULL);
 		}
 		break;
+	case BUS_NOTIFY_DRIVER_NOT_BOUND:
 	case BUS_NOTIFY_UNBOUND_DRIVER:
 		if (clknb->con_ids[0]) {
 			for (con_id = clknb->con_ids; *con_id; con_id++)
-- 
2.6.4

