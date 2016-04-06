From: Wei Ni <wni@nvidia.com>
Subject: [PATCH] thermal: tegra: fix static checker warning
Date: Wed, 6 Apr 2016 17:48:04 +0800
Message-ID: <1459936084-11875-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11308 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933944AbcDFJrm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 05:47:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, dan.carpenter@oracle.com
Cc: thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

There has a static checker warning:
warn: variable dereferenced before check 'dev' (see line 222)

Since check 'dev' is unnecessary, so remove this check.

Fixes: ee6d79f202a4 ("thermal: tegra: add thermtrip function")
Signed-off-by: Wei Ni <wni@nvidia.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/tegra/soctherm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 559c74279eb8..d3cc8c99726f 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -223,10 +223,7 @@ static int thermtrip_program(struct device *dev,
 	int temp;
 	u32 r;
 
-	if (!dev || !sg)
-		return -EINVAL;
-
-	if (!sg->thermtrip_threshold_mask)
+	if (!sg || !sg->thermtrip_threshold_mask)
 		return -EINVAL;
 
 	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
-- 
1.9.1

