From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Change behaviour when tracing ... nasty trap (was Re: [PATCH] PM/Trace: get rid of synchronous resume limit during PM trace)
Date: Fri, 30 Jan 2015 01:53:25 +0100
Message-ID: <6553656.pcJl3UFpb6@vostro.rjw.lan>
References: <54C5CB77.4000109@linux.intel.com> <2718950.eck1siDzqK@vostro.rjw.lan> <20150126134304.GA7889@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52918 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751609AbbA3Aai (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 19:30:38 -0500
In-Reply-To: <20150126134304.GA7889@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Liu, Chuansheng" <chuansheng.liu@intel.com>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, trivial@kernel.org

On Monday, January 26, 2015 02:43:04 PM Pavel Machek wrote:
> Document pm_tracing actually affecting suspend in non-trivial way.
> 
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> On Mon 2015-01-26 14:41:02, Rafael J. Wysocki wrote:
> > On Monday, January 26, 2015 12:05:16 PM Pavel Machek wrote:
> > > On Mon 2015-01-26 10:39:04, Liu, Chuansheng wrote:
> 
> > > > > > @@ -517,8 +517,7 @@ static int device_resume_noirq(struct device *dev,
> > > > > pm_message_t state, bool asyn
> > > > > >
> > > > > >  static bool is_async(struct device *dev)
> > > > > >  {
> > > > > > -	return dev->power.async_suspend && pm_async_enabled
> > > > > > -		&& !pm_trace_is_enabled();
> > > > > > +	return dev->power.async_suspend && pm_async_enabled;
> > > > > >  }
> > > > > >
> > > > > 
> > > > > Actually... whoever did the original patch was evil person. Changing
> > > > > behaviour when tracing is requested is evil, evil, evil. Git blame
> > > > > tells me
> > > > > 
> > > > > Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> > > > > 
> > > > > went to the dark side.
> > > > 
> > > > Although I didn't get where is something wrong, but the is_async() is not created by my commit,
> > > > it is from commit (PM: Start asynchronous resume threads upfront), I just moved it ahead.
> > > > 
> > > > And like other phases, I added it into resum/suspend_noirq()...
> > > 
> > > I see, blame blamed wrong person. It looks like Rafael is evil:
> > > 
> > > commit 97df8c12995c5bac73e3bfeea4c5be155c1f4401
> > > Author: Rafael J. Wysocki <rjw@sisk.pl>
> > > Date:   Sat Jan 23 22:25:31 2010 +0100
> > > 
> > >     PM: Start asynchronous resume threads upfront
> > 
> > This only means we won't use asyc suspend/resume at all when the RTC-based
> > resume debug is enabled, because it wouldn't make sense (the RTC-based
> > debug requires strict ordering of callbacks between devices or we may find
> > that device A hanged the resume while actually device B that was running in
> > parallel with A did that).
> > 
> > And I shouldn't even need to explain this ...  Sad.
> 
> Well, I forgot that pm_trace_is_enabled() is the simple, RTC based
> one, and believe it would be worth a comment...

A comment won't hurt. :-)

Applied, thanks!

> diff --git a/Documentation/power/s2ram.txt b/Documentation/power/s2ram.txt
> index 1bdfa04..4685aee 100644
> --- a/Documentation/power/s2ram.txt
> +++ b/Documentation/power/s2ram.txt
> @@ -69,6 +69,10 @@ Reason for this is that the RTC is the only reliably available piece of
>  hardware during resume operations where a value can be set that will
>  survive a reboot.
>  
> +pm_trace is not compatible with asynchronous suspend, so it turns
> +asynchronous suspend off (which may work around timing or
> +ordering-sensitive bugs).
> +
>  Consequence is that after a resume (even if it is successful) your system
>  clock will have a value corresponding to the magic number instead of the
>  correct date/time! It is therefore advisable to use a program like ntp-date
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
