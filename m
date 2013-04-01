From: Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: How to facilitate the cpuidle drivers to go to the same direction
 (Was: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization)
Date: Mon, 01 Apr 2013 11:35:59 +0530
Message-ID: <515923C7.8040408@linux.vnet.ibm.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org> <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org> <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com> <51558723.1050904@ti.com> <CAP245DWAAgQ4co34mdkFgepC5kP9v0n6B954ej2X_y20LE9kSQ@mail.gmail.com> <5155AEE7.106@ti.com> <5155B85F.6030808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5155B85F.6030808-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Patch Tracking <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Lists LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/29/2013 09:20 PM, Daniel Lezcano wrote:
> On 03/29/2013 04:10 PM, Santosh Shilimkar wrote:
>> On Friday 29 March 2013 06:20 PM, Amit Kucheria wrote:
>>> On Fri, Mar 29, 2013 at 5:50 PM, Santosh Shilimkar
>>> <santosh.shilimkar-l0cyMroinI0@public.gmane.org> wrote:
>>>> On Friday 29 March 2013 05:26 PM, Amit Kucheria wrote:
>>>>> On Fri, Mar 29, 2013 at 4:15 PM, Daniel Lezcano
>>>>> <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>>>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>>>>>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>>>>>>> The driver is initialized several times. This is wrong and if the
>>>>>>>> return code of the function was checked, it will return -EINVAL.
>>>>>>>>
>>>>>>>> Move this initialization out of the loop.
>>>>>>>>
>>>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>>>> ---
>>>>>>> Fix for this is already and v2 of the patch is here [1]
>>>>>>
>>>>>> Ah, ok. Thanks for reviewing the patch.
>>>>>>
>>>>>> Can we find a solution to have a single entry point to sumbit patches
>>>>>> for all the cpuidle drivers ?
>>>>>>
>>>>>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
>>>>>> another one for the at91 tree, etc ... and wait for all the trees to
>>>>>> sync before continuing to consolidate the code.
>>>>>>
>>>>>> Wouldn't be worth to move these drivers under the PM umbrella instead of
>>>>>> the SoC specific code ?
>>>>>>
>>>>>> Any idea to simplify the cpuidle consolidation and maintenance ?
>>>>>
>>>>> Adding Arnd and Olof to this discussion since atleast the ARM drivers
>>>>> go through their arm-soc tree.
>>>>>
>>>>> Given the work you're putting in to consolidate the drivers, perhaps
>>>>> they can insist that idle drivers get acked by you?
>>>>>
>>>> Not to create controversy but as a general rule there is nothing
>>>> like *insisting* ack on patches for merge apart from the official
>>>> maintainers(gate keepers).
>>>>
>>>> Having said that, its always good to get more reviews and acks so
>>>> that better code gets merged.
>>>>
>>>> This just my personal opinion.
>>>
>>> I'm not asking for special treatment here. :) I'm requesting one set
>>> of maintainers (arm-soc maintainers) to push back on changes that
>>> don't get platform idle drivers in sync with the consolidation work
>>> that is currently ongoing.
>>>
>>> This will speed up the process since it is hard to track every
>>> SoC-specific list for these changes. Some platform maintainers might
>>> not even be aware of it (those that Daniel hasn't modified yet). A
>>> similar approach seems to have worked for common clock, DT, pinmux,
>>> etc.
>>>
>> Every patch gets pulled into arm-soc/arm-core has to be posted on
>> LAKML. So as long as everybody follows that rule, there is no need to
>> track every SoC lists. And what I have seen so far every this rule
>> has been followed well.
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

I can very much relate to the above mentioned problem, where code
modifications done as a part of cpuidle framework needs to be
reflected in every arch back-end cpuidle driver.
We do have added advantages in moving
all the back-end drivers into drivers/cpuidle.
This would help us achieve better reviews, easier consolidations
and more importantly maintaining sync btw drivers and framework and
the up-streaming process.

But then, this means we get all the
arch specific code out under drivers/cpuidle
which can be very messy. Also instances where the changes
are specifically tied only to the  architecture of the back-end driver
(SoC specific), it is absolutely necessary to get SoC maintainer's review.

Cheers,
Deepthi

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
> +M:      Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> +L:      cpuidle-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +L:      linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:      Maintained
> +F:      drivers/cpuidle/
> +F:      include/linux/cpuidle.h
> +
>  CPUID/MSR DRIVER
>  M:     "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
>  S:     Maintained
> 
> Does it make sense ?
> 
> Thanks
>   -- Daniel
> 
> 
