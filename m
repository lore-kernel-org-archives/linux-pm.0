From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 15:04:46 +0200
Message-ID: <535122EE.7030803@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr> <534FFBB3.8050601@linaro.org> <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr> <20140418093845.GD11096@twins.programming.kicks-ass.net> <535116FC.5070700@linaro.org> <20140418125344.GX11182@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64228 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaDRNEW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Apr 2014 09:04:22 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so692639wib.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2014 06:04:21 -0700 (PDT)
In-Reply-To: <20140418125344.GX11182@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/18/2014 02:53 PM, Peter Zijlstra wrote:
> On Fri, Apr 18, 2014 at 02:13:48PM +0200, Daniel Lezcano wrote:
>> On 04/18/2014 11:38 AM, Peter Zijlstra wrote:
>>> On Thu, Apr 17, 2014 at 12:21:28PM -0400, Nicolas Pitre wrote:
>>>> CPU topology is needed to properly describe scheduling domains.  W=
hether
>>>> we balance across domains or pack using as few domains as possible=
 is a
>>>> separate issue.  In other words, you shouldn't have to care in thi=
s
>>>> patch series.
>>>>
>>>> And IMHO coupled C-state is a low-level mechanism that should rema=
in
>>>> private to cpuidle which the scheduler shouldn't be aware of.
>>>
>>> I'm confused.. why wouldn't you want to expose these?
>>
>> The couple C-state is used as a mechanism for cpuidle to sync the cp=
us when
>> entering a specific c-state. This mechanism is usually used to handl=
e the
>> cluster power down. It is only used for a two drivers (soon three) b=
ut it is
>> not the only mechanism used for syncing the cpus. There are also the=
 MCPM
>> (tc2), the hand made sync when the hardware allows it (ux500), and a=
n
>> abstraction from the firmware (mwait), transparent to the kernel.
>>
>> Taking into account the couple c-state only does not make sense beca=
use of
>> the other mechanisms above. This is why it should stay inside the cp=
uidle
>> framework.
>>
>> The extension of the cpu topology will provide a generic way to desc=
ribe and
>> abstracting such dependencies.
>>
>> Does it answer your question ?
>
> I suppose so; its still a bit like we won't but we will :-)
>
> So we _will_ actually expose coupled C states through the topology bi=
ts,
> that's good.

Ah, ok. I think I understood where the confusion is coming from.

A couple of definitions for the same thing :)

1. Coupled C-states : *mechanism* implemented in the cpuidle framework:=
=20
drivers/cpuidle/coupled.c

2. Coupled C-states : *constraint* to reach a cluster power down state,=
=20
will be described through the topology and could be implemented by=20
different mechanism (MCPM, handmade sync, cpuidle-coupled-c-state,=20
firmware).

We want to expose 2. not 1. to the scheduler.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

