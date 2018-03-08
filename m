From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Wed, 7 Mar 2018 17:28:34 -0800
Message-ID: <001101d3b67c$c8eb2550$5ac16ff0$@net>
References: <000a01d3b636$57b75c00$07261400$@net> thHZenCOVQdbpthHaeaJ1a
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: thHZenCOVQdbpthHaeaJ1a
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Rik van Riel' <riel@surriel.com>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.07 14:12 Rafael J. Wysocki wrote:
> On Wed, Mar 7, 2018 at 6:04 PM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.03.06 12:57 Rafael J. Wysocki wrote:
>
>> During the test I got some messages (I also got some with the V1 patch set):

> Can you please check if that's reporoducible with just the first three
> patches in the series applied?

I will.

>> The other observation is sometimes the number of irqs (turbostat) jumps
>> a lot. This did not occur with the V1 patch set. An increase in irqs is
>> expected, but I don't think that much.

> Right.

I did a trace for 1 hour, and got about 12 occurrence of very high IRQs.
I was able to correlate trace results with high IRQs per turbostat sampling
time (1 minute).

The extreme jumps in IRQs is due to CPUs wanting to be in idle state 4
(the deepest for my older i7 processor, C6), but the tick is not stopping,
(or so I am guessing) thus they exit idle state 4 every millisecond
(I am using a 1000 Hz kernel), and then pretty much immediately to go
back into idle state 4.
When this occurs, it seems to occur for a very long time, but it does
seem to eventually sort itself out. 

Example:
       5   2.0 [006] d..1   780.447005: cpu_idle: state=4 cpu_id=6
     993   2.0 [006] d..1   780.447999: cpu_idle: state=4294967295 cpu_id=6
       6   2.0 [006] d..1   780.448006: cpu_idle: state=4 cpu_id=6
     992   2.0 [006] d..1   780.448999: cpu_idle: state=4294967295 cpu_id=6
       6   2.0 [006] d..1   780.449005: cpu_idle: state=4 cpu_id=6

Where:
column 1 is the time difference in microseconds from the previous sample.
column 2 is the elapsed time of the test in minutes (for ease of correlating
	with the other once per minute data.
Other columns are unmodified from the raw trace data, but this file is
only CPU 6 and only idle entry/exit.

And the same area from the raw trace file:

<idle>-0     [006] d..1   780.447005: cpu_idle: state=4 cpu_id=6
 test1-2664  [007] d.h.   780.447999: local_timer_entry: vector=237
<idle>-0     [006] d..1   780.447999: cpu_idle: state=4294967295 cpu_id=6
 test1-2664  [007] d.h.   780.447999: hrtimer_expire_entry: hrtimer=00000000ea612c0e function=tick_sched_timer now=780435000915
<idle>-0     [006] d.h1   780.448000: local_timer_entry: vector=237
<idle>-0     [006] d.h1   780.448001: hrtimer_expire_entry: hrtimer=000000004b84020f function=tick_sched_timer now=780435002540
<idle>-0     [006] d.h1   780.448002: hrtimer_expire_exit: hrtimer=000000004b84020f
 test1-2664  [007] d.h.   780.448003: hrtimer_expire_exit: hrtimer=00000000ea612c0e
<idle>-0     [006] d.h1   780.448003: local_timer_exit: vector=237
 test1-2664  [007] d.h.   780.448003: local_timer_exit: vector=237
<idle>-0     [006] d..1   780.448006: cpu_idle: state=4 cpu_id=6

... Doug
