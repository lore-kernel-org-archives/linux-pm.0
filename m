From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v10 05/10] i2c: mux: pca954x: Call request irq after adding mux segments
Date: Tue, 25 Jul 2017 11:40:19 +0800
Message-ID: <1500954024-6860-6-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The pca954x device do not have the ability to mask interrupts. For
i2c slave devices that also don't have masking ability (eg ltc1760
smbalert output) delay registering the irq until after the mux
segments have been configured. During the mux add_adaptor call the
core i2c system can register an smbalert handler which would then
be called immediately when the irq is registered. This smbalert
handler will then clear the pending irq.

This removes the need for the irq_mask / irq_unmask calls that were
original used to do this.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 85 +++++++++++--------------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f1751c2..ac0f083 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -246,36 +246,6 @@ static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static void pca954x_irq_mask(struct irq_data *idata)
-{
-	struct pca954x *data = irq_data_get_irq_chip_data(idata);
-	unsigned int pos = idata->hwirq;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&data->lock, flags);
-
-	data->irq_mask &= ~BIT(pos);
-	if (!data->irq_mask)
-		disable_irq(data->client->irq);
-
-	raw_spin_unlock_irqrestore(&data->lock, flags);
-}
-
-static void pca954x_irq_unmask(struct irq_data *idata)
-{
-	struct pca954x *data = irq_data_get_irq_chip_data(idata);
-	unsigned int pos = idata->hwirq;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&data->lock, flags);
-
-	if (!data->irq_mask)
-		enable_irq(data->client->irq);
-	data->irq_mask |= BIT(pos);
-
-	raw_spin_unlock_irqrestore(&data->lock, flags);
-}
-
 static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
 {
 	if ((type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_LOW)
@@ -285,8 +255,6 @@ static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
 
 static struct irq_chip pca954x_irq_chip = {
 	.name = "i2c-mux-pca954x",
-	.irq_mask = pca954x_irq_mask,
-	.irq_unmask = pca954x_irq_unmask,
 	.irq_set_type = pca954x_irq_set_type,
 };
 
@@ -294,7 +262,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
-	int c, err, irq;
+	int c, irq;
 
 	if (!data->chip->has_irq || client->irq <= 0)
 		return 0;
@@ -314,24 +282,22 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 			handle_simple_irq);
 	}
 
-	err = devm_request_threaded_irq(&client->dev, data->client->irq, NULL,
-					pca954x_irq_handler,
-					IRQF_ONESHOT | IRQF_SHARED,
-					"pca954x", data);
-	if (err)
-		goto err_req_irq;
+	return 0;
+}
 
-	disable_irq(data->client->irq);
+static void pca954x_cleanup(struct i2c_mux_core *muxc)
+{
+	struct pca954x *data = i2c_mux_priv(muxc);
+	int c, irq;
 
-	return 0;
-err_req_irq:
-	for (c = 0; c < data->chip->nchans; c++) {
-		irq = irq_find_mapping(data->irq, c);
-		irq_dispose_mapping(irq);
+	if (data->irq) {
+		for (c = 0; c < data->chip->nchans; c++) {
+			irq = irq_find_mapping(data->irq, c);
+			irq_dispose_mapping(irq);
+		}
+		irq_domain_remove(data->irq);
 	}
-	irq_domain_remove(data->irq);
-
-	return err;
+	i2c_mux_del_adapters(muxc);
 }
 
 /*
@@ -417,6 +383,15 @@ static int pca954x_probe(struct i2c_client *client,
 			goto fail_del_adapters;
 	}
 
+	if (data->irq) {
+		ret = devm_request_threaded_irq(&client->dev, data->client->irq,
+						NULL, pca954x_irq_handler,
+						IRQF_ONESHOT | IRQF_SHARED,
+						"pca954x", data);
+		if (ret)
+			goto fail_del_adapters;
+	}
+
 	dev_info(&client->dev,
 		 "registered %d multiplexed busses for I2C %s %s\n",
 		 num, data->chip->muxtype == pca954x_ismux
@@ -425,25 +400,15 @@ static int pca954x_probe(struct i2c_client *client,
 	return 0;
 
 fail_del_adapters:
-	i2c_mux_del_adapters(muxc);
+	pca954x_cleanup(muxc);
 	return ret;
 }
 
 static int pca954x_remove(struct i2c_client *client)
 {
 	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
-	struct pca954x *data = i2c_mux_priv(muxc);
-	int c, irq;
 
-	if (data->irq) {
-		for (c = 0; c < data->chip->nchans; c++) {
-			irq = irq_find_mapping(data->irq, c);
-			irq_dispose_mapping(irq);
-		}
-		irq_domain_remove(data->irq);
-	}
-
-	i2c_mux_del_adapters(muxc);
+	pca954x_cleanup(muxc);
 	return 0;
 }
 
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
