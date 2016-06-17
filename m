From: Jisheng Zhang <jszhang@marvell.com>
Subject: RE: regression caused by bb6ab52f2bef ("intel_pstate: Do not set
 utilization update hook too early")
Date: Fri, 17 Jun 2016 15:32:00 +0000
Message-ID: <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
References: <20160617163023.5bb374f8@xhacker>
 <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com>,<20160617140353.GQ30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617140353.GQ30154@twins.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

First of all, sorry for top post, only webmail is available now.

Second, sorry again for report incorrect commit, I were too tired this morning so I remember the wrong commit.  The regression is caused by bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too early"), so I update the email title.

here is the bisect log:

# good: [9735a22799b9214d17d3c231fe377fc852f042e9] Linux 4.6-rc2
git bisect good 9735a22799b9214d17d3c231fe377fc852f042e9

# bad: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
git bisect bad bf16200689118d19de1b8d2a3c314fc21f5dc7bb

# good: [839a3f765728cdca0057a12e2dc0bf669ac1c22e] Merge branch 'for-linus-4.6' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs
git bisect good 839a3f765728cdca0057a12e2dc0bf669ac1c22e

# bad: [63b106a87dd84283e21aa2ce476732633eaab11d] Merge tag 'md/4.6-rc2-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/shli/md
git bisect bad 63b106a87dd84283e21aa2ce476732633eaab11d

# good: [30d237a6c2e9be1bb816fe8e787b88fd7aad833b] Merge tag 'mac80211-for-davem-2016-04-06' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211
git bisect good 30d237a6c2e9be1bb816fe8e787b88fd7aad833b

# bad: [fa81e66ec8648f62e96e95e53db2ea95a4b57b26] Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'acpi-cppc'
git bisect bad fa81e66ec8648f62e96e95e53db2ea95a4b57b26

# good: [08820546e4c30c84d0a1f1a49df055e1719c07ea] intel_idle: Propagate hot plug errors.
git bisect good 08820546e4c30c84d0a1f1a49df055e1719c07ea

# bad: [b318556479cc923970a79d6c2311138581c0db83] cpufreq: dt: Drop stale comment
git bisect bad b318556479cc923970a79d6c2311138581c0db83

# bad: [febce40febcff3ccdb33f63456ffc4cfc61640c8] intel_pstate: Avoid extra invocation of intel_pstate_sample()
git bisect bad febce40febcff3ccdb33f63456ffc4cfc61640c8

# bad: [bb6ab52f2befe1fb29ac198f27d8a6aadf510f81] intel_pstate: Do not set utilization update hook too early
git bisect bad bb6ab52f2befe1fb29ac198f27d8a6aadf510f81

# first bad commit: [bb6ab52f2befe1fb29ac198f27d8a6aadf510f81] intel_pstate: Do not set utilization update hook too early


________________________________________
From: Peter Zijlstra [peterz@infradead.org]
Sent: Friday, June 17, 2016 22:03
To: Paul E. McKenney
Cc: Rafael J. Wysocki; Jisheng Zhang; Rafael J. Wysocki; Viresh Kumar; linux-pm@vger.kernel.org; Linux Kernel Mailing List
Subject: Re: regression caused by 08f511fd41c3 ("cpufreq: Reduce cpufreq_update_util() overhead a bit")

On Fri, Jun 17, 2016 at 06:16:51AM -0700, Paul E. McKenney wrote:
> > Paul, Peter, any ideas about what may be going on here?
>
> Looks to me like this commit moved some code from synchronize_rcu() to
> synchronize_sched().  Assuming that this is a CONFIG_PREEMPT=y system,
> might there have been a decrease in the wakeups from the rcu_preempt
> kthread?

The 'funny' thing is though; those synchronize thingies are only reached
when we change cpufreq policy, so things like:

  for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ; do echo performance > $i ; done

Something which is hardly possible when idle. Weird.
