From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Q: cpuidle results in degredation in ethernet performance ?
Date: Tue, 4 Aug 2015 18:24:29 +0300
Message-ID: <CAJ2oMhJgj02yzGQEqBZW1Fbdc1GEv0-4-NBOt97Mfdiz=tDXSg@mail.gmail.com>
References: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
	<55C0CC17.604@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33375 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757589AbbHDPYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 11:24:30 -0400
Received: by ioii16 with SMTP id i16so20372478ioi.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 08:24:29 -0700 (PDT)
In-Reply-To: <55C0CC17.604@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org

On Tue, Aug 4, 2015 at 5:28 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 08/01/2015 09:34 PM, Ran Shalit wrote:
>>
>> Hello,
>>
>> Maybe if someone here understands cpuidel he can help me...
>>
>> I am using omap, with cpuidel and I have some strange behaviour only
>> when cpuidle is used:
>> 1.  I test ethernet bandwidth with iperf
>> 2. With large packet test (16k), I get same bandwidth in version with
>> cpuidle support as in version without cpuidel supported.
>> 3. With small packet test (<2000 bytes), I get high degredation in
>> performance in version with cpuidle. On viewing statistics I see that
>> the cpu gets into cpu inactive state (C3 state -  not retention yet,
>> only cpu not active). I guess this is the cuase of the degredation.
>> With large packets I get no increment in C3 state usage.
>> 4. I think that menu governer behaviour might explain this, but I
>> don't understand it deeply enough.
>>
>> Can anyone shed a light on this ? Is there anything I can do to overcome
>> this ?
>
>
> Is an omap3 or omap4 ?
>
>
Hi,

It is omap3530.

Thanks,
Ran
