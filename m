From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Mon, 17 Feb 2014 10:36:48 +0530
Message-ID: <CAKohpom+twiWXfk8-bZ70jbVABYt+zPg8oqCY1D80cjGML0ivQ@mail.gmail.com>
References: <20140214072623.3dd67851@mjolnir.ossman.eu>
	<52FE01A2.9030905@linux.vnet.ibm.com>
	<20140214153423.340e404e@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:37225 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaBQFGt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 00:06:49 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so16576777obc.18
        for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2014 21:06:49 -0800 (PST)
In-Reply-To: <20140214153423.340e404e@mjolnir.ossman.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 14 February 2014 20:04, Pierre Ossman <pierre-list@ossman.eu> wrote:
> On Fri, 14 Feb 2014 17:14:34 +0530
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>
>>
>> So with that, I don't see how the KHz value can turn out to be zero!

I think he is hitting some bug where he might be getting to this:

if (!data)
    return 0;

> Very interesting. But I can tell you that it is indeed happening. With
> my earlier patch (that checked the return value), I did have this in my
> dmesg:
>
> [  188.044175] cpufreq: updating policy for CPU 1
> [  188.044177] cpufreq: Driver did not initialize current freq
> [  188.044177] cpufreq: setting new policy for CPU 0: 1000000 - 2800000 kHz
>
> I can sprinkle some more pr_debug:s in there if you want to trace it
> further?

Please get some prints and see what's going wrong in powernowk8_get().
In case you are getting !data as null, get some messages in
powernowk8_cpu_exit() as well..
