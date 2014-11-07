From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/5] sched: idle: cpuidle: Check the latency req before
 idle
Date: Fri, 07 Nov 2014 10:35:00 +0100
Message-ID: <545C9244.6040508@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org> <CAM4v1pOg1GFW82WD8b6Vas5xhYQrQtdP1STGxyzYtrBNSa+-Pw@mail.gmail.com> <544FE787.8090108@linaro.org> <54504A60.2090908@linux.vnet.ibm.com> <545A3414.7030500@linaro.org> <545AF424.2070302@linux.vnet.ibm.com> <545B7AAC.3020309@linaro.org> <545C4AA4.7010904@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34220 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaKGJfE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 04:35:04 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so3953344wid.4
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 01:35:02 -0800 (PST)
In-Reply-To: <545C4AA4.7010904@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org

On 11/07/2014 05:29 AM, Preeti U Murthy wrote:
> On 11/06/2014 07:12 PM, Daniel Lezcano wrote:
>>
>> Preeti,
>>
>> I am wondering if we aren't going to a false debate.
>>
>> If the latency_req is 0, we should just poll and not enter in any id=
le
>> state even if one has zero exit latency. With a zero latency req, we
>> want full reactivity on the system, not enter an idle state with all=
 the
>> computation in the menu governor, no ?
>>
>> I agree this patch changes the behavior on PowerPC, but only if the
>> latency_req is set to zero. I don't think we are worried about power
>> saving when setting this value.
>>
>> Couldn't the patch accepted as it is for the sake of consistency on =
all
>> the platform and then we optimize cleanly for the special latency ze=
ro
>> case ?
>
> Alright Daniel, you can go ahead. I was thinking this patch through a=
nd
> now realize that, like you point out the logic will only get complica=
ted
> with all the additional hack.
>
> But would it be possible to add the weak arch_cpu_idle_loop() call fo=
r
> the cases where latency requirement is 0 like you had suggested earli=
er
> ? This would ensure the polling logic does not break on PowerPC and w=
e
> don't bother the governor even. I will add the function in the core
> PowerPC code. If arch does not define this function it will fall back=
 to
> cpu_idle_loop(). Fair enough?

Yes, sounds good.

I will add the weak function as the first patch in the series.

Thanks for your reviews.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

