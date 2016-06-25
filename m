From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/5] PM / devfreq: make event/exynos-nocp DEVFREQ_EVENT_EXYNOS_NOCP tristate
Date: Sat, 25 Jun 2016 14:43:50 -0400
Message-ID: <20160625184351.5045-5-paul.gortmaker@windriver.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

event/Kconfig:config DEVFREQ_EVENT_EXYNOS_NOCP
event/Kconfig:  bool "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"

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
 drivers/devfreq/event/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index 1e8b4f469f38..96ea29d1ede5 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -14,7 +14,7 @@ menuconfig PM_DEVFREQ_EVENT
 if PM_DEVFREQ_EVENT
 
 config DEVFREQ_EVENT_EXYNOS_NOCP
-	bool "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
+	tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
 	depends on ARCH_EXYNOS
 	select PM_OPP
 	help
-- 
2.8.4
