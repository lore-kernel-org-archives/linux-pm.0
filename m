From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] driver core: Add missing dev->bus->need_parent_lock checks
Date: Thu, 13 Dec 2018 19:27:47 +0100
Message-ID: <7586985.G9YL5ver76@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Liu <liumartin@google.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

__device_release_driver() has to check dev->bus->need_parent_lock
before dropping the parent lock and acquiring it again as it may
attempt to drop a lock that hasn't been acquired or lock a device
that shouldn't be locked and create a lock imbalance.

Fixes: 8c97a46af04b (driver core: hold dev's parent lock when needed)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This should go into -stable for everything over 4.18 methinks.

---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -933,11 +933,11 @@ static void __device_release_driver(stru
 
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_unlock(parent);
 
 			device_links_unbind_consumers(dev);
-			if (parent)
+			if (parent && dev->bus->need_parent_lock)
 				device_lock(parent);
 
 			device_lock(dev);
