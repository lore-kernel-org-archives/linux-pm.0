From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PM / devfreq: exynos-ppmu: fix error path in
 exynos_ppmu_probe()
Date: Tue, 28 Jun 2016 13:21:08 +0200
Message-ID: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

iounmap() needs to be called in case of memory allocation
(for devfreq-event devices) failure.  Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f312485..845bf25 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -482,7 +482,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 	if (!info->edev) {
 		dev_err(&pdev->dev,
 			"failed to allocate memory devfreq-event devices\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 	edev = info->edev;
 	platform_set_drvdata(pdev, info);
-- 
1.9.1
