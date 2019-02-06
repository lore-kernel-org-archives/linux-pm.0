From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60 SoC
Date: Wed, 6 Feb 2019 19:12:21 +0100
Message-ID: <20190206181221.27914-3-nicolas.ferre@microchip.com>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190206181221.27914-1-nicolas.ferre@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add support for additional reset causes and the proper compatibility
string for sam9x60 SoC. The restart function is the same as the samx7.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
v2: split series and collect tag

Sebastian,
I add your Acked-by tag here but as I would like that you take the 3 patches on
your tree now, I let you modify it on your side. I'm expecting Alexandre or
Ludovic to have a look as well.

Best regards,
  Nicolas

 drivers/power/reset/at91-reset.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index f44a9ffcc2ab..44ca983a49a1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -44,6 +44,9 @@ enum reset_type {
 	RESET_TYPE_WATCHDOG	= 2,
 	RESET_TYPE_SOFTWARE	= 3,
 	RESET_TYPE_USER		= 4,
+	RESET_TYPE_CPU_FAIL	= 6,
+	RESET_TYPE_XTAL_FAIL	= 7,
+	RESET_TYPE_ULP2		= 8,
 };
 
 static void __iomem *at91_ramc_base[2], *at91_rstc_base;
@@ -164,6 +167,15 @@ static void __init at91_reset_status(struct platform_device *pdev)
 	case RESET_TYPE_USER:
 		reason = "user reset";
 		break;
+	case RESET_TYPE_CPU_FAIL:
+		reason = "CPU clock failure detection";
+		break;
+	case RESET_TYPE_XTAL_FAIL:
+		reason = "32.768 kHz crystal failure detection";
+		break;
+	case RESET_TYPE_ULP2:
+		reason = "ULP2 reset";
+		break;
 	default:
 		reason = "unknown reset";
 		break;
@@ -183,6 +195,7 @@ static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ .compatible = "atmel,samx7-rstc", .data = samx7_restart },
+	{ .compatible = "microchip,sam9x60-rstc", .data = samx7_restart },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
-- 
2.17.1
