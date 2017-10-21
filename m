From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Sat, 21 Oct 2017 07:28:00 -0700
Message-ID: <000801d34a78$cdd27890$697769b0$@net>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <000101d34938$da740870$8f5c1950$@net> 5arveXt0DQS285as0eBwPb
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:33895 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbdJUO2I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Oct 2017 10:28:08 -0400
In-Reply-To: 5arveXt0DQS285as0eBwPb
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>
Cc: =?utf-8?Q?'Marcus_H=C3=A4hnel'?= <mhaehnel@os.inf.tu-dresden.de>, 'Daniel Hackenberg' <daniel.hackenberg@tu-dresden.de>, =?utf-8?Q?'Robert_Sch=C3=B6ne'?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Alex Shi' <alex.shi@linaro.org>, 'Ingo Molnar' <mingo@kernel.org>, 'Rik van Riel' <riel@redhat.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Nicholas Piggin' <npiggin@gmail.com>, linux-pm@vger.kernel.org, 'Len Brown' <lenb@kernel.org>

Hi Thomas,

Thanks for your quick reply.

On 2017.10.20 Thomas Ilsche wrote:
  
> Unfortunately, I don't have a complete picture of your issue.
>
> 1) What processor do you use and what are the following
> /sys/devices/system/cpu/cpu*/cpuidle/state*/{name,latency,residency}

Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
4 cores, 8 CPUs. I do not disable hyperthreading, which
your paper mentions you do.

All CPU have the same numbers, so CPU 0 used:

$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
POLL
C1
C1E
C3
C6

$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/latency
0
2
10
80
104

$ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/residency
0
2
20
211
345

