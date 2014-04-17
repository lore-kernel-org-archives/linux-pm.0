From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Thu, 17 Apr 2014 17:03:47 +0200
Message-ID: <534FED53.2030804@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <20140417144707.GL11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:43256 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaDQPDZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Apr 2014 11:03:25 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so566644wes.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2014 08:03:24 -0700 (PDT)
In-Reply-To: <20140417144707.GL11096@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/17/2014 04:47 PM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 03:53:32PM +0200, Daniel Lezcano wrote:
>> Concerning the policy, I would suggest to create an entry in
>> /proc/sys/kernel/sched_power, where a couple of values could be perf=
ormance
>> - power saving (0 / 1).
>
> Ingo wanted a sched_balance_policy file with 3 values:
>    "performance, power, auto"
>
> Where the auto thing switches between them, initially based off of
> having AC or not.

oh, good. Thanks !


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

