From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 14:13:48 +0200
Message-ID: <535116FC.5070700@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr> <534FFBB3.8050601@linaro.org> <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr> <20140418093845.GD11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42243 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaDRMNY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Apr 2014 08:13:24 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so460489wgh.7
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2014 05:13:23 -0700 (PDT)
In-Reply-To: <20140418093845.GD11096@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/18/2014 11:38 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 12:21:28PM -0400, Nicolas Pitre wrote:
>> CPU topology is needed to properly describe scheduling domains.  Whe=
ther
>> we balance across domains or pack using as few domains as possible i=
s a
>> separate issue.  In other words, you shouldn't have to care in this
>> patch series.
>>
>> And IMHO coupled C-state is a low-level mechanism that should remain
>> private to cpuidle which the scheduler shouldn't be aware of.
>
> I'm confused.. why wouldn't you want to expose these?

The couple C-state is used as a mechanism for cpuidle to sync the cpus=20
when entering a specific c-state. This mechanism is usually used to=20
handle the cluster power down. It is only used for a two drivers (soon=20
three) but it is not the only mechanism used for syncing the cpus. Ther=
e=20
are also the MCPM (tc2), the hand made sync when the hardware allows it=
=20
(ux500), and an abstraction from the firmware (mwait), transparent to=20
the kernel.

Taking into account the couple c-state only does not make sense because=
=20
of the other mechanisms above. This is why it should stay inside the=20
cpuidle framework.

The extension of the cpu topology will provide a generic way to describ=
e=20
and abstracting such dependencies.

Does it answer your question ?

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

