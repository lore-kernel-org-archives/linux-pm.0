From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/6] PM / OPP: Move opp core to its own directory
Date: Tue, 11 Aug 2015 05:55:06 +0530
Message-ID: <20150811002506.GE5766@linux>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <6dcf599b49886fd5a2157f2e61f7424cc754b6f0.1439187821.git.viresh.kumar@linaro.org>
 <20150810195142.GF9678@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35218 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831AbbHKAZK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 20:25:10 -0400
Received: by pacgr6 with SMTP id gr6so37350359pac.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 17:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150810195142.GF9678@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10-08-15, 12:51, Stephen Boyd wrote:
> On 08/10, Viresh Kumar wrote:
> > diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> > index f94a6ccfe787..7ff2726dab6c 100644
> > --- a/drivers/base/power/Makefile
> > +++ b/drivers/base/power/Makefile
> > @@ -1,8 +1,8 @@
> >  obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
> >  obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
> >  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
> > -obj-$(CONFIG_PM_OPP)	+= opp.o
> >  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
> >  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
> > +obj-$(CONFIG_PM_OPP)	+= opp/
> >  
> Any reason this moved from the previous location?

So that all the direct file compilation lines stay at the top and the
directory thing at the bottom. Just that order, nothing else.

> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
viresh
