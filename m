From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Fri, 25 Apr 2014 19:01:23 +0200
Message-ID: <535A94E3.5080004@linaro.org>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <535911DC.9050109@linaro.org> <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com> <2713863.BLQTYQm2Oa@vostro.rjw.lan> <20140425132055.GC11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:47778 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbaDYRBZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 13:01:25 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so2068857wes.22
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2014 10:01:24 -0700 (PDT)
In-Reply-To: <20140425132055.GC11096@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/25/2014 03:20 PM, Peter Zijlstra wrote:
> On Fri, Apr 25, 2014 at 01:46:53PM +0200, Rafael J. Wysocki wrote:
>
> _trim_ emails!!! one of these days I'm going to write a bot to flame
> your head of if there's excessive quoting.
>
>>> I had a offline conversation with Daniel about this since there are
>>> other triggers - thermal constraints and game-like apps being examp=
les
>>> - that might want to override the system policy. He intended
>>> "performance" mode to mean the existing code paths and "power" mode=
 to
>>> mean *additional* new heuristics for energy-efficiency. The power
>>> supply assumption is just the first one of those heuristics.
>>
>> Well, so now the question is whether or not we relly want to always
>> go to the "power" (or "energy efficiency" if you will) mode if the s=
ystem
>> is on battery.  That arguably may not be a good thing even for energ=
y
>> efficiency depending on how exactly the modes are defined.
>
> Nobody is talking about always. But in general it seems a good enough
> approach. Hell, many of the AC/BAT switches in todays power managemen=
t
> crap things are not always right.
>
> Do I want it to dim the LCD further when I unplug the laptop -- mostl=
y
> no, but still it does. And the most annoying one is that it reduces t=
he
> screen blank time to something near 5 seconds or so.
>
> Why would this be any different? If you know what you want you can tu=
rn
> the knob.
>
>> So in my opinion it's too early to add things like that at this poin=
t.
>
> Meh..
>

Peter,

I assume the patchset is correct for you (modulo the few comments about=
=20
code), right ?

As the sysctl is some kind of ABI, I would like to make sure we reach a=
=20
consensus and discuss a bit about that.

I understand Rafael and Amit could be reluctant with the power supply t=
o=20
be hardcoded. As mentioned Amit, we may want to switch to 'power' if th=
e=20
thermal framework tells us we are reaching a threshold. For example, th=
e=20
system is set to 'auto', we are on battery, thus the current policy is=20
'power', we plug the device, the current policy will switch to=20
'performance' but the thermal framework may want to do 'power' because=20
of some thermal constraint.

IMO, the power supply part could be extended to take into account the=20
thermal.

The other point is, I guess, what should do the 'power' policy ? pack=20
tasks or not ? Override the cpuidle governor and choose the deeper idle=
=20
states or not ? etc ... So in other words, how can we put a cursor=20
between 'performance' and 'power'. Knowing on some platform one may be=20
more efficient than another platform.

IIUC, 'performance' for you means 'max performance' and 'power' means=20
'max power', and a list of sysctl for each power/performance option giv=
e=20
us the knobs to tune one or another policy ? (Each platform defining it=
s=20
own options)

Would this approach be ok ?

Thanks

   -- Daniel







--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

