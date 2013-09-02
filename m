From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
Date: Mon, 02 Sep 2013 16:43:20 +0200
Message-ID: <3870129.vNtjevCIAF@amdc1032>
References: <4002844.4ZqqJexTv4@amdc1032> <2459763.PzPngK0oec@amdc1032>
 <52249F97.4080807@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <52249F97.4080807@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 02, 2013 04:24:23 PM Daniel Lezcano wrote:
> On 09/02/2013 03:48 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, September 02, 2013 03:18:51 PM Daniel Lezcano wrote:
> >> On 09/02/2013 11:41 AM, Bartlomiej Zolnierkiewicz wrote:
> >>> On Monday, September 02, 2013 10:54:17 AM Daniel Lezcano wrote:
> >>>> On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
> >>>>> Add "cpuidle-exynos.max_states=" parameter to allow user to specify
> >>>>> the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.
> >>>>>
> >>>>> This change is needed because C1 state (AFTR mode) is often not able
> >>>>> to work properly due to incompatibility with some bootloader versions.
> >>>>>
> >>>>> Usage examples:
> >>>>>
> >>>>> "cpuidle-exynos.max_states=1" disables C1 state (AFTR mode).
> >>>>>
> >>>>> "cpuidle-exynos.max_states=0" disables the driver completely.
> >>>>>
> >>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >>>>> Cc: Tomasz Figa <t.figa@samsung.com>
> >>>>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>>>
> >>>> There is a max_cstate option for acpi and intel idle. There is also the
> >>>> cpuidle.off=1 option. As the semantic is the same, I think adding a
> >>>> common cpuidle option usable for all the drivers is better.
> >>>
> >>> I thought about making the option common for all cpuidle drivers first
> >>> but due to support for multiple cpuidle drivers on one machine (i.e.
> >>> big.LITTLE), per-driver option looked like a better approach.
> >>>
> >>> Should I make the option common and not worry about multiple drivers on
> >>> one machine support?
> >>
> >> Mmh, that's a good point.
> >>
> >> I am not in favor of multiple options spread across the different
> >> drivers. Furthermore the max_cstate is used in the intel platform to
> >> 'discover' what states the firmware supports which is not the case of
> >> the cpuidle ARM drivers (except new PSCI based). This option does not
> >> really fits well here.
> >>
> >> There is the kernel parameter 'cpuidle.off', so disabling the driver is ok.
> >>
> >> You converted the cpuidle driver to a platform driver. Isn't possible to
> >> pass information in the platform data field at boot time to tell AFTR is
> >> not supported and then act on the 'disabled' field of this state ?
> > 
> > It might be possible but I don't know where the source of this data would
> > be, platform specific kernel parameter? It sounds just like moving the code
> > around and adding superfluous platform->driver code because the similar
> > kernel parameter to disable just AFTR can be added in cpuidle-exynos driver
> > as well.
> 
> It is to prevent to add a new kernel parameter (with the documentation)
> for a single driver which has a bogus idle state. If that could be
> handled internally that would be cleaner.

If I believed that it could be handled internally I wouldn't be trying to
add a kernel parameter to handle it.. Would I? ;)

> Can you shortly describe what happens with the bootloader and AFTR ?

AFTR just doesn't work with the custom U-Boot version that we are using
(attempts to go into AFTR mode result in lockup) and using the upstream
version of U-Boot is not an option since it doesn't support the hardware
that we are using AFAIK. I also don't know exactly why it doesn't work
(I just suspect that it reuses INFORM registers for some other purposes).

> I guess you are not interested in cpuidle.off=1 because you want cpuidle
> statistics for WFI, right ?

Right. :)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
