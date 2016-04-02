From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH RESEND] smp: make wake up idle cpus more generic
Date: Fri, 1 Apr 2016 23:15:10 -0700
Message-ID: <CAJFUiJiHDmhPOnO6NYnTnvaXMaB6E3Jc9MSau-juq2BtHWq-Qg@mail.gmail.com>
References: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com> <20160401070758.GA28352@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34518 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcDBGPc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2016 02:15:32 -0400
In-Reply-To: <20160401070758.GA28352@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>

>
> * Lianwei Wang <lianwei.wang@gmail.com> wrote:
>
>> The wake_up_all_idle_cpus API always wake up all the online
>> cpus, but sometimes we only want to wake up a set of cpus.
>> Use a generic function to wake up a group of cpus that is
>> specified by the cpumask parameter. This generic API can
>> benefit to the cases that only need to wake up a set of
>> cpus.
>
> What is the new user of this new argument to the wake-up call?
>
> Thanks,
>
>         Ingo

The ARM big.LITTLE arch is one of the users to use the new wake up
call. Two clusters in these SoCs and each cluster has 2 or more CPUs.
For some cases, we only need to wake up the cpus on one cluster, not
all the cpus. The other cluster can keep in idle state to save power.
Another use case is that for the threads/irqs that bind to some cpus,
we also want to wake up the cpus that the threads/irqs bind to, and
the other cpus can stay in idle state. I'm updating the pm_qos code to
support binding the request to a set of cpus, and the
cpuidle_latency_notify call can pass the cpumask parameter to the new
wake-up call.

Maybe someone else can find new user to play with the generic wake-up
call in the future.

Thanks,
Lianwei
