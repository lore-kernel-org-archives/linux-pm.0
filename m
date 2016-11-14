From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v10 5/8] usb: chipidea: let chipidea core device of_node equal's glue layer device of_node
Date: Mon, 14 Nov 2016 09:35:56 +0800
Message-ID: <1479087359-7547-6-git-send-email-peter.chen@nxp.com>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479087359-7547-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

At device tree, we have no device node for chipidea core,
the glue layer's node is the parent node for host and udc
device. But in related driver, the parent device is chipidea
core. So, in order to let the common driver get parent's node,
we let the core's device node equals glue layer device node.

Signed-off-by: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Tested-by: Maciej S. Szmigiero <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
@@ -1058,6 +1072,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
