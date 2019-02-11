From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / suspend: Print debug messages for device using direct-complete
Date: Mon, 11 Feb 2019 13:17:12 +0100
Message-ID: <2477658.mvXUDI8C0e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Devices using the direct-complete optimization are not present it
debug messages printed by the core device suspend and resume code,
which sometimes makes it difficult to diagnose problems related to
them, so add debug messages for those devices.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1741,8 +1741,10 @@ static int __device_suspend(struct devic
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-			if (pm_runtime_status_suspended(dev))
+			if (pm_runtime_status_suspended(dev)) {
+				pm_dev_dbg(dev, state, "direct-complete ");
 				goto Complete;
+			}
 
 			pm_runtime_enable(dev);
 		}
