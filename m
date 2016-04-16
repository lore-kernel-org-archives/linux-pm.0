From: Colin King <colin.king@canonical.com>
Subject: [PATCH] PM / clk: ensure we don't allocate a -ve size of count clks
Date: Sat, 16 Apr 2016 13:50:03 +0100
Message-ID: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41304 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcDPMuI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Apr 2016 08:50:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It is entirely possible for of_count_phandle_wit_args to
return a -ve error return value so we need to check for this
otherwise we end up allocating a negative number of clk objects.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 0e64a1b..3657ac1 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -159,7 +159,7 @@ int of_pm_clk_add_clks(struct device *dev)
 
 	count = of_count_phandle_with_args(dev->of_node, "clocks",
 					   "#clock-cells");
-	if (count == 0)
+	if (count <= 0)
 		return -ENODEV;
 
 	clks = kcalloc(count, sizeof(*clks), GFP_KERNEL);
-- 
2.7.4

