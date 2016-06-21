From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/5] PM / devfreq: make event/exynos-nocp explicitly non-modular
Date: Tue, 21 Jun 2016 01:15:00 -0400
Message-ID: <20160621051501.18396-5-paul.gortmaker@windriver.com>
References: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

event/Kconfig:config DEVFREQ_EVENT_EXYNOS_NOCP
event/Kconfig:  bool "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/event/exynos-nocp.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 6b6a5f310486..f954578abfdf 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/clk.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/devfreq-event.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
@@ -280,25 +280,12 @@ static int exynos_nocp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_nocp_remove(struct platform_device *pdev)
-{
-	struct exynos_nocp *nocp = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(nocp->clk);
-
-	return 0;
-}
-
 static struct platform_driver exynos_nocp_driver = {
 	.probe	= exynos_nocp_probe,
-	.remove	= exynos_nocp_remove,
 	.driver = {
 		.name	= "exynos-nocp",
+		.suppress_bind_attrs = true,
 		.of_match_table = exynos_nocp_id_match,
 	},
 };
-module_platform_driver(exynos_nocp_driver);
-
-MODULE_DESCRIPTION("Exynos NoC (Network on Chip) Probe driver");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(exynos_nocp_driver);
-- 
2.8.4
