From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 17/19] PM / devfreq: tegra: Support Tegra30
Date: Mon, 15 Apr 2019 17:55:03 +0300
Message-ID: <20190415145505.18397-18-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq driver can be used on Tegra30 without any code change and
it works perfectly fine, the default Tegra124 parameters are good enough
for Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 4 ++--
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index a78dffe603c1..78c33ddd4eea 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_TEGRA_DEVFREQ
-	tristate "Tegra DEVFREQ Driver"
-	depends on ARCH_TEGRA_124_SOC
+	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
+	depends on ARCH_TEGRA
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f0711d5ad27d..0a2465a58cf5 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -719,6 +719,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_devfreq_of_match[] = {
+	{ .compatible = "nvidia,tegra30-actmon" },
 	{ .compatible = "nvidia,tegra124-actmon" },
 	{ },
 };
-- 
2.21.0
