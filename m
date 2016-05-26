From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
Date: Thu, 26 May 2016 09:45:42 +0300
Message-ID: <20160526064541.GA6680@mwanda>
References: <alpine.DEB.2.10.1605251710500.3644@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1605251710500.3644@hadrien>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Smatch complains because platform_get_resource() returns NULL on error
and not an error pointer so the check is wrong.  Julia Lawall pointed
out that normally we don't check these, because devm_ioremap_resource()
has a check for NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: just remove the check

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index 6b6a5f3..a584140 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
 
 	/* Maps the memory mapped IO to control nocp register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
-
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
