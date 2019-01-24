From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/6] driver core: Reorder actions in __device_links_no_driver()
Date: Thu, 24 Jan 2019 12:16:43 +0100
Message-ID: <1613403.ZNkCsVQxPT@aspire.rjw.lan>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2493187.oiOpCWJBV7@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All links to suppliers have to be either "available" or in the
"supplier unbind in progress" state after __device_links_no_driver()
and the kref_put() may not actually delete them, so change the state
of each link in __device_links_no_driver() before attempting to drop
it.

While at it, update the kernedoc comment of __device_links_no_driver()
to reflect what happens more accurately.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -500,11 +500,11 @@ void device_links_driver_bound(struct de
  * __device_links_no_driver - Update links of a device without a driver.
  * @dev: Device without a drvier.
  *
- * Delete all non-persistent links from this device to any suppliers.
+ * Drop references to non-persistent links from this device to any suppliers.
  *
- * Persistent links stay around, but their status is changed to "available",
- * unless they already are in the "supplier unbind in progress" state in which
- * case they need not be updated.
+ * Links with DL_FLAG_AUTOREMOVE_CONSUMER unset stay around, but their status is
+ * changed to "available", unless they already are in the "supplier unbind in
+ * progress" state in which case they need not be updated.
  *
  * Links with the DL_FLAG_STATELESS flag set are ignored.
  */
@@ -516,10 +516,11 @@ static void __device_links_no_driver(str
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
+		if (link->status != DL_STATE_SUPPLIER_UNBIND)
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+
 		if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
 			kref_put(&link->kref, __device_link_del);
-		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
-			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
 	}
 
 	dev->links.status = DL_DEV_NO_DRIVER;
