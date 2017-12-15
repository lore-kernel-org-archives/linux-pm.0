From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Ask for help on governor
Date: Fri, 15 Dec 2017 15:26:18 +0100
Message-ID: <CAJZ5v0gk_hm1LMOWUZ0RfsEZB=xJHJgLvvyQmteb_vtBdYqsJA@mail.gmail.com>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7> <000701d37479$e0570320$a1050960$@net>
 <001f01d37544$5889d410$099d7c30$@net> <002001d37577$9706a730$c513f590$@net> <HE1PR0402MB282849253906D2387281806FF30B0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34643 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755864AbdLOO0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 09:26:20 -0500
Received: by mail-oi0-f51.google.com with SMTP id u193so6270382oie.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2017 06:26:19 -0800 (PST)
In-Reply-To: <HE1PR0402MB282849253906D2387281806FF30B0@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stratos Karafotis <stratosk@semaphore.gr>

On Fri, Dec 15, 2017 at 10:00 AM, Andy Tang <andy.tang@nxp.com> wrote:
> Hi Doug,
>
>> -----Original Message-----
>> From: Doug Smythies [mailto:dsmythies@telus.net]
>> Sent: Friday, December 15, 2017 3:38 PM
>> To: Andy Tang <andy.tang@nxp.com>
>> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
>> <rjw@rjwysocki.net>; 'Linux PM' <linux-pm@vger.kernel.org>; 'Viresh
>> Kumar' <viresh.kumar@linaro.org>; 'Stratos Karafotis'
>> <stratosk@semaphore.gr>
>> Subject: RE: Ask for help on governor
>>
>> Hi Andy,
>>
>> Could you please try the below reversion patch.
>> It is on top of kernel 4.15-rc3.
> Tried, no any effects.

Does this mean that the revert helps or that it doesn't help?

>>
>> On my system, and for the intel_cpufrequ scaling driver, the default
>> sampling_rate goes back to 20000 (which works) from 500 uSec (which
>> doesn't), for both the conservative and ondemand governors.
>
> If I set the sampling_rate to 20,000 (actually 10,000 is enough), cpufreq works too for both the conservative and ondemand governors.
> But on my platforms, the default rate is 1000 which leads to cpu load calculating issue.
>

OK, that's good to know.

I'll look deeper into this later today or tomorrow.

Thanks,
Rafael
