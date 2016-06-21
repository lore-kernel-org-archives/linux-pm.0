From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/5] PM / devfreq: make exynos-bus explicitly non-modular
Date: Tue, 21 Jun 2016 01:14:59 -0400
Message-ID: <20160621051501.18396-4-paul.gortmaker@windriver.com>
References: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:50129 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbcFUFPT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 01:15:19 -0400
In-Reply-To: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

devfreq/Kconfig:config ARM_EXYNOS_BUS_DEVFREQ
devfreq/Kconfig:        bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

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
 drivers/devfreq/exynos-bus.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 2363d0a189b7..2e018d80e0f7 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -17,7 +17,7 @@
 #include <linux/devfreq-event.h>
 #include <linux/device.h>
 #include <linux/export.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
@@ -553,7 +553,6 @@ static const struct of_device_id exynos_bus_of_match[] = {
 	{ .compatible = "samsung,exynos-bus", },
 	{ /* sentinel */ },
 };
-MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
 
 static struct platform_driver exynos_bus_platdrv = {
 	.probe		= exynos_bus_probe,
@@ -563,8 +562,4 @@ static struct platform_driver exynos_bus_platdrv = {
 		.of_match_table = of_match_ptr(exynos_bus_of_match),
 	},
 };
-module_platform_driver(exynos_bus_platdrv);
-
-MODULE_DESCRIPTION("Generic Exynos Bus frequency driver");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(exynos_bus_platdrv);
-- 
2.8.4

