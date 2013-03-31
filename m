From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: How to facilitate the cpuidle drivers to go to the same direction (Was: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization)
Date: Sun, 31 Mar 2013 13:14:15 +0200
Message-ID: <9490525.431L1KFHfz@vostro.rjw.lan>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <5155AEE7.106@ti.com> <5155B85F.6030808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48583 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab3CaLGp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 31 Mar 2013 07:06:45 -0400
In-Reply-To: <5155B85F.6030808@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Amit Kucheria <amit.kucheria@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Olof Johansson <olof@lixom.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, swarren@wwwdotorg.org, Patch Tracking <patches@linaro.org>, linux-pm@vger.kernel.org, "Nori, Sekhar" <nsekhar@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, benh@kernel.crashing.org, lethal@linux-sh.org

On Friday, March 29, 2013 04:50:55 PM Daniel Lezcano wrote:
> On 03/29/2013 04:10 PM, Santosh Shilimkar wrote:
> > On Friday 29 March 2013 06:20 PM, Amit Kucheria wrote:
> >> On Fri, Mar 29, 2013 at 5:50 PM, Santosh Shilimkar
> >> <santosh.shilimkar@ti.com> wrote:
> >>> On Friday 29 March 2013 05:26 PM, Amit Kucheria wrote:
> >>>> On Fri, Mar 29, 2013 at 4:15 PM, Daniel Lezcano
> >>>> <daniel.lezcano@linaro.org> wrote:
> >>>>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
> >>>>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
> >>>>>>> The driver is initialized several times. This is wrong and if the
> >>>>>>> return code of the function was checked, it will return -EINVAL.
> >>>>>>>
> >>>>>>> Move this initialization out of the loop.
> >>>>>>>
> >>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>>>>> ---
> >>>>>> Fix for this is already and v2 of the patch is here [1]
> >>>>>
> >>>>> Ah, ok. Thanks for reviewing the patch.
> >>>>>
> >>>>> Can we find a solution to have a single entry point to sumbit patches
> >>>>> for all the cpuidle drivers ?
> >>>>>
> >>>>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
> >>>>> another one for the at91 tree, etc ... and wait for all the trees to
> >>>>> sync before continuing to consolidate the code.
> >>>>>
> >>>>> Wouldn't be worth to move these drivers under the PM umbrella instead of
> >>>>> the SoC specific code ?
> >>>>>
> >>>>> Any idea to simplify the cpuidle consolidation and maintenance ?
> >>>>
> >>>> Adding Arnd and Olof to this discussion since atleast the ARM drivers
> >>>> go through their arm-soc tree.
> >>>>
> >>>> Given the work you're putting in to consolidate the drivers, perhaps
> >>>> they can insist that idle drivers get acked by you?
> >>>>
> >>> Not to create controversy but as a general rule there is nothing
> >>> like *insisting* ack on patches for merge apart from the official
> >>> maintainers(gate keepers).
> >>>
> >>> Having said that, its always good to get more reviews and acks so
> >>> that better code gets merged.
> >>>
> >>> This just my personal opinion.
> >>
> >> I'm not asking for special treatment here. :) I'm requesting one set
> >> of maintainers (arm-soc maintainers) to push back on changes that
> >> don't get platform idle drivers in sync with the consolidation work
> >> that is currently ongoing.
> >>
> >> This will speed up the process since it is hard to track every
> >> SoC-specific list for these changes. Some platform maintainers might
> >> not even be aware of it (those that Daniel hasn't modified yet). A
> >> similar approach seems to have worked for common clock, DT, pinmux,
> >> etc.
> >>
> > Every patch gets pulled into arm-soc/arm-core has to be posted on
> > LAKML. So as long as everybody follows that rule, there is no need to
> > track every SoC lists. And what I have seen so far every this rule
> > has been followed well.
> 
> (Added Benjamin, Deepthi and Paul)
> 
> I don't think everybody is following this rule, patches go to the SoC
> maintainer's tree without sometimes going through lakml.
> 
> Furthermore, there is not only ARM, there is also acpi_idle, intel_idle,
> pseries_idle and sh_idle, respectively located in:
> 
> drivers/acpi/processor_idle.c
> drivers/acpi/processor_driver.c
> drivers/idle/intel_idle.c
> 
> These ones above are under linux-pm, that is Rafael, like cpuidle, even
> if it is not marked in the MAINTAINERS file, so that should be ok.
> 
> And there is also:
> 
> arch/sh/kernel/cpu/shmobile/cpuidle.c
> arch/powerpc/platforms/pseries/processor_idle.c
> 
> And hopefully, some others in the right place, calxeda_idle and
> kirwood_idle located in drivers/cpuidle.
> 
> In the maintainer file, there is no information about cpuidle at all.
> 
> For example, if someone modify the cpuidle framework allowing to
> consolidate the code across the different drivers, we have to wait for
> the merge before using the new api into the different drivers.
> If we follow strictly the path of the merge tree we fall into a scenario
> where consolidating the drivers takes a loooooong time.
> 
> From my POV, *all* the cpuidle drivers must go under drivers/cpuidle,
> like cpufreq and pass through a single entry point to apply the patches,
> so the cpuidle framework and the drivers are always synced.
> 
> If everyone agree and we reach this consensus, then we can work to move
> these drivers to a single place.
> 
> I think Amit was suggesting to Cc me in the meantime, so while we are
> moving these drivers to this place, I can help to ensure we go to the
> same direction.
> 
> For example, Arnd Cc'ed me about the zynq cpuidle driver when it has
> been posted and, after review, it appeared it was totally obsolete wrt
> the modifications we did this year.
> 
> I propose first to add an entry in MAINTAINERS:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cf5fd3..5b5ab87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2206,6 +2206,15 @@ S:       Maintained
>  F:     drivers/cpufreq/
>  F:     include/linux/cpufreq.h
> 
> +CPU IDLE DRIVERS
> +M:      Rafael J. Wysocki <rjw@sisk.pl>
> +L:      cpuidle@vger.kernel.org
> +L:      linux-pm@vger.kernel.org
> +S:      Maintained
> +F:      drivers/cpuidle/
> +F:      include/linux/cpuidle.h
> +
>  CPUID/MSR DRIVER
>  M:     "H. Peter Anvin" <hpa@zytor.com>
>  S:     Maintained
> 
> Does it make sense ?

Yes, it does to me. :-)

That said, I'm not sure if moving the existing cpuidle drivers to that
directory solves any problems.  If somebody wants to keep their cpudile
driver in his/her arch or platform, and there may be reasons for that,
it's basically fine by me.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
