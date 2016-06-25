From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/5] PM / devfreq: make event/exynos-ppmu DEVFREQ_EVENT_EXYNOS_PPMU tristate
Date: Sat, 25 Jun 2016 14:43:51 -0400
Message-ID: <20160625184351.5045-6-paul.gortmaker@windriver.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160625184351.5045-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config DEVFREQ_EVENT_EXYNOS_PPMU
  bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"

...meaning that it currently is not being built as a module by anyone.

Rather than rip out the existing modular code, Chanwoo indicated
that he'd rather see the driver offered as tristate.

I don't have the hardware for runtime validation, so this change
is only validated for compile and modpost.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/devfreq/event/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
index 96ea29d1ede5..eb6f74a2b6b9 100644
--- a/drivers/devfreq/event/Kconfig
+++ b/drivers/devfreq/event/Kconfig
@@ -22,7 +22,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
 	  (Network on Chip) Probe counters to measure the bandwidth of AXI bus.
 
 config DEVFREQ_EVENT_EXYNOS_PPMU
-	bool "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
+	tristate "EXYNOS PPMU (Platform Performance Monitoring Unit) DEVFREQ event Driver"
 	depends on ARCH_EXYNOS
 	select PM_OPP
 	help
-- 
2.8.4
