From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
Date: Fri, 12 Oct 2018 11:37:39 +0200
Message-ID: <20181012093741eucas1p26a54ad3091e4ba2468f61083c64749db~c0ubdFqkD3034330343eucas1p2R@eucas1p2.samsung.com>
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
        <20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d@eucas1p1.samsung.com>
        <f099ded8-e074-da18-2eac-e07a5a99af18@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f099ded8-e074-da18-2eac-e07a5a99af18@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org
Cc: Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org


On 10/11/2018 10:23 AM, Daniel Lezcano wrote:
> On 11/10/2018 09:35, Lukasz Luba wrote:
>> Hi Daniel,
>>
>> On 10/10/2018 06:54 PM, Daniel Lezcano wrote:
>>> On 10/10/2018 17:35, Lukasz Luba wrote:
>>>> Hi Thara,
>>>>
>>>> I have run it on Exynos5433 mainline.
>>>> When it is enabled with step_wise thermal governor,
>>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>>> dhrystone ~10%.
>>>>
>>>> Could you tell me which thermal governor was used in your case?
>>>> Please also share the name of that benchmark, i will give it a try.
>>>> Is it single threaded compute-intensive?
>>>
>>> aobench AFAICT
>>>
>>> It would be interesting if you can share the thermal profile of your board.
>>>
>> Thanks for the benchmark name.
>> It was tested on Samsung TM2 device with Exynos 5433 with debian.
>> Thermal stuff you can find in mainline:
>> arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> 
> By thermal profile, I was meaning a figure with the temperature
> regulation (temperature idle, then workload, then temperature increase,
> mitigated temperature, end of workload, temperature decrease).
Currently, I cannot share these data.
> 
> The thermal description looks wrong in the DT. I suggest to experiment
> the series with the DT fixed.

Could you tell more what looks wrong or maybe send a draft/patch?
> eg. from hi6220.dtsi
> 
> 
>                  thermal-zones {
> 
>                          cls0: cls0 {
>                                  polling-delay = <1000>;
>                                  polling-delay-passive = <100>;
>                                  sustainable-power = <3326>;
> 
>                                  /* sensor ID */
>                                  thermal-sensors = <&tsensor 2>;
> 
>                                  trips {
>                                          threshold: trip-point@0 {
>                                                  temperature = <65000>;
>                                                  hysteresis = <0>;
>                                                  type = "passive";
>                                          };
> 
>                                          target: trip-point@1 {
>                                                  temperature = <75000>;
>                                                  hysteresis = <0>;
>                                                  type = "passive";
>                                          };
>                                  };
> 
>                                  cooling-maps {
>                                          map0 {
>                                                  trip = <&target>;
>                                                  cooling-device = <&cpu0
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>                                          };
>                                  };
>                          };
>                  };
> 
> Note the cooling devices are *passive*
> 
>
For me this DT looks like it is copied from ARM Juno board for IPA,
where AFAIR there were no interrupts for the temperature sensor
(due to some psci/scpi/firmware lack of support).
The cooling map is also short. I am not sure if it would work efficient
with step-wise, with IPA it will work.

The DT configuration for Exynos has been working OK for years.
Exynos5433 supports 8 trip points, Exynos5422 has 4.
So if you have more trip points you need to start 'polling'.
Therefore, for Exynos there is no need to run queued work
in thermal framework every 1s or 100ms just to
read the current temperature.
The exynos-tmu driver gets irq and calls thermal framework
when such trip point is crossed. Then there is 'monitoring
window' for the trip point...
Long story short: 'active' is used for that reason.

Regards,
Lukasz
