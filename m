From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v10 7/7] thermal:exynos:boost: Automatic enable/disable of
 BOOST feature (at Exynos4412)
Date: Tue, 03 Dec 2013 16:42:14 +0100
Message-ID: <20131203164214.3d4730f1@amdc2363>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1383672411-26324-1-git-send-email-l.majewski@samsung.com>
 <1383672411-26324-8-git-send-email-l.majewski@samsung.com>
 <529C9ED2.2060106@ti.com> <20131203083159.35895456@amdc2363>
 <529DD05E.1050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37334 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab3LCPmX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2013 10:42:23 -0500
In-reply-to: <529DD05E.1050402@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com, Amit Daniel Kachhap <amit.daniel@samsung.com>

Hi Eduardo,

> On 03-12-2013 03:31, Lukasz Majewski wrote:
> > Hi Eduardo,
> > 
> >> On 05-11-2013 13:26, Lukasz Majewski wrote:
> >>> This patch provides auto disable/enable operation for boost. It
> >>> uses already present thermal infrastructure to provide boost
> >>> hysteresis. A special set of TMU data has been defined for
> >>> Exynos4412, which is only considered when BOOST is enabled.
> >>
> >> Can you please add more description why you need a different set of
> >> thermal data when boost is enabled? 
> > 
> > It turned out that the Thermal subsystem (after rework done for
> > v3.12) is capable of providing hysteresis for BOOST.
> > 
> 
> So, the difference is only the hysteresis?
> 
> > For version of the patch up to v8 I had to modify the thermal core
> > to provide such functionality. Changes in core weren't accepted by
> > Zhang Rui.
> 
> Ok... But still I didn't get what you needed to modify and why..
> Sorry I jumped in the middle of ongoing discussion.
> 
> > 
> > Then I've looked again to the code and it turned out that proper
> > setting of Exynos4x12 data (like trigger levels and freq_clip_max)
> > can solve the problem in a much better way by using Exynos thermal
> > interrupts.
> > Another advantage is that those changes are done per device.
> > 
> >> This is also important in case you
> >> (Exynos thermal folks) would like to migrate this driver to have
> >> thermal data support in DT.
> > 
> > Some work on this driver is ongoing (mainly done by Bartek
> > Zolnierkiewicz). This BOOST change doesn't break anything and only
> > extend the current thermal code. Thereof it will not break anything.
> 
> Well, good that it does not break anything, right?
> 
> But, My point, Lukasz, is that I am failing to understand, based on
> your patch and description why we need a different data definition,
> one for boost, other for without boost. Can you help me to get your
> intention with this patch properly?

I reduce the trigger_level[0] and set new .freq_table[0] entry.
It works as follow (for BOOST):

1. Non-boost freq is 1.4 GHz on Exynos4412. BOOST is 1.5GHz. The BOOST
itself is enabled by CONFIG_CPU_FREQ_BOOST_SW. 

2. Exynos TMU driver reaches the lower TMU level (70 deg). Then the
core thermal looks for proper frequency table (.freq_tab[0]). If the
.temp_level matches the trigger_levels[0], then the frequency is reduced
to .freq_clip_max = 1400 * 1000. 

When the device cools down to 60 deg (trigger_levels[0] -
threshold_falling), then the max freq is restored to 1.5 GHz. This is
done automatically by thermal core.

For BOOST disabled we only can run with 1.4 GHz freq. For this reason
the freq_tab[X] entries must be modified. Also the Exynos part of
thermal requires that trigger_levels[0] is the lowest temperature trip,
so I cannot add the "BOOST disable" temp level in the end of
TMU_DATA_BOOST.

> 
> Side question is what happens in runtime if user echo 0 > boost?

As we had agreed with Rafael and Viresh, we are here mimic the HW CPUs
behaviour (like Intel CPU).
When user writes 'echo 0 > boost' then at cpufreq core we switch to max
freq to 1.4 GHz.

Thermal here is only for safety reasons.  

> Should we switch the data within the driver? 

No. When one decides to enable CONFIG_CPU_FREQ_BOOST_SW, then
corresponding Exynos data are persistent. 

> Would we be penalizing
> performance with strict hysteresis while we could be allowing longer
> periods of high frequency usage? 

But the hysteresis shows up only for emergency - when we go out from
allowed power envelope.

The BOOST is a component of LAB governor, which takes into account the
number of running cores. The "normal" BOOST use case is a situation
when at most two cores are running and other are down.
In this situation we can use BOOST to finish work faster.

> See what I am missing? Maybe we
> actually need something else a part from defining one data structure
> for boost other for non-boost systems.

I'm open for suggestions.

The current proposal aims to change TMU data only for target SoC -
Exynos4412 in this case. I deliberately don't touch the thermal core
code.

