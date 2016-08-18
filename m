From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v4] timekeeping: ignore the bogus sleep time if
 pm_trace is enabled
Date: Thu, 18 Aug 2016 19:24:34 +0800
Message-ID: <20160818112434.GA15646@sharon>
References: <1471517019-15216-1-git-send-email-yu.c.chen@intel.com>
 <1471516611.2157.22.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46140 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbcHRLSA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Aug 2016 07:18:00 -0400
Content-Disposition: inline
In-Reply-To: <1471516611.2157.22.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Xunlei Pang <xlpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

Hi Oliver,
On Thu, Aug 18, 2016 at 12:36:51PM +0200, Oliver Neukum wrote:
> On Thu, 2016-08-18 at 18:43 +0800, Chen Yu wrote:
> > Previously we encountered some memory overflow issues due to
> > the bogus sleep time brought by inconsistent rtc, which is
> > triggered when pm_trace is enabled, please refer to:
> > https://patchwork.kernel.org/patch/9286365/
> > It's improper in the first place to call __timekeeping_inject_sleeptime()
> > in case that pm_trace is enabled simply because that "hash" time value
> > will wreckage the timekeeping subsystem.
> 
> Hi,
> 
> do you know since when this bug exists?
> 
I think as Xunlei mentioned, the memory overflow issue should exist since
we changed timespec to timespec64 in timekeeping_debug, which should be
in 3.17. But the bogus sleep time caused by pm_trace should always be there as
long as we use rtc for sleep compensation.
> >  /**
> > @@ -1662,6 +1668,12 @@ void timekeeping_resume(void)
> >  	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
> >  		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
> >  		sleeptime_injected = true;
> > +		/*
> > +		 * If rtc is used as persist clock thus it
> > +		 * would be bogus when pm_trace is enabled.
> > +		 */
> > +		if (!persistent_clock_is_usable())
> > +			sleeptime_injected = false;
> >  	}
> >  
> >  	if (sleeptime_injected)
> 
> How about
> 
> sleeptime_injected = persistent_clock_is_usable();
> 
OK, this is simpler, will do in next version.

thanks,
Yu
> 
