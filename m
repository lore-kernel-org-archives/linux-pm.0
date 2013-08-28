From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Wed, 28 Aug 2013 14:31:03 +0530
Message-ID: <CADGdYn4tWhXwFm+qV3908LhX_Yx3wXGSWewErUjJdn8NWDdTEg@mail.gmail.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHz37Z3B5YM0fEoD9D7GoBjFJquJeYRJCmtHZJ0B8sjAsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:52689 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3H1JBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 05:01:04 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so4583595lbi.28
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2013 02:01:03 -0700 (PDT)
In-Reply-To: <CAK9yfHz37Z3B5YM0fEoD9D7GoBjFJquJeYRJCmtHZJ0B8sjAsw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Patch Tracking <patches@linaro.org>

On Mon, Aug 26, 2013 at 7:45 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi,
>
> On 19 August 2013 11:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Fixes some trivial typos.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> This series is based on next branch of below tree:
>> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>>
>> This is tested on Exynos4210 and 5250 based boards.
>> ---
>>  drivers/thermal/samsung/Kconfig |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
>> index b653f15..92492e4 100644
>> --- a/drivers/thermal/samsung/Kconfig
>> +++ b/drivers/thermal/samsung/Kconfig
>> @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
>>         depends on ARCH_HAS_BANDGAP
>>         help
>>           If you say yes here you get support for the TMU (Thermal Management
>> -         Unit) driver for SAMSUNG EXYNOS series of soc. This driver initialises
>> +         Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
>>           the TMU, reports temperature and handles cooling action if defined.
>> -         This driver uses the exynos core thermal API's and TMU configuration
>> -         data from the supported soc's.
>> +         This driver uses the Exynos core thermal APIs and TMU configuration
>> +         data from the supported SoCs.
>>
>>  config EXYNOS_THERMAL_CORE
>> -       bool "Core thermal framework support for EXYNOS SOC's"
>> +       bool "Core thermal framework support for EXYNOS SOCs"
>>         depends on EXYNOS_THERMAL
>>         help
>>           If you say yes here you get support for EXYNOS TMU
>>           (Thermal Management Unit) common registration/unregistration
>>           functions to the core thermal layer and also to use the generic
>> -         cpu cooling API's.
>> +         CPU cooling APIs.
>> --
>> 1.7.9.5
>>
>
> Any comments on this series?
Looks OK.
Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Thanks,
Amit
>
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

On Mon, Aug 26, 2013 at 7:45 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi,
>
> On 19 August 2013 11:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Fixes some trivial typos.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> This series is based on next branch of below tree:
>> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>>
>> This is tested on Exynos4210 and 5250 based boards.
>> ---
>>  drivers/thermal/samsung/Kconfig |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
>> index b653f15..92492e4 100644
>> --- a/drivers/thermal/samsung/Kconfig
>> +++ b/drivers/thermal/samsung/Kconfig
>> @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
>>         depends on ARCH_HAS_BANDGAP
>>         help
>>           If you say yes here you get support for the TMU (Thermal Management
>> -         Unit) driver for SAMSUNG EXYNOS series of soc. This driver initialises
>> +         Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
>>           the TMU, reports temperature and handles cooling action if defined.
>> -         This driver uses the exynos core thermal API's and TMU configuration
>> -         data from the supported soc's.
>> +         This driver uses the Exynos core thermal APIs and TMU configuration
>> +         data from the supported SoCs.
>>
>>  config EXYNOS_THERMAL_CORE
>> -       bool "Core thermal framework support for EXYNOS SOC's"
>> +       bool "Core thermal framework support for EXYNOS SOCs"
>>         depends on EXYNOS_THERMAL
>>         help
>>           If you say yes here you get support for EXYNOS TMU
>>           (Thermal Management Unit) common registration/unregistration
>>           functions to the core thermal layer and also to use the generic
>> -         cpu cooling API's.
>> +         CPU cooling APIs.
>> --
>> 1.7.9.5
>>
>
> Any comments on this series?
>
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
