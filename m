From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Thu, 17 Apr 2014 18:05:07 +0200
Message-ID: <534FFBB3.8050601@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59015 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaDQQEo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Apr 2014 12:04:44 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so620882wgg.18
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2014 09:04:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/17/2014 05:53 PM, Nicolas Pitre wrote:
> On Thu, 17 Apr 2014, Daniel Lezcano wrote:
>
>> Ok, refreshed the patchset but before sending it out I would to disc=
uss about
>> the rational of the changes and the policy, and change the patchset
>> consequently.
>>
>> What order to choose if the cpu is idle ?
>>
>> Let's assume all cpus are idle on a dual socket quad core.
>>
>> Also, we can reasonably do the hypothesis if the cluster is in low p=
ower mode,
>> the cpus belonging to the same cluster are in the same idle state (p=
utting
>> apart the auto-promote where we don't have control on).
>>
>> If the policy you talk above is 'aggressive power saving', we can fo=
llow the
>> rules with decreasing priority:
>>
>> 1. We want to prevent to wakeup the entire cluster
>> 	=3D> as the cpus are in the same idle state, by choosing a cpu in
>> 	=3D> shallow
>> state, we should have the guarantee we won't wakeup a cluster (excep=
t if no
>> shallowest idle cpu are found).
>
> This is unclear to me.  Obviously, if an entire cluster is down, that
> means all the CPUs it contains have been idle for a long time.  And
> therefore they shouldn't be subject to selection unless there is no
> other CPUs available.  Is that what you mean?

Yes, this is what I meant. But also what I meant is we can get rid for=20
the moment of the cpu topology and the coupling idle state because if w=
e=20
do this described approach, as the idle state will be the same for the=20
cpus belonging to the same cluster we won't select a cluster down=20
(except if there is no other CPUs available).

>> 2. We want to prevent to wakeup a cpu which did not reach the target=
 residency
>> time (will need some work to unify cpuidle idle time and idle task r=
un time)
>> 	=3D> with the target residency and, as a first step, with the idle
>> 	=3D> stamp,
>> we can determine if the cpu slept enough
>
> Agreed. However, right now, the scheduler does not have any
> consideration for that.  So this should be done as a separate patch.

Yes, I thought as a very first step we can rely on the idle stamp until=
=20
we unify the times with a big comment. Or I can first unify the idle=20
times and then take into account the target residency. It is to comply=20
with Rafael's request to have the 'big picture'.

>> 3. We want to prevent to wakeup a cpu in deep idle state
>> 	=3D> by looking for the cpu in shallowest idle state
>
> Obvious.
>
>> 4. We want to prevent to wakeup a cpu where the exit latency is long=
er than
>> the expected run time of the task (and the time to migrate the task =
?)
>
> Sure.  That would be a case for using task packing even if the policy=
 is
> set to performance rather than powersave whereas task packing is
> normally for powersave.

Yes, I agree, task packing improves also the performances and it makes=20
really sense to prevent task migration under some circumstances for a=20
better cache efficiency.

Thanks for the comments

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

