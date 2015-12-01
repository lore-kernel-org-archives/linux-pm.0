From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Tue, 1 Dec 2015 12:22:52 +0530
Message-ID: <20151201065252.GD4459@ubuntu>
References: <cover.1447904566.git.viresh.kumar@linaro.org>
 <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
 <20151125205147.GE11298@codeaurora.org>
 <20151127044517.GU3869@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33553 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbbLAGxD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 01:53:03 -0500
Received: by pabfh17 with SMTP id fh17so218287724pab.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 22:53:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151127044517.GU3869@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 27-11-15, 10:15, Viresh Kumar wrote:
> > > +	dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
> > > +					GFP_KERNEL);
> > 
> > And then we're going to modify said opp here under the mutex
> > lock.
> 
> opp-dev ..
> 
> > > +	if (!dev_opp->supported_hw) {
> > > +		ret = -ENOMEM;
> > > +		goto err;
> > > +	}
> > > +
> > > +	dev_opp->supported_hw_count = count;
> > 
> > So we've properly handled the concurrent writer case (which is
> > probably not even real), but we have improperly handled the case
> > where a reader is running in parallel to the writer. We should
> > only list_add_rcu the pointer once we're done modifying the
> > pointer we created. Otherwise a reader can come along and see the
> > half initialized structure, which is not good.
> 
> This function will be called, from some platform code, before the OPP
> table is initialized. It isn't useful to call it after the OPPs are
> added for the device. So there wouldn't be any concurrent reader.

Since these functions are *only* going to be called before any OPPs
are added for the device, and hence ruling out any concurrent readers,
maybe we can guarantee that with this:

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 5449bae74a44..ec74d98afe75 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -876,6 +876,9 @@ int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
                goto err;
        }
 
+       /* Make sure there are no concurrent readers while updating dev_opp */
+       WARN_ON(!list_empty(&dev_opp->opp_list));
+
        dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
                                        GFP_KERNEL);
        if (!dev_opp->supported_hw) {
@@ -924,6 +927,9 @@ void dev_pm_opp_put_supported_hw(struct device *dev)
                goto unlock;
        }
 
+       /* Make sure there are no concurrent readers while updating dev_opp */
+       WARN_ON(!list_empty(&dev_opp->opp_list));
+
        if (!dev_opp->supported_hw) {
                dev_err(dev, "%s: Doesn't have supported hardware list\n",
                        __func__);


I don't really want to create a duplicate dev_opp here and then
replace that in the list, because we know that we have just created
it.

Over that, if a reference to dev_opp is used somewhere else, lets say
within the pm_opp structure, then updating all OPPs at such times
would be really hard.

Lets close this before you go for vacations. I will get whatever
solution you feel is right.

-- 
viresh
