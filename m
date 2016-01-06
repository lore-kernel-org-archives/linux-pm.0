From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH 0/2] IRQ based next prediction
Date: Wed,  6 Jan 2016 16:22:52 +0100
Message-ID: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33953 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbcAFPXN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 10:23:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id u188so64071719wmu.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2016 07:23:12 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

The current approach to select an idle state is based on the idle period
statistics computation.

Useless to say this approach satisfied everyone as a solution to find the
best trade-off between the performances and the energy saving via the menu
governor.

However, the kernel is evolving to act pro-actively regarding the energy
constraints with the scheduler and the different power management subsystems
are not collaborating with the scheduler as the conductor of the decisions,
they all act independently.

The cpuidle governors are based on idle period statistics, without knowledge
of what woke up the cpu. In these sources of wakes up, the IPI are of course
accounted (as well as the timers irq) which results in doing statistics on
the scheduler behavior too. It is no sense to let the scheduler to take a
decision based on a next prediction of its own decisions.

In order to integrate the cpuidle framework into the scheduler, we have to
radically change the approach by clearly identifying what is causing a wake
up and how it behaves.

This serie inverts the logic.

Instead of tracking the idle durations and do statistics on them, these
patches track the interrupt individually and try to predict the next interrupt.

By combining the interrupts' next event on a single CPU, we can predict the
next event for the CPU, hence predict how long we will be sleeping when
entering idle.

The IPI and timer interrupts are not taken into account.

The first patch provides a callback to be registered in the irq subsystem
and to be called when an interrupt is handled with a timestamp.

The second patch uses the callback provided by the patch above to compute
the delta and store it in a circular buffer. It is per cpu, the callback
implements minimal operations as it is in an interrupt context.

When we the cpu enters idle, it asks for the expected sleep time. Then the
expected minimum sleep length for all interrupts is used and compared to
the timer sleep length, again the minimum is taken and gives the expected
sleep time.

The statistics are very trivial and could be improved later but this first
step shows we have a nice overall improvement in SMP. In UP the menu governor
is a bit better which may indicate the next prediction computation could be
improved but confirms removing the IPI from the equation increase the
accuracy.

These are the results with a workload emulator (mp3, video, browser, ...) on
a Dual Xeon 6 cores. Each test has been run 10 times. The results are based
on a debugfs statistics where, when we exit idle, we check if the idle state
was the right one which gives a successful prediction even if the exact
wakeup time is not correct. The error margin is absorbed by the idle state's
target residency, eg. idle1 is 10 us, idle2 is 50us, idle3 is 150us, if we
predict to sleep 110us but at the end we sleep 80us, the prediction is still
successful as the idle2 is the correct one for 80us and 110us.

(mean colum - 5th -, greater is better).

SMP (12 cores):

--------------------------
Successful predictions (%)
--------------------------
scripts/iolatsimu.sh.menu.dat:
N    min    max    sum    mean    stddev
10    30.96    39.3    346.15    34.615    2.37729
scripts/iolatsimu.sh.irq.dat:
N    min    max    sum    mean    stddev
10    22.21    54.39    377.1    37.71    11.3374
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-aio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    44.32    48.81    459.5    45.95    1.59114
scripts/fio-aio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    54.18    64.75    592.86    59.286    2.83509
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-cpuio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    86.86    91    890.21    89.021    1.34882
scripts/fio-cpuio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    97.97    98.57    981.85    98.185    0.171804
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-zipf.sh.menu.dat:
N    min    max    sum    mean    stddev
10    87.58    94.53    917.07    91.707    1.81287
scripts/fio-zipf.sh.irq.dat:
N    min    max    sum    mean    stddev
10    95.51    98.88    980.25    98.025    1.06026
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-netio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    65.51    81.82    729.41    72.941    5.34134
scripts/fio-netio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    97.38    97.88    976.19    97.619    0.162238
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-falloc.sh.menu.dat:
N    min    max    sum    mean    stddev
10    79.4    91.58    858.71    85.871    3.51946
scripts/fio-falloc.sh.irq.dat:
N    min    max    sum    mean    stddev
10    65.06    87.54    728.72    72.872    6.29703
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-null.sh.menu.dat:
N    min    max    sum    mean    stddev
10    89.44    92.83    908.96    90.896    1.12064
scripts/fio-null.sh.irq.dat:
N    min    max    sum    mean    stddev
10    95.68    98.74    978.19    97.819    0.954468
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-browser.sh.menu.dat:
N    min    max    sum    mean    stddev
10    59    67.66    640.21    64.021    3.11123
scripts/rt-app-browser.sh.irq.dat:
N    min    max    sum    mean    stddev
10    81.45    91.48    865.2    86.52    3.39756
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-mp3.sh.menu.dat:
N    min    max    sum    mean    stddev
10    65.85    70.67    674.85    67.485    1.34196
scripts/rt-app-mp3.sh.irq.dat:
N    min    max    sum    mean    stddev
10    94.97    97.24    963.96    96.396    0.743897
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-video.sh.menu.dat:
N    min    max    sum    mean    stddev
10    59.41    63.14    615.57    61.557    1.24713
scripts/rt-app-video.sh.irq.dat:
N    min    max    sum    mean    stddev
10    70.92    76.8    747.7    74.77    1.84455
--------------------------
Successful predictions (%)
--------------------------
scripts/video.sh.menu.dat:
N    min    max    sum    mean    stddev
10    27.99    35.54    302.23    30.223    2.27853
scripts/video.sh.irq.dat:
N    min    max    sum    mean    stddev
10    54.42    72.42    635.55    63.555    6.48589
--------------------------
Successful predictions (%)
--------------------------
scripts/netperf.sh.menu.dat:
N    min    max    sum    mean    stddev
10    67.49    82.46    748.43    74.843    4.64976
scripts/netperf.sh.irq.dat:
N    min    max    sum    mean    stddev
10    97.51    99.43    990.12    99.012    0.545768


