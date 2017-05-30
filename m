From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] driver core: fix automatic pinctrl management
Date: Tue, 30 May 2017 18:25:51 +0200
Message-ID: <20170530162554.26159-5-johan@kernel.org>
References: <20170530162554.26159-1-johan@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33650 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdE3Q1B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2017 12:27:01 -0400
In-Reply-To: <20170530162554.26159-1-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>

Commit ab78029ecc34 ("drivers/pinctrl: grab default handles from device
core") added automatic pin-control management to driver core by looking
up and setting any default pinctrl state found in device tree while a
device is being probed.

This obviously runs into problems as soon as device-tree nodes are
reused for child devices which are later also probed as pins would
already have been claimed by the ancestor device.

For example if a USB host controller claims a pin, its root hub would
consequently fail to probe when its device-tree node is set to the node
of the controller:

    pinctrl-single 48002030.pinmux: pin PIN204 already requested by 48064800.ehci; cannot claim for usb1
    pinctrl-single 48002030.pinmux: pin-204 (usb1) status -22
    pinctrl-single 48002030.pinmux: could not request pin 204 (PIN204) from group usb_dbg_pins  on device pinctrl-single
    usb usb1: Error applying setting, reverse things back
    usb: probe of usb1 failed with error -22

Fix this by checking the new of_node_reused flag and skipping automatic
pinctrl configuration during probe if set.

Note that the flag is checked in driver core rather than in pinctrl
(e.g. in pinctrl_dt_to_map()) which would specifically have prevented
intentional use of a parent's pinctrl properties by a child device
(should such a need ever arise).

Fixes: ab78029ecc34 ("drivers/pinctrl: grab default handles from device core")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/pinctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 5917b4b5fb99..eb929dd6ef1e 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -23,6 +23,9 @@ int pinctrl_bind_pins(struct device *dev)
 {
 	int ret;
 
+	if (dev->of_node_reused)
+		return 0;
+
 	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
 	if (!dev->pins)
 		return -ENOMEM;
-- 
2.13.0
