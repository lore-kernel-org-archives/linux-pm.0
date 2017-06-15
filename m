From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 06/10] i2c: mux: pca954x: Call request irq after adding mux segments
Date: Thu, 15 Jun 2017 21:59:34 +0800
Message-ID: <1497535178-12001-7-git-send-email-preid@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The pca954x device do not have the ability to mask interrupts. For
i2c slave devices that also don't have masking ability (eg ltc1760
smbalert output) delay registering the irq until after the mux
segments have been configured. During the mux add_adaptor call the
core i2c system can register an smbalert handler which would then
be called immediately when the irq is registered. This smbalert
handler will then clear the pending irq.

Also add return check to irq_create_mapping call.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 59 +++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 2f21138..b152efa 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -305,7 +305,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
-	int c, err, irq;
+	int c, irq;
 
 	if (!data->chip->has_irq || client->irq <= 0)
 		return 0;
@@ -320,29 +320,31 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 
 	for (c = 0; c < data->chip->nchans; c++) {
 		irq = irq_create_mapping(data->irq, c);
+		if (irq <= 0) {
+			dev_err(&client->dev, "failed irq create map\n");
+			return -EINVAL;
+		}
 		irq_set_chip_data(irq, data);
 		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
-			handle_simple_irq);
+					 handle_simple_irq);
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
@@ -435,6 +437,15 @@ static int pca954x_probe(struct i2c_client *client,
 		}
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
@@ -443,25 +454,15 @@ static int pca954x_probe(struct i2c_client *client,
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
-
-	if (data->irq) {
-		for (c = 0; c < data->chip->nchans; c++) {
-			irq = irq_find_mapping(data->irq, c);
-			irq_dispose_mapping(irq);
-		}
-		irq_domain_remove(data->irq);
-	}
 
-	i2c_mux_del_adapters(muxc);
+	pca954x_cleanup(muxc);
 	return 0;
 }
 
-- 
1.8.3.1
