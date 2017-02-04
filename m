From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Date: Fri, 3 Feb 2017 17:00:24 -0800
Message-ID: <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
References: <20170202010601.75995-1-code@mmayer.net> <20170202010601.75995-4-code@mmayer.net>
 <20170203042917.GL7458@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35732 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdBDBA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2017 20:00:26 -0500
Received: by mail-wm0-f41.google.com with SMTP id b65so55087949wmf.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2017 17:00:26 -0800 (PST)
In-Reply-To: <20170203042917.GL7458@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2 February 2017 at 20:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 01-02-17, 17:06, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Enable all applicable CPUfreq options.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
>> index 4eb5d6e..6fda604 100644
>> --- a/arch/mips/configs/bmips_stb_defconfig
>> +++ b/arch/mips/configs/bmips_stb_defconfig
>> @@ -26,6 +26,16 @@ CONFIG_INET=y
>>  # CONFIG_INET_XFRM_MODE_BEET is not set
>>  # CONFIG_INET_LRO is not set
>>  # CONFIG_INET_DIAG is not set
>> +CONFIG_CPU_FREQ=y
>> +CONFIG_CPU_FREQ_STAT=y
>> +CONFIG_CPU_FREQ_STAT_DETAILS=y
>> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
>> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> +CONFIG_BMIPS_CPUFREQ=y
>>  CONFIG_CFG80211=y
>>  CONFIG_NL80211_TESTMODE=y
>>  CONFIG_MAC80211=y
>
> Rebase your stuff over pm/linux-next and you will see some changes here. Also
> schedutil is the new governor in town, you must give it a try.

I'll definitely turn on SCHEDUTIL. As for the changes in next, I don't
see any conflicts. My series applied fine on top of linux-next from
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/. Did
I use the wrong tree?

$ git log

commit f81d425292d7d14d45eedc16b9f59066e6640500
Author: Markus Mayer <mmayer@broadcom.com>
Date:   Wed Feb 1 16:45:06 2017 -0800

    MIPS: BMIPS: enable CPUfreq

    Enable all applicable CPUfreq options.

    Signed-off-by: Markus Mayer <mmayer@broadcom.com>

commit 9b71c19f3d9af3867f8ec144305b7f23bfaa42f3
Author: Markus Mayer <mmayer@broadcom.com>
Date:   Wed Feb 1 16:19:01 2017 -0800

    cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs

    Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
    BMIPS5xxx-based SoCs.

    Signed-off-by: Markus Mayer <mmayer@broadcom.com>

commit 3a2894802066c8a24da6890bcc2c0b7fae1ccb40
Author: Markus Mayer <mmayer@broadcom.com>
Date:   Wed Feb 1 16:16:55 2017 -0800

    BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.

    Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.

    Signed-off-by: Markus Mayer <mmayer@broadcom.com>

commit fd4c9e3a71b4c967731c99525a2e94085a776638
Merge: ba358f6 a9306a6
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Sat Feb 4 00:45:12 2017 +0100

    Merge branch 'pm-core-fixes' into linux-next

    * pm-core-fixes:
      PM / runtime: Avoid false-positive warnings from might_sleep_if()

...

Thanks,
-Markus

> --
> viresh
