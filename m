From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RESEND] smp: make wake up idle cpus more generic
Date: Sat, 2 Apr 2016 15:10:40 +0200
Message-ID: <56FFC4D0.4090609@linaro.org>
References: <1459489819-20435-1-git-send-email-lianwei.wang@gmail.com>
 <20160401070758.GA28352@gmail.com>
 <CAJFUiJiHDmhPOnO6NYnTnvaXMaB6E3Jc9MSau-juq2BtHWq-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJFUiJiHDmhPOnO6NYnTnvaXMaB6E3Jc9MSau-juq2BtHWq-Qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>, Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 04/02/2016 08:15 AM, Lianwei Wang wrote:
>>
>> * Lianwei Wang <lianwei.wang@gmail.com> wrote:
>>
>>> The wake_up_all_idle_cpus API always wake up all the online
>>> cpus, but sometimes we only want to wake up a set of cpus.
>>> Use a generic function to wake up a group of cpus that is
>>> specified by the cpumask parameter. This generic API can
>>> benefit to the cases that only need to wake up a set of
>>> cpus.
>>
>> What is the new user of this new argument to the wake-up call?
>>
>> Thanks,
>>
>>          Ingo
>
> The ARM big.LITTLE arch is one of the users to use the new wake up
> call. Two clusters in these SoCs and each cluster has 2 or more CPUs.
> For some cases, we only need to wake up the cpus on one cluster, not
> all the cpus. The other cluster can keep in idle state to save power.
> Another use case is that for the threads/irqs that bind to some cpus,
> we also want to wake up the cpus that the threads/irqs bind to, and
> the other cpus can stay in idle state. I'm updating the pm_qos code t=
o
> support binding the request to a set of cpus, and the
> cpuidle_latency_notify call can pass the cpumask parameter to the new
> wake-up call.

Hi Lianwei,

a quick suggestion : cpuidle_driver->cpumask

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
