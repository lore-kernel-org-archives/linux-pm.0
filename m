From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Thu, 19 Nov 2015 08:30:56 +0530
Message-ID: <20151119030056.GM7336@ubuntu>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
 <c90cf734ae1cc009601a69cdcc744d412c7b9cfa.1447669859.git.viresh.kumar@linaro.org>
 <20151119011241.GK32672@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33721 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbbKSDBB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 22:01:01 -0500
Received: by pabfh17 with SMTP id fh17so67284319pab.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 19:01:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151119011241.GK32672@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 18-11-15, 17:12, Stephen Boyd wrote:
> > +	/* Operations on OPP structures must be done from within rcu locks */
> > +	rcu_read_lock();
> > +
> > +	dev_opp = _add_device_opp(dev);
> > +	if (!dev_opp)
> > +		return -ENOMEM;
> > +
> > +	/* Do we already have a prop-name associated with dev_opp? */
> > +	if (dev_opp->prop_name) {
> > +		dev_err(dev, "%s: Already have prop-name %s\n", __func__,
> > +			dev_opp->prop_name);
> > +		ret = -EINVAL;
> > +		goto unlock;
> > +	}
> > +
> > +	dev_opp->prop_name = kstrdup(name, GFP_KERNEL);
> 
> I'm very confused now on the whole locking scheme. How can we be
> modifying the dev_opp under an rcu_read_lock? Don't we need to
> hold a stronger lock than a read lock because _add_device_opp()
> has already published the structure we're modifying here?

Yeah, it should be called from within the mutex lock we have.

> How is cpufreq-dt going to be changed to support this?

Maybe not at all :)

> I wonder
> if it would be better to hide these sorts of things behind a
> wrapper on top of the guts of dev_pm_opp_of_add_table(). That way
> the lifetime of the prop_name and hw_versions are contained to
> the same lifetime rules as the device's OPP table. Right now it
> seems like we're asking OPP initializers to call two or three
> functions in the right order to get the table initialized
> properly, which is not as easy as calling one function.

Yeah, so things should happen in order, but the caller for the new
routines can't be cpufreq-dt (well it can be, but then some
information is required via platform data).

These routines are supposed to be called by some sort of platform
specific code, as we need to read some efuses from hardware to know
about all this. And cpufreq-dt can't decide that.

Though, to keep things simple, we can put that information in platform
data, so that only cpufreq-dt does all the stuff in the correct order.

We can always add a wrapper which will add hardware-versions,
named-properties and finally initialize opp table. But I would like to
wait a bit for that.

Now that I need to update 2/3 again, due to your comments on this
patch, I will repost this series again instead of messing up here.

-- 
viresh
