From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 3/3] i2c: rcar: disable PM in multi-master mode
Date: Wed, 16 Dec 2015 19:44:20 +0100
Message-ID: <1450291460-10514-4-git-send-email-wsa@the-dreams.de>
References: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56571 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071AbbLPSoe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 13:44:34 -0500
In-Reply-To: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

In multi master mode, the IP core needs to be always active for
arbitration reasons. Get the config from DT and set up PM depending on
the config.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 79fd2aab8fa087..7c523dcaee3e48 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -96,6 +96,9 @@
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
+/* persistent flags */
+#define ID_P_PM_BLOCKED	(1 << 31)
+#define ID_P_MASK	ID_P_PM_BLOCKED
 
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
@@ -277,7 +280,7 @@ static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
 {
 	priv->msg++;
 	priv->msgs_left--;
-	priv->flags = 0;
+	priv->flags &= ID_P_MASK;
 	rcar_i2c_prepare_msg(priv);
 }
 
@@ -495,7 +498,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	/* init first message */
 	priv->msg = msgs;
 	priv->msgs_left = num;
-	priv->flags = ID_FIRST_MSG;
+	priv->flags = (priv->flags & ID_P_MASK) | ID_FIRST_MSG;
 	rcar_i2c_prepare_msg(priv);
 
 	time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
@@ -630,7 +633,13 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_put;
 
 	rcar_i2c_init(priv);
-	pm_runtime_put(dev);
+
+	/* Don't suspend when multi-master to keep arbitration working */
+	if (of_get_property(dev->of_node, "multi-master", NULL))
+		priv->flags |= ID_P_PM_BLOCKED;
+	else
+		pm_runtime_put(dev);
+
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq, rcar_i2c_irq, 0, dev_name(dev), priv);
@@ -664,6 +673,8 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	i2c_del_adapter(&priv->adap);
+	if (priv->flags & ID_P_PM_BLOCKED)
+		pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
 	return 0;
-- 
2.1.4

