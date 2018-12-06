From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2] power: reset: at91-poweroff: move shdwc related data to
 one structure
Date: Thu, 6 Dec 2018 17:29:46 +0000
Message-ID: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Move SHDWC realted data to only one structure to have them grouped.
Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
mpddrc_base part of struct shdwc").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- avoid allocate at91_shdwc and keep it static instead
- avoid registering at91_shdwc as platform data and use static variable
  instead

 drivers/power/reset/at91-poweroff.c | 48 +++++++++++++++++++--------------=
----
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index d3d87af24e55..9e74e131c675 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -51,14 +51,16 @@ static const char *shdwc_wakeup_modes[] =3D {
 	[AT91_SHDW_WKMODE0_ANYLEVEL]	=3D "any",
 };
=20
-static void __iomem *at91_shdwc_base;
-static struct clk *sclk;
-static void __iomem *mpddrc_base;
+static struct shdwc {
+	struct clk *sclk;
+	void __iomem *shdwc_base;
+	void __iomem *mpddrc_base;
+} at91_shdwc;
=20
 static void __init at91_wakeup_status(struct platform_device *pdev)
 {
 	const char *reason;
-	u32 reg =3D readl(at91_shdwc_base + AT91_SHDW_SR);
+	u32 reg =3D readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
=20
 	/* Simple power-on, just bail out */
 	if (!reg)
@@ -92,9 +94,9 @@ static void at91_poweroff(void)
=20
 		"	b	.\n\t"
 		:
-		: "r" (mpddrc_base),
+		: "r" (at91_shdwc.mpddrc_base),
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
-		  "r" (at91_shdwc_base),
+		  "r" (at91_shdwc.shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
 		: "r6");
 }
@@ -144,7 +146,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct pla=
tform_device *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
 			mode |=3D AT91_SHDW_RTTWKEN;
=20
-	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
+	writel(wakeup_mode | mode, at91_shdwc.shdwc_base + AT91_SHDW_MR);
 }
=20
 static int __init at91_poweroff_probe(struct platform_device *pdev)
@@ -155,15 +157,15 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	int ret;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	at91_shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc_base))
-		return PTR_ERR(at91_shdwc_base);
+	at91_shdwc.shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(at91_shdwc.shdwc_base))
+		return PTR_ERR(at91_shdwc.shdwc_base);
=20
-	sclk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sclk))
-		return PTR_ERR(sclk);
+	at91_shdwc.sclk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(at91_shdwc.sclk))
+		return PTR_ERR(at91_shdwc.sclk);
=20
-	ret =3D clk_prepare_enable(sclk);
+	ret =3D clk_prepare_enable(at91_shdwc.sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return ret;
@@ -176,20 +178,20 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
 	if (np) {
-		mpddrc_base =3D of_iomap(np, 0);
+		at91_shdwc.mpddrc_base =3D of_iomap(np, 0);
 		of_node_put(np);
=20
-		if (!mpddrc_base) {
+		if (!at91_shdwc.mpddrc_base) {
 			ret =3D -ENOMEM;
 			goto clk_disable;
 		}
=20
-		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+		ddr_type =3D readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
 				 AT91_DDRSDRC_MD;
 		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
 		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
-			iounmap(mpddrc_base);
-			mpddrc_base =3D NULL;
+			iounmap(at91_shdwc.mpddrc_base);
+			at91_shdwc.mpddrc_base =3D NULL;
 		}
 	}
=20
@@ -198,7 +200,7 @@ static int __init at91_poweroff_probe(struct platform_d=
evice *pdev)
 	return 0;
=20
 clk_disable:
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc.sclk);
 	return ret;
 }
=20
@@ -207,10 +209,10 @@ static int __exit at91_poweroff_remove(struct platfor=
m_device *pdev)
 	if (pm_power_off =3D=3D at91_poweroff)
 		pm_power_off =3D NULL;
=20
-	if (mpddrc_base)
-		iounmap(mpddrc_base);
+	if (at91_shdwc.mpddrc_base)
+		iounmap(at91_shdwc.mpddrc_base);
=20
-	clk_disable_unprepare(sclk);
+	clk_disable_unprepare(at91_shdwc.sclk);
=20
 	return 0;
 }
--=20
2.7.4
