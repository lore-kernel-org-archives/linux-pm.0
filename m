From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/2] power/reset: at91-reset: remove leftover
 platform_device_id
Date: Wed, 18 Jan 2017 00:07:38 +0100
Message-ID: <20170117230738.28257-2-alexandre.belloni@free-electrons.com>
References: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

commit eacd8d09db7f ("power/reset: at91-reset: remove useless
at91_reset_platform_probe()") removed non DT probe support but forgot to
remove the now useless id_table. Do that now.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-reset.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index bb2588f0a4c7..b99769f8ab15 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -248,20 +248,12 @@ static int __exit at91_reset_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id at91_reset_plat_match[] = {
-	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
-	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, at91_reset_plat_match);
-
 static struct platform_driver at91_reset_driver = {
 	.remove = __exit_p(at91_reset_remove),
 	.driver = {
 		.name = "at91-reset",
 		.of_match_table = at91_reset_of_match,
 	},
-	.id_table = at91_reset_plat_match,
 };
 module_platform_driver_probe(at91_reset_driver, at91_reset_probe);
 
-- 
2.11.0
