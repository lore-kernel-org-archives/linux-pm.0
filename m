From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v3 3/7] ARM: dts: Add PPMU device tree support for Exynos5250
Date: Wed, 16 Jul 2014 23:31:07 +0530
Message-ID: <CAM4voanDqbTqG81pSKZ94baTJ0wdrc6MxPMTJrZvFy12FEHORw@mail.gmail.com>
References: <1400779322-4410-4-git-send-email-a.kesavan@samsung.com>
	<1405449266-26267-1-git-send-email-a.kesavan@samsung.com>
	<53C65A72.7000406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:39141 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934606AbaGPSBH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 14:01:07 -0400
In-Reply-To: <53C65A72.7000406@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: "myungjoo.ham" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, devicetree <devicetree@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Tomasz,

On Wed, Jul 16, 2014 at 4:26 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Actually one more comment.
>
> On 15.07.2014 20:34, Abhilash Kesavan wrote:
>
> [snip]
>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 834fb5a..5284f00 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -778,4 +778,12 @@
>>               clocks = <&clock CLK_SSS>;
>>               clock-names = "secss";
>>       };
>> +
>> +     ppmu@10C40000 {
>> +             compatible = "samsung,exynos5250-int-busfreq";
>> +             reg = <0x10C40000 0x2000        /* PPMU_DDR_C */
>> +                    0x10C50000 0x2000        /* PPMU_DDR_L */
>> +                    0x10CB0000 0x2000        /* PPMU_DDR_R */
>> +                    0x13660000 0x2000>;      /* PPMU_RIGHT */
>> +     };
>>  };
>>
>
> Please separate patches adding the binding from patches modifying device
> tree sources. Those are two logically separate changes.
Will split them in the next version.
>
> Best regards,
> Tomasz
