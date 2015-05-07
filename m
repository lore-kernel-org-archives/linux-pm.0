From: Wei Ni <wni@nvidia.com>
Subject: [PATCH] thermal: of: fix cooling_spec.args for 64bit
Date: Thu, 7 May 2015 12:29:12 +0800
Message-ID: <1430972952-16303-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17775 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbEGE3R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 00:29:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>

The THERMAL_NO_LIMIT is defined as -1UL, when it is set in DT,
the of-thermal will use of_parse_phandle_with_args() to parse it.
Since the args is uint32_t, so in 32bit system, the of framework
will read it as 0xffffffff, it's the expected value "-1".
But in 64bit system, this value is read as 0x00000000ffffffff,
it's not a negative value, it will cause problems.

This change can fix this issue.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/of-thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 9e8c614103ef..8d6b4070dea3 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -613,8 +613,10 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 	}
 	__tbp->cooling_device = cooling_spec.np;
 	if (cooling_spec.args_count >= 2) { /* at least min and max */
-		__tbp->min = cooling_spec.args[0];
-		__tbp->max = cooling_spec.args[1];
+		__tbp->min = cooling_spec.args[0] == -1U ?
+			THERMAL_NO_LIMIT : cooling_spec.args[0];
+		__tbp->max = cooling_spec.args[1] == -1U ?
+			THERMAL_NO_LIMIT : cooling_spec.args[1];
 	} else {
 		pr_err("wrong reference to cooling device, missing limits\n");
 	}
-- 
1.9.1

