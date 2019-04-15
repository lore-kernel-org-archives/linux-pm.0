From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 09/19] PM / devfreq: tegra: Change interrupt request order
Date: Mon, 15 Apr 2019 17:54:55 +0300
Message-ID: <20190415145505.18397-10-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The interrupt should be requested after devfreq initialization because
interrupt handler uses the devfreq, otherwise interrupt handler will
crash if interrupt fires before the initialization. This shouldn't
happen in practice, but it's more correct to have interrupt available
after all of interrupt prerequisites are ready.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 98ba27b1e2c4..2a1464098200 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -686,14 +686,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tegra);
 
-	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
-					actmon_thread_isr, IRQF_SHARED,
-					"tegra-devfreq", tegra);
-	if (err) {
-		dev_err(&pdev->dev, "Interrupt request failed\n");
-		return err;
-	}
-
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
 						 &tegra_devfreq_profile,
@@ -701,6 +693,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
+		return err;
+	}
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
+					actmon_thread_isr, IRQF_SHARED,
+					"tegra-devfreq", tegra);
+	if (err) {
+		dev_err(&pdev->dev, "Interrupt request failed\n");
 		goto remove_opps;
 	}
 
-- 
2.21.0