> 2) To get a better picture you can use perf via the following
> events in addition to power and residency:
>
> sched:sched_switch     -> which tasks are scheduled when.
> power:cpu_idle (state) -> which state was used when going to sleep
>
> Record a timeline with these events by using perf record -a -e
> You could also use -C to select only the core that should be
> idle but uses C0
> You can analyse it via perf script (or perf timeline if you have a
> scalable and fast SVG viewer, which I'm not sure exists)
>
> If you see state0 selected before a long idle phase, it's what we
> call a Powernightmare. The intervals of 8 previous idles can tell
> what the heuristic tries.

Very interesting. Running "perf record" with your events
has a drastic effect on the rate of occurrence of the issue.
Actually, it pretty much eliminates it. However, I was still
able to capture a few. (data further below.)

> Some things to consider to avoid other influences on power
> - uniformity of the busy core's workload
> - fixed userspace p-state
> - pinned threads

Agreed.

> If you can share a reproducible use-case I can also try with
> our tool chain (recording toolchain is FOSS, visualizer is not)

My test computer is a server, with no GUI. To make "idle" even
more "idle", I do this:

$ cat set_cpu_turn_off_services
#! /bin/bash
# Turn off some services to try to get "idle" to be more "idle"
sudo systemctl stop mysql.service
sudo systemctl stop apache2.service
sudo systemctl stop nmbd.service
sudo systemctl stop smbd.service
sudo systemctl stop cron.service
sudo systemctl stop winbind.service
sudo systemctl stop apt-daily.timer
sudo systemctl stop libvirtd.service

My original "Reported-and-tested-by" work for 0c313cb
only looked at my "idle" test system, and still is good
enough.

However, now I observe significant excessive power sometimes 
under load, the simplest being a single threaded CPU intensive
job.
 
I merely load one CPU 100% (i.e. loadave = 1), and watch the others,
using turbostat (at >= 2 minutes per sample) and/or monitoring
idle state times (at >= 2 minutes, but typically more,
between samples) and/or the intel_pstate_tracer.py tool.

Some example trace data (edited). Look for "<<<<<<<<".
The previous 8 idle entry/exits are included in each sample:

CPU 1 sample 1:

doug@s15:~/idle/perf$ cat t02_1_1.txt
   kworker/u16:1  5273 [001] 137660.900599: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900601:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900645:     power:cpu_idle: state=4294967295 cpu_id=1 time: 44
         swapper     0 [001] 137660.900649: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900655: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900657: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900659: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900661:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900704:     power:cpu_idle: state=4294967295 cpu_id=1 time: 43
         swapper     0 [001] 137660.900708: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900713: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900717: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900718: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900720:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900763:     power:cpu_idle: state=4294967295 cpu_id=1 time: 43
         swapper     0 [001] 137660.900766: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900772: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900775:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900778:     power:cpu_idle: state=4294967295 cpu_id=1 time: 3
         swapper     0 [001] 137660.900779: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900781: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900783:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900818:     power:cpu_idle: state=4294967295 cpu_id=1 time: 35
         swapper     0 [001] 137660.900821: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900827: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900830: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900831: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900833:     power:cpu_idle: state=4 cpu_id=1
         swapper     0 [001] 137660.900879:     power:cpu_idle: state=4294967295 cpu_id=1 time: 46
         swapper     0 [001] 137660.900882: sched:sched_switch: swapper/1:0 [120] R ==> kworker/u16:1:5273 [120]
   kworker/u16:1  5273 [001] 137660.900891: sched:sched_switch: kworker/u16:1:5273 [120] t ==> swapper/1:0 [120]
         swapper     0 [001] 137660.900894:     power:cpu_idle: state=1 cpu_id=1
         swapper     0 [001] 137661.679273:     power:cpu_idle: state=4294967295 cpu_id=1 time: 778378
         swapper     0 [001] 137661.679280:     power:cpu_idle: state=1 cpu_id=1
         swapper     0 [001] 137662.191265:     power:cpu_idle: state=4294967295 cpu_id=1 time: 511984
         swapper     0 [001] 137662.191274:     power:cpu_idle: state=0 cpu_id=1  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
         swapper     0 [001] 137662.843297:     power:cpu_idle: state=4294967295 cpu_id=1 time: 652023 uS
         swapper     0 [001] 137662.843301: sched:sched_switch: swapper/1:0 [120] R ==> watchdog/1:14 [0]
      watchdog/1    14 [001] 137662.843307: sched:sched_switch: watchdog/1:14 [0] S ==> swapper/1:0 [120]

CPU 3 sample 1:
doug@s15:~/idle/perf$ cat t02_3_1.txt
         swapper     0 [003] 136958.987314:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136959.167299:     power:cpu_idle: state=4294967295 cpu_id=3
         swapper     0 [003] 136959.167316:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136960.479303:     power:cpu_idle: state=4294967295 cpu_id=3 time: 1.312 Sec
         swapper     0 [003] 136960.479311:     power:cpu_idle: state=1 cpu_id=3
         swapper     0 [003] 136960.479328:     power:cpu_idle: state=4294967295 cpu_id=3 time: 17 uSec
         swapper     0 [003] 136960.479340:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136962.495332:     power:cpu_idle: state=4294967295 cpu_id=3 time: 2.016 Sec
         swapper     0 [003] 136962.495340:     power:cpu_idle: state=2 cpu_id=3
         swapper     0 [003] 136962.495372:     power:cpu_idle: state=4294967295 cpu_id=3 time: 32 uSec
         swapper     0 [003] 136962.495385:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136962.655390:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.16 Sec
         swapper     0 [003] 136962.655399:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136962.987380:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.332 Sec
         swapper     0 [003] 136962.987393: sched:sched_switch: swapper/3:0 [120] R ==> watchdog/3:26 [0]
      watchdog/3    26 [003] 136962.987397: sched:sched_switch: watchdog/3:26 [0] S ==> swapper/3:0 [120]
         swapper     0 [003] 136962.987402:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136963.167387:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.18 Seconds
         swapper     0 [003] 136963.167404:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 136963.679391:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.512 Seconds
         swapper     0 [003] 136963.679399:     power:cpu_idle: state=0 cpu_id=3  <<<<<<<<<<<<<<<<<<<<<<<
         swapper     0 [003] 136966.655478:     power:cpu_idle: state=4294967295 cpu_id=3 time: 2.875 Seconds

CPU 3 sample 2:

doug@s15:~/idle/perf$ cat t02_3_2.txt
         swapper     0 [003] 137563.001020:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137563.181005:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.18 Sec
         swapper     0 [003] 137563.181023:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137564.493009:     power:cpu_idle: state=4294967295 cpu_id=3 time: 9 uSec
         swapper     0 [003] 137564.493018:     power:cpu_idle: state=1 cpu_id=3
         swapper     0 [003] 137564.493036:     power:cpu_idle: state=4294967295 cpu_id=3 time: 18 uSec
         swapper     0 [003] 137564.493048:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137566.509039:     power:cpu_idle: state=4294967295 cpu_id=3 time: 2.016 Sec
         swapper     0 [003] 137566.509048:     power:cpu_idle: state=2 cpu_id=3
         swapper     0 [003] 137566.509082:     power:cpu_idle: state=4294967295 cpu_id=3 time: 34 uSec
         swapper     0 [003] 137566.509094:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137566.669096:     power:cpu_idle: state=4294967295 cpu_id=3 time: 7 uSec
         swapper     0 [003] 137566.669103:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137567.001089:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.332 Sec
         swapper     0 [003] 137567.001103: sched:sched_switch: swapper/3:0 [120] R ==> watchdog/3:26 [0]
      watchdog/3    26 [003] 137567.001107: sched:sched_switch: watchdog/3:26 [0] S ==> swapper/3:0 [120]
         swapper     0 [003] 137567.001112:     power:cpu_idle: state=4 cpu_id=3
         swapper     0 [003] 137567.181094:     power:cpu_idle: state=4294967295 cpu_id=3 time: 0.18 Sec
         swapper     0 [003] 137567.181098:     power:cpu_idle: state=0 cpu_id=3 <<<<<<<<<<<<<<<<<<
         swapper     0 [003] 137570.669187:     power:cpu_idle: state=4294967295 cpu_id=3 time: 3.488 Sec

Idle state times (seconds) over 2 minutes, CPU 7 = 100% load, while "perf record" running:
CPU 0:
   State 0: 1.436071
   State 1: 0.000317
   State 2: 0.000000
   State 3: 0.000000
   State 4: 118.554395
CPU 1:
   State 0: 0.000053
   State 1: 0.000007
   State 2: 0.000000
   State 3: 0.000000
   State 4: 120.000261
CPU 2:
   State 0: 0.000000
   State 1: 0.000000
   State 2: 0.032397
   State 3: 0.030218
   State 4: 119.902810
CPU 3:
   State 0: 2.176088
   State 1: 0.000114
   State 2: 0.000887
   State 3: 0.000000
   State 4: 117.820492
CPU 4:
   State 0: 0.000000
   State 1: 0.000086
   State 2: 0.001627
   State 3: 0.000000
   State 4: 121.360904
CPU 5:
   State 0: 0.000000
   State 1: 0.000014
   State 2: 0.001412
   State 3: 0.000000
   State 4: 120.000058
CPU 6:
   State 0: 0.000000
   State 1: 0.000015
   State 2: 0.000427
   State 3: 0.001088
   State 4: 119.984763
CPU 7:
   State 0: 0.000000
   State 1: 0.000000
   State 2: 0.000000
   State 3: 0.000000
   State 4: 0.000000

Idle state times (seconds) over 2 minutes, CPU 7 = 100% load, no "perf record":
CPU 0:
   State 0: 0.000223
   State 1: 0.000679
   State 2: 0.000000
   State 3: 0.000000
   State 4: 119.991636
CPU 1:
   State 0: 3.912153
   State 1: 0.000130
   State 2: 0.000000
   State 3: 0.000000
   State 4: 116.088366
CPU 2:
   State 0: 0.000000
   State 1: 0.000000
   State 2: 0.026982
   State 3: 0.026250
   State 4: 119.920878
CPU 3:
   State 0: 0.000039
   State 1: 0.000325
   State 2: 0.000981
   State 3: 0.000422
   State 4: 119.996761
CPU 4:
   State 0: 23.944607
   State 1: 0.000092
   State 2: 0.001095
   State 3: 0.000000
   State 4: 99.258784
CPU 5:
   State 0: 29.880724
   State 1: 0.000065
   State 2: 0.000934
   State 3: 0.000000
   State 4: 90.120384
CPU 6:
   State 0: 3.740422
   State 1: 0.000017
   State 2: 0.000451
   State 3: 0.000000
   State 4: 116.253516
CPU 7:
   State 0: 0.000000
   State 1: 0.000000
   State 2: 0.000000
   State 3: 0.000000
   State 4: 0.000000

... Doug
