From: Inderpal Singh <inderpal.singh@linaro.org>
Subject: Re: [PATCH 3/3] dts: Add cpufreq controller node for Exynos5440 SoC
Date: Fri, 8 Feb 2013 22:19:09 +0530
Message-ID: <CAG17yqQBjuc9t2iXg0sjTMo=pbXcjkwuP0uRFu=YR=58+AmEmA@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-3-git-send-email-amit.daniel@samsung.com>
	<CAG17yqTSxjoTDcGg+6rt+gnDyJBO7j3MBP_g5B=vYZqa1qaD+g@mail.gmail.com>
	<CADGdYn44okjQHQo-W9Y-pFFHzO9-3HL-ZB36aVvfzMRp098ZtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:45564 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946657Ab3BHQtL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Feb 2013 11:49:11 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so1192687wie.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Feb 2013 08:49:09 -0800 (PST)
In-Reply-To: <CADGdYn44okjQHQo-W9Y-pFFHzO9-3HL-ZB36aVvfzMRp098ZtA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit kachhap <amit.kachhap@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org

On 8 February 2013 00:03, amit kachhap <amit.kachhap@gmail.com> wrote:
> On Wed, Feb 6, 2013 at 8:49 PM, Inderpal Singh
> <inderpal.singh@linaro.org> wrote:
>> On 7 February 2013 01:09, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
>>> Add cpufreq controller device node for Exynos5440 SoC for passing
>>> parameters like controller base address, interrupt and cpufreq
>>> table.
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
>>> index 024269d..b20b517 100644
>>> --- a/arch/arm/boot/dts/exynos5440.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5440.dtsi
>>> @@ -63,6 +63,15 @@
>>>
>>>         };
>>>
>>> +       cpufreq@160000 {
>>> +               compatible = "samsung,exynos5440-cpufreq";
>>> +               reg = <0x160000 0x1000>;
>>> +               interrupts = <0 57 0>;
>>> +               cpufreq_tbl = < 1200000 1025000
>>> +                               1000000 975000
>>> +                               800000  925000 >;
>>> +       };
>>> +
>>
>> I think cpufreq_tbl should be part of the cpu node as it's the
>> property of the cpu.
>> Please refer cpufreq-cpu0 and spear-cpufreq.
>
> http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/15364.
> In this thread same discussion followed. I am not sure what is the
> correct way but looks like Kukjin concluded this with a timer node
> separate from the CPU code.
>

I am only talking about cpufreq_tbl and its nothing but operating
points for the cpus. It seems its agreed upon to add operating-points
to cpu node as being done by all other platforms like imx6q, am33xx,
cpufreq-cpu0 and spear.

Thanks,
Inder

> Thanks,
> Amit Daniel
>>
>>>         serial@B0000 {
>>>                 compatible = "samsung,exynos4210-uart";
>>>                 reg = <0xB0000 0x1000>;
>>> --
>>> 1.7.10.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
