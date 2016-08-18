From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Thu, 18 Aug 2016 20:42:38 +0200
Message-ID: <20160818184238.GA25515@amd>
References: <cover.1470908324.git.yu.c.chen@intel.com>
 <20160811185441.GA15813@amd>
 <20160812025225.GA12238@sharon>
 <20160812063312.GD30992@amd>
 <CAJZ5v0jgiPsSV3ZRVeM+D7KD7wJudPD+0Fq0BoJGT1mZ3yryxg@mail.gmail.com>
 <20160817034347.GA15682@sharon>
 <20160818120641.GA12732@amd>
 <36DF59CE26D8EE47B0655C516E9CE6402878801E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46945 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbcHSBts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 21:49:48 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402878801E@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

Hi!

> > > OK, I've modified the patch to the following version, Rafael, Pavel
> > > could you take a glance at it, thanks:
> > 
> > Certainly looks better.
> > 
> > > Index: linux/kernel/power/Kconfig
> > >
> > ================================================================
> > ===
> > > --- linux.orig/kernel/power/Kconfig
> > > +++ linux/kernel/power/Kconfig
> > > @@ -197,7 +197,7 @@ config DPM_WATCHDOG  config
> > DPM_WATCHDOG_TIMEOUT
> > >  	int "Watchdog timeout in seconds"
> > >  	range 1 120
> > > -	default 60
> > > +	default 120
> > >  	depends on DPM_WATCHDOG
> > >
> > 
> > I like this part.
> > 
> > > +++ linux/Documentation/kernel-parameters.txt
> > > @@ -2749,6 +2749,8 @@ bytes respectively. Such letter suffixes
> > >  	nowatchdog	[KNL] Disable both lockup detectors, i.e.
> > >                          soft-lockup and NMI watchdog (hard-lockup).
> > >
> > > +	no_dpm_watchdog	[KNL] Disable the device suspend/resume
> > watchdog.
> > > +
> > >  	nowb		[ARM]
> > >
> > >  	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
> > 
> > Do we really need the new cmdline option? Can we just tell people to disable
> > DPM_WATCHDOG completely?
> > 
> > Is there reason to keep the DPM_WATCHDOG? Did it find some real bugs lately?
> > 
> We can tell users to disable the DPM_WATCHDOG, maybe some android people would like
> to use this feature to track/confirm hardware/firmware issues.
> I'm ok with only adjusting the timeout from 60 to 120. 

I believe that's the best solution for now. (Android people often
claim commandline is hard for them to use...)

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
