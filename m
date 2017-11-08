From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Tue, 7 Nov 2017 23:53:59 -0500
Message-ID: <CAJvTdKkP5xu6r7k7u0yjjGBtQ=3giRehGxLL=VfyJLdV1XJZNg@mail.gmail.com>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
 <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net> <85fb012d-adba-a646-dfd5-a5322714a412@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43443 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdKHEyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 23:54:01 -0500
Received: by mail-qt0-f170.google.com with SMTP id j58so1902419qtj.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 20:54:01 -0800 (PST)
In-Reply-To: <85fb012d-adba-a646-dfd5-a5322714a412@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Chen Yu <yu.c.chen@intel.com>
Cc: Doug Smythies <dsmythies@telus.net>, =?UTF-8?Q?Marcus_H=C3=A4hnel?= <mhaehnel@os.inf.tu-dresden.de>, Daniel Hackenberg <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Thomas,

> The timers actually do happen and run, however poll_idle
> directly resumes after the interrupt - there is no need_resched(). The me=
nu
> governor assumes that a timer will trigger another menu_select, but it do=
es not.

FYI,

Chen-Yu recently ran into this issue also.  In his case, the workload
is a FUTEX test case
in LKP, where half of the logical CPUs are busy, and the other half
have nothing to run,
but seem to be spending time in C0 rather than in idle, because they are ge=
tting
fooled into poll_idle, and staying there.

cheers,
-Len




