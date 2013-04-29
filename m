From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: thermal: exynos4: Add documentation for
 Exynos SoC thermal bindings
Date: Mon, 29 Apr 2013 10:31:13 +0530
Message-ID: <CADGdYn6HorcBE1Aa9q7+JFcoZzYgTZE7WcNbFpPjEE-QW2f3Dg@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-4-git-send-email-l.majewski@samsung.com>
	<51794FF0.2050406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:42416 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3D2FBO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 01:01:14 -0400
In-Reply-To: <51794FF0.2050406@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Rui,

On Thu, Apr 25, 2013 at 9:16 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> On 25-04-2013 08:30, Lukasz Majewski wrote:
>>
>> Proper description for Exynos4 bindings added to Documentation/devicetree/
>> bindings
>>
>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
>
> I am fine with this one too.
>
> Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

This patch looks fine and can be merged.
Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Thanks,
Amit Daniel
>
>
>> ---
>> Changes for v2:
>> - Documentation extension according to ML feedback
>> ---
>>   .../devicetree/bindings/thermal/exynos-thermal.txt |   25
>> ++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> new file mode 100644
>> index 0000000..535fd0e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>> @@ -0,0 +1,25 @@
>> +* Exynos Thermal Management Unit (TMU)
>> +
>> +** Required properties:
>> +
>> +- compatible : One of the following:
>> +              "samsung,exynos4412-tmu"
>> +              "samsung,exynos4210-tmu"
>> +              "samsung,exynos5250-tmu"
>> +- interrupt-parent : The phandle for the interrupt controller
>> +- reg : Address range of the thermal registers
>> +- interrupts : Should contain interrupt for thermal system
>> +- clocks : The main clock for TMU device
>> +- clock-names : Thermal system clock name
>> +
>> +Example:
>> +
>> +       tmu@100C0000 {
>> +               compatible = "samsung,exynos4412-tmu";
>> +               interrupt-parent = <&combiner>;
>> +               reg = <0x100C0000 0x100>;
>> +               interrupts = <2 4>;
>> +               clocks = <&clock 383>;
>> +               clock-names = "tmu_apbif";
>> +               status = "disabled";
>> +       };
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
