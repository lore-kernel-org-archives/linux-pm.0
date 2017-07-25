From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 2/4 v2] x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
Date: Tue, 25 Jul 2017 15:32:14 -0700
Message-ID: <006201d30595$e0a23870$a1e6a950$@net>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> OdMzdCn8EoQc4OdN0dPPUw
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:38254 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdGYWka (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jul 2017 18:40:30 -0400
In-Reply-To: OdMzdCn8EoQc4OdN0dPPUw
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>, rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>

Sorry to be late to the party on this one:

On 2017.06.23 10:12 Len Brown wrote:

> The goal of this change is to give users a uniform and meaningful
> result when they read /sys/...cpufreq/scaling_cur_freq
> on modern x86 hardware, as compared to what they get today.

Myself, I like what I got then, and not what I get now.

> Modern x86 processors include the hardware needed
> to accurately calculate frequency over an interval --
> APERF, MPERF, and the TSC.
> 
> Here we provide an x86 routine to make this calculation
> on supported hardware, and use it in preference to any
> driver driver-specific cpufreq_driver.get() routine.
> 
> MHz is computed like so:
> 
> MHz = base_MHz * delta_APERF / delta_MPERF

Yes, thanks very much.

> MHz is the average frequency of the busy processor
> over a measurement interval.  The interval is
> defined to be the time between successive invocations
> of aperfmperf_khz_on_cpu(), which are expected to to
> happen on-demand when users read sysfs attribute
> cpufreq/scaling_cur_freq.

Yes but that can be hours apart, resulting in useless information.
This threw me for a loop for several days.
 
> As with previous methods of calculating MHz,
> idle time is excluded.

Which makes the response time to a correct answer
asymmetric. i.e. removal of a load on a CPU will
linger much much longer that adding a load on a CPU.

> base_MHz above is from TSC calibration global "cpu_khz".

Yes, thank you very much.

> This x86 native method to calculate MHz returns a meaningful result
> no matter if P-states are controlled by hardware or firmware
> and/or if the Linux cpufreq sub-system is or is-not installed.
>
> When this routine is invoked more frequently, the measurement
> interval becomes shorter.  However, the code limits re-computation
> to 10ms intervals so that average frequency remains meaningful.
>
> Discerning users are encouraged to take advantage of
> the turbostat(8) utility, which can gracefully handle
> concurrent measurement intervals of arbitrary length.

Somehow, somewhere along the way, turbostat no longer seems
to use base_MHz based on the actual TSC. It used to.
 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> arch/x86/kernel/cpu/Makefile     |  1 +
> arch/x86/kernel/cpu/aperfmperf.c | 79 ++++++++++++++++++++++++++++++++++++++++
> drivers/cpufreq/cpufreq.c        | 12 +++++-
> include/linux/cpufreq.h          |  2 +
> 4 files changed, 93 insertions(+), 1 deletion(-)
> create mode 100644 arch/x86/kernel/cpu/aperfmperf.c

... [deleted some] ...

> + * aperfmperf_snapshot_khz()
> + * On the current CPU, snapshot APERF, MPERF, and jiffies
> + * unless we already did it within 10ms

Well, it'll be 8 mSec on a 250 Hz kernel.
There is no maximum time defined, so the interval can be anything,
and therefore the result can be dominated by stale information.

> + * calculate kHz, save snapshot
> + */
> +static void aperfmperf_snapshot_khz(void *dummy)
> +{
> +	u64 aperf, aperf_delta;
> +	u64 mperf, mperf_delta;
> +	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
> +
> +	/* Don't bother re-computing within 10 ms */
> +	if (time_before(jiffies, s->jiffies + HZ/100))
> +		return;

The above condition would be 8 mSec on a 250 Hertz kernel,
wouldn't it?
(I don't care, I'm just saying.)
__________________________________

A long boring story is copied below, but it also includes my test data.

Summary:

. There no longer seems to be a way to check the CPU frequency without affecting the processor (i.e. forcing a wakeup),
thereby potentially influencing the system under test.
. Yes, the old way might have been a "lie", but in some situations it was much much less of a "lie", and took data that
was already available (and at the very maximum 4 seconds old), and didn't force a wakeup, thus monitoring CPU frequency
was a negligible perturbation to the system.
. Now the data is as old as the time the command was run, which might be hours.

For reference my test computer contains an i7-2600K processor, and TSC is 3411.1043 MHz. Minimum pstate 16.

I did follow the e-mail thread [1] about changes to the "cpu MHz" line from /proc/cpuinfo, and expected it to have changed,
and indeed, it only ever prints TSC now and never changes. Whereas with kernel 4.12 it printed the actual CPU frequency,
albeit with the limitations stated in the e-mail thread, which I have always understood and accepted. O.K. so now it
is useless as an actual CPU frequency inquiry tool.

Now, there are two other methods (well three if one includes turbostat) for observing CPU frequency:

The "sudo cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq" method, works the same as it
did in the past (well, there is another active thread about issues with it), but requires root access.
 
And the "cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq" method, which works fine
with kernel 4.12, but seems to give incorrect information with kernel 4.13-rc1, unless one inquires two or
more times and discards the first inquiry.

Test 1 data: 

Notes:
CPU 7 only. It is 100% busy all the time.
The CPU burn program prints a time stamp every N loops, as a way to do a sanity check on CPU frequency.
Sanity checks were also done by acquiring trace data.
Turbo is disabled, so the maximum CPU frequency is predicable and known, independent of what other cores are doing.
The data is not from the first loop through this test.

Data:
/sys/devices/system/cpu/intel_pstate/max_perf_pct: 100
Actual CPU 7 frequency: 3411104
Kernel 4.12: /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq: 3400000
Kernel 4.13-rc1: /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq: 3400000
Kernel 4.12: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 3400000
Kernel 4.13-rc1, 1st read: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 1765012*
Kernel 4.13-rc1, 2nd read: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 3411286

/sys/devices/system/cpu/intel_pstate/max_perf_pct: 42
Actual CPU 7 frequency: 1605225
Kernel 4.12: /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq: 1599768
Kernel 4.13-rc1: /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq: 1599975
Kernel 4.12: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 1599768
Kernel 4.13-rc1, 1st read: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 3309707*
Kernel 4.13-rc1, 2nd read: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 1605311

* The value listed for the first read is both a function of the time difference between
changing the maximum CPU frequency and the inquiry and how long since the last read the
actual CPU frequency was changed.

Data (for increase from 1.6 GHz to 3.4 GHz):
First read quickly (manually): 1765012
0.25 seconds to first read: 1663176
0.5 seconds to first read: 1671658
 1 seconds to first read: 1767889
 2 seconds to first read: 1872128
 3 seconds to first read: 1769770
 4 seconds to first read: 1814673
 5 seconds to first read: 2297147
10 seconds to first read: 2394407
20 seconds to first read: 2720619
30 seconds to first read: 2875374
2 minutes to first read: 3373563
5 minutes to first read: 3363630
10 minutes to first read: 3376521

Data (for decrease from 3.4 GHz to 1.6 GHz):
0.25 seconds to first read: 3381255
0.5 seconds to first read: 3323808
 1 seconds to first read: 3247873
 2 seconds to first read: 3090182
 3 seconds to first read: 3104870
 4 seconds to first read: 2837281
 5 seconds to first read: 2962827
10 seconds to first read: 2510951
20 seconds to first read: 2763956
30 seconds to first read: 2116198
2 minutes to first read: 1876923
5 minutes to first read: 1715839
10 minutes to first read: 1634040

Note: the above table was done more or less manually.

Test 2 data:

Just take the load off of CPU 7 and then look at its frequency (any amount of time later, I have yet to find a time limit):

Kernel 4.13-rc1, 1st read (1 minute after load removed): /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 3410964
Kernel 4.13-rc1, 2nd read (anytime after the 1st read): /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 1605326

Kernel 4.13-rc1, 1st read (24 minutes after load removed): /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 3268873
Kernel 4.13-rc1, 2nd read (anytime after the 1st read): /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: 1605233
 
[1] http://marc.info/?t=149766883400002&r=1&w=2

Note: now also tested with kernel 4.13-rc2.

... Doug
