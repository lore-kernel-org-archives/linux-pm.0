From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 01/12] OPP: Free OPP table properly on performance state irregularities
Date: Wed, 19 Sep 2018 15:20:20 -0700
Message-ID: <2fbb8670b4ff4454f1c0de510f788d737edc4b90.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 18" <stable@vger.kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The OPP table was freed, but not the individual OPPs which is done from
_dev_pm_opp_remove_table(). Fix it by calling _dev_pm_opp_remove_table()
as well.

Cc: 4.18 <stable@vger.kernel.org> # v4.18
Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..20988c426650 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -425,6 +425,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
+		_dev_pm_opp_remove_table(opp_table, dev, false);
 		goto put_opp_table;
 	}
 
-- 
2.14.1
