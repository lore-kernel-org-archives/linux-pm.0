From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [RFC PATCH 0/2] thermal: Add generic devfreq cooling device
Date: Mon, 20 Jul 2015 15:43:57 +0100
Message-ID: <9hhr3o2evo2.fsf@e105922-lin.cambridge.arm.com>
References: <1437048173-23744-1-git-send-email-cw00.choi@samsung.com>
	<9hhh9p3caxm.fsf@e105922-lin.cambridge.arm.com>
	<55A8FA48.4030304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:40996 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754505AbbGTOnC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 10:43:02 -0400
In-Reply-To: <55A8FA48.4030304@samsung.com> (Chanwoo Choi's message of "Fri,
	17 Jul 2015 21:51:20 +0900")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, ulf.hansson@linaro.org, khilman@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, inki.dae@samsung.com, l.majewski@samsung.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi Chanwoo,

Chanwoo Choi <cw00.choi@samsung.com> writes:

> Hi Punit,
>
> On 07/17/2015 07:53 PM, Punit Agrawal wrote:
>> Hi Chanwoo,
>> 
>> Chanwoo Choi <cw00.choi@samsung.com> writes:
>> 
>>> This patchset introduce the generic devfreq cooling device for generic thermal
>>> framework. The devfreq devices are used ad cooling device to reduce the
>>> overheating temperature. This patch is based on drivers/thermal/cpu_cooling.c.
>>> The devfreq cooling device can change the ragne of the frequency table of
>>> devfreq device according to cooling level in device tree file.
>>>
>> 
>> Have you had a look at the devfreq cooling patches from Javi[0][1]? How
>> is the current patchset different?
>
> I didn't see Javi's patchset before. Thanks for your information.
>
> I reviewed ths Javi's patchset. Both Javi's patchset and my patchset 
> has same concept except for applying the power allocator thermal governor
> as you below comment.
>
> But, there are some difference.
>
> First,
> I don't add new devfreq API (devfreq_set_max() / devfreq_set_min()).
> The my patchset used existing update_devfreq() to update the
> maximum frequency of devfreq device.
>

Ok.

> Second,
> In my patchset, the devfreq cooling device will be operated
> as existing cpu cooling device. If sensor measure the overheating
> temperature, devfreq cooling device will limit the maximum frequency
> of devfreq device.

Javi's patchset behaves exactly as you describe here.

> As below example, the devicetree file includes
> the overheating temperature information of each trip-point.
> - Javi's patchset used the static power value calculated by
> devfreq_cooling_gen_power_table() instead of temperature.
>

You've got this wrong.

The power table is used to model device power consumption which allows
the device to be used with the power_allocator governor. Refer to the
power_allocator documentation[2] to understand how it is used.

This doesn't change the behaviour when used with other governors.

[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/thermal/power_allocator.txt?id=refs/tags/v4.2-rc3

> Third,
> Javi's patchset used the same string of type when calling
> the thermal_of_cooling_device_register()
> - Javi's patchset used always the same "devfreq" string.
> - My patchset used the different "thermal-devfreq-%d" string
> according to each devfreq cooling device.
>

Except for this difference (which needs to be fixed), the current
patchset is a subset of the functionality proposed in [1].

With the merging of the power_allocator governor in v4.2, it makes sense
for the devfreq cooling device to also include support for it -
especially when the functionality is already under discussion on the
list.

As such, it would be great if you could provide feedback on that thread.

Thanks,
Punit

> In my patchset, devfreq cooling device uses the same method
> to determine the throttling situation as existing cpu cooling
> device. It is just my opinion.
>
>> 
>> At first glance, it seems that you are not implementing the extensions
>> that allow devfreq cooling devices to be used with power_allocator
>> thermal governor that got merged in v4.2-rc1.
>> 
>> Thanks,
>> Punit
>> 
>> [0] http://article.gmane.org/gmane.linux.power-management.general/61936
>> [1] http://article.gmane.org/gmane.linux.power-management.general/62417
>
> Thanks,
> Chanwoo Choi
>
>> 
>> 
>>> To verify the devfreq cooling device driver, I testd it with following platform:
>>>
>>> For example,
>>> - The Mali GPU of Exynos5433 SoC uses the devfreq framework to support the DVFS
>>> feature and Exynos5433 contains the G3D (GPU) thermal sensor. Following example
>>> explain the correlation between mali dt node and thermal sensor/zone.
>>> : thermal sensor : G3D sensor of Samsung Exynos5433 [1][2]
>>> : devfreq cooling device : Mali GPU [3]
>>>
>>> According to the temperature of g3d thermal sensor inclued in Exynos5433,
>>> devfreq cooling device can change the maximum frequency of Mali GPU.
>>>
>>> 1. In Exynos5433-based board dts file, Mali GPU dt node uses the devfreq
>>> framework to suppot the DVFS feature. Following dt node includes the
>>> both 'cooling-cells' and 'operating-points' which means the supported
>>> frequency entries:
>>>
>>> 	mali: mali@14AC0000 {
>>> 		compatible = "arm,mali-midgard";
>>> 		reg = <0x14AC0000 0x5000>;
>>> 		interrupts = <0 282 0>, <0 283 0>, <0 281 0>;
>>> 		interrupt-names = "JOB", "MMU", "GPU";
>>> 		clocks = <&cmu_g3d CLK_ACLK_G3D>;
>>> 		clock-names = "clk_mali";
>>> 		power-domains = <&pd_g3d>;
>>> 		status = "disabled";
>>>
>>> 		#cooling-cells = <2>;
>>>
>>> 		operating-points = <
>>> 			700000 1150000
>>> 			600000 1150000
>>> 			550000 1125000
>>> 			500000 1075000
>>> 			420000 1025000
>>> 			350000 1025000
>>> 			266000 1000000
>>> 			160000 1000000
>>> 		>;
>>> 	};
>>>
>>> 2. In exynos5433.dtsi, G3D thermal sensor measure the temperature of Mali GPU:
>>>
>>> 	tmu_g3d: tmu@10070000 {
>>> 		compatible = "samsung,exynos5433-tmu";
>>> 		reg = <0x10070000 0x200>;
>>> 		interrupts = <0 99 0>;
>>> 		clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
>>> 			 <&cmu_peris CLK_SCLK_TMU1>;
>>> 		clock-names = "tmu_apbif", "tmu_sclk";
>>> 		#include "exynos5433-tmu-sensor-conf.dtsi"
>>> 		status = "disabled";
>>> 	};
>>>
>>> 3. In exynos5433-tmu.dtsi, thermal-zones includes both trip points and
>>> cooling-maps of g3d thermal sensor. Following cooling-maps show the match
>>> between each trip point and each cooling device (devfreq device of mali):
>>>
>>> 	thermal-zones {
>>> 		/* ...... */
>>> 		g3d_thermal: g3d-thermal {
>>> 			thermal-sensors = <&tmu_g3d>;
>>> 			polling-delay-passive = <0>;
>>> 			polling-delay = <0>;
>>> 			trips {
>>> 				g3d_alert_0: g3d-alert-0 {
>>> 					temperature = <30000>;	/* millicelsius */
>>> 					hysteresis = <10000>;	/* millicelsius */
>>> 					type = "active";
>>> 				};
>>> 				g3d_alert_1: g3d-alert-1 {
>>> 					temperature = <40000>;	/* millicelsius */
>>> 					hysteresis = <10000>;	/* millicelsius */
>>> 					type = "active";
>>> 				};
>>>
>>> 				/* ...... */
>>> 			};
>>>
>>> 			cooling-maps {
>>> 				map0 {
>>> 					/* Set maximum frequency as 550MHz  */
>>> 					trip = <&g3d_alert_0>;
>>> 					cooling-device = <&mali 2 2>;
>>> 				};
>>> 				map1 {
>>> 					/* Set maximum frequency as 420MHz  */
>>> 					trip = <&g3d_alert_1>;
>>> 					cooling-device = <&mali 4 4>;
>>> 				};
>>>
>>> 				/* ...... */
>>> 			};
>>> 		};
>>>
>>> 		......
>>> 	};
>>>
>>> [1] https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/?h=v4.3-next/dt64-samsung&id=ac008f6b537703bb9a6fcc3882ca4af3331aa24f
>>> [2] https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/?h=v4.3-next/dt64-samsung&id=bcddc3a84e49ca1c646cf2081687a544a15f9218
>>> [3] malideveloper.arm.com/downloads/drivers/TX041/r5p0-06rel0/TX041-SW-99002-r5p0-06rel0.tgz
>>>
>>> Chanwoo Choi (2):
>>>   PM: devfreq: Add the prototype of update_devfreq() to export
>>>   thermal: devfreq_cooling: Add generic devfreq cooling device implementaion
>>>
>>>  .../devicetree/bindings/thermal/thermal.txt        |   8 +-
>>>  drivers/devfreq/devfreq.c                          |  22 +-
>>>  drivers/thermal/Kconfig                            |  11 +
>>>  drivers/thermal/Makefile                           |   3 +
>>>  drivers/thermal/devfreq-cooling.c                  | 309 +++++++++++++++++++++
>>>  include/linux/devfreq-cooling.h                    |  80 ++++++
>>>  include/linux/devfreq.h                            |   7 +
>>>  7 files changed, 425 insertions(+), 15 deletions(-)
>>>  create mode 100644 drivers/thermal/devfreq-cooling.c
>>>  create mode 100644 include/linux/devfreq-cooling.h
>> 
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
