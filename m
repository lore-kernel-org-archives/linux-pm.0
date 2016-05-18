From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] PM / devfreq: exynos-nocp: Checking for IS_ERR instead of
 NULL
Date: Wed, 18 May 2016 13:37:07 +0300
Message-ID: <20160518103707.GA9436@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51685 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbcERKhe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 06:37:34 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org

The platform_get_resource() function returns NULL on error, it never
returns error pointers.

Fixes: 0179a913875a ('PM / devfreq: event: Add new Exynos NoC probe driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 6b6a5f3..03b35d5 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -220,8 +220,8 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
 
 	/* Maps the memory mapped IO to control nocp register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (!res)
+		return -ENXIO;
 
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
