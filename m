From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu,  2 Mar 2017 15:45:01 +0000
Message-ID: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>
List-Id: linux-pm@vger.kernel.org

The current version of schedutil has some issues related to the management
of update flags used by systems with frequency domains spawning multiple CPUs.

Each time a CPU utilisation update is issued by the scheduler a set of flags
are configured to define (mainly) which class is asking for a utilisation
update. These flags are then used by the frequency selection policy to
identify the OPP to choose.

In the current implementation, CPU flags are overridden each time the
scheduler calls schedutil for an update. Such a behaviour produces issues
in these scenarios, where we assume CPU1 and CPU2 share the same frequency
domain:
a) a RT task which executed on CPU1 can keep the domain at an high frequency
   for a long period of time, even if there are no longer RT tasks on
   CPUs in that domain
b) a FAIR task co-scheduled in the same CPU of a RT task can override the
   flags configured by the RT task and potentially this can cause an
   unwanted frequency drop

These misbehaviours have been verified using a set of simple rt-app based
synthetic workloads, running on a ARM's Juno board, and results are
available in this Notebook [1].

This series proposes a set of fixes for the aforementioned issues as well
as a small improvement to speedup the selection of the maximum frequency
when RT tasks enter a CPU.

This series is based on top of today's tip/sched/core and is public available
from this repository:

  git://www.linux-arm.com/linux-pb eas/schedutil/flags_fixes

Cheers Patrick

[1] https://gist.github.com/d6a21b459a18091b2b058668a550010d

Patrick Bellasi (6):
  cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
  cpufreq: schedutil: ignore the sugov kthread for frequencies
    selections
  cpufreq: schedutil: ensure max frequency while running RT/DL tasks
  cpufreq: schedutil: relax rate-limiting while running RT/DL tasks
  cpufreq: schedutil: avoid utilisation update when not necessary
  sched/rt: fast switch to maximum frequency when RT tasks are scheduled

 include/linux/sched.h            |  1 +
 kernel/sched/cpufreq_schedutil.c | 59 ++++++++++++++++++++++++++++++++++------
 kernel/sched/idle_task.c         |  4 +++
 kernel/sched/rt.c                | 15 ++++++++--
 4 files changed, 68 insertions(+), 11 deletions(-)

-- 
2.7.4
