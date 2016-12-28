From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 4/8] PM / devfreq: exynos-ppmu: Show the registred device
 for ppmu device
Date: Wed, 28 Dec 2016 20:56:48 +0900
Message-ID: <1482926212-19223-5-git-send-email-cw00.choi@samsung.com>
References: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115654epcas1p1fcd9be231f97e6782e06d75ace95a9ba@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch just adds the simple log to show the PPMU device's registration
during the kernel booting.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index fb3706faf5bd..9b5294d0bff4 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -591,7 +591,7 @@ static int exynos_ppmu_parse_dt(struct platform_device *pdev,
 	info->ppmu.clk = devm_clk_get(dev, "ppmu");
 	if (IS_ERR(info->ppmu.clk)) {
 		info->ppmu.clk = NULL;
-		dev_warn(dev, "cannot get PPMU clock\n");
+		dev_dbg(dev, "cannot get PPMU clock\n");
 	}
 
 	ret = of_get_devfreq_events(np, info);
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
