From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v11 5/8] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
Date: Thu, 5 Jan 2017 14:01:56 +0800
Message-ID: <1483596119-27508-6-git-send-email-peter.chen@nxp.com>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, Peter Chen <peter.chen@freescale.com>, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
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
index 3dbb4a2..fdffc67 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -928,6 +928,16 @@ static int ci_hdrc_probe(struct platform_device *pdev)
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
@@ -938,11 +948,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
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
@@ -953,7 +967,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto clear_of_node;
 	}
 
 	ci->hw_bank.phys = res->start;
@@ -1059,6 +1073,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ci_role_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
+clear_of_node:
+	dev->of_node = NULL;
 
 	return ret;
 }
@@ -1077,6 +1093,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	ci_extcon_unregister(ci);
 	ci_role_destroy(ci);
 	ci_hdrc_enter_lpm(ci, true);
+	ci->dev->of_node = NULL;
 	ci_usb_phy_exit(ci);
 
 	return 0;
-- 
2.7.4
