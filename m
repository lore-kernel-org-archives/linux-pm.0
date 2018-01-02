From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / wakeup: Drop redundant check from device_init_wakeup()
Date: Tue, 02 Jan 2018 01:42:56 +0100
Message-ID: <17840720.nSOd29rnxo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since device_wakeup_disable() checks the device's power.can_wakeup 
flag, device_init_wakeup() doesn't need to do that before calling it,
so drop that redundant check from device_init_wakeup().

No intentional changes in functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -448,9 +448,7 @@ int device_init_wakeup(struct device *de
 		device_set_wakeup_capable(dev, true);
 		ret = device_wakeup_enable(dev);
 	} else {
-		if (dev->power.can_wakeup)
-			device_wakeup_disable(dev);
-
+		device_wakeup_disable(dev);
 		device_set_wakeup_capable(dev, false);
 	}
 
