From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] OPP: Fix parsing of multiple phandles in "operating-points-v2" property
Date: Fri, 23 Nov 2018 10:47:30 +0530
Message-ID: <3e27c79c4b121a64e85f26ab8957e5d0a09ff28e.1542950247.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We currently return error if more than one phandle is present in the
"operating-points-v2" property, which is incorrect. We only want to
check the count of phandles here and set index to 0 if only one phandle
is present.

Fix it.

Fixes: 5ed4cecd75e9 ("OPP: Pass OPP table to _of_add_opp_table_v{1|2}()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 5a4b47958073..38a08805a30c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -579,10 +579,8 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 		 */
 		count = of_count_phandle_with_args(dev->of_node,
 						   "operating-points-v2", NULL);
-		if (count != 1)
-			return -ENODEV;
-
-		index = 0;
+		if (count == 1)
+			index = 0;
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
-- 
2.19.1.568.g152ad8e3369a
