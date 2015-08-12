From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/2] PM / OPP: Fix static checker warning (broken 64bit big endian systems)
Date: Wed, 12 Aug 2015 16:30:19 +0530
Message-ID: <fac7aa53b304bbff1ff22f65670e05e5e6dc6396.1439376998.git.viresh.kumar@linaro.org>
References: <cover.1439376998.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439376998.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439376998.git.viresh.kumar@linaro.org>
References: <cover.1439376998.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, dan.carpenter@oracle.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Dan Carpenter reported (generated with static checker):

drivers/base/power/opp.c:949 _opp_add_static_v2()
warn: passing casted pointer '&new_opp->clock_latency_ns' to
'of_property_read_u32()' 64 vs 32.

This code will break on 64 bit, big endian machines.

Fix this by reading the value in a u32 type variable first and then
assigning it to the unsigned long variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 4d6c4576f7ae..72dc59248876 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -918,6 +918,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
 	u64 rate;
+	u32 val;
 	int ret;
 
 	/* Hold our list modification lock here */
@@ -946,14 +947,15 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	new_opp->np = np;
 	new_opp->dynamic = false;
 	new_opp->available = true;
-	of_property_read_u32(np, "clock-latency-ns",
-			     (u32 *)&new_opp->clock_latency_ns);
+	of_property_read_u32(np, "clock-latency-ns", &val);
+	new_opp->clock_latency_ns = val;
 
 	ret = opp_get_microvolt(new_opp, dev);
 	if (ret)
 		goto free_opp;
 
-	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
+	of_property_read_u32(np, "opp-microamp", &val);
+	new_opp->u_amp = val;
 
 	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
-- 
2.4.0
