From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle
 info
Date: Wed, 02 Apr 2014 10:26:31 +0200
Message-ID: <533BC9B7.3010501@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <22904760.5rGZuP5nsx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59552 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbaDBI0R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Apr 2014 04:26:17 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so6602437wiv.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Apr 2014 01:26:16 -0700 (PDT)
In-Reply-To: <22904760.5rGZuP5nsx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/02/2014 01:01 AM, Rafael J. Wysocki wrote:
> On Friday, March 28, 2014 01:29:53 PM Daniel Lezcano wrote:
>> The following patchset provides an interaction between cpuidle and t=
he scheduler.
>>
>> The first patch encapsulate the needed information for the scheduler=
 in a
>> separate cpuidle structure. The second one stores the pointer to thi=
s structure
>> when entering idle. The third one, use this information to take the =
decision to
>> find the idlest cpu.
>>
>> After some basic testing with hackbench, it appears there is an impr=
ovement for
>> the performances (small) and for the duration of the idle states (wh=
ich provides
>> a better power saving).
>>
>> The measurement has been done with the 'idlestat' tool previously po=
sted in this
>> mailing list.
>>
>> So the benefit is good for both sides performance and power saving.
>>
>> The select_idle_sibling could be also improved in the same way.
>
> Well, quite frankly, I don't really like this series.  Not the idea i=
tself, but
> the way it has been implemented.
>
> First off, if the scheduler is to access idle state data stored in st=
ruct
> cpuidle_state, I'm not sure why we need a separate new structure for =
that?
> Couldn't there be a pointer to a whole struct cpuidle_state from stru=
ct rq
> instead?  [->exit_latency is the only field that find_idlest_cpu() in=
 your
> third patch seems to be using anyway.]

Hi Rafael,

thank you very much for reviewing the patchset.

I created a specific structure to encapsulate the informations needed=20
for the scheduler and to prevent to export unneeded data. This is purel=
y=20
for code design. Also it was to separate the idle's energy=20
characteristics from the cpuidle framework data (flags, name, etc ...).

The exit_latency field is only used in this patchset but the=20
target_residency will be used also (eg. prevent to wakeup a cpu before=20
the minimum idle time target residency).

The power field is ... hum ... not filled by any board (except for=20
calxeda). Vendors do not like to share this information, so very likely=
=20
that would be changed to a normalized value, I don't know.

I agree we can put a pointer to the struct cpuidle_state instead if tha=
t=20
reduce the impact of the patchset.

> Second, is accessing the idle state information for all CPUs from fin=
d_idlest_cpu()
> guaranteed to be non-racy?  I mean, what if a CPU changes its state f=
rom idle to
> non-idle while another one is executing find_idlest_cpu()?  In other =
words,
> where's the read memory barrier corresponding to the write ones in th=
e modified
> cpu_idle_call()?  And is the memory barrier actually sufficient?  Aft=
er all,
> you need to guarantee that the CPU is still idle after you have evalu=
ated
> idle_cpu() on it.

Well, as Nicolas mentioned it in another mail, we can live with races,=20
the scheduler will take a wrong decision but nothing worth than what we=
=20
have today. In any case we want to prevent any lock in the code.

> Finally, is really the heuristics used by find_idlest_cpu() to select=
 the "idlest"
> CPU the best one?  What about deeper vs shallower idle states, for ex=
ample?

I believe it is what is supposed to do the patchset. 1. if the cpu is=20
idle, pick the shallower, 2. if the cpu is not idle pick the less=20
loaded. But may be there is something wrong in the routine as pointed=20
Nico, I have to double check it.

Thanks !

   -- Daniel




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

