From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Mon, 5 Sep 2016 09:54:20 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609050941180.5647@nanos>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com> <4130556.MNmyvLDyHH@vostro.rjw.lan> <alpine.DEB.2.20.1609022119160.5647@nanos> <20160904153739.GA5400@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160904153739.GA5400@sharon>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "3.17+" <stable@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 4 Sep 2016, Chen Yu wrote:
> Hi Thomas, Rafael,
> On Fri, Sep 02, 2016 at 09:26:51PM +0200, Thomas Gleixner wrote:
> > On Wed, 31 Aug 2016, Rafael J. Wysocki wrote:
> > > On Monday, August 29, 2016 12:40:39 AM Chen Yu wrote:
> > > > +
> > > > +	/*
> > > > +	 * Make rtc-based persistent clock unusable
> > > > +	 * if pm_trace is enabled, only take effect
> > > > +	 * for timekeeping_suspend/resume.
> > > > +	 */
> > > > +	if (pm_trace_is_enabled() &&
> > > > +	    x86_platform.get_wallclock == mach_get_cmos_time) {
> > > > +		ts->tv_sec = 0;
> > > > +		ts->tv_nsec = 0;
> > > > +	}
> > > 
> > > I'm not sure about this.  Looks hackish.
> > 
> > Indeed. Can't you just keep track that pm_trace fiddled with the cmos clock
> > and then discard the value either in the core or in mach_get_cmos_time()
> The previous version is more straightforward, since
> it ignored the bogus rtc in core. Would you please take
> a glance at it too, thanks:
> https://patchwork.kernel.org/patch/9287347/

This is the same hackery just different:

> +bool persistent_clock_is_usable(void)
> +{
> +	/* Unusable if pm_trace is enabled. */
> +	return !((x86_platform.get_wallclock == mach_get_cmos_time) &&
> +	        pm_trace_is_enabled());
> +}

I really have no idea why this is burried in x86 land. The pm_trace hackery
issues mc146818_set_time() to fiddle with the RTC. So any implementation of
this is affected.

So that very piece of pmtrace code should keep track of the wreckage it did
to the RTC and provide the fact to the core timekeeping code which can then
skip the update.

Thanks,

	tglx
