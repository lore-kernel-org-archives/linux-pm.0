From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v5] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Sun, 4 Sep 2016 23:37:39 +0800
Message-ID: <20160904153739.GA5400@sharon>
References: <1472402439-1146-1-git-send-email-yu.c.chen@intel.com>
 <4130556.MNmyvLDyHH@vostro.rjw.lan>
 <alpine.DEB.2.20.1609022119160.5647@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18073 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbcIDP3n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Sep 2016 11:29:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1609022119160.5647@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org, John Stultz <john.stultz@linaro.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>, "3.17+" <stable@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

Hi Thomas, Rafael,
On Fri, Sep 02, 2016 at 09:26:51PM +0200, Thomas Gleixner wrote:
> On Wed, 31 Aug 2016, Rafael J. Wysocki wrote:
> > On Monday, August 29, 2016 12:40:39 AM Chen Yu wrote:
> > > +
> > > +	/*
> > > +	 * Make rtc-based persistent clock unusable
> > > +	 * if pm_trace is enabled, only take effect
> > > +	 * for timekeeping_suspend/resume.
> > > +	 */
> > > +	if (pm_trace_is_enabled() &&
> > > +	    x86_platform.get_wallclock == mach_get_cmos_time) {
> > > +		ts->tv_sec = 0;
> > > +		ts->tv_nsec = 0;
> > > +	}
> > 
> > I'm not sure about this.  Looks hackish.
> 
> Indeed. Can't you just keep track that pm_trace fiddled with the cmos clock
> and then discard the value either in the core or in mach_get_cmos_time()
The previous version is more straightforward, since
it ignored the bogus rtc in core. Would you please take
a glance at it too, thanks:
https://patchwork.kernel.org/patch/9287347/

Thanks,
Yu