On Tue, Nov 7, 2017 at 6:04 PM, Thomas Ilsche
<thomas.ilsche@tu-dresden.de> wrote:
> Hi Doug,
>
> thanks to your detailed description I was able to reproduce and track dow=
n
> the
> issue on one of our systems with a similar processor. The effect is simil=
ar,
> the
> core stays in a shallow sleep state for too long. This is also amplified =
on
> a
> system with little background noise where a core can stay in C0 for secon=
ds.
> But the cause / trigger is different. By my observation with many perf
> probes,
> the next timer is preventing a deep sleep, also overriding the anti-poll
> mechanism.
>
> This immediate (usually 1-3 us) timer can be both tick_sched_timer and
> watchdog_timer_fn. The timers actually do happen and run, however poll_id=
le
> directly resumes after the interrupt - there is no need_resched(). The me=
nu
> governor assumes that a timer will trigger another menu_select, but it do=
es
> not.
> Neither does our fallback timer - so the mitigation.
>
> I made a hack[1] to stop poll_idle after timer_expires which prevents the
> issue
> in my tests. The idea is to make sure that poll_idle is really exited
> whenever a
> timer happens. I was trying to use existing information, but I'm not
> entirely
> sure if tick_sched.timer_expires actually has the right semantic. At the
> very
> least it would have to be exposed properly. Another way could be to set s=
ome
> flag within the timer handlers that is checked in poll_idle, but that is
> inviting race conditions. There is also the danger that resulting shorter=
,
> more
> frequent, times spent in C0 further confuses the menu heuristic.
>
> This issue is important to consider for the mitigation idea using a
> continuing
> tick timer when entering a shallow sleep state. We must ensure that the t=
ick
> timer actually ends all sleep states including poll_idle.
>
> I did some experiments on an Core i7-2600 at nominal userspace frequency
> with
> enabled HyperThreading with one thread doing while(1){} over 20 min each.
> The default configuration consumes on average 53.5 W AC power. The
> configurations with C0 disabled, all but C6 disabled, and my timer_expire=
s
> hack
> consume between 48.6 and 49.0 W on average. In the plots [2] of the 50 ms
> external power samples you nicely see the clusters where 1/2/3 cores are =
in
> C0
> adding about 9 W each.
>
> I was able to reproduce it on a number of additional CPUs, including larg=
er
> multi-socket server systems. There are some systems where C0 is never use=
d
> in
> the scenario, but that could be due to other factors. I think this is mos=
tly
> independent of the actual CPU architecture.
>
> [1]:
> https://github.com/tud-zih-energy/linux/commit/7529b167dc7c2afaacd4551fe0=
1ec576df5097e3
> [2]: https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares_poll.png
>
>
>>> Can you please share the patch, I'd like to use it for some experiments=
.
>>
>>
>> Can you not achieve the same, or at least similar and good enough for
>> testing, conditions by disabling all the other idle states?
>>
>> On my system, the max idle state is 4 (C6), and I just disable states
>> 0-3 to force always state 4.
>
>
> Absolutely! Previously I was using a version prior to 3ed09c9 where
> disabling state 0 was allowed.
>
> Best,
> Thomas
>
>
> On 2017-10-21 16:28, Doug Smythies wrote:
>>
>> Hi Thomas,
>>
>> Thanks for your quick reply.
>>
>> On 2017.10.20 Thomas Ilsche wrote:
>>
>>>
>>> Unfortunately, I don't have a complete picture of your issue.
>>>
>>> 1) What processor do you use and what are the following
>>> /sys/devices/system/cpu/cpu*/cpuidle/state*/{name,latency,residency}
>>
>>
>> Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
>> 4 cores, 8 CPUs. I do not disable hyperthreading, which
>> your paper mentions you do.
>>
>> All CPU have the same numbers, so CPU 0 used:
>>
>> $ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/name
>> POLL
>> C1
>> C1E
>> C3
>> C6
>>
>> $ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/latency
>> 0
>> 2
>> 10
>> 80
>> 104
>>
>> $ cat /sys/devices/system/cpu/cpu0/cpuidle/state*/residency
>> 0
>> 2
>> 20
>> 211
>> 345
>>
>>> 2) To get a better picture you can use perf via the following
>>> events in addition to power and residency:
>>>
>>> sched:sched_switch     -> which tasks are scheduled when.
>>> power:cpu_idle (state) -> which state was used when going to sleep
>>>
>>> Record a timeline with these events by using perf record -a -e
>>> You could also use -C to select only the core that should be
>>> idle but uses C0
>>> You can analyse it via perf script (or perf timeline if you have a
>>> scalable and fast SVG viewer, which I'm not sure exists)
>>>
>>> If you see state0 selected before a long idle phase, it's what we
>>> call a Powernightmare. The intervals of 8 previous idles can tell
>>> what the heuristic tries.
>>
>>
>> Very interesting. Running "perf record" with your events
>> has a drastic effect on the rate of occurrence of the issue.
>> Actually, it pretty much eliminates it. However, I was still
>> able to capture a few. (data further below.)
>>
>>> Some things to consider to avoid other influences on power
>>> - uniformity of the busy core's workload
>>> - fixed userspace p-state
>>> - pinned threads
>>
>>
>> Agreed.
>>
>>> If you can share a reproducible use-case I can also try with
>>> our tool chain (recording toolchain is FOSS, visualizer is not)
>>
>>
>> My test computer is a server, with no GUI. To make "idle" even
>> more "idle", I do this:
>>
>> $ cat set_cpu_turn_off_services
>> #! /bin/bash
>> # Turn off some services to try to get "idle" to be more "idle"
>> sudo systemctl stop mysql.service
>> sudo systemctl stop apache2.service
>> sudo systemctl stop nmbd.service
>> sudo systemctl stop smbd.service
>> sudo systemctl stop cron.service
>> sudo systemctl stop winbind.service
>> sudo systemctl stop apt-daily.timer
>> sudo systemctl stop libvirtd.service
>>
>> My original "Reported-and-tested-by" work for 0c313cb
>> only looked at my "idle" test system, and still is good
>> enough.
>>
>> However, now I observe significant excessive power sometimes
>> under load, the simplest being a single threaded CPU intensive
>> job.
>>   I merely load one CPU 100% (i.e. loadave =3D 1), and watch the others,
>> using turbostat (at >=3D 2 minutes per sample) and/or monitoring
>> idle state times (at >=3D 2 minutes, but typically more,
>> between samples) and/or the intel_pstate_tracer.py tool.
>>
>> Some example trace data (edited). Look for "<<<<<<<<".
>> The previous 8 idle entry/exits are included in each sample:
>>
>> CPU 1 sample 1:
>>
>> doug@s15:~/idle/perf$ cat t02_1_1.txt
>>     kworker/u16:1  5273 [001] 137660.900599: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900601:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900645:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 44
>>           swapper     0 [001] 137660.900649: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900655: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900657: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900659: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900661:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900704:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 43
>>           swapper     0 [001] 137660.900708: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900713: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900717: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900718: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900720:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900763:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 43
>>           swapper     0 [001] 137660.900766: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900772: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900775:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900778:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 3
>>           swapper     0 [001] 137660.900779: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900781: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900783:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900818:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 35
>>           swapper     0 [001] 137660.900821: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900827: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900830: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900831: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900833:     power:cpu_idle: state=
=3D4
>> cpu_id=3D1
>>           swapper     0 [001] 137660.900879:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 46
>>           swapper     0 [001] 137660.900882: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> kworker/u16:1:5273 [120]
>>     kworker/u16:1  5273 [001] 137660.900891: sched:sched_switch:
>> kworker/u16:1:5273 [120] t =3D=3D> swapper/1:0 [120]
>>           swapper     0 [001] 137660.900894:     power:cpu_idle: state=
=3D1
>> cpu_id=3D1
>>           swapper     0 [001] 137661.679273:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 778378
>>           swapper     0 [001] 137661.679280:     power:cpu_idle: state=
=3D1
>> cpu_id=3D1
>>           swapper     0 [001] 137662.191265:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 511984
>>           swapper     0 [001] 137662.191274:     power:cpu_idle: state=
=3D0
>> cpu_id=3D1  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>>           swapper     0 [001] 137662.843297:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D1 time: 652023 uS
>>           swapper     0 [001] 137662.843301: sched:sched_switch:
>> swapper/1:0 [120] R =3D=3D> watchdog/1:14 [0]
>>        watchdog/1    14 [001] 137662.843307: sched:sched_switch:
>> watchdog/1:14 [0] S =3D=3D> swapper/1:0 [120]
>>
>> CPU 3 sample 1:
>> doug@s15:~/idle/perf$ cat t02_3_1.txt
>>           swapper     0 [003] 136958.987314:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136959.167299:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3
>>           swapper     0 [003] 136959.167316:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136960.479303:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 1.312 Sec
>>           swapper     0 [003] 136960.479311:     power:cpu_idle: state=
=3D1
>> cpu_id=3D3
>>           swapper     0 [003] 136960.479328:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 17 uSec
>>           swapper     0 [003] 136960.479340:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136962.495332:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 2.016 Sec
>>           swapper     0 [003] 136962.495340:     power:cpu_idle: state=
=3D2
>> cpu_id=3D3
>>           swapper     0 [003] 136962.495372:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 32 uSec
>>           swapper     0 [003] 136962.495385:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136962.655390:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.16 Sec
>>           swapper     0 [003] 136962.655399:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136962.987380:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.332 Sec
>>           swapper     0 [003] 136962.987393: sched:sched_switch:
>> swapper/3:0 [120] R =3D=3D> watchdog/3:26 [0]
>>        watchdog/3    26 [003] 136962.987397: sched:sched_switch:
>> watchdog/3:26 [0] S =3D=3D> swapper/3:0 [120]
>>           swapper     0 [003] 136962.987402:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136963.167387:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.18 Seconds
>>           swapper     0 [003] 136963.167404:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 136963.679391:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.512 Seconds
>>           swapper     0 [003] 136963.679399:     power:cpu_idle: state=
=3D0
>> cpu_id=3D3  <<<<<<<<<<<<<<<<<<<<<<<
>>           swapper     0 [003] 136966.655478:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 2.875 Seconds
>>
>> CPU 3 sample 2:
>>
>> doug@s15:~/idle/perf$ cat t02_3_2.txt
>>           swapper     0 [003] 137563.001020:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137563.181005:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.18 Sec
>>           swapper     0 [003] 137563.181023:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137564.493009:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 9 uSec
>>           swapper     0 [003] 137564.493018:     power:cpu_idle: state=
=3D1
>> cpu_id=3D3
>>           swapper     0 [003] 137564.493036:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 18 uSec
>>           swapper     0 [003] 137564.493048:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137566.509039:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 2.016 Sec
>>           swapper     0 [003] 137566.509048:     power:cpu_idle: state=
=3D2
>> cpu_id=3D3
>>           swapper     0 [003] 137566.509082:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 34 uSec
>>           swapper     0 [003] 137566.509094:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137566.669096:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 7 uSec
>>           swapper     0 [003] 137566.669103:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137567.001089:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.332 Sec
>>           swapper     0 [003] 137567.001103: sched:sched_switch:
>> swapper/3:0 [120] R =3D=3D> watchdog/3:26 [0]
>>        watchdog/3    26 [003] 137567.001107: sched:sched_switch:
>> watchdog/3:26 [0] S =3D=3D> swapper/3:0 [120]
>>           swapper     0 [003] 137567.001112:     power:cpu_idle: state=
=3D4
>> cpu_id=3D3
>>           swapper     0 [003] 137567.181094:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 0.18 Sec
>>           swapper     0 [003] 137567.181098:     power:cpu_idle: state=
=3D0
>> cpu_id=3D3 <<<<<<<<<<<<<<<<<<
>>           swapper     0 [003] 137570.669187:     power:cpu_idle:
>> state=3D4294967295 cpu_id=3D3 time: 3.488 Sec
>>
>> Idle state times (seconds) over 2 minutes, CPU 7 =3D 100% load, while "p=
erf
>> record" running:
>> CPU 0:
>>     State 0: 1.436071
>>     State 1: 0.000317
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 118.554395
>> CPU 1:
>>     State 0: 0.000053
>>     State 1: 0.000007
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 120.000261
>> CPU 2:
>>     State 0: 0.000000
>>     State 1: 0.000000
>>     State 2: 0.032397
>>     State 3: 0.030218
>>     State 4: 119.902810
>> CPU 3:
>>     State 0: 2.176088
>>     State 1: 0.000114
>>     State 2: 0.000887
>>     State 3: 0.000000
>>     State 4: 117.820492
>> CPU 4:
>>     State 0: 0.000000
>>     State 1: 0.000086
>>     State 2: 0.001627
>>     State 3: 0.000000
>>     State 4: 121.360904
>> CPU 5:
>>     State 0: 0.000000
>>     State 1: 0.000014
>>     State 2: 0.001412
>>     State 3: 0.000000
>>     State 4: 120.000058
>> CPU 6:
>>     State 0: 0.000000
>>     State 1: 0.000015
>>     State 2: 0.000427
>>     State 3: 0.001088
>>     State 4: 119.984763
>> CPU 7:
>>     State 0: 0.000000
>>     State 1: 0.000000
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 0.000000
>>
>> Idle state times (seconds) over 2 minutes, CPU 7 =3D 100% load, no "perf
>> record":
>> CPU 0:
>>     State 0: 0.000223
>>     State 1: 0.000679
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 119.991636
>> CPU 1:
>>     State 0: 3.912153
>>     State 1: 0.000130
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 116.088366
>> CPU 2:
>>     State 0: 0.000000
>>     State 1: 0.000000
>>     State 2: 0.026982
>>     State 3: 0.026250
>>     State 4: 119.920878
>> CPU 3:
>>     State 0: 0.000039
>>     State 1: 0.000325
>>     State 2: 0.000981
>>     State 3: 0.000422
>>     State 4: 119.996761
>> CPU 4:
>>     State 0: 23.944607
>>     State 1: 0.000092
>>     State 2: 0.001095
>>     State 3: 0.000000
>>     State 4: 99.258784
>> CPU 5:
>>     State 0: 29.880724
>>     State 1: 0.000065
>>     State 2: 0.000934
>>     State 3: 0.000000
>>     State 4: 90.120384
>> CPU 6:
>>     State 0: 3.740422
>>     State 1: 0.000017
>>     State 2: 0.000451
>>     State 3: 0.000000
>>     State 4: 116.253516
>> CPU 7:
>>     State 0: 0.000000
>>     State 1: 0.000000
>>     State 2: 0.000000
>>     State 3: 0.000000
>>     State 4: 0.000000
>>
>> ... Doug
>>
>>
>
> --
> Dipl. Inf. Thomas Ilsche
> Computer Scientist
> Highly Adaptive Energy-Efficient Computing
> CRC 912 HAEC: http://tu-dresden.de/sfb912
> Technische Universit=C3=A4t Dresden
> Center for Information Services and High Performance Computing (ZIH)
> 01062 Dresden, Germany
>
> Phone: +49 351 463-42168
> Fax: +49 351 463-37773
> E-Mail: thomas.ilsche@tu-dresden.de
>
>



--=20
Len Brown, Intel Open Source Technology Center
