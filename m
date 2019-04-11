From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 4/8] PM / devfreq: tegra: Don't release IRQ manually on driver removal
Date: Fri, 12 Apr 2019 01:29:10 +0300
Message-ID: <20190411222914.25539-5-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The IRQ releasing is handled by "managed resources", hence there is no
need to release IRQ manually.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 6185e7ab20a8..ed67d7a48176 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -717,7 +717,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 	u32 val;
 	unsigned int i;
 
@@ -729,8 +728,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 
 	actmon_write_barrier(tegra);
 
-	devm_free_irq(&pdev->dev, irq, tegra);
-
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
 	clk_disable_unprepare(tegra->clock);
-- 
2.21.0
