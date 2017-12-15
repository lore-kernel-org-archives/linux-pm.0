From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Ask for help on governor
Date: Sat, 16 Dec 2017 00:53:23 +0100
Message-ID: <CAJZ5v0it_1n02f_6e+1-EzU8HR_171QDMTLNPb_SxFFB43FB=w@mail.gmail.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <20171213061759.GT25177@vireshk-i7> <002001d37577$9706a730$c513f590$@net> <002501d375d2$54f942c0$feebc840$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32968 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755795AbdLOXxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 18:53:25 -0500
Received: by mail-ot0-f193.google.com with SMTP id h9so9179957oti.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2017 15:53:24 -0800 (PST)
In-Reply-To: <002501d375d2$54f942c0$feebc840$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Tang <andy.tang@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stratos Karafotis <stratosk@semaphore.gr>

On Fri, Dec 15, 2017 at 7:27 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2017.12.15 07:54 Rafael J. Wysocki wrote:
>> On Friday, December 15, 2017 8:37:38 AM Doug Smythies wrote:
>>
>>> Could you please try the below reversion patch.
>>> It is on top of kernel 4.15-rc3.
>>>
>>> On my system, and for the intel_cpufrequ scaling driver,
>>> the default sampling_rate goes back to 20000 (which works)
>>> from 500 uSec (which doesn't), for both the conservative
>>> and ondemand governors.
>>
>> OK
>>
>> So AFAICS the problem is that dbs_update() makes assumptions that are not
>> me, quite obviously, if the sampling interval is less than the tick period.
>>
>> For example, the "time_elapsed > 2 * sampling_rate" condition in it may
>> very well trigger every time in that case and that obviously affects the
>> conservative governor.
>
> It does trigger every time and that is why the conservative gov. sticks at
> low frequency.
>
>> What about the patch below, then?
>
> I am testing now, from previous work, and already reported on this thread,
> I already know that the conservative governor will be O.K..
> It will take me awhile to thoroughly test the ondemand governor. At only 1.0
> ticks at best it will be quite noisy and more sensitive to work/sleep frequencies
> for periodic workflows.

OK

Please also check a variant with 2 * TICK_NSEC / NSEC_PER_USEC on the
right-hand side.  If that's substantially less noisy, we can use it
instead.

The response latency of the governor obviously depends on that, but
the factor of 2 shouldn't really matter that much in that respect.

> By the way, I modified your proposed patch, which needed to divide by
> NSEC_PER_USEC instead of multiply by.
> i.e. I am testing this:
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 58d4f4e..1c2fd1d 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -430,7 +430,14 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         if (ret)
>                 goto free_policy_dbs_info;
>
> +       /*
> +        * The sampling interval should not be greater than the transition
> +        * latency of the CPU, but it also cannot be less than the tick period
> +        * for dbs_update() to work correctly.
> +        */
>         dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
> +       if (dbs_data->sampling_rate < TICK_NSEC / NSEC_PER_USEC)
> +               dbs_data->sampling_rate = TICK_NSEC / NSEC_PER_USEC;
>
>         if (!have_governor_per_policy())
>                 gov->gdbs_data = dbs_data;
>

Yeah, that's what I really meant. :-)

Using the multiplication instead of the division was a mistake (again,
quite obviously).

Thanks,
Rafael
