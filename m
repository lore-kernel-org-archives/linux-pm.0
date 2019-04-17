From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v3 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
Date: Thu, 18 Apr 2019 01:29:24 +0300
Message-ID: <20190417222925.5815-16-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In order to reflect that driver serves NVIDIA Tegra30 and later SoC
generations, let's rename the driver's source file to "tegra30-devfreq.c".
This will make driver files to look more consistent after addition of a
driver for Tegra20.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Makefile                               | 2 +-
 drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (100%)

diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..47e5aeeebfd1 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
-obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
similarity index 100%
rename from drivers/devfreq/tegra-devfreq.c
rename to drivers/devfreq/tegra30-devfreq.c
-- 
2.21.0
