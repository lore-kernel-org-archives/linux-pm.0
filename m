From: Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH RFC 06/27] PM / Domains: add debugfs 'states' and
 'timings' seq files
Date: Wed, 16 Dec 2015 15:12:09 +0100
Message-ID: <56717139.8050204@baylibre.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-7-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrOPKc-WDsHNpndkoZa5g6tnnbE2C5JsqZ6DMCX+6hmFw@mail.gmail.com>
 <567145E1.5040804@baylibre.com>
 <CAPDyKFqPn5StedOgd-toxKvvcM078NuVvN8yUDByRZSe9HvKbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38709 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbbLPOMM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 09:12:12 -0500
Received: by mail-wm0-f48.google.com with SMTP id l126so39685662wml.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 06:12:11 -0800 (PST)
In-Reply-To: <CAPDyKFqPn5StedOgd-toxKvvcM078NuVvN8yUDByRZSe9HvKbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>

On 16/12/2015 13:48, Ulf Hansson wrote:
> [...]
>
>>>
>>> A general comment. Static functions in genpd shall start with one of
>>> the following prefix.
>>>
>>> genpd_*
>>> _genpd_*
>>> __genpd_*
>>>
>>> Please change accordingly.
>>
>>
>> Many static routines were already prefixed like the exported functions with
>> "pm_", shall I make a separate patch for this renaming ?
>
> My point is that I don't want it to becomes worse.
>
> If you follow the above rule for new changes, I am happy.
>
> Whether you want to send a separate patch fixing the other existing
> name to be consistent with above rule, I would also be happy. :-)

Fair enough, I'll do a renaming patch :)

>
>>
>>
>>>
>>>> ---
>>>>    drivers/base/power/domain.c | 115
>>>> +++++++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 107 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>> index c300293..9a0df09 100644
>>>> --- a/drivers/base/power/domain.c
>>>> +++ b/drivers/base/power/domain.c
>>>> @@ -2169,21 +2169,120 @@ static const struct file_operations
>>>> pm_genpd_summary_fops = {
>>>>           .release = single_release,
>>>>    };
>>>>
>>>> +static int pm_genpd_states_show(struct seq_file *s, void *data)
>>>> +{
>>>> +       struct generic_pm_domain *genpd;
>>>> +
>>>> +       seq_puts(s,
>>>> +                "\n  Domain             State name        Enter + Exit =
>>>> Min_off_on (ns)\n");
>>>> +       seq_puts(s,
>>>> +
>>>> "-----------------------------------------------------------------------\n");
>>>> +
>>>
>>>
>>> You must hold the gpd_list_lock while traversing the gpd list.
>>>
>>>> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>>>> +
>>>> +               int i;
>>>> +
>>>> +               for (i = 0; i < genpd->state_count; i++) {
>>>
>>>
>>> To be sure you have valid data, you should hold the genpd lock here.
>>>
>>
>> At some point while testing with calling suspend from the power_off handler,
>> the cpu would go to sleep with the lock held, hence using this seq-file
>> would not work.
>
> That seems like a bad behaviour during suspend. Why does it hold the lock?

that was in the scenario where 2 or more cpus are devices of the same 
power domain. IIRC you would have something like:

arm_enter_idle_state(cpu)
	pm_runtime_put_sync
		rpm_suspend
		__rpm_get_callback
			pm_genpd_runtime_suspend
				[Take lock]
				->platform code to enter sleep...

and race condition with another cpu of the same cluster trying to 
suspend or resume at the same time. it is a bad behaviour, I cannot test
the os-initiated mode here but I assume this is done differently and is 
no longer an issue (sorry for not being more specific).

>
> On the other it shouldn't matter as userspace can't access the debugfs
> nodes, since its frozen at those times, right!?

you can have cpu_j off, and cpu_i running the shell, in the scenario 
above. But since this was while hacking calling psci from 
genpd.power_off, I'm not sure it's worth mentioning...

>
>>
>> while I agree, I think it is not super likely that a
>> domain/child/devices/states are added or removed at this point (the DT is
>> parsed already), would using list_for_each_entry_safe be safe enough ?
>
> No it's not.
>
> The gpd_list is protected with the gdp_list_lock, which is needed
> because new genpds can be added at any point.
>
> You also need the genpd lock here, as otherwise you may print the
> latency-values in the middle of when these are being updated.

Understood, I'll put the lock back.

>
>>
>>
>>>> +                       seq_printf(s, "%-20s %-20s %lld+%lld=%lld\n",
>>>> +                                  genpd->name,
>>>> +                                  genpd->states[i].name,
>>>> +                                  genpd->states[i].power_on_latency_ns,
>>>> +                                  genpd->states[i].power_off_latency_ns,
>>>> +                                  genpd->states[i].power_off_latency_ns
>>>> +                                  +
>>>> genpd->states[i].power_on_latency_ns);
>>>> +               }
>>>> +
>>>> +       }
>>>> +
>>>> +       seq_puts(s, "\n");
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>
> [...]
>
> Kind regards
> Uffe
>

