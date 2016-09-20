From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v7 5/8] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
Date: Tue, 20 Sep 2016 11:36:44 +0800
Message-ID: <1474342607-27512-6-git-send-email-peter.chen@nxp.com>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, vaibhav.hiremath@linaro.org, stillcompiling@gmail.com, Peter Chen <peter.chen@freescale.com>, p.zabel@pengutronix.de, festevam@gmail.com, mka@chromium.org, linux-arm-kernel@lists.infradead.org
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
 drivers/usb/chipidea/core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..6839e19 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -927,6 +927,16 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
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
+
 	if (ci->platdata->phy) {
 		ci->phy = ci->platdata->phy;
 	} else if (ci->platdata->usb_phy) {
@@ -937,11 +947,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 		/* if both generic PHY and USB PHY layers aren't enabled */
 		if (PTR_ERR(ci->phy) == -ENOSYS &&
-				PTR_ERR(ci->usb_phy) == -ENXIO)
-			return -ENXIO;
+				PTR_ERR(ci->usb_phy) == -ENXIO) {
+			ret = -ENXIO;
+			goto clear_of_node;
+		}
 
-		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy))
-			return -EPROBE_DEFER;
+		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
+			ret = -EPROBE_DEFER;
+			goto clear_of_node;
+		}
 
 		if (IS_ERR(ci->phy))
 			ci->phy = NULL;
@@ -952,7 +966,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto clear_of_node;
 	}
 
 	ci->hw_bank.phys = res->start;
@@ -1058,6 +1072,8 @@ stop:
 	ci_role_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
+clear_of_node:
+	dev->of_node = NULL;
 
 	return ret;
 }
@@ -1076,6 +1092,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	ci_extcon_unregister(ci);
 	ci_role_destroy(ci);
 	ci_hdrc_enter_lpm(ci, true);
+	ci->dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return 0;
-- 
2.7.4
