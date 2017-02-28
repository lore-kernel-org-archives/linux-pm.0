From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Tue, 28 Feb 2017 14:38:37 +0000
Message-ID: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

Was: SchedTune: central, scheduler-driven, power-perfomance control

This series presents a possible alternative design for what has been presented
in the past as SchedTune. This redesign has been defined to address the main
concerns and comments collected in the LKML discussion [1] as well at the last
LPC [2].
The aim of this posting is to present a working prototype which implements
what has been discussed [2] with people like PeterZ, PaulT and TejunH.

The main differences with respect to the previous proposal [1] are:
 1. Task boosting/capping is now implemented as an extension on top of
    the existing CGroup CPU controller.
 2. The previous boosting strategy, based on the inflation of the CPU's
    utilization, has been now replaced by a more simple yet effective set
    of capacity constraints.

The proposed approach allows to constrain the minimum and maximum capacity
of a CPU depending on the set of tasks currently RUNNABLE on that CPU.
The set of active constraints are tracked by the core scheduler, thus they
apply across all the scheduling classes. The value of the constraints are
used to clamp the CPU utilization when the schedutil CPUFreq's governor
selects a frequency for that CPU.

This means that the new proposed approach allows to extend the concept of
tasks classification to frequencies selection, thus allowing informed
run-times (e.g. Android, ChromeOS, etc.) to efficiently implement different
optimization policies such as:
 a) Boosting of important tasks, by enforcing a minimum capacity in the
    CPUs where they are enqueued for execution.
 b) Capping of background tasks, by enforcing a maximum capacity.
 c) Containment of OPPs for RT tasks which cannot easily be switched to
    the usage of the DL class, but still don't need to run at the maximum
    frequency.

The new approach has also been designed to be compliant to CGroups v2
principles, such as the support for single hierarchy and the "limit"
resource distribution model (described in Documentation/cgroup-v2.txt).

A further development of this idea is under development and will allow to
exploit the same capacity capping attributes, in conjunction to the recently
merged capacity awareness bits [3], in order to achieve a more complete tasks
boosting/capping strategy which is completely scheduler driven and based on
user-space defined tasks classification.

The first three patches of this series introduces capacity_{min,max} tracking
in the core scheduler, as an extension of the CPU controller.
The fourth patch integrates capacity capping with schedutil for FAIR tasks,
while the last patch does the same for RT/DL tasks.

This series is based on top of today's tip/sched/core and is public available
from this repository:

  git://www.linux-arm.com/linux-pb eas/stune/rfcv3

Cheers Patrick

.:: References
[1] https://lkml.org/lkml/2016/10/27/503
[2] https://lkml.org/lkml/2016/11/25/342
[3] https://lkml.org/lkml/2016/10/14/312

Patrick Bellasi (5):
  sched/core: add capacity constraints to CPU controller
  sched/core: track CPU's capacity_{min,max}
  sched/core: sync capacity_{min,max} between slow and fast paths
  sched/{core,cpufreq_schedutil}: add capacity clamping for FAIR tasks
  sched/{core,cpufreq_schedutil}: add capacity clamping for RT/DL tasks

 include/linux/sched.h            |   3 +
 init/Kconfig                     |  17 ++
 kernel/sched/core.c              | 352 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  83 ++++++++-
 kernel/sched/sched.h             |  31 ++++
 5 files changed, 478 insertions(+), 8 deletions(-)

-- 
2.7.4
