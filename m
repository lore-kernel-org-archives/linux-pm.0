From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/5] PM / devfreq: make exynos-bus ARM_EXYNOS_BUS_DEVFREQ tristate
Date: Sat, 25 Jun 2016 14:43:49 -0400
Message-ID: <20160625184351.5045-4-paul.gortmaker@windriver.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

devfreq/Kconfig:config ARM_EXYNOS_BUS_DEVFREQ
devfreq/Kconfig:        bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"

...meaning that it currently is not being built as a module by anyone.

Rather than rip out the existing modular code, Chanwoo indicated
that he'd rather see the driver offered as tristate.

I don't have the hardware for runtime validation, so this change
is only validated for compile and modpost.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 78dac0e9da11..a5be56ec57f2 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -75,7 +75,7 @@ config DEVFREQ_GOV_PASSIVE
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
-	bool "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
+	tristate "ARM EXYNOS Generic Memory Bus DEVFREQ Driver"
 	depends on ARCH_EXYNOS
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select DEVFREQ_GOV_PASSIVE
-- 
2.8.4
