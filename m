From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [RFC 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on high load
Date: Thu, 18 Feb 2016 08:47:25 +0530
Message-ID: <CANAwSgSOZMxXGFLgu67dL7GVEFh6TEG1NrUviqRY2oAVt16-sg@mail.gmail.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
 <1455692128-28504-4-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgQHiJGSYB7Qhq066Mqfskwrr_3SDQGXH-WN=Wt3SEF-QA@mail.gmail.com> <56C522A9.8070800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56C522A9.8070800@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof

On 18 February 2016 at 07:17, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 18.02.2016 04:53, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 17 February 2016 at 12:25, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> After adding cpufreq-dt support to Exynos542x, the Odroid XU3-Lite can
>>> be easily overheated when launching eight CPU-intensive tasks:
>>>         thermal thermal_zone3: critical temperature reached(121 C),shutting down
>>>
>>> This seems to be specific to Odroid XU3-Lite board which officially
>>> supports lower frequencies than regular XU3 or XU4. When working at
>>> maximum CPU speed (1800 MHz big and 1300 MHz LITTLE) in warmer place for
>>> longer time, the fan fails to cool down the board and it reaches
>>> critical temperature.
>>>
>>> Add CPU cooling to Exynos5422/5800 to fix this issue. When reaching 95
>>> degrees of Celsius, the board will slow down by 3 steps (around
>>> 1400/1000 MHz). When reaching 110 degrees of Celsius go to 600 MHz.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 41 +++++++++++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>>> index 2b289d7c0d13..66073ce29aee 100644
>>> --- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>>> @@ -34,6 +34,16 @@
>>>                                         hysteresis = <5000>; /* millicelsius */
>>>                                         type = "active";
>>>                                 };
>>> +                               cpu_alert3: cpu-alert-3 {
>>> +                                       temperature = <95000>; /* millicelsius */
>>> +                                       hysteresis = <5000>; /* millicelsius */
>>> +                                       type = "passive";
>>> +                               };
>>> +                               cpu_alert4: cpu-alert-4 {
>>> +                                       temperature = <110000>; /* millicelsius */
>>> +                                       hysteresis = <5000>; /* millicelsius */
>>> +                                       type = "passive";
>>> +                               };
>>>                                 cpu_crit0: cpu-crit-0 {
>>>                                         temperature = <120000>; /* millicelsius */
>>>                                         hysteresis = <0>; /* millicelsius */
>>> @@ -53,6 +63,37 @@
>>>                                      trip = <&cpu_alert2>;
>>>                                      cooling-device = <&fan0 2 3>;
>>>                                 };
>>> +
>>> +                               /*
>>> +                                * When reaching cpu_alert3, reduce CPU
>>> +                                * by 3 steps. On Exynos5422/5800 that would
>>> +                                * be: 1400 MHz and 1000 MHz.
>>> +                                */
>>> +                               map3 {
>>> +                                    trip = <&cpu_alert3>;
>>> +                                    cooling-device = <&cpu0 3 3>;
>>> +                               };
>>> +                               map4 {
>>> +                                    trip = <&cpu_alert3>;
>>> +                                    cooling-device = <&cpu4 3 3>;
>>> +                               };
>>> +
>>> +                               /*
>>> +                                * When reaching cpu_alert4, reduce CPU
>>> +                                * to 600 MHz (11 steps for big, 7 steps for
>>> +                                * LITTLE).
>>> +                                * Exynos5420 has less OPPs and reversed
>>> +                                * numbering of CPUs (big/LITTLE) so this
>>> +                                * would not match.
>>> +                                */
>>> +                               map5 {
>>> +                                    trip = <&cpu_alert4>;
>>> +                                    cooling-device = <&cpu0 7 7>;
>>> +                               };
>>> +                               map6 {
>>> +                                    trip = <&cpu_alert4>;
>>> +                                    cooling-device = <&cpu4 11 11>;
>>> +                               };
>>>                         };
>>>                 };
>>>         };
>>> --
>>> 2.5.0
>>>
>>
>> could you append this patch with following changes.
>
> Could you describe why?
>
>From the documentation.
Documentation/thermal/sysfs-api.txt

passive_delay: number of milliseconds to wait between polls when
performing passive cooling.
polling_delay: number of milliseconds to wait between polls when
checking  whether trip points have been crossed (0 for interrupt
driven systems).

Exynos driver is interrupt driven so please ignore.

