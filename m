From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v10 06/10] i2c: mux: pca954x: Return error if irq_create_mapping fails
Date: Tue, 25 Jul 2017 11:40:20 +0800
Message-ID: <1500954024-6860-7-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

irq_create_mapping can return an error, report error to log and return.
Cleanup will occur in the probe function when an error is returned.

Suggested-by: Peter Rosin <peda@axentia.se>
Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ac0f083..7002bfd 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -277,6 +277,10 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 
 	for (c = 0; c < data->chip->nchans; c++) {
 		irq = irq_create_mapping(data->irq, c);
+		if (!irq) {
+			dev_err(&client->dev, "failed irq create map\n");
+			return -EINVAL;
+		}
 		irq_set_chip_data(irq, data);
 		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
 			handle_simple_irq);
-- 
1.8.3.1
