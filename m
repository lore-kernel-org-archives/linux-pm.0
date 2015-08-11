From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Tue, 11 Aug 2015 12:27:38 +0530
Message-ID: <20150811065738.GE5147@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
 <20150811022546.GL5766@linux>
 <20150811060855.GH9678@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32816 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933728AbbHKG5p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:57:45 -0400
Received: by pabyb7 with SMTP id yb7so123739646pab.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 23:57:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811060855.GH9678@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10-08-15, 23:08, Stephen Boyd wrote:
> On 08/11, Viresh Kumar wrote:
> > On 10-08-15, 17:31, Stephen Boyd wrote:
> > > So ret is 0. I thought it was an error path, but I guess this is a
> > > warning path and we return 0 still?
> > 
> > Urg ..
> 
> Oh I see this is an existing problem... Same problem goes for the
> count check. It may be better to fix those two cases first and
> then do this cleanup. But I don't mind either way.

-------------------------8<-------------------------
Message-Id: <b2d2d842165ec1748a56ecc03b85bd89321a644b.1439276231.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 11 Aug 2015 12:22:07 +0530
Subject: [PATCH] PM / OPP: Return proper errors on failure

We are returning 0 by mistake, fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1daaa1a418a2..be3356a3a452 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1292,14 +1292,18 @@ static int _of_init_opp_table_v2(struct device *dev,
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto out;
+	}
 
 	if (!ret) {
 		if (!dev_opp) {
 			dev_opp = _find_device_opp(dev);
-			if (WARN_ON(!dev_opp))
+			if (WARN_ON(!dev_opp)) {
+				ret = -ENOENT;
 				goto out;
+			}
 		}
 
 		dev_opp->np = opp_np;
