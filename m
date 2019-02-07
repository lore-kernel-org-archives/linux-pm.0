From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] driver core: Document limitation related to DL_FLAG_RPM_ACTIVE
Date: Thu, 07 Feb 2019 19:41:56 +0100
Message-ID: <2290146.QHuzNgG4dT@aspire.rjw.lan>
References: <3917694.ab5GGAjohB@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3917694.ab5GGAjohB@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If device_link_add() is called twice in a row to create a stateless
device link for the same consumer-supplier pair without an attempt
to delete the link between these calls, and the second caller passes
DL_FLAG_RPM_ACTIVE to it in flags, calling either device_link_del()
or device_link_remove() immediately after that will leave the link's
supplier device with nonzero PM-runtime usage counter, which may
prevent the supplier from being runtime-suspended going forward
until the link is deleted by another invocation of device_link_del()
or device_link_remove() for it.

Even though this is confusing and may lead to subtle issues, trying
to avoid it in the framework also may cause problems to appear, so
document it as a known limitation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/device_link.rst |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: linux-pm/Documentation/driver-api/device_link.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/device_link.rst
+++ linux-pm/Documentation/driver-api/device_link.rst
@@ -86,9 +86,10 @@ integration is desired.
 
 Two other flags are specifically targeted at use cases where the device
 link is added from the consumer's ``->probe`` callback:  ``DL_FLAG_RPM_ACTIVE``
-can be specified to runtime resume the supplier upon addition of the
-device link.  ``DL_FLAG_AUTOREMOVE_CONSUMER`` causes the device link to be
-automatically purged when the consumer fails to probe or later unbinds.
+can be specified to runtime resume the supplier and prevent it from suspending
+before the consumer is runtime suspended.  ``DL_FLAG_AUTOREMOVE_CONSUMER``
+causes the device link to be automatically purged when the consumer fails to
+probe or later unbinds.
 
 Similarly, when the device link is added from supplier's ``->probe`` callback,
 ``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
@@ -121,6 +122,20 @@ set) are expected to be removed by whoev
 to add them with the help of either :c:func:`device_link_del()` or
 :c:func:`device_link_remove()`.
 
+Passing ``DL_FLAG_RPM_ACTIVE`` along with ``DL_FLAG_STATELESS`` to
+:c:func:`device_link_add()` may cause the PM-runtime usage counter of the
+supplier device to remain nonzero after a subsequent invocation of either
+:c:func:`device_link_del()` or :c:func:`device_link_remove()` to remove the
+device link returned by it.  This happens if :c:func:`device_link_add()` is
+called twice in a row for the same consumer-supplier pair without removing the
+link between these calls, in which case allowing the PM-runtime usage counter
+of the supplier to drop on an attempt to remove the link may cause it to be
+suspended while the consumer is still PM-runtime-active and that has to be
+avoided.  [To work around this limitation it is sufficient to let the consumer
+runtime suspend at least once, or call :c:func:`pm_runtime_set_suspended()` for
+it with PM-runtime disabled, between the :c:func:`device_link_add()` and
+:c:func:`device_link_del()` or :c:func:`device_link_remove()` calls.]
+
 Sometimes drivers depend on optional resources.  They are able to operate
 in a degraded mode (reduced feature set or performance) when those resources
 are not present.  An example is an SPI controller that can use a DMA engine
