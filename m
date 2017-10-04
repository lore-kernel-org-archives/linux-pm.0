From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Add missing of_node_put(np)
Date: Wed,  4 Oct 2017 11:35:03 +0530
Message-ID: <3a82b2d3311e16f0f638de18bf0ee803540014a3.1507096875.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44075 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdJDGFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 02:05:11 -0400
Received: by mail-pg0-f50.google.com with SMTP id b1so4485056pge.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 23:05:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Tobias Jordan <Tobias.Jordan@elektrobit.com>, "4 . 3+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
doesn't drop the reference to "np" on errors. Fix that.

Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
Cc: 4.3+ <stable@vger.kernel.org> # 4.3+
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
[ VK: Improved commit log. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 0b718886479b..87509cb69f79 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -397,6 +397,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			_dev_pm_opp_remove_table(opp_table, dev, false);
+			of_node_put(np);
 			goto put_opp_table;
 		}
 	}
-- 
2.14.1.202.g24db08a6e8fe
