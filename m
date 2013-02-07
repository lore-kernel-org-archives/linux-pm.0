From: amit kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH 3/3] dts: Add cpufreq controller node for Exynos5440 SoC
Date: Thu, 7 Feb 2013 10:33:07 -0800
Message-ID: <CADGdYn44okjQHQo-W9Y-pFFHzO9-3HL-ZB36aVvfzMRp098ZtA@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-3-git-send-email-amit.daniel@samsung.com>
	<CAG17yqTSxjoTDcGg+6rt+gnDyJBO7j3MBP_g5B=vYZqa1qaD+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57459 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017Ab3BGSdI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Feb 2013 13:33:08 -0500
In-Reply-To: <CAG17yqTSxjoTDcGg+6rt+gnDyJBO7j3MBP_g5B=vYZqa1qaD+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inderpal Singh <inderpal.singh@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org

On Wed, Feb 6, 2013 at 8:49 PM, Inderpal Singh
<inderpal.singh@linaro.org> wrote:
> On 7 February 2013 01:09, Amit Daniel Kachhap <amit.daniel@samsung.com> wrote:
>> Add cpufreq controller device node for Exynos5440 SoC for passing
>> parameters like controller base address, interrupt and cpufreq
>> table.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
>> index 024269d..b20b517 100644
>> --- a/arch/arm/boot/dts/exynos5440.dtsi
>> +++ b/arch/arm/boot/dts/exynos5440.dtsi
>> @@ -63,6 +63,15 @@
>>
>>         };
>>
>> +       cpufreq@160000 {
>> +               compatible = "samsung,exynos5440-cpufreq";
>> +               reg = <0x160000 0x1000>;
>> +               interrupts = <0 57 0>;
>> +               cpufreq_tbl = < 1200000 1025000
>> +                               1000000 975000
>> +                               800000  925000 >;
>> +       };
>> +
>
> I think cpufreq_tbl should be part of the cpu node as it's the
> property of the cpu.
> Please refer cpufreq-cpu0 and spear-cpufreq.

http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/15364.
In this thread same discussion followed. I am not sure what is the
correct way but looks like Kukjin concluded this with a timer node
separate from the CPU code.

Thanks,
Amit Daniel
>
>>         serial@B0000 {
>>                 compatible = "samsung,exynos4210-uart";
>>                 reg = <0xB0000 0x1000>;
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
