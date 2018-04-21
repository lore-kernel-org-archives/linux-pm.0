From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 01/27] thermal: armada: add a function that sanitizes the
 thermal zone name
Date: Sat, 21 Apr 2018 17:12:29 +0200
Message-ID: <20180421151255.29929-2-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Thermal zone names must follow certain rules imposed by the framework.
They are limited in length and shall not have any hyphen '-'.

This is done in a separate function for future use in another location.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 4c275ec10ac5..077e8e562306 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -70,6 +70,7 @@ struct armada_thermal_priv {
 	void __iomem *status;
 	void __iomem *control0;
 	void __iomem *control1;
+	char zone_name[THERMAL_NAME_LENGTH];
 	struct armada_thermal_data *data;
 };
 
@@ -353,6 +354,36 @@ static const struct of_device_id armada_thermal_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, armada_thermal_id_table);
 
+static void armada_set_sane_name(struct platform_device *pdev,
+				 struct armada_thermal_priv *priv)
+{
+	const char *name = dev_name(&pdev->dev);
+	char *insane_char;
+
+	if (strlen(name) > THERMAL_NAME_LENGTH) {
+		/*
+		 * When inside a system controller, the device name has the
+		 * form: f06f8000.system-controller:ap-thermal so stripping
+		 * after the ':' should give us a shorter but meaningful name.
+		 */
+		name = strrchr(name, ':');
+		if (!name)
+			name = "armada_thermal";
+		else
+			name++;
+	}
+
+	/* Save the name locally */
+	strncpy(priv->zone_name, name, THERMAL_NAME_LENGTH);
+
+	/* Then check there are no '-' or hwmon core will complain */
+	do {
+		insane_char = strpbrk(priv->zone_name, "-");
+		if (insane_char)
+			*insane_char = '_';
+	} while (insane_char);
+}
+
 static int armada_thermal_probe(struct platform_device *pdev)
 {
 	void __iomem *control = NULL;
@@ -381,6 +412,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	priv->data = (struct armada_thermal_data *)match->data;
 
+	/* Ensure device name is correct for the thermal core */
+	armada_set_sane_name(pdev, priv);
+
 	/*
 	 * Legacy DT bindings only described "control1" register (also referred
 	 * as "control MSB" on old documentation). New bindings cover
@@ -402,7 +436,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	priv->data->init_sensor(pdev, priv);
 
-	thermal = thermal_zone_device_register(dev_name(&pdev->dev), 0, 0, priv,
+	thermal = thermal_zone_device_register(priv->zone_name, 0, 0, priv,
 					       &ops, NULL, 0, 0);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
-- 
2.14.1
