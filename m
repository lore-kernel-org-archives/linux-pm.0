From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Mon, 28 Apr 2014 13:07:31 +0200
Message-ID: <535E3673.8020606@linaro.org>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <535911DC.9050109@linaro.org> <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com> <2713863.BLQTYQm2Oa@vostro.rjw.lan> <20140425132055.GC11096@twins.programming.kicks-ass.net> <535A94E3.5080004@linaro.org> <20140425184327.GH26782@laptop.programming.kicks-ass.net> <535E28D0.7050502@linaro.org> <20140428102819.GG27561@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38735 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbaD1LHc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Apr 2014 07:07:32 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so5467912wiv.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2014 04:07:31 -0700 (PDT)
In-Reply-To: <20140428102819.GG27561@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/28/2014 12:28 PM, Peter Zijlstra wrote:
> On Mon, Apr 28, 2014 at 12:09:20PM +0200, Daniel Lezcano wrote:
>> I agree a numerical value is not flexible. But it sounds weird to pu=
t a
>> scheduler option in the sysfs and maybe more options will follow.
>>
>> I am wondering if we shouldn't create a new cgroup for 'energy' and =
put
>> everything in there. So we will have more flexibility for extension =
and we
>> will be able to create a group of tasks for performance and a group =
of tasks
>> for energy saving.
>>
>> Does it make sense ?
>
> The old knobs used to live here:
>
> -What:          /sys/devices/system/cpu/sched_mc_power_savings
> -               /sys/devices/system/cpu/sched_smt_power_savings

Ah right.

> Not entirely sure that's a fine place, but it has precedent.

I share your doubts about the right place.

I'm really wondering if the cgroup couldn't be a good solution:

Amit pointed the conflict about the power vs performance with some=20
applications. We want to have for example a game to run fast performanc=
e=20
and some other application to save power.

The cgroup will allow to:

  * eg. create a couple of cgroup one for performance and the other one=
=20
for power and assign the different applications to one of these group

  * tweak the options just for a group of processes. Depending of the=20
behavior of the task, the userspace can create and change some options=20
for a specific application for optimum performance or energy saving

  * add more energy options in a place easy to extend

  * use string based options

  * alternatively use a single configuration for the entire system

  * use the event based file to trigger event about power consumption=20
(threshold reached) and from there we can easily freeze the group of=20
processes consuming too much energy

The cgroup will provide a highly configurable mechanism based on tasks=20
and could use with some other cgroup subsys (eg. to force the tasks on =
a=20
set of cpus).

IMHO, the cgroup is a good place.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

