From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] devfreq: tegra: fix error code in tegra_devfreq_probe()
Date: Fri, 30 Jun 2017 02:22:11 -0500
Message-ID: <20170630072211.GA21867@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/devfreq/tegra-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 214fff9..ae71215 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		return -ENODEV;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		return irq;
 	}
 
 	platform_set_drvdata(pdev, tegra);
-- 
2.5.0
