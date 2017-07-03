From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] devfreq: tegra: fix error return code in
 tegra_devfreq_probe()
Date: Mon, 3 Jul 2017 07:47:38 -0500
Message-ID: <20170703124738.GA3947@embeddedgus>
References: <df35dc5e-0a8f-0022-be20-36be38fbf83b@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <df35dc5e-0a8f-0022-be20-36be38fbf83b@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

platform_get_irq() returns an error code, but the tegra-devfreq
driver ignores it and always returns -ENODEV. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Rewrite commit message.

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
