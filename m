From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: Ask for help on governor
Date: Thu, 14 Dec 2017 20:25:02 +0200
Message-ID: <424841c2-f2e6-5f8e-32f4-4ec37b07b045@semaphore.gr>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7> <000701d37479$e0570320$a1050960$@net>
 <HE1PR0402MB2828076F9049436EFE149A29F30A0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.semaphore.gr ([138.201.185.188]:48956 "EHLO
        mail.semaphore.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbdLNSex (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 13:34:53 -0500
In-Reply-To: <HE1PR0402MB2828076F9049436EFE149A29F30A0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Content-Language: en-MW
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>, Doug Smythies <dsmythies@telus.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

Hi

On 14/12/2017 04:42 πμ, Andy Tang wrote:
> 
> 
>> -----Original Message-----
>> From: Doug Smythies [mailto:dsmythies@telus.net]
>> Sent: Thursday, December 14, 2017 9:21 AM
>> To: Andy Tang <andy.tang@nxp.com>; 'Viresh Kumar'
>> <viresh.kumar@linaro.org>; 'Stratos Karafotis' <stratosk@semaphore.gr>
>> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
>> <rjw@rjwysocki.net>; 'Linux PM' <linux-pm@vger.kernel.org>; Doug
>> Smythies <dsmythies@telus.net>
>> Subject: RE: Ask for help on governor
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
> As I mentioned in earlier email, load varies from different sampling_rate.
> 
> Regards,
> Andy
> 

I'm not sure I understood what the problem is (maybe because I can't see
the description of the issue in the quotes).

Commit 00bfe05889e91b5112893b001e4a47b0a0f8bdd7 affects only conservative
governor.
Do you have the same issue with ondemand too?

Stratos
