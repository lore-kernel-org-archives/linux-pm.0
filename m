From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v4 02/16] PM / devfreq: tegra: Replace readl-writel with relaxed versions
Date: Thu,  2 May 2019 02:38:01 +0300
Message-ID: <20190501233815.32643-3-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is no need to insert memory barrier on each readl/writel
invocation, hence use the relaxed versions.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 43cd1233f87b..f7378a42d184 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 
 static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
 {
-	return readl(tegra->regs + offset);
+	return readl_relaxed(tegra->regs + offset);
 }
 
 static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
 {
-	writel(val, tegra->regs + offset);
+	writel_relaxed(val, tegra->regs + offset);
 }
 
 static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
 {
-	return readl(dev->regs + offset);
+	return readl_relaxed(dev->regs + offset);
 }
 
 static void device_writel(struct tegra_devfreq_device *dev, u32 val,
 			  u32 offset)
 {
-	writel(val, dev->regs + offset);
+	writel_relaxed(val, dev->regs + offset);
 }
 
 static unsigned long do_percent(unsigned long val, unsigned int pct)
-- 
2.21.0
