From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [Patch v3 2/5] cpuidle: config: Add ARCH_EXYNOS entry to select
 cpuidle-big-little driver
Date: Mon, 5 May 2014 14:39:19 +0530
Message-ID: <CANuQgHE50Ogqaf7jJsfy6Wx40oCsUBSXz=877BaXdXswQ7e8tw@mail.gmail.com>
References: <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
	<1399278444-8312-1-git-send-email-chander.kashyap@linaro.org>
	<1399278444-8312-3-git-send-email-chander.kashyap@linaro.org>
	<536752FD.3040704@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36318 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbaEEJJU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 May 2014 05:09:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so3730095oag.27
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2014 02:09:19 -0700 (PDT)
In-Reply-To: <536752FD.3040704@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Chander Kashyap <k.chander@samsung.com>

Hi Andreas,

On 5 May 2014 14:29, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
> Hi,
>
> Am 05.05.2014 10:27, schrieb Chander Kashyap:
>> Exynos5420 is a big-little SoC from Samsung. It has 4 A15 and 4 A7 c=
ores.
>> In order to use generic cpuidle-big-little driver, this patch adds E=
xynos5420
>> specific check to initialize generic cpuidle driver.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
>> ---
>> Changes in v3: None
>> Changes in v2:
>>       1. Changed config macro from SOC_EXYNOS5420 to SOC_EXYNOS5420
>
> This is probably a copy&pasto? Anyway, the commit message needs an
> update since no Exynos5420 specific check is done below afaics. That
> went into 3/5.

Oops that's write,
Copy paste mistake, and commit message change is required. I will fix i=
t .

Thanks


>
> Cheers,
> Andreas
>
>>  drivers/cpuidle/Kconfig.arm |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.a=
rm
>> index 97ccc31..d9596e7 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -4,7 +4,7 @@
>>
>>  config ARM_BIG_LITTLE_CPUIDLE
>>       bool "Support for ARM big.LITTLE processors"
>> -     depends on ARCH_VEXPRESS_TC2_PM
>> +     depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
>>       select ARM_CPU_SUSPEND
>>       select CPU_IDLE_MULTIPLE_DRIVERS
>>       help
>>
>
>
> --
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=
=C3=BCrnberg



--=20
with warm regards,
Chander Kashyap
