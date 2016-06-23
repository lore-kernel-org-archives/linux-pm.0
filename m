From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: regression caused by bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too early")
Date: Thu, 23 Jun 2016 09:07:28 -0700
Message-ID: <001501d1cd69$5880c7f0$098257d0$@net>
References: <20160617163023.5bb374f8@xhacker> <20160617164054.6339c5d4@xhacker> <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com> <20160617131651.GU3923@linux.vnet.ibm.com>,<20160617140353.GQ30154@twins.programming.kicks-ass.net> <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jisheng Zhang' <jszhang@marvell.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, "'Paul E. McKenney'" <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 2016.06.17 08:32 Jisheng Zhang wrote:

> Second, sorry again for report incorrect commit, 
> I were too tired this morning so I remember the wrong commit.
> The regression is caused by bb6ab52f2bef ("intel_pstate: Do not
> set utilization update hook too early"), so I update the email title.

Summary:

Isn't running powertop itself a significant contributor here?

When running powertop, the system is no longer "idle".
Powertop has a significant effect on a system that achieves such a quite "idle state".
If one uses a kernel that includes the later commit:
"intel_pstate: Avoid extra invocation of intel_pstate_sample()"
then there are many skipped samples when running powertop.

To some extent, some increase in wakeups per second, is what was supposed to
happen with the recent changes, and is what solved the very long standing issue
of failing to raise the CPU frequency when high enough periodic loads just so
happened to be idle on jiffy boundaries. Admittedly, I am somewhat confusing
wakeups per second with number of passes through the intel_pstate driver
per second here.

Details:

Note 1: On my system (server, no GUI), I could only get down to an "idle" of around
20 wakeups / second, after turning off Samba, mysql, apache, cron.

Using kernel 4.7-rc3 (and then later 4.7-rc4), I observed significant impact when running powertop.
(I also isolated this to the same commit, bb6ab52f2bef)
As a function of sample time:
Sample time (seconds)	Events/second
300				~20
200				~20
100				~22
 50				~29
 30				~33
 20				~44
  3				~155

Instead of using powertop, if I observe timer stats manually I get ~20 wakeups / second.
If I use an older kernel (4.4 ish) I get ~20 wakeups per second.

If I leave mysql running, chosen because while idling it has a fairly high number
of events per second, no increase in wakeups per second is observed before or after the commit
in question here (it is always around 25 Events / second).

Using a kernel that includes the commit
"intel_pstate: Avoid extra invocation of intel_pstate_sample()"
and running powertop with a sample interval of 5 seconds, just to increase
the number of events per second, then intel_pstate samples are skipped at
a rate of about 200 per minute, and some trace data makes no sense at all. Besides the
skipped samples, sometimes the new pstate is set to maximum for no apparent reason.
It seems that powertop messes with the minimum frequency, sometimes setting it
to the maximum turbo value (presumably at a rate of about 100 per minute,
causing one skip when setting it high and one skip when it is restored) Example:

The following script was run while running powertop:

#!/bin/dash

echo "watch minimum frequency. Doug Smythies 2016.06.23"
echo "I think powertop messes with the minimum frequency. Try to catch it."
echo "If I use watch, with -g, it exits but doesn't leave the display showing the numbers."
echo
  cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq > watch_min
while [ 1 ];
do
  echo "." >> watch_min
# Don't hog too much CPU, even though it makes it harder to get a hit
  sleep 0.2
  cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq >> watch_min
done

In the resulting file several occurrences similar to the below are observed:

.
1600000
3800000   <<<<<<<<<< ????
1600000
1600000
1600000
1600000
1600000
1600000
.
1600000
1600000
1600000
1600000
1600000
1600000
1600000
1600000
.

On my, otherwise idle, system package power goes up by about 1 watt while running powertop
(with a sample time of 5 seconds) (from ~3.9 to ~4.9 watts).

> here is the bisect log:
>
> # good: [9735a22799b9214d17d3c231fe377fc852f042e9] Linux 4.6-rc2
> git bisect good 9735a22799b9214d17d3c231fe377fc852f042e9
> # bad: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
> git bisect bad bf16200689118d19de1b8d2a3c314fc21f5dc7bb
> # good: [839a3f765728cdca0057a12e2dc0bf669ac1c22e] Merge branch 'for-linus-4.6' of
git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs
> git bisect good 839a3f765728cdca0057a12e2dc0bf669ac1c22e
> # bad: [63b106a87dd84283e21aa2ce476732633eaab11d] Merge tag 'md/4.6-rc2-fix' of
git://git.kernel.org/pub/scm/linux/kernel/git/shli/md
> git bisect bad 63b106a87dd84283e21aa2ce476732633eaab11d
> # good: [30d237a6c2e9be1bb816fe8e787b88fd7aad833b] Merge tag 'mac80211-for-davem-2016-04-06' of
git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211
> git bisect good 30d237a6c2e9be1bb816fe8e787b88fd7aad833b
> # bad: [fa81e66ec8648f62e96e95e53db2ea95a4b57b26] Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'acpi-cppc'
> git bisect bad fa81e66ec8648f62e96e95e53db2ea95a4b57b26
> # good: [08820546e4c30c84d0a1f1a49df055e1719c07ea] intel_idle: Propagate hot plug errors.
> git bisect good 08820546e4c30c84d0a1f1a49df055e1719c07ea
> # bad: [b318556479cc923970a79d6c2311138581c0db83] cpufreq: dt: Drop stale comment
> git bisect bad b318556479cc923970a79d6c2311138581c0db83
> # bad: [febce40febcff3ccdb33f63456ffc4cfc61640c8] intel_pstate: Avoid extra invocation of intel_pstate_sample()
> git bisect bad febce40febcff3ccdb33f63456ffc4cfc61640c8
> # bad: [bb6ab52f2befe1fb29ac198f27d8a6aadf510f81] intel_pstate: Do not set utilization update hook too early
> git bisect bad bb6ab52f2befe1fb29ac198f27d8a6aadf510f81
> # first bad commit: [bb6ab52f2befe1fb29ac198f27d8a6aadf510f81] intel_pstate: Do not set utilization update hook too early
