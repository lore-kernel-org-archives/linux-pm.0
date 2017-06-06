From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/7] USB: of: document reference taken by child-lookup helper
Date: Tue,  6 Jun 2017 17:58:59 +0200
Message-ID: <20170606155904.26819-3-johan@kernel.org>
References: <20170606155904.26819-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606155904.26819-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@nxp.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pm@vger.kernel.org

Document that the child-node lookup helper takes a reference to the
device-tree node which needs to be dropped after use.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index d563cbcf76cf..3863bb1ce8c5 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -28,7 +28,8 @@
  *
  * Find the node from device tree according to its port number.
  *
- * Return: On success, a pointer to the device node, %NULL on failure.
+ * Return: A pointer to the node with incremented refcount if found, or
+ * %NULL otherwise.
  */
 struct device_node *usb_of_get_child_node(struct device_node *parent,
 					int portnum)
-- 
2.13.0
