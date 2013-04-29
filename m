From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: thermal: exynos4: TMU device tree
 support for Exynos4412 targets
Date: Mon, 29 Apr 2013 10:27:38 +0530
Message-ID: <CADGdYn4URkw+ny5z6eKGWuujgb6kNy5k5FC09GXcVE=z6Jh4mA@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-2-git-send-email-l.majewski@samsung.com>
	<51794F94.4030107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <51794F94.4030107@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Apr 25, 2013 at 9:15 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> On 25-04-2013 08:30, Lukasz Majewski wrote:
>>
>> Device tree support for TMU at Exynos4x12 targets.
>>
>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
>
> This patch looks good to me:
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

This patch looks nice but I guess this patch should go via Kukjin
Kim's samsung tree.
Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Thanks,
Amit Daniel
>
>> ---
>> Changes for v2:
>> - None
>> ---
>>   arch/arm/boot/dts/exynos4x12.dtsi |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi
>> b/arch/arm/boot/dts/exynos4x12.dtsi
>> index e3380a7..ee920b3 100644
>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>> @@ -79,4 +79,14 @@
>>                 interrupts = <0 89 0>;
>>                 status = "disabled";
>>         };
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
>>   };
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
