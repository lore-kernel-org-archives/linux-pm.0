From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/2] PM / OPP: Fix static checker warning (broken 64bit big endian systems)
Date: Mon, 17 Aug 2015 19:20:20 +0530
Message-ID: <0a41aca3107cea2d9fac3f4536e5c7f4acd90f7d.1439818955.git.viresh.kumar@linaro.org>
References: <fac7aa53b304bbff1ff22f65670e05e5e6dc6396.1439376998.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34650 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbHQNu0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 09:50:26 -0400
Received: by pdbfa8 with SMTP id fa8so56130258pdb.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2015 06:50:25 -0700 (PDT)
In-Reply-To: <fac7aa53b304bbff1ff22f65670e05e5e6dc6396.1439376998.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, dan.carpenter@oracle.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

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
V3->V4:
- Assign values only if of_property_read_u32() is successful.

 drivers/base/power/opp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 4d6c4576f7ae..803d8b7ced89 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -918,6 +918,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
 	u64 rate;
+	u32 val;
 	int ret;
 
 	/* Hold our list modification lock here */
@@ -946,14 +947,16 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	new_opp->np = np;
 	new_opp->dynamic = false;
 	new_opp->available = true;
-	of_property_read_u32(np, "clock-latency-ns",
-			     (u32 *)&new_opp->clock_latency_ns);
+
+	if (!of_property_read_u32(np, "clock-latency-ns", &val))
+		new_opp->clock_latency_ns = val;
 
 	ret = opp_get_microvolt(new_opp, dev);
 	if (ret)
 		goto free_opp;
 
-	of_property_read_u32(np, "opp-microamp", (u32 *)&new_opp->u_amp);
+	if (!of_property_read_u32(new_opp->np, "opp-microamp", &val))
+		new_opp->u_amp = val;
 
 	ret = _opp_add(dev, new_opp, dev_opp);
 	if (ret)
-- 
2.4.0

