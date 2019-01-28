From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] driver core: Do not call rpm_put_suppliers() in pm_runtime_drop_link()
Date: Tue, 29 Jan 2019 00:08:36 +0100
Message-ID: <9744885.kWxcYK6YUu@aspire.rjw.lan>
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2405639.4es7pRLqn0@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling rpm_put_suppliers() from pm_runtime_drop_link() is excessive
as it affects all suppliers of the consumer device and not just the
one pointed to by the device link being dropped.  Worst case it may
cause the consumer device to stop working unexpectedly.  Moreover, in
principle it is racy with respect to runtime PM of the consumer
device.

To avoid these problems drop runtime PM references on the particular
supplier pointed to by the link in question only and do that after
the link has been dropped from the consumer device's list of links to
suppliers, which is in device_link_free().

Fixes: a0504aecba76 ("PM / runtime: Drop usage count for suppliers at device link removal")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c          |    3 +++
 drivers/base/power/runtime.c |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -375,6 +375,9 @@ EXPORT_SYMBOL_GPL(device_link_add);
 
 static void device_link_free(struct device_link *link)
 {
+	while (refcount_dec_not_one(&link->rpm_active))
+		pm_runtime_put(link->supplier);
+
 	put_device(link->consumer);
 	put_device(link->supplier);
 	kfree(link);
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1623,8 +1623,6 @@ void pm_runtime_new_link(struct device *
 
 void pm_runtime_drop_link(struct device *dev)
 {
-	rpm_put_suppliers(dev);
-
 	spin_lock_irq(&dev->power.lock);
 	WARN_ON(dev->power.links_count == 0);
 	dev->power.links_count--;
