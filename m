From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] thermal: spear: remove unnecessary OOM messages
Date: Wed, 07 May 2014 15:05:32 +0900
Message-ID: <01ad01cf69ba$5af198d0$10d4ca70$%han@samsung.com>
References: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24567 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbaEGGFe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 02:05:34 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5600K72WX9ISC0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 07 May 2014 15:05:33 +0900 (KST)
In-reply-to: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Zhang Rui' <rui.zhang@intel.com>
Cc: 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/thermal/spear_thermal.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index ab79ea4..1e2193f 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -113,10 +113,8 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	}
 
 	stdev = devm_kzalloc(&pdev->dev, sizeof(*stdev), GFP_KERNEL);
-	if (!stdev) {
-		dev_err(&pdev->dev, "kzalloc fail\n");
+	if (!stdev)
 		return -ENOMEM;
-	}
 
 	/* Enable thermal sensor */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.10.4