> 
> > 
> >>
> >>
> >>>
> >>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> >>> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> >>>
> >>> ---
> >>> Changes for v10:
> >>>     - Remove boost related code from thermal_core.c
> >>>     - Use already present thermal infrastructure to provide
> >>> thermal hysteresis
> >>>     - Introduce special set of TMU data for BOOST
> >>>
> >>> Changes for v9:
> >>>     - None
> >>>
> >>> Changes for v8:
> >>>     - Move cpufreq_boost_* stub functions definition (needed when
> >>> cpufreq is not compiled in) to cpufreq.h at cpufreq core support
> >>> commit
> >>>
> >>> Changes for v7:
> >>>     - None
> >>>
> >>> Changes for v6:
> >>>     - Disable boost only when supported and enabled
> >>>     - Protect boost related thermal_zone_device struct fields with
> >>> mutex
> >>>     - Evaluate temperature trend during boost enable decision
> >>>     - Create separate methods to handle boost enable/disable
> >>>       (thermal_boost_{enable|disable}) operations
> >>>     - Boost is disabled at any trip point passage (not only the
> >>> non critical one)
> >>>     - Add stub definitions for cpufreq boost functions used when
> >>>       CONFIG_CPU_FREQ is NOT defined.
> >>>
> >>> Changes for v5:
> >>>     - Move boost disable code from cpu_cooling.c to thermal_core.c
> >>>       (to handle_non_critical_trips)
> >>>     - Extent struct thermal_zone_device by adding overheated bool
> >>> flag
> >>>     - Implement auto enable of boost after device cools down
> >>>     - Introduce boost_polling flag, which indicates if thermal
> >>> uses it's predefined pool delay or has woken up thermal workqueue
> >>> only to wait until device cools down.
> >>>
> >>> Changes for v4:
> >>>     - New patch
> >>
> >>
> >> Might be interesting to see the changelog for this patch only.
> > 
> > The above list presents the development state of this particular
> > patch (thermal). 
> > Up to v8 I had modified the thermal core. For v10 I've decided to
> > use proper Exynos data setting.
> > 
> > If in any doubt, please ask. 
> > 
> > This last thermal patch of the series hinders this code to be
> > applied to cpufreq subsystem (Viresh had acked it some time ago and
> > I hope that he hasn't changed his mind :-) ).
> > 
> > 
> >>
> >>>
> >>>  drivers/thermal/samsung/exynos_tmu_data.c |   47
> >>> +++++++++++++++++++++++++++++ 1 file changed, 47 insertions(+)
> >>>
> >>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c
> >>> b/drivers/thermal/samsung/exynos_tmu_data.c index 073c292..9346926
> >>> 100644 --- a/drivers/thermal/samsung/exynos_tmu_data.c
> >>> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> >>> @@ -167,13 +167,60 @@ static const struct exynos_tmu_registers
> >>> exynos4412_tmu_registers = { .features = (TMU_SUPPORT_EMULATION |
> >>> TMU_SUPPORT_TRIM_RELOAD | \ TMU_SUPPORT_FALLING_TRIP |
> >>> TMU_SUPPORT_READY_STATUS | \ TMU_SUPPORT_EMUL_TIME)
> >>> +
> >>> +#define EXYNOS4412_TMU_DATA_BOOST \
> >>> +	.threshold_falling = 10, \
> >>> +	.trigger_levels[0] = 70, \
> >>> +	.trigger_levels[1] = 85, \
> >>> +	.trigger_levels[2] = 103, \
> >>> +	.trigger_levels[3] = 110, \
> >>> +	.trigger_enable[0] = true, \
> >>> +	.trigger_enable[1] = true, \
> >>> +	.trigger_enable[2] = true, \
> >>> +	.trigger_enable[3] = true, \
> >>> +	.trigger_type[0] = THROTTLE_ACTIVE, \
> >>> +	.trigger_type[1] = THROTTLE_ACTIVE, \
> >>> +	.trigger_type[2] = THROTTLE_ACTIVE, \
> >>> +	.trigger_type[3] = SW_TRIP, \
> >>> +	.max_trigger_level = 4, \
> >>> +	.gain = 8, \
> >>> +	.reference_voltage = 16, \
> >>> +	.noise_cancel_mode = 4, \
> >>> +	.cal_type = TYPE_ONE_POINT_TRIMMING, \
> >>> +	.efuse_value = 55, \
> >>> +	.min_efuse_value = 40, \
> >>> +	.max_efuse_value = 100, \
> >>> +	.first_point_trim = 25, \
> >>> +	.second_point_trim = 85, \
> >>> +	.default_temp_offset = 50, \
> >>> +	.freq_tab[0] = { \
> >>> +		.freq_clip_max = 1400 * 1000, \
> >>> +		.temp_level = 70, \
> >>> +	}, \
> >>> +	.freq_tab[1] = { \
> >>> +		.freq_clip_max = 800 * 1000, \
> >>> +		.temp_level = 85, \
> >>> +	}, \
> >>> +	.freq_tab[2] = { \
> >>> +		.freq_clip_max = 200 * 1000, \
> >>> +		.temp_level = 103, \
> >>> +	}, \
> >>> +	.freq_tab_count = 3, \
> >>> +	.registers = &exynos4412_tmu_registers, \
> >>> +	.features = (TMU_SUPPORT_EMULATION |
> >>> TMU_SUPPORT_TRIM_RELOAD | \
> >>> +			TMU_SUPPORT_FALLING_TRIP |
> >>> TMU_SUPPORT_READY_STATUS | \
> >>> +			TMU_SUPPORT_EMUL_TIME)
> >>>  #endif
> >>>  
> >>>  #if defined(CONFIG_SOC_EXYNOS4412)
> >>>  struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
> >>>  	.tmu_data = {
> >>>  		{
> >>> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> >>> +			EXYNOS4412_TMU_DATA_BOOST,
> >>> +#else
> >>>  			EXYNOS4412_TMU_DATA,
> >>> +#endif
> >>>  			.type = SOC_ARCH_EXYNOS4412,
> >>>  			.test_mux = EXYNOS4412_MUX_ADDR_VALUE,
> >>>  		},
> >>>
> >>
> >>
> > 
> 
> 



-- 
-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
