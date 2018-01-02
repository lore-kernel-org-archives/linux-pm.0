From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 06/12] power: supply: account for const type of of_device_id.data
Date: Tue,  2 Jan 2018 14:28:02 +0100
Message-ID: <1514899688-27844-7-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This driver creates two const structures that it stores in the data
field of an of_device_id array.

The data field of an of_device_id structure has type const void *, so
there is no need for a const-discarding cast when putting const values
into such a structure.

Furthermore, adding const to the declaration of the location that
receives a const value from such a field ensures that the compiler
will continue to check that the value is not modified.  The
const-discarding cast on the extraction from the data field is thus
no longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/supply/axp20x_ac_power.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -u -p a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -159,7 +159,7 @@ static int axp20x_ac_power_probe(struct
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct axp20x_ac_power *power;
-	struct axp_data *axp_data;
+	const struct axp_data *axp_data;
 	static const char * const irq_names[] = { "ACIN_PLUGIN", "ACIN_REMOVAL",
 		NULL };
 	int i, irq, ret;
@@ -176,7 +176,7 @@ static int axp20x_ac_power_probe(struct
 	if (!power)
 		return -ENOMEM;
 
-	axp_data = (struct axp_data *)of_device_get_match_data(&pdev->dev);
+	axp_data = of_device_get_match_data(&pdev->dev);
 
 	if (axp_data->acin_adc) {
 		power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
@@ -230,10 +230,10 @@ static int axp20x_ac_power_probe(struct
 static const struct of_device_id axp20x_ac_power_match[] = {
 	{
 		.compatible = "x-powers,axp202-ac-power-supply",
-		.data = (void *)&axp20x_data,
+		.data = &axp20x_data,
 	}, {
 		.compatible = "x-powers,axp221-ac-power-supply",
-		.data = (void *)&axp22x_data,
+		.data = &axp22x_data,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);

