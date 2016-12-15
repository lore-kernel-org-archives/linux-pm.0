From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] PM / devfreq: exynos-bus: Fix the wrong return value
Date: Thu, 15 Dec 2016 18:30:38 +0900
Message-ID: <1481794238-5005-4-git-send-email-cw00.choi@samsung.com>
References: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, stable@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the wrong return value. If devfreq driver requires the wrong
and non-available governor, it is fail. So, this patch returns the error
insead of -EPROBE_DEFER.

Fixes: 403e0689d2a9 ("PM / devfreq: exynos: Add support of bus frequency of
		      sub-blocks using passive governor")
Cc: stable@vger.kernel.org
cc: linux-samsung-soc@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index a8ed7792ece2..9af86f46fbec 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -497,7 +497,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	if (IS_ERR(bus->devfreq)) {
 		dev_err(dev,
 			"failed to add devfreq dev with passive governor\n");
-		ret = -EPROBE_DEFER;
+		ret = PTR_ERR(bus->devfreq);
 		goto err;
 	}
 
-- 
1.9.1
