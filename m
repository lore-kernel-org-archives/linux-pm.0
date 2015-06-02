From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/6] regulator: core: Print at debug level on debugfs creation failure
Date: Mon,  1 Jun 2015 18:47:55 -0700
Message-ID: <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57814 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbbFBBsC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 21:48:02 -0400
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>

Failure to create a debugfs node is not an error, but we print a
warning upon failure to create the node. Downgrade this to a
debug printk so that we're quiet here. This allows multiple
drivers to request a CPU's regulator so that CPUfreq and AVSish
drivers can coexist.

The downside of this approach is that whoever gets to debugfs first
the others who come later to not have any debugfs attributes associated
with them.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f6989485c382..9dba0a3d4526 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1208,7 +1208,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->debugfs = debugfs_create_dir(regulator->supply_name,
 						rdev->debugfs);
 	if (!regulator->debugfs) {
-		rdev_warn(rdev, "Failed to create debugfs directory\n");
+		rdev_dbg(rdev, "Failed to create debugfs directory\n");
 	} else {
 		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
 				   &regulator->uA_load);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

