From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Thu, 16 Apr 2015 10:46:47 +0200
Message-ID: <552F76F7.6090405@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org> <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org> <20150415121831.GU5029@twins.programming.kicks-ass.net> <552E8715.4060601@linaro.org> <20150415171057.GA4300@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36486 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964912AbbDPIqr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 04:46:47 -0400
Received: by wgsk9 with SMTP id k9so72804424wgs.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2015 01:46:46 -0700 (PDT)
In-Reply-To: <20150415171057.GA4300@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, Ingo Molnar <mingo@redhat.com>

On 04/15/2015 07:10 PM, Morten Rasmussen wrote:
> On Wed, Apr 15, 2015 at 04:43:17PM +0100, Daniel Lezcano wrote:
>> On 04/15/2015 02:18 PM, Peter Zijlstra wrote:
>>> On Wed, Apr 15, 2015 at 12:00:24PM +0200, Daniel Lezcano wrote:
>>>> The find_idlest_cpu is assuming the rq->idle_stamp information ref=
lects when
>>>> the cpu entered the idle state. This is wrong as the cpu may exit =
and enter
>>>> the idle state several times without the rq->idle_stamp being upda=
ted.
>>>
>>> Sure, but you forgot to tell us why it matters.
>>
>> Yes, right. Thanks for pointing this out.
>>
>> Assuming we are in the situation where there are several idle cpus i=
n
>> the same idle state.
>>
>> With the current code, the function find_idlest_cpu will choose a cp=
u
>> with the shortest idle duration. This information is based on the
>> rq->idle_stamp variable and is correct until one of the idle cpu is
>> exiting the cpuidle_enter function and re-entering it again. As soon=
 as
>> this happen, the rq->idle_stamp value is no longer a reliable inform=
ation.
>>
>> Example:
>>
>>    * CPU0 and CPU1 are running
>>    * CPU2 and CPU3 are in the C3 state.
>>    * CPU2 entered idle at T2
>>    * CPU3 entered idle at T3
>>    * T2 < T3
>>
>> The function find_idlest_cpu will choose CPU3 because it has a short=
er
>> idle duration.
>>
>> Then CPU3 is woken up by an interrupt, process it and re-enter idle =
C3.
>>
>> The information will still give the out to date information T2 < T3 =
and
>> find_idlest_cpu will choose CPU2 instead of CPU3.
>
> I can't get the example to match your description of how
> find_idlest_cpu() is supposed to work :-(
>
> Did you mean CPU2 (not CPU3) getting woken up by an interrupt and
> find_busiest_cpu() choosing CPU3 instead of CPU2 after the interrupt?
>
> In your example find_busiest_cpu() should return CPU3 before the
> interrupt as it went to sleep last and the interrupt on CPU3 should n=
ot
> affect that choice as CPU3 is still the last cpu to go to sleep
> (regardless of your patch). No?

Yes you are right. I meant CPU2 is woken up by the interrupt.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

