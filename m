From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/7] USB: of: document reference taken by child-lookup helper
Date: Tue, 30 May 2017 18:25:49 +0200
Message-ID: <20170530162554.26159-3-johan@kernel.org>
References: <20170530162554.26159-1-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36754 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdE3Q0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2017 12:26:49 -0400
In-Reply-To: <20170530162554.26159-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

Document that the child-node lookup helper takes a reference to the
device-tree node which needs to be dropped after use.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index d563cbcf76cf..17a4af02cf5b 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -28,6 +28,9 @@
  *
  * Find the node from device tree according to its port number.
  *
+ * Takes a reference to the returned device-tree node, which needs to be
+ * dropped after use.
+ *
  * Return: On success, a pointer to the device node, %NULL on failure.
  */
 struct device_node *usb_of_get_child_node(struct device_node *parent,
-- 
2.13.0
