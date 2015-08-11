From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Tue, 11 Aug 2015 08:03:49 +0530
Message-ID: <20150811023349.GM5766@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32809 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbbHKCdx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 22:33:53 -0400
Received: by pabyb7 with SMTP id yb7so119015326pab.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 19:33:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55C9425B.4060207@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10-08-15, 17:31, Stephen Boyd wrote:
> I am not insisting anything. But another patch to get rid of the
> goto sounds fine.

The separate patch to kill goto.

---------------------8<-------------------------

Message-Id: <9f9b9ea6ea3685d5f71c132e7efb18917253961f.1439260355.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 11 Aug 2015 08:01:01 +0530
Subject: [PATCH] PM / OPP: Remove unnecessary goto statements

The code simply returns after jumping to the out label and doesn't free
any resources, etc.

Kill the unnecessary goto statements.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index f42e098b71fe..220e8d77e2c4 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1269,14 +1269,14 @@ static int _of_init_opp_table_v2(struct device *dev,
 {
 	struct device_node *np;
 	struct device_opp *dev_opp;
-	int ret = 0, count = 0;
+	int ret, count = 0;
 
 	dev_opp = _managed_opp(opp_np);
 	if (dev_opp) {
 		/* OPPs are already managed */
 		if (!_add_list_dev(dev, dev_opp))
-			ret = -ENOMEM;
-		goto out;
+			return -ENOMEM;
+		return 0;
 	}
 
 	/* We have opp-list node now, iterate over it and add OPPs */
@@ -1287,31 +1287,24 @@ static int _of_init_opp_table_v2(struct device *dev,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			break;
+			of_free_opp_table(dev);
+			return ret;
 		}
 	}
 
 	/* There should be one of more OPP defined */
 	if (WARN_ON(!count))
-		goto out;
-
-	if (ret) {
-		of_free_opp_table(dev);
-		goto out;
-	}
+		return -ENOENT;
 
 	dev_opp = _find_device_opp(dev);
-	if (WARN_ON(!dev_opp)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (WARN_ON(!dev_opp))
+		return -EINVAL;
 
 	dev_opp->np = opp_np;
 	dev_opp->shared_opp = of_property_read_bool(opp_np,
 			"opp-shared");
 
-out:
-	return ret;
+	return 0;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
