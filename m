From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/8] memory: atmel-sdramc: allow probing from pdata
Date: Tue, 21 Oct 2014 23:55:34 +0200
Message-ID: <1413928540-27099-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Allow probing the atmel-sdramc from platform_data.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/memory/atmel-sdramc.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
index 148906dabe55..e1222557dc9d 100644
--- a/drivers/memory/atmel-sdramc.c
+++ b/drivers/memory/atmel-sdramc.c
@@ -19,6 +19,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -127,7 +128,7 @@ static const struct of_device_id atmel_ramc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_ramc_of_match);
 
-static int atmel_ramc_probe(struct platform_device *pdev)
+static int atmel_ramc_of_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	const struct at91_ramc_caps *caps;
@@ -168,6 +169,46 @@ static int atmel_ramc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int atmel_ramc_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	const struct platform_device_id *match;
+	int idx = 0;
+
+	for (idx = 0; idx < 2; idx++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1);
+		at91_ramc_base[idx] = devm_ioremap(&pdev->dev, res->start,
+						   resource_size(res));
+		if (IS_ERR(at91_ramc_base[idx])) {
+			dev_err(&pdev->dev, "Could not map ram controller address\n");
+			return PTR_ERR(at91_ramc_base[idx]);
+		}
+	}
+
+	match = platform_get_device_id(pdev);
+	at91_ramc_shutdown = (void (*)(void))match->driver_data;
+
+	return 0;
+};
+
+static int atmel_ramc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	if (pdev->dev.of_node)
+		ret = atmel_ramc_of_probe(pdev);
+	else
+		ret = atmel_ramc_platform_probe(pdev);
+
+	return ret;
+}
+
+static struct platform_device_id atmel_ramc_plat_match[] = {
+	{ "at91sam9260-sdramc", (unsigned long)at91sam9260_shutdown, },
+	{ "at91sam9g45-ddramc", (unsigned long)at91sam9g45_shutdown, },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver atmel_ramc_driver = {
 	.probe		= atmel_ramc_probe,
 	.driver		= {
@@ -175,6 +216,7 @@ static struct platform_driver atmel_ramc_driver = {
 		.owner	= THIS_MODULE,
 		.of_match_table = atmel_ramc_of_match,
 	},
+	.id_table = atmel_ramc_plat_match,
 };
 
 static int __init atmel_ramc_init(void)
-- 
1.9.1
