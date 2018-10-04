From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] OPP: Return error on error from dev_pm_opp_get_opp_count()
Date: Thu,  4 Oct 2018 09:46:21 +0530
Message-ID: <09f662f95306f3e3d47ab6842bc4b0bb868a80ad.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org, d-gerlach@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Return error number instead of 0 on failures.

Fixes: a1e8c13600bf ("PM / OPP: "opp-hz" is optional for power domains")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cdf918aaac34..2c2df4e4fc14 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -318,7 +318,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 		count = PTR_ERR(opp_table);
 		dev_dbg(dev, "%s: OPP table not found (%d)\n",
 			__func__, count);
-		return 0;
+		return count;
 	}
 
 	count = _get_opp_count(opp_table);
-- 
2.18.0.rc1.242.g61856ae69a2c
