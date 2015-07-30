From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
Date: Thu, 30 Jul 2015 15:47:37 +0530
Message-ID: <20150730101737.GB9121@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976>
 <20150727030239.GG19944@linux>
 <55B80A34.1010805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32935 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbG3KRo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 06:17:44 -0400
Received: by padck2 with SMTP id ck2so21429588pad.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 03:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55B80A34.1010805@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, mturquette@baylibre.com, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 28-07-15, 16:03, Stephen Boyd wrote:
> There is talk about moving to 64 bits for the frequency in the clk API.
> It's not actively being developed though and I'm not sure when we'll get
> there. From a DT perspective though, I don't see why it would be bad to
> have two cells instead of one cell for the frequency here. It would
> allow up to 64 bits of frequency so that when we change the clk API we
> won't need to do anything in the OPP bindings to handle it. Just because
> we have problems in the kernel doesn't mean we should put the same
> problems into DT.

Updated the code as:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d9ebbd739b23..73e4e1ce60a1 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -743,6 +743,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 {
        struct device_opp *dev_opp;
        struct dev_pm_opp *new_opp;
+       u64 rate;
        int ret;
 
        /* Hold our list modification lock here */
@@ -754,12 +755,18 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
                goto unlock;
        }
 
-       ret = of_property_read_u32(np, "opp-hz", (u32 *)&new_opp->rate);
+       ret = of_property_read_u64(np, "opp-hz", &rate);
        if (ret < 0) {
                dev_err(dev, "%s: opp-hz not found\n", __func__);
                goto free_opp;
        }
 
+       /*
+        * Rate is defined as an unsigned long in clk API, and so casting
+        * explicitly to its type. Must be fixed once rate is 64 bit
+        * guaranteed in clk API.
+        */
+       new_opp->rate = (unsigned long)rate;
        new_opp->turbo = of_property_read_bool(np, "turbo-mode");
 
        new_opp->np = np;


-- 
viresh