Best Regards.
-Anand Moon

>> diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> index 66073ce..4e72637 100644
>> --- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> @@ -16,8 +16,8 @@
>>         thermal-zones {
>>                 cpu0_thermal: cpu0-thermal {
>>                         thermal-sensors = <&tmu_cpu0 0>;
>> -                       polling-delay-passive = <0>;
>> -                       polling-delay = <0>;
>> +                       polling-delay-passive = <250>; /* milliseconds */
>> +                       polling-delay = <500>; /* milliseconds */
>>                         trips {
>>                                 cpu_alert0: cpu-alert-0 {
>>                                         temperature = <50000>; /*
>> millicelsius */
>> ---
>> On running linaro pm-qa diagnostic tool
>> ----------------------------------------------------------
>>
>> thermal_01.28: checking 'thermal_zone2'/'trip_point_2_temp' ='110000'...    Ok
>> thermal_01.29: checking 'cdev0_trip_point' exists in
>> '/sys/devices/virtual/thermal/thermal_zone0'... Ok
>> thermal_01.30: checking 'thermal_zone0/cdev0_trip_point' valid binding...   Ok
>> thermal_01.31: checking 'cdev4_trip_point' exists in
>> '/sys/devices/virtual/thermal/thermal_zone0'... Ok
>> thermal_01.32: checking 'thermal_zone0/cdev4_trip_point' valid binding...   Err
>> thermal_01.33: checking 'cdev4_trip_point' exists in
>> '/sys/devices/virtual/thermal/thermal_zone0'... Ok
>> thermal_01.34: checking 'thermal_zone0/cdev4_trip_point' valid binding...   Err
>> thermal_01.35: checking 'cdev4_trip_point' exists in
>> '/sys/devices/virtual/thermal/thermal_zone0'... Ok
>> thermal_01.36: checking 'thermal_zone0/cdev4_trip_point' valid binding...   Err
>> thermal_01.37: checking 'cdev4_trip_point' exists in
>> '/sys/devices/virtual/thermal/thermal_zone0'... Ok
>> thermal_01.38: checking 'thermal_zone0/cdev4_trip_point' valid binding...   Err
>>
>> thermal_01: fail
>> -------------------------------------------------------
>> I also got lot's of error.
>>
>> root@odroidxu4l:~# cpu[ 3050.847663] cpu cpu4: Failed to find dev_opp: -19
>> [ 3171.640836] cpu cpu4: device_opp_debug_create_link: Failed to create link
>> [ 3171.646197] cpu cpu4: _add_list_dev: Failed to register opp debugfs (-12)
>> [ 3171.653574] cpu cpu7: device_opp_debug_create_link: Failed to create link
>> [ 3171.659752] cpu cpu7: _add_list_dev: Failed to register opp debugfs (-12)
>> [ 3171.697011] cpu cpu5: cpufreq_init: failed to get clk: -2
>> [ 3171.732505] cpu cpu6: cpufreq_init: failed to get clk: -2
>> [ 3171.768160] cpu cpu7: cpufreq_init: failed to get clk: -2
>>
>> Tested on Odroid-XU4
>>
>> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> The patch is not sufficient. It does not work the way it should...
>
> BTW, I found the issue. The order of trip points in DT:
> thermal_zone0/trip_point_0_hyst:5000
> thermal_zone0/trip_point_0_temp:50000
> thermal_zone0/trip_point_0_type:active
> thermal_zone0/trip_point_1_hyst:5000
> thermal_zone0/trip_point_1_temp:60000
> thermal_zone0/trip_point_1_type:active
> thermal_zone0/trip_point_2_hyst:5000
> thermal_zone0/trip_point_2_temp:70000
> thermal_zone0/trip_point_2_type:active
> thermal_zone0/trip_point_3_hyst:0
> thermal_zone0/trip_point_3_temp:120000  <---- this should be last one!
> thermal_zone0/trip_point_3_type:critical
> thermal_zone0/trip_point_4_hyst:5000
> thermal_zone0/trip_point_4_temp:90000
> thermal_zone0/trip_point_4_type:passive
> thermal_zone0/trip_point_5_hyst:5000
> thermal_zone0/trip_point_5_temp:110000
> thermal_zone0/trip_point_5_type:passive
>
> After fixing the order in DT, the cpu cooler starts working.
>
> Best regards,
> Krzysztof
>
