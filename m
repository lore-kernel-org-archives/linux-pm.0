From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/2] PM / Domains: Extract code to power off/on a PM domain
Date: Wed, 29 Oct 2014 10:09:56 -0700
Message-ID: <7htx2majkr.fsf@deeprootsystems.com>
References: <1414066336-11168-1-git-send-email-geert+renesas@glider.be>
	<1414066336-11168-2-git-send-email-geert+renesas@glider.be>
	<CAPDyKFr+8A_i5GyrL+KOv7AvqoMEFaiJ0ck9AQGn=M4vJ7g7Xg@mail.gmail.com>
	<CAMuHMdWA+KeEoS+79Qos958r=4rWGN_ZeAbhP9FB5ZoEoQKqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:40153 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933749AbaJ2RKA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 13:10:00 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so3592445pab.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2014 10:09:59 -0700 (PDT)
In-Reply-To: <CAMuHMdWA+KeEoS+79Qos958r=4rWGN_ZeAbhP9FB5ZoEoQKqpQ@mail.gmail.com>
	(Geert Uytterhoeven's message of "Wed, 29 Oct 2014 14:32:30 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Ulf,
>
> On Wed, Oct 29, 2014 at 2:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 23 October 2014 14:12, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>> PM domains are powered on/off from various places. Some callers do
>>> latency measurements, others don't. Consolidate using two helper
>>> functions, which always measure the latencies, and update the stored
>>> latencies when needed.
>>>
>>> Other minor changes:
>>>   - Use pr_warn() instead of pr_warning(),
>>>   - There's no need to check genpd->name, %s handles NULL pointers fine,
>>>   - Make the warning format strings identical, to save memory.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your review.
>
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -151,6 +151,59 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>>>         genpd->cpuidle_data->idle_state->exit_latency = usecs64;
>>>  }
>>>
>>> +static int do_genpd_power_on(struct generic_pm_domain *genpd)
>>
>> Should we try to agree on the prefixes of the function names in genpd?
>> Currently there are a mix of them.
>>
>> May I suggest we try to stick to this:
>>
>> Exported functions:
>> pm_genpd_*
>> _pm_genpd_*
>> __pm_genpd_*
>>
>> Static functions:
>> genpd_*
>> _genpd_*
>> __genpd_*
>>
>> What do you think? Do you have any better suggestions?
>
> Sounds sane.
>
> So:
>
> s/do_genpd_power_on/genpd_power_on/
> s/do_genpd_power_off/genpd_power_off/

With that name change, feel free to add

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
