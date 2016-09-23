From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/2] PM / OPP: compatible string is not optional
Date: Fri, 23 Sep 2016 12:18:01 +0530
Message-ID: <94d3439d2942831fe933f0b5e08baaf4a7ba087d.1474613134.git.viresh.kumar@linaro.org>
References: <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The OPP core code doesn't check for the compatible string today and any
faulty binding will go unnoticed.

Add a check in OPP core to take care of that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This patch replaces: "[PATCH 1/2] PM / OPP: compatible is an optional
property".

FWIW, I have checked that none of the current users of
operating-points-v2 had this problem and this patch can be merged
safely.

 drivers/base/power/opp/of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 1dfd3dd92624..111a5cad9f8a 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -318,6 +318,11 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 	struct opp_table *opp_table;
 	int ret = 0, count = 0;
 
+	if (!of_device_is_compatible(opp_np, "operating-points-v2")) {
+		dev_err(dev, "Not compatible with operating-points-v2\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&opp_table_lock);
 
 	opp_table = _managed_opp(opp_np);
-- 
2.7.1.410.g6faf27b