In UP:

--------------------------
Successful predictions (%)
--------------------------
scripts/iolatsimu.sh.menu.dat:
N    min    max    sum    mean    stddev
10    49.5    55.66    514.02    51.402    2.31278
scripts/iolatsimu.sh.irq.dat:
N    min    max    sum    mean    stddev
10    39.49    63.51    552.35    55.235    6.54344
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-aio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    49.44    51.9    502.44    50.244    0.849552
scripts/fio-aio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    35.58    42.06    381.57    38.157    2.05544
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-cpuio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    93.07    97.26    954.71    95.471    1.52628
scripts/fio-cpuio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    91.02    97.48    943.92    94.392    2.21478
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-zipf.sh.menu.dat:
N    min    max    sum    mean    stddev
10    76.92    88    831.94    83.194    3.2838
scripts/fio-zipf.sh.irq.dat:
(2 runs without idle transitions)
N    min    max    sum    mean    stddev
8    50    100    657.5    82.1875    22.418
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-netio.sh.menu.dat:
N    min    max    sum    mean    stddev
10    78.95    85.71    818.7    81.87    2.01494
scripts/fio-netio.sh.irq.dat:
N    min    max    sum    mean    stddev
10    62.5    90    733.51    73.351    7.77129
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-falloc.sh.menu.dat:
N    min    max    sum    mean    stddev
10    29.42    38.46    357.83    35.783    2.57226
scripts/fio-falloc.sh.irq.dat:
N    min    max    sum    mean    stddev
10    28.85    37.48    333.22    33.322    3.121
--------------------------
Successful predictions (%)
--------------------------
scripts/fio-null.sh.menu.dat:
N    min    max    sum    mean    stddev
10    73.53    84.62    806.44    80.644    3.57214
scripts/fio-null.sh.irq.dat:
N    min    max    sum    mean    stddev
10    57.14    85.71    761.68    76.168    8.73407
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-browser.sh.menu.dat:
N    min    max    sum    mean    stddev
10    96.33    98.8    976.84    97.684    0.834921
scripts/rt-app-browser.sh.irq.dat:
N    min    max    sum    mean    stddev
10    93.02    100    984.58    98.458    2.08916
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-mp3.sh.menu.dat:
N    min    max    sum    mean    stddev
10    99.06    99.59    993.8    99.38    0.178948
scripts/rt-app-mp3.sh.irq.dat:
N    min    max    sum    mean    stddev
10    95.81    99.54    978.95    97.895    1.36267
--------------------------
Successful predictions (%)
--------------------------
scripts/rt-app-video.sh.menu.dat:
N    min    max    sum    mean    stddev
10    96.96    99.08    983.25    98.325    0.632899
scripts/rt-app-video.sh.irq.dat:
N    min    max    sum    mean    stddev
10    74.77    97.5    829.45    82.945    7.10247
--------------------------
Successful predictions (%)
--------------------------
scripts/video.sh.menu.dat:
N    min    max    sum    mean    stddev
10    48.52    59.73    541.3    54.13    3.11611
scripts/video.sh.irq.dat:
N    min    max    sum    mean    stddev
10    43.71    58.5    533.62    53.362    4.84646 

Daniel Lezcano (2):
  irq: Add a framework to measure interrupt timings
  sched: idle: IRQ based next prediction for idle period

 drivers/cpuidle/Kconfig   |   5 +
 include/linux/interrupt.h |  45 ++++
 include/linux/irqdesc.h   |   3 +
 kernel/irq/Kconfig        |   3 +
 kernel/irq/handle.c       |  12 +
 kernel/irq/manage.c       |  65 +++++-
 kernel/sched/Makefile     |   1 +
 kernel/sched/idle-sched.c | 553 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 686 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/idle-sched.c

-- 
1.9.1

