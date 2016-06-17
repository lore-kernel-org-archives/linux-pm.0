From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression caused by 08f511fd41c3 ("cpufreq: Reduce
 cpufreq_update_util() overhead a bit")
Date: Fri, 17 Jun 2016 15:09:36 +0200
Message-ID: <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
References: <20160617163023.5bb374f8@xhacker> <20160617164054.6339c5d4@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617164054.6339c5d4@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 10:40 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Dear all,
>
> On Fri, 17 Jun 2016 16:30:23 +0800 Jisheng Zhang wrote:
>
>> Dear all,
>>
>> I found one regression: In an idle system, wakeups/s (reported by powertop)
>> is increased a lot, e.g on a intel snb 4 core platform, the wakeup event
>> number is increased from 8 wakeups/s to 24 wakeup/s. bisect points to
>> this commit. I could send detailed bisect log if it's wanted.
>>
>
> more information maybe useful: after the commit, the top two wakeup source
> are
>
>         Process        [rcu_sched]
>
>         Timer          tick_sched_timer

And what was there before the commit?

Granted, I'm not seeing this on my systems.

Paul, Peter, any ideas about what may be going on here?

Thanks,
Rafael
