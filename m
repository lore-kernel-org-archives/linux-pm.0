From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v11 05/10] i2c: mux: pca954x: call request irq after adding mux segments
Date: Thu, 24 Aug 2017 17:31:05 +0800
Message-ID: <1503567070-115646-6-git-send-email-preid@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
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

Signed-off-by: Phil Reid <preid@electromag.com.au>
Acked-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 91 ++++++++++++-------------------------
 1 file changed, 28 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index f1751c2..5ec5020 100644
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
@@ -391,7 +357,7 @@ static int pca954x_probe(struct i2c_client *client,
 
 	ret = pca954x_irq_setup(muxc);
 	if (ret)
-		goto fail_del_adapters;
+		goto fail_cleanup;
 
 	/* Now create an adapter for each channel */
 	for (num = 0; num < data->chip->nchans; num++) {
@@ -414,7 +380,16 @@ static int pca954x_probe(struct i2c_client *client,
 
 		ret = i2c_mux_add_adapter(muxc, force, num, class);
 		if (ret)
-			goto fail_del_adapters;
+			goto fail_cleanup;
+	}
+
+	if (data->irq) {
+		ret = devm_request_threaded_irq(&client->dev, data->client->irq,
+						NULL, pca954x_irq_handler,
+						IRQF_ONESHOT | IRQF_SHARED,
+						"pca954x", data);
+		if (ret)
+			goto fail_cleanup;
 	}
 
 	dev_info(&client->dev,
@@ -424,26 +399,16 @@ static int pca954x_probe(struct i2c_client *client,
 
 	return 0;
 
-fail_del_adapters:
-	i2c_mux_del_adapters(muxc);
+fail_cleanup:
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
