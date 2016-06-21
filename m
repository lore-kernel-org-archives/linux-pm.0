From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/5] PM / devfreq: make event/exynos-ppmu explicitly non-modular
Date: Tue, 21 Jun 2016 01:15:01 -0400
Message-ID: <20160621051501.18396-6-paul.gortmaker@windriver.com>
References: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config DEVFREQ_EVENT_EXYNOS_PPMU
   bool "EXYNOS PPMU (Platform Perf Monitoring Unit) DEVFREQ event Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f312485f1451..38a997807043 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -524,8 +524,4 @@ static struct platform_driver exynos_ppmu_driver = {
 		.of_match_table = exynos_ppmu_id_match,
 	},
 };
-module_platform_driver(exynos_ppmu_driver);
-
-MODULE_DESCRIPTION("Exynos PPMU(Platform Performance Monitoring Unit) driver");
-MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(exynos_ppmu_driver);
-- 
2.8.4
