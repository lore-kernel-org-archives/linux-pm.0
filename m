From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Thu, 18 Aug 2016 14:06:41 +0200
Message-ID: <20160818120641.GA12732@amd>
References: <cover.1470908324.git.yu.c.chen@intel.com>
 <20160811185441.GA15813@amd>
 <20160812025225.GA12238@sharon>
 <20160812063312.GD30992@amd>
 <CAJZ5v0jgiPsSV3ZRVeM+D7KD7wJudPD+0Fq0BoJGT1mZ3yryxg@mail.gmail.com>
 <20160817034347.GA15682@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55807 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcHRMGp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 08:06:45 -0400
Content-Disposition: inline
In-Reply-To: <20160817034347.GA15682@sharon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

On Wed 2016-08-17 11:43:48, Chen Yu wrote:
> On Fri, Aug 12, 2016 at 01:25:04PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 12, 2016 at 8:33 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > >> > > Recently we have a new report that, the harddisk can not
> > >> > > resume on time due to firmware issues, and got a kernel
> > >> > > panic because of DPM watchdog timeout. Since the default
> > >> > > timeout has once been modified from 12 to 60 seconds, we
> > >> > > might still encounter new case which requires a longer timeout,
> > >> > > so expose the value to sysfs and let the users decide which
> > >> > > value is appropriate, meanwhile this can also ease the debugging
> > >> > > process.
> > >> > >
> > >> > > The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
> > >> > > thus the second patch which does the actual work, can use
> > >> > > CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.
> > >> >
> > >> > Kernel should just work. User should not have to configure random
> > >> > knobs to have working suspend/hibernation.
> > >> >
> > >> > We do not want "CONFIG_BREAK_SUSPEND" so I believe we don't want
> > >> > "CONFIG_DPM_WATCHDOG". If normal users select it and it breaks their
> > >> > system, make it depend on "CONFIG_EXPERT" or hide it in some other
> > >> > way or maybe remove it from Kconfig altogether.
> > >> >
> > >> > Or maybe CONFIG_DPM_WATCHDOG should contain numeric value that user
> > >> > has to select?
> > >> >
> > >> Yes, if people select it then they have the risk to break their system,
> > >> and the original thought of the patch is to behave like a diagnosis to
> > >> make it easier for the users to figure it out, how much time it takes
> > >> to suspend/resume a bogus peripheral, without recomping the kernel.
> > >> -- currently the timeout value for CONFIG_DPM_WATCHDOG can be adjusted
> > >> by menuconfig, but bug reporter might have to recompile the kernel
> > >> to confirm, and it takes some time to get a feedback from them, so...
> > >
> > > Please don't add sysfs knobs for this. People should not need to
> > > adjust sysfs files to get working kernel.
> > >
> > > You can for example make the default 120 seconds.
> > 
> > Plus, IMO it would be good to be able to disable this thing from the
> > kernel command line entirely in case 2 minutes is still too little
> > time for somebody.
> >
> OK, I've modified the patch to the following version, Rafael, Pavel could
> you take a glance at it, thanks:

Certainly looks better.

> Index: linux/kernel/power/Kconfig
> ===================================================================
> --- linux.orig/kernel/power/Kconfig
> +++ linux/kernel/power/Kconfig
> @@ -197,7 +197,7 @@ config DPM_WATCHDOG
>  config DPM_WATCHDOG_TIMEOUT
>  	int "Watchdog timeout in seconds"
>  	range 1 120
> -	default 60
> +	default 120
>  	depends on DPM_WATCHDOG
>

I like this part.

> +++ linux/Documentation/kernel-parameters.txt
> @@ -2749,6 +2749,8 @@ bytes respectively. Such letter suffixes
>  	nowatchdog	[KNL] Disable both lockup detectors, i.e.
>                          soft-lockup and NMI watchdog (hard-lockup).
>  
> +	no_dpm_watchdog	[KNL] Disable the device suspend/resume watchdog.
> +
>  	nowb		[ARM]
>  
>  	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.

Do we really need the new cmdline option? Can we just tell people to
disable DPM_WATCHDOG completely?

Is there reason to keep the DPM_WATCHDOG? Did it find some real bugs
lately?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
