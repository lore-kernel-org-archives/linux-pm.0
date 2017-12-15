From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Thu, 14 Dec 2017 17:30:49 -0800
Message-ID: <001f01d37544$5889d410$099d7c30$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx <000701d37479$e0570320$a1050960$@net> PJTJeNt3QC2CsPJTOebNwi
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:33865 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754538AbdLOBax (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Dec 2017 20:30:53 -0500
In-Reply-To: PJTJeNt3QC2CsPJTOebNwi
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Andy Tang' <andy.tang@nxp.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.12.13 18:42 Andy Tang wrote:
> On 2017.12.14 09:21 Doug wrote: 
>> 
>> diff --git a/drivers/cpufreq/cpufreq_governor.c
>> b/drivers/cpufreq/cpufreq_governor.c
>> index 58d4f4e..3493ca7 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -222,6 +222,7 @@ unsigned int dbs_update(struct cpufreq_policy
>> *policy)
>>                         max_load = load;
>>         }
>> 
>> +       idle_periods = 0;
>
> With this line added, conservative governor works well.
>
> Ondemand governor still can't work well.

Your original message said:

On 12-12-17, 02:46, Andy Tang wrote:
> I run into a question that conservative governor can't work while ondemand governor works well.

So, for my part of it, I never looked at ondemand.

> As I mentioned in earlier email, load varies from different sampling_rate.

Because that e-mail was html, a lot of people didn't get it, and it also is not
in the archives. Anyway:

On 2017.12.12 23:24 Andy wrote:

> I also found sampling_rate affects the CPU load dramatically.
>			sample rate
>			100000	10000	1000
> actual cpu load	1%		1%	1%
> cpu report load	1%		20%	40-100%
>
> So we can know that when sample_rate is higher than 10000us, cpufreq can not calculate the load correctly.

Can you tell us more details about how you did this test and how you know your data is correct?
In particular, what is your work/sleep frequency for your 1% load.
In my experience the work/sleep frequency has always been a very important consideration with these tests.
What is the tick rate of your kernel? Myself, I wouldn't expect a 1000 uSec sample period to work properly.

I used turbostat to verify my tests, and yes, on demand does start to misbehave if the sampling period
is short relative to the tick period (jiffy time), otherwise it was fine.

... Doug
