From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add CPU ID for Braswell processor
Date: Wed, 27 Aug 2014 09:47:45 -0700
Message-ID: <53FE0BB1.9060201@gmail.com>
References: <1408701944-14734-1-git-send-email-mika.westerberg@linux.intel.com> <CAKohpo=7CyRT7szhJAQXjRfBFyw_6LuHSdVS39z=899T0eBoMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64475 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914AbaH0Qrs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 12:47:48 -0400
In-Reply-To: <CAKohpo=7CyRT7szhJAQXjRfBFyw_6LuHSdVS39z=899T0eBoMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: dirk.brandewie@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08/22/2014 03:19 AM, Viresh Kumar wrote:
> On 22 August 2014 15:35, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> This is pretty much the same as Intel Baytrail, only the CPU ID is
>> different. Add the new ID to the supported CPU list.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Dirk might be away on holidays..

Yes Sorry

Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index c5eac949760d..a3cf8994160b 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -660,6 +660,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>>          ICPU(0x3f, core_params),
>>          ICPU(0x45, core_params),
>>          ICPU(0x46, core_params),
>> +       ICPU(0x4c, byt_params),
>>          ICPU(0x4f, core_params),
>>          ICPU(0x56, core_params),
>>          {}
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

