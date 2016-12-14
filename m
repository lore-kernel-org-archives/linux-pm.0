From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Wed, 14 Dec 2016 14:19:58 -0300
Message-ID: <55956cee-fdf8-5cab-9fd2-f7ed3e87334b@osg.samsung.com>
References: <5220084.l31t5oJbsy@amdc3058>
 <CGME20161214144053epcas4p1dc75ef6ec203f718e02afe9e4351bfe5@epcas4p1.samsung.com>
 <ee4321d6-dcc9-4de7-c376-6b169d160322@osg.samsung.com>
 <4861151.PfdUkXTZox@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4861151.PfdUkXTZox@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arjun K V <arjun.kv@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Bartlomiej,

On 12/14/2016 01:10 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, December 14, 2016 11:40:08 AM Javier Martinez Canillas wrote:
>> Hello Bartlomiej,
>>
>> On 12/14/2016 11:25 AM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Wednesday, December 14, 2016 11:06:45 AM Javier Martinez Canillas wrote:
>>>>
>>>> Hello Bartlomiej,
>>>>
>>>> On 12/14/2016 10:28 AM, Bartlomiej Zolnierkiewicz wrote:
>>>>>
>>>>> On Tuesday, December 13, 2016 04:18:05 PM Javier Martinez Canillas wrote:
>>>>>> Hello Bartlomiej,
>>>>>
>>>>> Hi,
>>>>>
>>>>>> On 12/13/2016 01:52 PM, Bartlomiej Zolnierkiewicz wrote:
>>>>>>> Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
>>>>>>> (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
>>>>>>> cooling maps to account for new OPPs.
>>>>>>>
>>>>>>> Since new OPPs are not available on all Exynos5422/5800 boards modify
>>>>>>> dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
>>>>>>> Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.
>>>>>>>
>>>>>>> Tested on Odroid-XU3 and XU3 Lite.
>>>>>>>
>>>>>>> Cc: Doug Anderson <dianders@chromium.org>
>>>>>>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>>>> Cc: Andreas Faerber <afaerber@suse.de>
>>>>>>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>> Cc: Ben Gamari <ben@smart-cactus.org>
>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   14 +++++++-------
>>>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   17 +++++++++++++++++
>>>>>>>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |    4 ++++
>>>>>>>  arch/arm/boot/dts/exynos5800.dtsi                  |   15 +++++++++++++++
>>>>>>>  4 files changed, 43 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>>> ===================================================================
>>>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.779763261 +0100
>>>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi	2016-12-13 15:59:33.775763261 +0100
>>>>>>> @@ -118,7 +118,7 @@
>>>>>>>  				/*
>>>>>>>  				 * When reaching cpu_alert3, reduce CPU
>>>>>>>  				 * by 2 steps. On Exynos5422/5800 that would
>>>>>>> -				 * be: 1600 MHz and 1100 MHz.
>>>>>>> +				 * (usually) be: 1800 MHz and 1200 MHz.
>>>>>>>  				 */
>>>>>>>  				map3 {
>>>>>>>  					trip = <&cpu_alert3>;
>>>>>>> @@ -131,16 +131,16 @@
>>>>>>>  
>>>>>>>  				/*
>>>>>>>  				 * When reaching cpu_alert4, reduce CPU
>>>>>>> -				 * further, down to 600 MHz (11 steps for big,
>>>>>>> -				 * 7 steps for LITTLE).
>>>>>>> +				 * further, down to 600 MHz (13 steps for big,
>>>>>>> +				 * 8 steps for LITTLE).
>>>>>>>  				 */
>>>>>>> -				map5 {
>>>>>>> +				cooling_map5: map5 {
>>>>>>>  					trip = <&cpu_alert4>;
>>>>>>> -					cooling-device = <&cpu0 3 7>;
>>>>>>> +					cooling-device = <&cpu0 3 8>;
>>>>>>>  				};
>>>>>>> -				map6 {
>>>>>>> +				cooling_map6: map6 {
>>>>>>>  					trip = <&cpu_alert4>;
>>>>>>> -					cooling-device = <&cpu4 3 11>;
>>>>>>> +					cooling-device = <&cpu4 3 13>;
>>>>>>>  				};
>>>>>>>  			};
>>>>>>>  		};
>>>>>>> Index: b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
>>>>>>> ===================================================================
>>>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.779763261 +0100
>>>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts	2016-12-13 15:59:33.775763261 +0100
>>>>>>> @@ -21,6 +21,23 @@
>>>>>>>  	compatible = "hardkernel,odroid-xu3-lite", "samsung,exynos5800", "samsung,exynos5";
>>>>>>>  };
>>>>>>>  
>>>>>>> +&cluster_a15_opp_table {
>>>>>>> +	/delete-node/opp@2000000000;
>>>>>>> +	/delete-node/opp@1900000000;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&cluster_a7_opp_table {
>>>>>>> +	/delete-node/opp@1400000000;
>>>>>>> +};
>>>>>>> +
>>>>>>
>>>>>> I think that a comment in the DTS why these operating points aren't available
>>>>>> in this board will make more clear why the nodes are being deleted.
>>>>>
>>>>> Ok, I will add these comments in the next patch revision.
>>>>>
>>>>>>> +&cooling_map5 {
>>>>>>> +	cooling-device = <&cpu0 3 7>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&cooling_map6 {
>>>>>>> +	cooling-device = <&cpu4 3 11>;
>>>>>>> +};
>>>>>>> +
>>>>>>>  &pwm {
>>>>>>>  	/*
>>>>>>>  	 * PWM 0 -- fan
>>>>>>> Index: b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>>>>>> ===================================================================
>>>>>>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
>>>>>>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts	2016-12-13 15:59:33.779763261 +0100
>>>>>>> @@ -146,6 +146,10 @@
>>>>>>>  	vdd-supply = <&ldo9_reg>;
>>>>>>>  };
>>>>>>>  
>>>>>>> +&cluster_a7_opp_table {
>>>>>>> +	/delete-property/opp@1400000000;
>>>>>>> +};
>>>>>>> +
>>>>>>>  &cpu0 {
>>>>>>>  	cpu-supply = <&buck2_reg>;
>>>>>>>  };
>>>>>>> Index: b/arch/arm/boot/dts/exynos5800.dtsi
>>>>>>> ===================================================================
>>>>>>> --- a/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
>>>>>>> +++ b/arch/arm/boot/dts/exynos5800.dtsi	2016-12-13 15:59:33.779763261 +0100
>>>>>>> @@ -24,6 +24,16 @@
>>>>>>>  };
>>>>>>>  
>>>>>>>  &cluster_a15_opp_table {
>>>>>>> +	opp@2000000000 {
>>>>>>> +		opp-hz = /bits/ 64 <2000000000>;
>>>>>>> +		opp-microvolt = <1250000>;
>>>>>>> +		clock-latency-ns = <140000>;
>>>>>>> +	};
>>>>>>> +	opp@1900000000 {
>>>>>>> +		opp-hz = /bits/ 64 <1900000000>;
>>>>>>> +		opp-microvolt = <1250000>;
>>>>>>> +		clock-latency-ns = <140000>;
>>>>>>> +	};
>>>>>>>  	opp@1700000000 {
>>>>>>>  		opp-microvolt = <1250000>;
>>>>>>>  	};
>>>>>>> @@ -85,6 +95,11 @@
>>>>>>>  };
>>>>>>>
>>>>>>
>>>>>> AFAIK Thomas restricted the maximum OPP, because for A15 freqs > 1.8GHz the
>>>>>> INT rail would need to be scaled up as well since there's a maximum voltage
>>>>>> difference between the ARM and INT rails before the system becomes unstable:
>>>>>>
>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/276766.html
>>>>>> https://lkml.org/lkml/2014/5/2/419
>>>>>>
>>>>>> The ChromiumOS vendor tree uses a virtual regulator driver that makes sure
>>>>>> the maximum voltage skew is between a limit. But that never made to mainline:
>>>>>>
>>>>>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/boot/dts/exynos5420-peach-pit.dtsi#90
>>>>>> https://lkml.org/lkml/2014/4/29/28
>>>>>>
>>>>>> Did that change and there's infrastructure in mainline now to cope with that?
>>>>>> If that's the case, I think it would be good to mention in the commit message.
>>>>>
>>>>> I was not aware of this limitation and AFAIK mainline has currently
>>>>> no code to handle it.  I also cannot find any code to handle this in
>>>>
>>>> Yes, that's what I thought as well but maybe I was missing something.
>>>>
>>>>> Hardkernel's vendor kernel for Odroid-XU3 board.
>>>>>
>>>>> Do you know whether this problem exists also on Exynos5422/5800
>>>>> SoCs or only on Exynos5420 one?  I see that ChromiumOS uses virtual
>>>>> regulator code also on Exynos5800 SoC based Peach Pi board but was
>>>>> the problem actually present on this board?
>>>>>
>>>>
>>>> My understanding is that this problem is present in 5420/5422/5800
>>>> but I have no way to confirm this. I'm just guessing from the info
>>>> in the ChromiumOS vendor tree.
>>>>
>>>> If you look at the commit that added the regulator-locker driver,
>>>> the test says to be done in a Peach Pi so it seems the problem is
>>>> not restricted to only Exynos5420:
>>>>
>>>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/ba63620feace4eaed5572ac2e77d8d61754af704
>>>>  
>>>>> [ I added Arjun to Cc:, maybe he can help in explaining this issue
>>>>>   (unfortunately Inderpal's email is no longer working). ]
>>>>>
>>>>
>>>> Added Abhilash to cc list as well since he was involved in the Exynos ChromeOS tree.
>>>
>>> Abhilash's email is also no longer valid.. :(
>>>
>>
>> Yes, I noticed that as well :(
>>
>>>>> Please also note that on Exynos5422/5800 SoCs the same ARM rail
>>>>> voltage is used for 1.9 GHz & 2.0 GHz OPPs as for the 1.8 GHz one.
>>>>> IOW if the problem exists it is already present in the mainline
>>>>> kernel.
>>>>>
>>>>
>>>> Ah, I only looked at your patch and I didn't compare the voltage levels
>>>> in your 1.9 GHz and 2.0 GHz OPPs with the current 1.8 GHz in mainline.
>>>>
>>>> I wonder if the voltage levels in your patch are correct then, since the
>>>> ChromiumOS tree uses a higher voltages for the 1.9 GHz and 2.0 GHz OPPs:
>>>>
>>>> /*
>>>>  * Default ASV table
>>>>  */
>>>> static const unsigned int asv_voltage_5420[CPUFREQ_NUM_LEVELS] = {
>>>> 	1362500,	/* L0  2100 */
>>>> 	1312500,	/* L1  2000 */
>>>> 	1275000,	/* L2  1900 */
>>>> 	1225000,	/* L3  1800 */
>>>> 	1200000,	/* L4  1700 */
>>>>
>>>> This is from https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/cpufreq/exynos5420-cpufreq.c#175
>>>
>>> I think that the above voltages are original ones for Exynos5420
>>> (not for Exynos5422/5800).
>>>
>>
>> In the ChromiumOS tree, the same CPUFreq driver is used for both the Peach
>> Pit (Exynos5420) and Peach Pi (Exynos5800) Chromebooks.
> 
> This seems suboptimal (or maybe even incorrect as Exynos5422/5800
> SoCs also use different clock divider values for clocks related to
> CPU clock than Exynos5420 SoC).
>

Yes, I know. There's lot of if (soc_is_exynos5420()) and if (soc_is_exynos5422())
checks in the driver though so I guess those differences are taken into account.

I haven't reviewed that driver in detail though so maybe something is missing.

> Anyway, I can drop Peach Pi support from my patch for now if you want.
>

I'm not against adding all the missing operating points btw, I'm just trying to
make sure that's safe to do so in mainline.

>>> The voltages in my patch were taken from Hardkernel's kernel for
>>> Odroid-XU3:
>>>
>>> /*
>>>  * ASV group voltage table
>>>  */
>>> static const unsigned int asv_voltage_5422_CA15[CPUFREQ_LEVEL_END_CA15] = {
>>> ...
>>> 	1250000,    /* L4  2000 */
>>> 	1250000,    /* L5  1900 */
>>> 	1250000,    /* L6  1800 */
>>> ...
>>>
>>> https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y-android/drivers/cpufreq/exynos5422-eagle-cpufreq.c#L314
>>>
>>
>> In general I prefer to use the ChromiumOS tree as a reference instead of the
>> HardKernel one, since the former is in a much better shape IMHO.
> 
> I generally agree, OTOH Hardkernel's tree is based on Samsung's
> vendor trees and additionally it contains all low-level hardware
> details for Odroid-XU3 board (not present in ChromiumOS tree).
>

Fair enough.

>> I think is worth to check in a kernel tree in http://opensource.samsung.com/
>> for a product that's Exynos5422/5800 based.
> 
> I've just checked kernel from SM-G900H_LL_Opensource.zip (for Galaxy
> S5 which is Exynos5422 based) and it uses 50mV lower voltages for
> 1.6 GHz - 2.0 GHz OPPs, for the lower frequencies OPPs voltages are
> identical to the ones used by HardKernel's tree,
>

Interesting, thanks a lot for checking. So if the voltage levels for 1.9 GHz
and 2.0 GHz are the same than 1.8 GHz, then I agree with you that either is
safe to add these OPPs in mainline or the problem is already present there.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
