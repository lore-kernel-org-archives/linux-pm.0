From: Mason <slash.tmp@free.fr>
Subject: schedule_timeout sleeps too long after dividing CPU frequency
Date: Tue, 12 May 2015 16:32:47 +0200
Message-ID: <55520F0F.5010906@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080704020907030400010002"
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704020907030400010002
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,

I'm working on a Cortex A9 based platform.

I have a basic clock tree, and a very basic cpufreq driver using
mostly generic driver glue:

static struct cpufreq_driver tangox_cpufreq_driver = {
	.name		= "tangox-cpufreq",
	.init		= tangox_cpu_init,
	.verify		= cpufreq_generic_frequency_table_verify,
	.target_index	= tangox_target,
	.get		= cpufreq_generic_get,
	.exit		= cpufreq_generic_exit,
	.attr		= cpufreq_generic_attr,
};

My target_index function is trivial:

static int tangox_target(struct cpufreq_policy *policy, unsigned int idx)
{
	return clk_set_rate(policy->clk, freq_table[idx].frequency * 1000);
}

I was testing an unrelated driver at low frequencies, with the nominal
frequency (999 MHz) divided by 54 (i.e. freq = 18.5 MHz) and I noticed
that when the driver calls

    schedule_timeout(HZ);

the thread sleeps 54 seconds instead of 1.

[ 1107.827279] Sleep for 300 jiffies.
[ 1161.838513] Done sleeping.

(I have HZ set to 300)

I enabled DEBUG in the generic cpufreq driver to see what happens
when I request a frequency change:

# cd /sys/devices/system/cpu/cpu0/cpufreq
# cat scaling_governor
performance
# cat scaling_available_frequencies
999000 499500 333000 199800 111000 18500
# echo 18500 > scaling_max_freq
[   19.597257] cpufreq: setting new policy for CPU 0: 18500 - 18500 kHz
[   19.604017] cpufreq: new min and max freqs are 18500 - 18500 kHz
[   19.610345] cpufreq: governor: change or update limits
[   19.615596] cpufreq: __cpufreq_governor for CPU 0, event 3
[   19.621186] cpufreq: target for CPU 0: 18500 kHz, relation 1, requested 18500 kHz
[   19.628783] cpufreq: __cpufreq_driver_target: cpu: 0, oldfreq: 999000, new freq: 18500
[   19.636818] cpufreq: notification 0 of frequency transition to 18500 kHz
[   19.643625] cpufreq: notification 0 of frequency transition to 18500 kHz
[   19.650454] NEW RATE=9250000
[   19.653644] NEW RATE=9250000
[   19.657091] cpufreq: notification 1 of frequency transition to 18500 kHz
[   19.664176] cpufreq: FREQ: 18500 - CPU: 0
[   19.668412] cpufreq: notification 1 of frequency transition to 18500 kHz
[   19.675648] cpufreq: FREQ: 18500 - CPU: 1

The "NEW RATE" traces are ones I added in smp_twd.c:twd_update_frequency()
(my clockevent source) to check whether the CPU frequency change propagated
to smp_twd.

I must have made an obvious mistake. Could someone point it out to me?
(I have attached the output of /proc/timer_list to this message)

Looking more closely at schedule_timeout(), I suppose the work happens
in __mod_timer()... Hmm, that one is over my head.

What am I missing?

Regards.

--------------080704020907030400010002
Content-Type: text/plain; charset=UTF-8;
 name="timer_list"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="timer_list"

Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 1996236245543 nsecs

cpu: 0
 clock 0:
  .base:       e7ae51e8
  .index:      0
  .resolution: 3333333 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: sched_clock_timer, sched_clock_poll, S:01
 # expires at 2087831315985-2087831315985 nsecs [in 91595070442 to 91595070442 nsecs]
 clock 1:
  .base:       e7ae5220
  .index:      1
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       e7ae5258
  .index:      2
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       e7ae5290
  .index:      3
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 1996229420769 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 1985388003747 nsecs
  .iowait_sleeptime: 10995516 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294894041

cpu: 1
 clock 0:
  .base:       e7aed1e8
  .index:      0
  .resolution: 3333333 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       e7aed220
  .index:      1
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 2:
  .base:       e7aed258
  .index:      2
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       e7aed290
  .index:      3
  .resolution: 3333333 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     0 nsecs
active timers:
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 0
  .last_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 1996231929568 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 1992784761637 nsecs
  .iowait_sleeptime: 40375788 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294894041

Tick Device: mode:     0
Broadcast device
Clock Event Device: <NULL>
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   464320782665
 min_delta_ns:   1622
 mult:           19864224
 shift:          31
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  tick_handle_periodic
 retries:        0

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   464320782665
 min_delta_ns:   1622
 mult:           19864224
 shift:          31
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  tick_handle_periodic
 retries:        0


--------------080704020907030400010002--
