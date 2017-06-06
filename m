From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/7] USB: core: fix device node leak
Date: Tue,  6 Jun 2017 17:58:58 +0200
Message-ID: <20170606155904.26819-2-johan@kernel.org>
References: <20170606155904.26819-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606155904.26819-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@nxp.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Make sure to release any OF device-node reference taken when creating
the USB device.

Note that we currently do not hold a reference to the root hub
device-tree node (i.e. the parent controller node).

Fixes: 69bec7259853 ("USB: core: let USB device know device node")
Cc: stable <stable@vger.kernel.org>	# v4.6
Acked-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/core/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 28b053cacc90..62e1906bb2f3 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -416,6 +416,8 @@ static void usb_release_dev(struct device *dev)
 
 	usb_destroy_configuration(udev);
 	usb_release_bos_descriptor(udev);
+	if (udev->parent)
+		of_node_put(dev->of_node);
 	usb_put_hcd(hcd);
 	kfree(udev->product);
 	kfree(udev->manufacturer);
-- 
2.13.0
