From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Fri, 27 Nov 2015 10:15:17 +0530
Message-ID: <20151127044517.GU3869@ubuntu>
References: <cover.1447904566.git.viresh.kumar@linaro.org>
 <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
 <20151125205147.GE11298@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34337 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbK0EpW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 23:45:22 -0500
Received: by padhx2 with SMTP id hx2so103192597pad.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2015 20:45:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151125205147.GE11298@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 25-11-15, 12:51, Stephen Boyd wrote:
> > +int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versions,
> > +				unsigned int count)
> > +{
> > +	struct device_opp *dev_opp;
> > +	int ret = 0;
> > +
> > +	/* Hold our list modification lock here */
> > +	mutex_lock(&dev_opp_list_lock);
> > +
> > +	dev_opp = _add_device_opp(dev);
> 
> So this function will publish an opp to the list...

Not an opp but opp-dev.

> > +	if (!dev_opp) {
> > +		ret = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	/* Do we already have a version hierarchy associated with dev_opp? */
> > +	if (dev_opp->supported_hw) {
> > +		dev_err(dev, "%s: Already have supported hardware list\n",
> > +			__func__);
> > +		ret = -EBUSY;
> > +		goto err;
> > +	}
> > +
> > +	dev_opp->supported_hw = kmemdup(versions, count * sizeof(*versions),
> > +					GFP_KERNEL);
> 
> And then we're going to modify said opp here under the mutex
> lock.

opp-dev ..

> > +	if (!dev_opp->supported_hw) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	dev_opp->supported_hw_count = count;
> 
> So we've properly handled the concurrent writer case (which is
> probably not even real), but we have improperly handled the case
> where a reader is running in parallel to the writer. We should
> only list_add_rcu the pointer once we're done modifying the
> pointer we created. Otherwise a reader can come along and see the
> half initialized structure, which is not good.

This function will be called, from some platform code, before the OPP
table is initialized. It isn't useful to call it after the OPPs are
added for the device. So there wouldn't be any concurrent reader.

> I'm worried that the RCU locking is messed up in other places in
> this file now too. Hopefully not, but it's going to require an
> audit.

I do share your concern.. But this stuff should be okay. Even the
other patch as well.

-- 
viresh
