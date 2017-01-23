From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 2/4] PM / devfreq: exynos-ppmu: Show the registred device
 for ppmu device
Date: Mon, 23 Jan 2017 12:31:37 +0900
Message-ID: <1485142299-9986-3-git-send-email-cw00.choi@samsung.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033151epcas5p341aa786474af221e390eed87ea48381e@epcas5p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch just adds the simple log to show the PPMU device's registration
during the kernel booting.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index fb3706faf5bd..9b7350935b73 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -643,6 +643,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 				"failed to add devfreq-event device\n");
 			return PTR_ERR(edev[i]);
 		}
+
+		pr_info("exynos-ppmu: new PPMU device registered %s (%s)\n",
+			dev_name(&pdev->dev), desc[i].name);
 	}
 
 	clk_prepare_enable(info->ppmu.clk);
-- 
1.9.1
