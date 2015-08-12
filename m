From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PM / OPP: Add clock-latency-ns support
Date: Wed, 12 Aug 2015 12:27:09 +0530
Message-ID: <20150812065709.GM32049@linux>
References: <20150810163804.GA10496@mwanda>
 <20150811081228.GC5509@linux>
 <20150811135122.GL5096@mwanda>
 <20150811185421.GM2839@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34306 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbHLG5Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 02:57:25 -0400
Received: by pdbfa8 with SMTP id fa8so4155564pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 23:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811185421.GM2839@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org

On 11-08-15, 11:54, Stephen Boyd wrote:
> Making it portable should be simple enough by having a temporary
> variable of type u32 though.

Right.

@Dan: Does this look fine to you?

Message-Id: <40b3ad3c99c5fe1c50d997ba5418dd602c673f13.1439362565.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 12 Aug 2015 12:20:49 +0530
Subject: [PATCH] PM / OPP: Fix static checker warning (broken 64bit big endian
 systems)

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
index 204c6c945168..a9e0af0dd9e5 100644
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
