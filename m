From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
Date: Fri, 19 Feb 2016 12:51:48 +0900
Message-ID: <56C69154.40608@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <87h9h599zi.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:12820 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423660AbcBSDv4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 22:51:56 -0500
In-reply-to: <87h9h599zi.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 19.02.2016 02:58, Punit Agrawal wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
>> 12 steps for big core (700-1800 MHz). Add respective cooling cells.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Changes since v1:
>> 1. Add cooling properties to all CPUs (suggested by Viresh).
>> ---
>>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> index 261d25173f61..5c052d7ff554 100644
>> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
>> @@ -33,6 +33,9 @@
>>  			clock-frequency = <1800000000>;
>>  			cci-control-port = <&cci_control1>;
>>  			operating-points-v2 = <&cluster_a15_opp_table>;
>> +			cooling-min-level = <0>;
>> +			cooling-max-level = <11>;
> 
> Although the above two properties are defined they aren't parsed in the
> kernel.
> 
> Setting min / max extents for cooling devices via cooling maps does work
> though.

It is described as optional property in
Documentation/devicetree/bindings/thermal/thermal.txt ... but indeed it
is totally ignored.

So what is the recommendation? Get rid of it from DTS and documentation
or leave it because it will be implemented someday?

Thanks for feedback!

Best regards,
Krzysztof

