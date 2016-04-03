From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH RESEND] smp: make wake up idle cpus more generic
Date: Sun, 3 Apr 2016 00:10:54 -0700
Message-ID: <CAJFUiJhD1MVoO8aULspxn6cDeqPctsxtCoS-TNEjOyXf6B0YLg@mail.gmail.com>
References: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com>
 <20160401070758.GA28352@gmail.com> <CAJFUiJiHDmhPOnO6NYnTnvaXMaB6E3Jc9MSau-juq2BtHWq-Qg@mail.gmail.com>
 <56FFC4D0.4090609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35257 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcDCHLQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2016 03:11:16 -0400
In-Reply-To: <56FFC4D0.4090609@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Apr 2, 2016 at 6:10 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 04/02/2016 08:15 AM, Lianwei Wang wrote:
>>>
>>>
>>> * Lianwei Wang <lianwei.wang@gmail.com> wrote:
>>>
>>>> The wake_up_all_idle_cpus API always wake up all the online
>>>> cpus, but sometimes we only want to wake up a set of cpus.
>>>> Use a generic function to wake up a group of cpus that is
>>>> specified by the cpumask parameter. This generic API can
>>>> benefit to the cases that only need to wake up a set of
>>>> cpus.
>>>
>>>
>>> What is the new user of this new argument to the wake-up call?
>>>
>>> Thanks,
>>>
>>>          Ingo
>>
>>
>> The ARM big.LITTLE arch is one of the users to use the new wake up
>> call. Two clusters in these SoCs and each cluster has 2 or more CPUs=
=2E
>> For some cases, we only need to wake up the cpus on one cluster, not
>> all the cpus. The other cluster can keep in idle state to save power=
=2E
>> Another use case is that for the threads/irqs that bind to some cpus=
,
>> we also want to wake up the cpus that the threads/irqs bind to, and
>> the other cpus can stay in idle state. I'm updating the pm_qos code =
to
>> support binding the request to a set of cpus, and the
>> cpuidle_latency_notify call can pass the cpumask parameter to the ne=
w
>> wake-up call.
>
>
> Hi Lianwei,
>
> a quick suggestion : cpuidle_driver->cpumask
>
>   -- Daniel
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Yes, Daniel. Send a cpumask to cpuidle_driver from pm_qos. Did you do
it already? Or are you planing to do it?
