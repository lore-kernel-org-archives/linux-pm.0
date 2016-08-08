From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node equal's glue layer device of_node
Date: Mon, 8 Aug 2016 16:52:10 +0800
Message-ID: <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, Peter Chen <peter.chen@freescale.com>
List-Id: linux-pm@vger.kernel.org

From: Peter Chen <peter.chen@freescale.com>

At device tree, we have no device node for chipidea core,
the glue layer's node is the parent node for host and udc
device. But in related driver, the parent device is chipidea
core. So, in order to let the common driver get parent's node,
we let the core's device node equals glue layer device node.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Tested-by Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/usb/chipidea/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..b189dc7 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		dev_err(dev, "unable to init phy: %d\n", ret);
 		return ret;
 	}
+	/*
+	 * At device tree, we have no device node for chipidea core,
+	 * the glue layer's node is the parent node for host and udc
+	 * device. But in related driver, the parent device is chipidea
+	 * core. So, in order to let the common driver get parent's node,
+	 * we let the core's device node equals glue layer's node.
+	 */
+	if (dev->parent && dev->parent->of_node)
+		dev->of_node = dev->parent->of_node;
 
 	ci->hw_bank.phys = res->start;
 
@@ -1057,6 +1066,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 stop:
 	ci_role_destroy(ci);
 deinit_phy:
+	dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return ret;
@@ -1076,6 +1086,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	ci_extcon_unregister(ci);
 	ci_role_destroy(ci);
 	ci_hdrc_enter_lpm(ci, true);
+	ci->dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return 0;
-- 
1.9.1
