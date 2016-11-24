From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 6/6] PM / devfreq: event: exynos-ppmu: Add the completion log
 of device registration
Date: Thu, 24 Nov 2016 14:01:08 +0900
Message-ID: <1479963668-22845-7-git-send-email-cw00.choi@samsung.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch just adds the simple log to show the PPMU device's registration
during the kernel booting.

For example on exynos4412-odroidu3 board as following:
[    1.845929] exynos-ppmu: new PPMU device registered 106a0000.ppmu_dmc0
[    1.848997] exynos-ppmu: new PPMU device registered 106b0000.ppmu_dmc1
[    1.853512] exynos-ppmu: new PPMU device registered 112a0000.ppmu_rightbus
[    1.860524] exynos-ppmu: new PPMU device registered 116a0000.ppmu_leftbus0

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index fb3706faf5bd..b2696181c929 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -647,6 +647,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(info->ppmu.clk);
 
+	pr_info("exynos-ppmu: new PPMU device registered %s\n",
+			dev_name(&pdev->dev));
+
 	return 0;
 }
 
-- 
1.9.1
