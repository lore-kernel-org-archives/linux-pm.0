From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Ask for help on governor
Date: Wed, 13 Dec 2017 12:25:01 +0530
Message-ID: <20171213065501.GU25177@vireshk-i7>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com>
 <000801d37364$d48f6ed0$7dae4c70$@net>
 <000f01d373bf$deacca10$9c065e30$@net>
 <20171213061759.GT25177@vireshk-i7>
 <HE1PR0402MB28285FD45E5E6B72C4C1068DF3350@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:41671 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdLMGzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 01:55:05 -0500
Received: by mail-pf0-f176.google.com with SMTP id j28so942353pfk.8
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 22:55:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB28285FD45E5E6B72C4C1068DF3350@HE1PR0402MB2828.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

On 13-12-17, 06:22, Andy Tang wrote:
> Hi,
> 
> Thanks you all for help. 
> Anyway I found the root cause myself.

Well, I was quite sure that the problem you reported is different than what
Dough was talking about..

> It was caused by commit: 00bfe05889e91b5112893b001e4a47b0a0f8bdd7.
> 
> In this commit, the part of code is as below:
> +       if (policy_dbs->idle_periods < UINT_MAX) {
> +               unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
> +
> +               if (requested_freq > freq_steps)
> +                       requested_freq -= freq_steps;
> +               else
> +                       requested_freq = policy->min;
> +
> +               policy_dbs->idle_periods = UINT_MAX;
> +       }
> 
> On my platform, there are 3 frequency available which are: 1600Mhz, 800Mhz, 400Mhz.
> Freq_steps is 80Mhz.
> Due to this code, the requested_freq is always 480Mhz. Since we want 800Mhz as next target frequency, the cpu frequency can't be changed.

I am not sure I follow what you are saying. The above code is only taking care
of idle periods (i.e. while the CPU was idle and we couldn't decrease the
frequency). If there are no idle periods, then the requested_freq will increase
by 80 MHz every time we try to change the frequency and after the 5th call its
value will become 800 MHz and so we should see an update.

Have you tried reverting the commit 00bfe0588 on top of 4.14? Does it make your
regression go away?

> Please work out a patch to fix this.

Sure we can help, but I didn't understand the root cause yet.

> This issue exists on all our LS* platforms.

LS -> loongson ?

-- 
viresh
