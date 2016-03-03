From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu, 3 Mar 2016 04:04:15 +0100
Message-ID: <CAJZ5v0gq0FQDbJkkKb3UFciWtLQ3S1cpX-miECrQ+yRYDdbgdg@mail.gmail.com>
References: <1456945994-5616-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1466378.uUxCvZYPPQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33119 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbcCCDER (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:04:17 -0500
Received: by mail-lb0-f177.google.com with SMTP id k15so7775539lbg.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 19:04:16 -0800 (PST)
In-Reply-To: <1466378.uUxCvZYPPQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Mar 3, 2016 at 1:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, March 02, 2016 11:13:14 AM Srinivas Pandruvada wrote:

[cut]

>> Currently scaling_available_frequencies displays list of available
>> frequencies which can be used to set max/min or current scaling frequency.

>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 51eef87..2706bb5 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -646,6 +646,37 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>>  }
>>  #endif
>>
>> +static int x86_get_turbo_activation_ratio(int cpu, u64 *tar)
>> +{
>> +     u64 plat_info;
>> +     int err;
>> +
>> +     err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
>> +     /* Check number of config TDP levels > 0 */
>> +     if (!err && ((plat_info >> 33) & 0x03) > 0)
>> +             err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO,
>> +                                      tar);
>> +     else
>> +             err = -EOPNOTSUPP;
>> +
>> +     return err;
>
> What about
>
>         err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
>         if (err)
>                 return err;
>
>         if (plat_info >> 33) & 0x03 > 0)

Missing parens.  The above should be

        if (((plat_info >> 33) & 0x03) > 0)

>                 return rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, tar);
>
>         return -ENXIO;
>
>> +}

Thanks,
Rafael
