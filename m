From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle
 info
Date: Mon, 31 Mar 2014 17:55:18 +0200
Message-ID: <53398FE6.1090203@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <CAKfTPtC4E=7DxnXZy8bSpeAqyLwsr-oXodXBod2aMc_x4VyqGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:65068 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbaCaPzG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Mar 2014 11:55:06 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so6196790wgg.30
        for <linux-pm@vger.kernel.org>; Mon, 31 Mar 2014 08:55:05 -0700 (PDT)
In-Reply-To: <CAKfTPtC4E=7DxnXZy8bSpeAqyLwsr-oXodXBod2aMc_x4VyqGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alex Shi <alex.shi@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 03/31/2014 03:52 PM, Vincent Guittot wrote:
> On 28 March 2014 13:29, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>> The following patchset provides an interaction between cpuidle and t=
he scheduler.
>>
>> The first patch encapsulate the needed information for the scheduler=
 in a
>> separate cpuidle structure. The second one stores the pointer to thi=
s structure
>> when entering idle. The third one, use this information to take the =
decision to
>> find the idlest cpu.
>>
>> After some basic testing with hackbench, it appears there is an impr=
ovement for
>> the performances (small) and for the duration of the idle states (wh=
ich provides
>> a better power saving).
>>
>> The measurement has been done with the 'idlestat' tool previously po=
sted in this
>> mailing list.
>>
>> So the benefit is good for both sides performance and power saving.
>
> Hi Daniel,
>
> I have looked at your results and i'm a bit surprised that you have s=
o
> much time in C-state with a test that involved 400 tasks on a dual
> cores HT system. You shouldn't have any CPUs in idle state when
> running hackbench; the total time of core0state in C7-IVB is
> 87932131.00(us), which is quite huge for a bench that runs 44sec. Or
> i'm doing something wrong in the interpretation of the results ?

No, actually I mixed the output of hackbench without being run with=20
idlestat or with idlestat.

The hackbench's results below are without idlestat.

The idlestat results are consistent and effectively it adds a non=20
negligeable overhead as it impacts the hackbench results.

So to summarize, hackbench has been run 4 times.

1, 2 : without idlestat, with and without the patchset - hackbench=20
results ~42 secs

3, 4 : with idlestat, with and without the patchset - hackbench results=
=20
~87 secs

At the first the glance, the results are consistent but I will double=20
check them.

Do you have a suggestion for a benchmarking program ?

Thanks !

   -- Daniel


