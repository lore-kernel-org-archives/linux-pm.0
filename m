From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/4] power: reset: at91-poweroff: use one poweroff function
 for at91-poweroff
Date: Mon, 5 Nov 2018 11:14:23 +0000
Message-ID: <1541416443-4321-2-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

Use only one poweroff function and adapt it to work for both scenarios
(with LPDDR or not). The assignement of pm_power_off was moved at the
end of probe after all initializations are OK. This patch adapt the idea
from commit 4e018c1e9b05 ("power: reset: at91-poweroff: use only one
poweroff function").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 49 ++++++++++++++++++++-------------=
----
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index fb2fc8f741a1..82533f4c72fc 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -76,11 +76,6 @@ static void __init at91_wakeup_status(struct platform_de=
vice *pdev)
=20
 static void at91_poweroff(void)
 {
-	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
-}
-
-static void at91_lpddr_poweroff(void)
-{
 	asm volatile(
 		/* Align to cache lines */
 		".balign 32\n\t"
@@ -89,9 +84,11 @@ static void at91_lpddr_poweroff(void)
 		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
=20
 		/* Power down SDRAM0 */
+		"	tst	%0, #0\n\t"
+		"	beq	1f\n\t"
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 		/* Shutdown CPU */
-		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+		"1:	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
=20
 		"	b	.\n\t"
 		:
@@ -177,34 +174,42 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
 	if (pdev->dev.of_node)
 		at91_poweroff_dt_set_wakeup_mode(pdev);
=20
-	pm_power_off =3D at91_poweroff;
-
 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
-	if (!np)
-		return 0;
+	if (np) {
+		mpddrc_base =3D of_iomap(np, 0);
+		of_node_put(np);
=20
-	mpddrc_base =3D of_iomap(np, 0);
-	of_node_put(np);
+		if (!mpddrc_base) {
+			ret =3D -ENOMEM;
+			goto clk_disable;
+		}
=20
-	if (!mpddrc_base)
-		return 0;
+		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
+				 AT91_DDRSDRC_MD;
+		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
+		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
+			iounmap(mpddrc_base);
+			mpddrc_base =3D NULL;
+		}
+	}
=20
-	ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
-	if ((ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR2) ||
-	    (ddr_type =3D=3D AT91_DDRSDRC_MD_LPDDR3))
-		pm_power_off =3D at91_lpddr_poweroff;
-	else
-		iounmap(mpddrc_base);
+	pm_power_off =3D at91_poweroff;
=20
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sclk);
+	return ret;
 }
=20
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off =3D=3D at91_poweroff ||
-	    pm_power_off =3D=3D at91_lpddr_poweroff)
+	if (pm_power_off =3D=3D at91_poweroff)
 		pm_power_off =3D NULL;
=20
+	if (mpddrc_base)
+		iounmap(mpddrc_base);
+
 	clk_disable_unprepare(sclk);
=20
 	return 0;
--=20
2.7.4
