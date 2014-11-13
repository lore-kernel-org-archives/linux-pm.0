From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Remove architecture specific menu entries
Date: Thu, 13 Nov 2014 23:17:38 +0100
Message-ID: <1453735.aQt8yDaY5N@vostro.rjw.lan>
References: <92d6fb45a43b8d800cbcdf690bbf6f8e4713b95e.1415765396.git.viresh.kumar@linaro.org> <1415843008.15957.45.camel@freescale.com> <CAKohpokMgHNUWX8s9Vfow+JdRsnF3LDpS4Erqks5RznyXDDBFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52649 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933492AbaKMV4m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 16:56:42 -0500
In-Reply-To: <CAKohpokMgHNUWX8s9Vfow+JdRsnF3LDpS4Erqks5RznyXDDBFw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Scott Wood <scottwood@freescale.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yuantian Tang <Yuantian.Tang@freescale.com>

On Thursday, November 13, 2014 10:56:53 AM Viresh Kumar wrote:
> On 13 November 2014 07:13, Scott Wood <scottwood@freescale.com> wrote:
> > On Thu, 2014-11-13 at 02:47 +0100, Rafael J. Wysocki wrote:
> >> On Wednesday, November 12, 2014 09:40:43 AM Viresh Kumar wrote:
> >> > CPUFreq driver's Kconfig entries are added in Kconfig.<arch> files and they are
> >> > all included from the main Kconfig file using a menu entry. This creates another
> >> > level of (unnecessary) hierarchy within the menuconfig entries.
> >> >
> >> > The problem occurs when there are drivers usable across architectures. Either
> >> > their config entry is duplicated in all the supported architectures or is put
> >> > into the main Kconfig entry. With the later one, we have menuconfig entries for
> >> > drivers at two levels then.
> >> >
> >> > Fix these issues by getting rid of another level of menuconfig entries and
> >> > populate all drivers within the main cpufreq menu.
> >>
> >> Won't this be confusing?
> >
> > Why would it be confusing?  It's already in a not-too-large "CPU
> > Frequency scaling" menu, the names of the individual options should be
> > clear enough, and they'd all be grouped at the end of the menu.
> >
> > FWIW, there's already "Generic DT based cpufreq driver" under that menu.
> >
> >> Can we at least have a "CPU frequency scaling drivers" menu for drivers
> >> the *contents* of which will depend on the architecture?
> >
> > That works too -- I just don't see the confusion aspect.
> 
> After thinking a bit about the concerns raised by both of you, I decided to look
> at what others are doing about this. And this is the best I came around:
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index a24d678..230a912 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -183,6 +183,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
> 
>           If in doubt, say N.
> 
> +comment "CPU frequency scaling drivers"
> +
>  config CPUFREQ_DT
>         tristate "Generic DT based cpufreq driver"
>         depends on HAVE_CLK && OF
> 
> 
> And this is how it looks in menuconfig now:
> 
>         [*] CPU Frequency scaling
>         <*>   CPU frequency translation statistics (NEW)
>         [ ]     CPU frequency translation statistics details (NEW)
>               Default CPUFreq governor (performance)  --->
>         -*-   'performance' governor
>         < >   'powersave' governor (NEW)
>         < >   'userspace' governor for userspace frequency scaling
> (NEW)
>         < >   'ondemand' cpufreq policy governor (NEW)
>         < >   'conservative' cpufreq governor (NEW)
>               *** CPU frequency scaling drivers ***
>         < >   Generic DT based cpufreq driver (NEW)
>         < >   Generic ARM big LITTLE CPUfreq driver (NEW)
>         [*]   SAMSUNG EXYNOS4210 (NEW)
>         [*]   SAMSUNG EXYNOS4x12 (NEW)
>         [*]   SAMSUNG EXYNOS5250 (NEW)
>         [*]   SAMSUNG EXYNOS5440 (NEW)
>         [ ]   EXYNOS Frequency Overclocking - Software (NEW)
> 
> 
> Good enough ?

Yes, that works too.

That "EXYNOS Frequency Overclocking" item looks odd, but that's a different
matter ...


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
