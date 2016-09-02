From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Fri, 2 Sep 2016 21:26:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609022119160.5647@nanos>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com> <4130556.MNmyvLDyHH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <4130556.MNmyvLDyHH@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "3.17+" <stable@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Aug 2016, Rafael J. Wysocki wrote:
> On Monday, August 29, 2016 12:40:39 AM Chen Yu wrote:
> > +
> > +	/*
> > +	 * Make rtc-based persistent clock unusable
> > +	 * if pm_trace is enabled, only take effect
> > +	 * for timekeeping_suspend/resume.
> > +	 */
> > +	if (pm_trace_is_enabled() &&
> > +	    x86_platform.get_wallclock == mach_get_cmos_time) {
> > +		ts->tv_sec = 0;
> > +		ts->tv_nsec = 0;
> > +	}
> 
> I'm not sure about this.  Looks hackish.

Indeed. Can't you just keep track that pm_trace fiddled with the cmos clock
and then discard the value either in the core or in mach_get_cmos_time()

Thanks,

	tglx
