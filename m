From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: governor: Ensure sufficiently large sampling intervals
Date: Mon, 18 Dec 2017 18:42:01 +0100
Message-ID: <CAJZ5v0jkPwrHVv+SiDzkYHXm7-ehe9KdYKdkaFP07Xi8kai21g@mail.gmail.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <002001d37577$9706a730$c513f590$@net> <002501d375d2$54f942c0$feebc840$@net> <000601d3781a$d1354b50$739fe1f0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36423 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934358AbdLRRmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 12:42:02 -0500
Received: by mail-ot0-f194.google.com with SMTP id d5so14051726oti.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 09:42:02 -0800 (PST)
In-Reply-To: <000601d3781a$d1354b50$739fe1f0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Stratos Karafotis <stratosk@semaphore.gr>, Andy Tang <andy.tang@nxp.com>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Dec 18, 2017 at 5:11 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2017.12.17 17:16 Rafael J. Wysocki wrote:
>
>> After commit aa7519af450d (cpufreq: Use transition_delay_us for legacy
>> governors as well) the sampling_rate field of struct dbs_data may be
>> less than the tick period which causes dbs_update() to produce
>> incorrect results, so make the code ensure that the value of that
>> field will always be sufficiently large.
>>
>> Fixes: aa7519af450d (cpufreq: Use transition_delay_us for legacy governors as well)
>> Reported-by: Andy Tang <andy.tang@nxp.com>
>> Reported-by: Doug Smythies <dsmythies@telus.net>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>> drivers/cpufreq/cpufreq_governor.c |   19 ++++++++++++++++---
>> 1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
>> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
>> @@ -22,6 +22,8 @@
>>
>> #include "cpufreq_governor.h"
>>
>> +#define CPUFREQ_DBS_MIN_SAMPLING_INTERVAL    (2 * TICK_NSEC / NSEC_PER_USEC)
>> +
>
> Left over from the other thread on Friday I was testing both the above and
> the 1 TICK version:
>
> +#define CPUFREQ_DBS_MIN_SAMPLING_INTERVAL      (TICK_NSEC / NSEC_PER_USEC)
>
> I tested periodic workflows at around 35% average load with work/sleep
> frequencies from 100 to 2100 hertz, for both 250 Hertz kernels
> (4 millisecond TICK) and 1000 Hertz kernels (1 millisecond TICK)
>
> The 1 TICK version does have a "nosier" response than the 2 TICK version,
> but both seem to work fine. Neither are worse than the schedutil response
> for the same test.
>
> I'd be O.K. with either the 1 TICK or 2 TICK versions.

OK, thanks!

I prefer "less noisy", so I'll take the 2 TICK one (originally in this patch).

It can still be changed to 1 TICK later if there are complaints (even
though I'm not really expecting any).

Thanks,
Rafael
