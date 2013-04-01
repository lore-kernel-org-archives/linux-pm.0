From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RFC PATCH 0/2] cpufreq: Introduce LAB cpufreq governor.
Date: Mon, 01 Apr 2013 17:24:15 +0900
Message-ID: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33536 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3DAIZE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 04:25:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patchset adds new cpufreq governor named LAB(Legacy Application
Boost). Basically, this governor is based on ondemand governor.

** Introduce LAB (Legacy Application Boost) governor

<<Purpose>>
 One of the problem of ondemand is that it considers the most busy
cpu only while doesn't care how many cpu is in busy state at the
moment. This may results in unnecessary power consumption, and it'll
be critical for the system having limited power source.

 To get the best energy efficiency, LAB governor considers not only
idle time but also the number of idle cpus. It primarily focuses on
supplying adequate performance to users within the limited resource.
It checks the number of idle cpus then controls the maximum frequency
dynamically. And it also applies different frequency increasing level
depends on that information. In simple terms the less the number of
busy cpus, the better performance will be given.
 In addition, stable system's power consumption in the busy state can
be achieved also with using LAB governor. This will help to manage and
estimate power consumption in certain system.

<<Algorithm>>
- Count the idle cpus :
 Number of idle cpus are determined by historical result. It stores
cpu idle usage derived by dividing cpu idling time with a period
at every time when cpufreq timer is called. And it calculates average
of idle usage from the most recent stored data. It uses cpu state
usage information from per-cpu cpuidle_device. However, because that
cpu state usage information is updated only when cpu exits the state,
so the information may differ with the real one while cpu is in idle
at checking time. To detect whether cpu is idling, it uses timestamps
of cpuidle devices. It needs to re-calculate idle state usage for the
following cases.

The possible 3 cases which cpu is in idle at checking time.
(Shaded section represents staying in idle)

1) During the last period, idle state would be broken more than once.

 |____________|__      _____|_______       |
 |////////////|//|____|/////|//____________|
 t1           t2            @             t4

2) During the last period, there was no idle state entered, current
   idle is the first one.

 |            |     ________|_______       |
 |____________|____|////////|////__________|
 t1           t2            @             t4

3) During the last whole period, the core is in idle state.

 |      ______|_____________|________      |
 |_____|//////|/////////////|////__________|
 t1           t2            @             t4

(@ : Current checking point)

 After calculating idle state usage, it decides whether cpu was idle
in the last period with the idle threshold. If average of idle usage
is bigger than threshold, then it treats the cpu as a idle cpu.
 For the test, I set default threshold value to 90.

- Limitation of maximum frequency :
 With information got from counting the idle cpus phase, it sets maximum
frequency for the next period. By default, it limits the current policy's
maximum frequency by from 0 to 35% depends on the number of idle cpus.

- Setting next frequency
 LAB governor changes the frequency step by step like the conservative
governor. However, in LAB governor, the step is changing dynamically
depending on how many cpus are in idle.

	next_freq = current_freq + current_idle_cpus * increasing_step;

<<To do>>
 The prototype of this feature was developed as a cpuidle driver, so it
it uses cpuidle framework information temporarily. I'd like to use the
data of per-cpu tick_sched variable, it has all information that I want
exactly but it can't be accessed from cpufreq side.


I tested this patch on pegasus qaud board.
Any comments are welcomed.

Jonghwa Lee (2):
  cpuidle: Add idle enter/exit time stamp for notifying current idle
    state.
  cpufreq: Introduce new cpufreq governor, LAB(Legacy Application
    Boost).

 drivers/cpufreq/Kconfig            |   26 ++
 drivers/cpufreq/Makefile           |    1 +
 drivers/cpufreq/cpufreq_governor.h |   14 +
 drivers/cpufreq/cpufreq_lab.c      |  553 ++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c          |    8 +-
 include/linux/cpufreq.h            |    3 +
 include/linux/cpuidle.h            |    4 +
 7 files changed, 605 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_lab.c

-- 
1.7.9.5