>> The select_idle_sibling could be also improved in the same way.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D t=
est with hackbench 3.14-rc8 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> /usr/bin/hackbench -l 10000 -s 4096
>>
>> Running in process mode with 10 groups using 40 file descriptors eac=
h (=3D=3D 400 tasks)
>> Each sender will pass 10000 messages of 4096 bytes
>>
>> Time: 44.433
>>
>> Total trace buffer: 1846688 kB
>> clusterA@state  hits          total(us)         avg(us) min(us) max(=
us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 0                  0.00            0.00 0.00    0.0=
0
>>    core0@state   hits          total(us)         avg(us) min(us) max=
(us)
>>          POLL    0                  0.00            0.00 0.00    0.0=
0
>>          C1-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C1E-IVB 0                  0.00            0.00 0.00    0.0=
0
>>          C3-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C6-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C7-IVB  1396        87932131.00        62988.63 0.00    320=
146.00
>>      cpu0@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 1                 14.00           14.00 14.00   14.=
00
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 1                262.00          262.00 262.00  262=
=2E00
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 1180        87938177.00        74523.88 1.00    320=
147.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu0 wakeups        name            count
>>           irq009 acpi            1
>>      cpu1@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 475         87941356.00       185139.70 322.00  150=
0690.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu1 wakeups        name            count
>>           irq009 acpi            3
>>    core1@state   hits          total(us)         avg(us) min(us) max=
(us)
>>          POLL    0                  0.00            0.00 0.00    0.0=
0
>>          C1-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C1E-IVB 0                  0.00            0.00 0.00    0.0=
0
>>          C3-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C6-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C7-IVB  0                  0.00            0.00 0.00    0.0=
0
>>      cpu2@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 11            288157.00        26196.09 16.00   200=
060.00
>>           C1E-VB 6             221601.00        36933.50 79.00   200=
066.00
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 950         87417466.00        92018.39 19.00   200=
074.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   2                 34.00           17.00 11.00   23.=
00
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    745            18800.00           25.23 2.00    156=
=2E00
>>      cpu2 wakeups        name            count
>>           irq019 ahci            50
>>           irq009 acpi            17
>>      cpu3@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu3 wakeups        name            count
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test with hackbench=
 3.14-rc8 + patchset =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>
>> /usr/bin/hackbench -l 10000 -s 4096
>>
>> Running in process mode with 10 groups using 40 file descriptors eac=
h (=3D=3D 400 tasks)
>> Each sender will pass 10000 messages of 4096 bytes
>>
>> Time: 42.179
>>
>> Total trace buffer: 1846688 kB
>> clusterA@state  hits          total(us)         avg(us) min(us) max(=
us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 0                  0.00            0.00 0.00    0.0=
0
>>    core0@state   hits          total(us)         avg(us) min(us) max=
(us)
>>          POLL    0                  0.00            0.00 0.00    0.0=
0
>>          C1-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C1E-IVB 0                  0.00            0.00 0.00    0.0=
0
>>          C3-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C6-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C7-IVB  880         89157590.00       101315.44 0.00    400=
184.00
>>      cpu0@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 1                233.00          233.00 233.00  233=
=2E00
>>           C3-IVB 1                260.00          260.00 260.00  260=
=2E00
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 700         89162006.00       127374.29 182.00  400=
187.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu0 wakeups        name            count
>>           irq009 acpi            2
>>      cpu1@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 334         89164805.00       266960.49 1.00    150=
0677.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu1 wakeups        name            count
>>           irq009 acpi            6
>>    core1@state   hits          total(us)         avg(us) min(us) max=
(us)
>>          POLL    0                  0.00            0.00 0.00    0.0=
0
>>          C1-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C1E-IVB 0                  0.00            0.00 0.00    0.0=
0
>>          C3-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C6-IVB  0                  0.00            0.00 0.00    0.0=
0
>>          C7-IVB  0                  0.00            0.00 0.00    0.0=
0
>>      cpu2@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 19           2169047.00       114160.37 18.00   999=
129.00
>>           C1E-IB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 376         86993307.00       231365.18 20.00   150=
0682.00
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu2 wakeups        name            count
>>           irq009 acpi            32
>>           irq019 ahci            45
>>      cpu3@state  hits          total(us)         avg(us) min(us) max=
(us)
>>           POLL   0                  0.00            0.00 0.00    0.0=
0
>>           C1-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C1E-VB 0                  0.00            0.00 0.00    0.0=
0
>>           C3-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C6-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           C7-IVB 0                  0.00            0.00 0.00    0.0=
0
>>           1701   0                  0.00            0.00 0.00    0.0=
0
>>           1700   0                  0.00            0.00 0.00    0.0=
0
>>           1600   0                  0.00            0.00 0.00    0.0=
0
>>           1500   0                  0.00            0.00 0.00    0.0=
0
>>           1400   0                  0.00            0.00 0.00    0.0=
0
>>           1300   0                  0.00            0.00 0.00    0.0=
0
>>           1200   0                  0.00            0.00 0.00    0.0=
0
>>           1100   0                  0.00            0.00 0.00    0.0=
0
>>           1000   0                  0.00            0.00 0.00    0.0=
0
>>           900    0                  0.00            0.00 0.00    0.0=
0
>>           800    0                  0.00            0.00 0.00    0.0=
0
>>           782    0                  0.00            0.00 0.00    0.0=
0
>>      cpu3 wakeups        name            count
>>
>>
>> Daniel Lezcano (3):
>>    cpuidle: encapsulate power info in a separate structure
>>    idle: store the idle state the cpu is
>>    sched/fair: use the idle state info to choose the idlest cpu
>>
>>   arch/arm/include/asm/cpuidle.h       |    6 +-
>>   arch/arm/mach-exynos/cpuidle.c       |    4 +-
>>   drivers/acpi/processor_idle.c        |    4 +-
>>   drivers/base/power/domain.c          |    6 +-
>>   drivers/cpuidle/cpuidle-at91.c       |    4 +-
>>   drivers/cpuidle/cpuidle-big_little.c |    9 +--
>>   drivers/cpuidle/cpuidle-calxeda.c    |    6 +-
>>   drivers/cpuidle/cpuidle-kirkwood.c   |    4 +-
>>   drivers/cpuidle/cpuidle-powernv.c    |    8 +--
>>   drivers/cpuidle/cpuidle-pseries.c    |   12 ++--
>>   drivers/cpuidle/cpuidle-ux500.c      |   14 ++---
>>   drivers/cpuidle/cpuidle-zynq.c       |    4 +-
>>   drivers/cpuidle/driver.c             |    6 +-
>>   drivers/cpuidle/governors/ladder.c   |   14 +++--
>>   drivers/cpuidle/governors/menu.c     |    8 +--
>>   drivers/cpuidle/sysfs.c              |    2 +-
>>   drivers/idle/intel_idle.c            |  112 +++++++++++++++++-----=
------------
>>   include/linux/cpuidle.h              |   10 ++-
>>   kernel/sched/fair.c                  |   46 ++++++++++++--
>>   kernel/sched/idle.c                  |   17 +++++-
>>   kernel/sched/sched.h                 |    5 ++
>>   21 files changed, 180 insertions(+), 121 deletions(-)
>>
>> --
>> 1.7.9.5
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

