From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/9] driver core: Avoid careless re-use of existing device links
Date: Fri, 01 Feb 2019 01:46:54 +0100
Message-ID: <2222273.ydJmd408XJ@aspire.rjw.lan>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <jroedel@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit ead18c23c263 ("driver core: Introduce device links
reference counting"), if there is a link between the given supplier
and the given consumer already, device_link_add() will refcount it
and return it unconditionally.  However, if the flags passed to
it on the second (or any subsequent) attempt to create a device
link between the same consumer-supplier pair are not compatible with
the existing link's flags, that is incorrect.

First off, if the existing link is stateless and the next caller of
device_link_add() for the same consumer-supplier pair wants a
stateful one, or the other way around, the existing link cannot be
returned, because it will not match the expected behavior, so make
device_link_add() dump the stack and return NULL in that case.

Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
device_link_add(), its caller will expect its reference to the link
to be dropped automatically on consumer driver removal, which will
not happen if that flag is not set in the link's flags (and
analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
device_link_add() update the existing link's flags accordingly
before returning it to the caller.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/core.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -221,12 +221,29 @@ struct device_link *device_link_add(stru
 		goto out;
 	}
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node)
-		if (link->consumer == consumer) {
-			kref_get(&link->kref);
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer != consumer)
+			continue;
+
+		/*
+		 * Don't return a stateless link if the caller wants a stateful
+		 * one and vice versa.
+		 */
+		if (WARN_ON((flags & DL_FLAG_STATELESS) != (link->flags & DL_FLAG_STATELESS))) {
+			link = NULL;
 			goto out;
 		}
 
+		if (flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
+
+		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
+
+		kref_get(&link->kref);
+		goto out;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;
