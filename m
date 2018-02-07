From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Wed, 7 Feb 2018 11:45:31 +0100
Message-ID: <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51291 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeBGKpe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Feb 2018 05:45:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so2280735wmd.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Feb 2018 02:45:33 -0800 (PST)
In-Reply-To: <20180207102446.GS28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

On 07/02/2018 11:24, Viresh Kumar wrote:
> On 07-02-18, 11:04, Daniel Lezcano wrote:
>> Yeah, this is a bit fuzzy. There are still cooling-{min|max}-*state*
>> definitions in the DTs
>>
>> Documentation/devicetree/bindings/hwmon/pwm-fan.txt:
>> cooling-min-state = <0>;
>> arch/arm/boot/dts/exynos4412-odroidu3.dts:
>> cooling-min-state = <0>;
>> arch/arm/boot/dts/exynos5410-odroidxu.dts:
>> cooling-min-state = <0>;
>> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi:
>> cooling-min-state = <0>;
>> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi:
>> cooling-min-state = <0>;
>>
>>
>> IIUC, the cooling-device in the mapping defines the min and max states
>> which are the values used in the thermal zone binding.
>>
>> And the cooling-[min|max]-level are the hardware limits:
>>
>> cooling-min-level <= cooling-device min|max state <= cooling-max-level
>>
>> For example on the hikey6220:
>>
>> The DT specifies for CPU0:
>>
>> 	operating-points-v2 = <&cpu_opp_table>;
>> 	cooling-min-level = <4>;
>> 	cooling-max-level = <0>;
>> 	#cooling-cells = <2>; /* min followed by max */
>>
>> and for the cooling device for map0
>>
>> 	cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>
>> So if my understanding is correct, the optional property
>> cooling-[min|max]-level is used to make sure the cooling device min
>> state and max state are in the hardware boundaries. And the thermal
>> framework misses to do the consistency check at init.
>>
>> I'm not sure how useful are cooling-{min|max}-*state* bindings.

I meant here cooling-{min|max}-*level*

> Okay, but we aren't validating it this way in code. Isn't it ?

Yes, that is my understanding. cooling-min-level and cooling-max-level
are not used in the thermal framework code today.

So if they are defined, we should check the cooling-device max and min
are in the boundaries (if they are different from no-limit).

That needs confirmation from the maintainers, I'm not 100% sure.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
