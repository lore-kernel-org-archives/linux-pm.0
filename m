From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 3/3] PM / devfreq: exynos-bus: Fix the wrong return value
Date: Wed, 28 Dec 2016 20:52:36 +0900
Message-ID: <1482925956-19044-4-git-send-email-cw00.choi@samsung.com>
References: <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115241epcas5p4dbe02a82279d6aad8dac1a2cc0fdc9cb@epcas5p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50401 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbcL1Lxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:53:33 -0500
In-reply-to: <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org

This patch fixes the wrong return value. If devfreq driver requires the wrong
and non-available governor, it is fail. So, this patch returns the error
insead of -EPROBE_DEFER.

Fixes: 403e0689d2a9 ("PM / devfreq: exynos: Add support of bus frequency of
		      sub-blocks using passive governor")
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Cc: stable@vger.kernel.org
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

