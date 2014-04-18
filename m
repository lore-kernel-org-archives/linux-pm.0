From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 10:36:53 +0200
Message-ID: <5350E425.6070300@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <20140417144707.GL11096@twins.programming.kicks-ass.net> <534FED53.2030804@linaro.org> <20140418080951.GB14280@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:48218 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbaDRIga (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Apr 2014 04:36:30 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so477872wib.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2014 01:36:29 -0700 (PDT)
In-Reply-To: <20140418080951.GB14280@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/18/2014 10:09 AM, Ingo Molnar wrote:
>
> * Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>> On 04/17/2014 04:47 PM, Peter Zijlstra wrote:
>>> On Thu, Apr 17, 2014 at 03:53:32PM +0200, Daniel Lezcano wrote:
>>>> Concerning the policy, I would suggest to create an entry in
>>>> /proc/sys/kernel/sched_power, where a couple of values could be pe=
rformance
>>>> - power saving (0 / 1).
>>>
>>> Ingo wanted a sched_balance_policy file with 3 values:
>>>    "performance, power, auto"
>>>
>>> Where the auto thing switches between them, initially based off of
>>> having AC or not.
>>
>> oh, good. Thanks !
>
> Also, 'auto' should be the default, because the kernel doing TRT is
> really what users want.
>
> Userspace can sill tweak it all and make it all user-space controlled=
,
> by flipping between 'performance' and 'power'. (and those modes are
> also helpful for development and debugging.)

Copy that.

   Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

