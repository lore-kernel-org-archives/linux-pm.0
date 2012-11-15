From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH 1/1] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 11:54:21 +0530
Message-ID: <CAK44p22wzbTE-u5QcasJhzYa9Ht7e9sNrJ63V2QX2+ZEp=vhSg@mail.gmail.com>
References: <1352875704-2178-1-git-send-email-sachin.kamat@linaro.org>
	<1352938284.2143.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55948 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2KOGYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Nov 2012 01:24:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1342113oag.19
        for <linux-pm@vger.kernel.org>; Wed, 14 Nov 2012 22:24:22 -0800 (PST)
In-Reply-To: <1352938284.2143.5.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>
Cc: durgadoss.r@intel.com, patches@linaro.org, akpm@linux-foundation.org

On 15 November 2012 05:41, Zhang Rui <rui.zhang@intel.com> wrote:
> Hi, Sachin,
>
> thanks for catching the problem.
>
> On Wed, 2012-11-14 at 12:18 +0530, Sachin Kamat wrote:
>> CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
>> for dependencies gives the following compilation warnings:
>> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
>> CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
>> direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
>>
> Amit,
>
> how is exynos driver supposed to work?
> do you want the exynos driver still be loaded without CPU_THERMAL?
> If yes, EXYNOS_THERMAL should not select CPU_FREQ_TABLE.
> If no, EXYNOS_THERMAL should depends on CPU_THERMAL instead of THERMAL.
> and CPU_THERMAL will select CPU_FREQ_TABLE instead.
>
> IMO, either of the above solution will be more proper to fix this
> warning.

Yes Rui, Currently exynos driver has dependency on CPU_THERMAL. There
is some code-refactoring work needed to remove this dependency.
As of now to fix the warning following changes may be sufficient.
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -50,7 +50,8 @@ config RCAR_THERMAL

 config EXYNOS_THERMAL
        tristate "Temperature sensor on Samsung EXYNOS"
-       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
+       depends on THERMAL
+       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && CPU_THERMAL
        select CPU_FREQ_TABLE
        help
          If you say yes here you get support for TMU (Thermal Managment

Thanks,
Amit Daniel

>
> thanks,
> rui
>
>> Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> Build tested using exynos4_defconfig on linux-next tree of 20121114.
>> ---
>>  drivers/thermal/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 266c15e..197b7db 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -50,7 +50,7 @@ config RCAR_THERMAL
>>
>>  config EXYNOS_THERMAL
>>       tristate "Temperature sensor on Samsung EXYNOS"
>> -     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
>> +     depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL && CPU_FREQ
>>       select CPU_FREQ_TABLE
>>       help
>>         If you say yes here you get support for TMU (Thermal Managment
>
>
