From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 03/10] staging: board: Remove calls to of_genpd_get_from_provider()
Date: Tue, 16 Aug 2016 10:49:29 +0100
Message-ID: <1471340976-5379-4-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4243 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbcHPJug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 05:50:36 -0400
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Update the staging/board PM domain code to use the
of_genpd_add_subdomain() and remove any calls to
of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/staging/board/board.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index 45807d8287d1..86dc41101610 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -140,7 +140,6 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
 					const char *domain)
 {
 	struct of_phandle_args pd_args;
-	struct generic_pm_domain *pd;
 	struct device_node *np;
 
 	np = of_find_node_by_path(domain);
@@ -151,14 +150,8 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
 
 	pd_args.np = np;
 	pd_args.args_count = 0;
-	pd = of_genpd_get_from_provider(&pd_args);
-	if (IS_ERR(pd)) {
-		pr_err("Cannot find genpd %s (%ld)\n", domain, PTR_ERR(pd));
-		return PTR_ERR(pd);
-	}
-	pr_debug("Found genpd %s for device %s\n", pd->name, pdev->name);
 
-	return pm_genpd_add_device(pd, &pdev->dev);
+	return of_genpd_add_device(&pd_args, &pdev->dev);
 }
 #else
 static inline int board_staging_add_dev_domain(struct platform_device *pdev,
-- 
2.1.4

