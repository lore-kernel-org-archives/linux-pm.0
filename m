From: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Tue, 20 May 2014 16:27:40 +0200
Message-ID: <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbaETO1q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 10:27:46 -0400
In-Reply-To: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>

Following the introduction of voltage ranges into OPP
we need a way to encode them in the device tree in a
similar fashion to the non-ranged versions.

To keep compatibility with old DTs the parsing function
is changed to understand both versions.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/power/opp.txt | 23 ++++++++++++++++++
 drivers/base/power/opp.c                        | 31 ++++++++++++++++++-------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..5b520ff321f5 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -10,6 +10,16 @@ Properties:
 	freq: clock frequency in kHz
 	vol: voltage in microvolt
 
+or
+
+- operating-points-range: An array of 4-tuple items, each item consisting
+  of a frequency and a related voltage range in the following form:
+  <freq min-vol-uV nom-vol-uV max-vol-uV>
+	freq: clock frequency in kHz
+	min-vol-uV: absolute minimum required voltage for this frequency
+	nom-vol-uV: nominal voltage for this frequency
+	max-vol-uV: absolute maximum allowed voltage for this frequency
+
 Examples:
 
 cpu@0 {
@@ -23,3 +33,16 @@ cpu@0 {
 		198000  850000
 	>;
 };
+
+cpu@0 {
+	compatible = "arm,cortex-a8";
+	reg = <0x0>;
+	operating-points-range = <
+		/*  kHz min(uV) nom(uV) max(uV) */
+		 166666  850000  900000 1400000
+		 400000  900000  950000 1400000
+		 800000 1050000 1100000 1400000
+		1000000 1200000 1250000 1400000
+		1200000 1300000 1350000 1400000
+	>;
+};
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index e738a37df915..6af9c465c46b 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -727,11 +727,16 @@ int of_init_opp_table(struct device *dev)
 {
 	const struct property *prop;
 	const __be32 *val;
-	int nr;
+	int nr, prop_size;
 
-	prop = of_find_property(dev->of_node, "operating-points", NULL);
-	if (!prop)
+	if ((prop = of_find_property(dev->of_node, "operating-points", NULL)))
+		prop_size = 2;
+	else if ((prop = of_find_property(dev->of_node,
+					  "operating-points-range", NULL)))
+		prop_size = 4;
+	else
 		return -ENODEV;
+
 	if (!prop->value)
 		return -ENODATA;
 
@@ -740,22 +745,32 @@ int of_init_opp_table(struct device *dev)
 	 * voltage like <freq-kHz vol-uV>.
 	 */
 	nr = prop->length / sizeof(u32);
-	if (nr % 2) {
+	if (nr % prop_size) {
 		dev_err(dev, "%s: Invalid OPP list\n", __func__);
 		return -EINVAL;
 	}
 
 	val = prop->value;
 	while (nr) {
-		unsigned long freq = be32_to_cpup(val++) * 1000;
-		unsigned long volt = be32_to_cpup(val++);
+		unsigned long freq, volt_min, volt_nominal, volt_max;
+
+		freq = be32_to_cpup(val++) * 1000;
+		if (prop_size == 4) {
+			volt_min = be32_to_cpup(val++);
+			volt_nominal = be32_to_cpup(val++);
+			volt_max = be32_to_cpup(val++);
+		} else {
+			volt_nominal = be32_to_cpup(val++);
+			volt_min = volt_max = volt_nominal;
+		}
 
-		if (dev_pm_opp_add(dev, freq, volt, volt, volt)) {
+		if (dev_pm_opp_add(dev, freq, volt_min, volt_nominal,
+				   volt_max)) {
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 			continue;
 		}
-		nr -= 2;
+		nr -= prop_size;
 	}
 
 	return 0;
-- 
2.0.0.rc0

