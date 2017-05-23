From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH RFC 0/8] SCHED_DEADLINE freq/cpu invariance and OPP selection
Date: Tue, 23 May 2017 09:53:43 +0100
Message-ID: <20170523085351.18586-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

this RFC set implements frequency/cpu invariance and OPP selection for
SCHED_DEADLINE. The set has been slightly tested on a Juno platform. The
current incarnation of the patches stems both from previous RFD[1] review
comments and discussion at OSPM-summit[2], during which we seemed to agree
that:

 - we probably want to use running_bw (instead of this_bw), as it is less
   pessimistic (we should save more energy)
 - special kworker hack seems acceptable as a mid term solution to foster
   further SCHED_DEADLINE/schedutil development/adoption

A point that is still very much up for discussion (more that the others :) is
how we implement frequency/cpu scaling. SCHED_FLAG_RECLAIM tasks only need
grub_reclaim(), as the function already scales their reservation runtime
considering other reservations and maximum bandwidth a CPU has to offer.
However, for normal !RECLAIM tasks multiple things can be implemented which
seem to make sense:

 - don't scale at all: normal tasks will only get a % of CPU _time_ as granted
   by AC
 - go to max as soon as a normal task in enqueued: this because dimensioning of
   parameters is usually done at max OPP/biggest CPU and normal task assume
   that this is always the condition when they run
 - scale runtime acconding to current frequency and max CPU capacity: this is
   what this set is currently implementing

Opinions?

The set is based on tip/sched/core as of today (a9e7f6544b9c) plus some
schedutil fixes coming from linux-pm/linux-next and Luca's "CPU reclaiming for
SCHED_DEADLINE" [3].

Patches high level description:

 o [01-02]/08 add the necessary links to start accounting DEADLINE contribution
              to OPP selection 
 o 03/08      it's a temporary solution to make possible (on ARM) to change
              frequency for DEADLINE tasks (that would possibly delay the SCHED_FIFO
              worker kthread); proper solution would be to be able to issue frequency
              transition from an atomic ctx
 o [04-05]/08 it's a schedutil change that copes with the fact that DEADLINE
              doesn't require periodic OPP selection triggering point
 o [06-07]/08 make arch_scale_{freq,cpu}_capacity() function available on !CONFIG_SMP
              configurations too
 o 08/08      implements frequency/cpu invariance for tasks' reservation
              parameters; which basically means that we implement GRUB-PA [4]

Changes w.r.t. RFD:

 - use grub_reclaim for RECLAIM and scale freq/cpu for !RECLAIM
 - discard CFS contribution only, after TICK_NSEC
 - added patches 06 and 07 to fix !CONFIG_SMP builds

Please have a look. Feedback and comments are, as usual, more than welcome.

In case you would like to test this out:

 git://linux-arm.org/linux-jl.git upstream/deadline/freq-rfc

Best,

- Juri

[1] http://marc.info/?l=linux-kernel&m=149036457909119&w=2
[2] http://retis.sssup.it/ospm-summit/program.html
    https://lwn.net/Articles/721573/
[3] http://marc.info/?l=linux-kernel&m=149513848804404
[4] C. Scordino, G. Lipari, A Resource Reservation Algorithm for Power-Aware
    Scheduling of Periodic and Aperiodic Real-Time Tasks, IEEE Transactions
    on Computers, December 2006.

Juri Lelli (8):
  sched/cpufreq_schedutil: make use of DEADLINE utilization signal
  sched/deadline: move cpu frequency selection triggering points
  sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
  sched/cpufreq_schedutil: split utilization signals
  sched/cpufreq_schedutil: always consider all CPUs when deciding next
    freq
  sched/sched.h: remove sd arch_scale_freq_capacity parameter
  sched/sched.h: move arch_scale_{freq,cpu}_capacity outside CONFIG_SMP
  sched/deadline: make bandwidth enforcement scale-invariant

 include/linux/sched.h            |  1 +
 include/linux/sched/cpufreq.h    |  2 --
 include/linux/sched/topology.h   | 12 ++++----
 include/uapi/linux/sched.h       |  1 +
 kernel/sched/core.c              | 19 ++++++++++--
 kernel/sched/cpufreq_schedutil.c | 62 ++++++++++++++++++++++++----------------
 kernel/sched/deadline.c          | 39 ++++++++++++++++++++-----
 kernel/sched/fair.c              |  4 +--
 kernel/sched/sched.h             | 27 +++++++++++++----
 9 files changed, 116 insertions(+), 51 deletions(-)

-- 
2.11.0
