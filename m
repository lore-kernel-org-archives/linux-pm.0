From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 3/4] intel_pstate: add sample time scaling
Date: Mon, 9 Jun 2014 08:58:27 -0700
Message-ID: <001601cf83fb$a7652f50$f62f8df0$@net>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com> <1401381145-17745-4-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta3.telus.net ([209.171.16.76]:58098 "EHLO cmta3.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933265AbaFIP6a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Jun 2014 11:58:30 -0400
In-Reply-To: <1401381145-17745-4-git-send-email-dirk.j.brandewie@intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>, stable@vger.kernel.org, Doug Smythies <dsmythies@telus.net>


On 2014.05.29 09:32 Dirk wrote:

> From: Dirk Brandewie <dirk.j.brandewie@intel.com>

> The PID assumes that samples are of equal time, which for a deferable
> timers this is not true when the system goes idle.  This causes the
> PID to take a long time to converge to the min P state and depending
> on the pattern of the idle load can make the P state appear stuck.

> The hold-off value of three sample times before using the scaling is
> to give a grace period for applications that have high performance
> requirements and spend a lot of time idle,  The poster child for this
> behavior is the ffmpeg benchmark in the Phoronix test suite.

> Cc: <stable@vger.kernel.org> # 3.14.x
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
> drivers/cpufreq/intel_pstate.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index db8a992..c4dad16 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -58,6 +58,7 @@ struct sample {
> 	u64 aperf;
> 	u64 mperf;
> 	int freq;
> +	ktime_t time;
> };
> 
> struct pstate_data {
> @@ -93,6 +94,7 @@ struct cpudata {
> 	struct vid_data vid;
> 	struct _pid pid;
> 
> +	ktime_t last_sample_time;
> 	u64	prev_aperf;
> 	u64	prev_mperf;
> 	struct sample sample;
> @@ -576,6 +578,8 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
> 	aperf = aperf >> FRAC_BITS;
> 	mperf = mperf >> FRAC_BITS;
> 
> +	cpu->last_sample_time = cpu->sample.time;
> +	cpu->sample.time = ktime_get();
> 	cpu->sample.aperf = aperf;
>	cpu->sample.mperf = mperf;
> 	cpu->sample.aperf -= cpu->prev_aperf;
> @@ -598,12 +602,24 @@ static inline void intel_pstate_set_sample_time(struct cpudata *cpu)
> 
> static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
> {
> -	int32_t core_busy, max_pstate, current_pstate;
> +	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> +	u32 duration_us;
> +	u32 sample_time;
> 
> 	core_busy = cpu->sample.core_pct_busy;
> 	max_pstate = int_tofp(cpu->pstate.max_pstate);
> 	current_pstate = int_tofp(cpu->pstate.current_pstate);
> 	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
> +
> +	sample_time = (pid_params.sample_rate_ms  * USEC_PER_MSEC);
> +	duration_us = (u32) ktime_us_delta(cpu->sample.time,
> +					cpu->last_sample_time);
> +	if (duration_us > sample_time * 3) {
> +		sample_ratio = div_fp(int_tofp(sample_time),
> +				int_tofp(duration_us));
> +		core_busy = mul_fp(core_busy, sample_ratio);
> +	}
> +
> 	return core_busy;
> }
> 
> -- 
> 1.9.0

The inclusion of deferrable timer run times subjects
this driver to any issues with them. Indeed, there
seems to be a problem with the deferrable timers
and periodic workflows that can result in the driver
incorrectly pushing the CPU frequency downwards.

This driver will suffer collateral damage if the
root issue is not fixed.

Summary:

For the periodic cases where the CPU wakes up and does
its chunk of work and goes back to sleep all within
one jiffy boundary, the deferred timer system does not
realize this situation has occurred and the driver is
not called. Eventually the driver is called and this
patch kicks in and applies downward pressure on
the CPU frequency.

A perfect example (1000 Hz kernel):

Consider a periodic workflow that has 600 microseconds
of work to do at 100 hertz, and the job is started
asynchronously with respect to the current jiffy count.
Then it is 40% probable that the CPU frequency will
be pushed to minimum, whereas (on my system) it should
be about 2.4 GHz. The intel_pstate driver gets called
only once in every 4 seconds.

I did this 360 times and got the CPU frequency forced
down on 38% of the runs (136 times out of 360).

A simple method to check using timer stats:

The script:

doug@s15:~/temp$ cat set_cpu_timer_stats
#! /bin/bash
# Reset the counters
echo "0" > /proc/timer_stats
echo "1" > /proc/timer_stats
# Apply a 6 percent load at 100 hertz for 20 seconds
taskset -c 5 /home/doug/c/consume 6.0 100.0 20.0 &
sleep 10
# What is the CPU 5 frequency?
echo -n "CPU 5 frequency (~ 1.6 GHz means forced low, ~2.4 GHz means O.K.): "
cat /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq
sleep 11
cat /proc/timer_stats | grep intel

An example where the work is all done within one jiffy:

Notice the CPU frequency is pinned low and there are only
a few timer calls in the 20 seconds.
 
doug@s15:~/temp$ sudo ./set_cpu_timer_stats
CPU 5 frequency (~ 1.6 GHz means forced low, ~2.4 GHz means O.K.): 1599992
consume: 6.0 100.0 20.0  PID: 7530  Elapsed: 20000099  Now: 1402323478790491
  19D,     0 swapper/6        intel_pstate_timer_func (intel_pstate_timer_func)
  28D,     0 swapper/5        intel_pstate_timer_func (intel_pstate_timer_func)
  29D,     0 swapper/3        intel_pstate_timer_func (intel_pstate_timer_func)
  20D,     0 swapper/1        intel_pstate_timer_func (intel_pstate_timer_func)
   9D,     0 swapper/7        intel_pstate_timer_func (intel_pstate_timer_func)
  35D,     0 swapper/2        intel_pstate_timer_func (intel_pstate_timer_func)
  12D,     0 swapper/0        intel_pstate_timer_func (intel_pstate_timer_func)
  16D,     0 swapper/4        intel_pstate_timer_func (intel_pstate_timer_func)

An example where the work spans a jiffy boundary:
Notice the CPU frequency is not pinned low and there are
the expected ~ 2000 driver calls.

doug@s15:~/temp$ sudo ./set_cpu_timer_stats
CPU 5 frequency (~ 1.6 GHz means forced low, ~2.4 GHz means O.K.): 2409750
consume: 6.0 100.0 20.0  PID: 7543  Elapsed: 20000099  Now: 1402323597033729
   8D,     0 swapper/4        intel_pstate_timer_func (intel_pstate_timer_func)
2004D,     0 swapper/5        intel_pstate_timer_func (intel_pstate_timer_func)
  43D,     0 swapper/3        intel_pstate_timer_func (intel_pstate_timer_func)
  35D,     0 swapper/2        intel_pstate_timer_func (intel_pstate_timer_func)
  24D,     0 swapper/1        intel_pstate_timer_func (intel_pstate_timer_func)
  20D,     0 swapper/6        intel_pstate_timer_func (intel_pstate_timer_func)
   8D,     0 swapper/7        intel_pstate_timer_func (intel_pstate_timer_func)
  10D,     0 swapper/0        intel_pstate_timer_func (intel_pstate_timer_func)

O.K. the above was a perfect example, done specifically
for dramatic effect and for best exposure of the issue.
What about the more generic, but still periodic, case?

Well, then it comes down to beat frequencies between the
process and the jiffy boundaries. I have run a great many
different work/sleep frequencies and there are lots of
cases where the driver call is deferred enough to cause
this patch code to engage incorrectly. However in these
scenarios the CPU frequency will oscillate in step with
the beat frequency (I can supply a graph if needed).

Note: Yes, fixed time work chunks does not consider the
more realistic scenario where the work time would scale
with CPU frequency. That just changes the threshold for
the issue, but not the root issue itself.

Note: Work was done on a 1000 Hz (1 jiffy = 1 mS) kernel.
The issue is 4 times worse for 250 Hz kernels.

Note: It has taken me until now to get to this point,
such that I could comment on-list. One, of many, issues
hindering progress, was that I was originally using
a 250 Hertz Kernel and Dirk Brandewie was using a
1000 Hertz Kernel. So I would ask Dirk to verify
something and it would be fine for him.

Note: I would need help to isolate the root issue
further. I got lost in timer.c and the mapping
.h file (I can not recall the name).

... Doug


