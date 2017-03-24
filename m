From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFD PATCH 0/5] SCHED_DEADLINE freq/cpu invariance and OPP selection
Date: Fri, 24 Mar 2017 14:08:55 +0000
Message-ID: <20170324140900.7334-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752352AbdCXOJS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 10:09:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com

Hi,

this is a very exploratory set implementing frequency/cpu invariance and OPP
selection for SCHED_DEADLINE. The set has been slightly tested on a Juno
platform. While the actual implementation is very premature, I'm posting this
early to facilitate discussion at OSPM-summit [1].

Results of the testing, highlighting why these features are useful are
available here:

 - without the set
   https://gist.github.com/a6e3ee99cec32e00cc537b53cd3d54d2

 - with the set
   https://gist.github.com/1f7d485fc3ce9234fe627dcb53b2935c

The set is based on tip/sched/core as of today (bc4278987e38) plus a couple of
schedutil fixes coming from linux-pm/linux-next and Luca's "CPU reclaiming for
SCHED_DEADLINE" v5 [2].

Patches high level description:

 o [01-02]/05 add the necessary links to start accounting DEADLINE contribution
              to OPP selection 
 o 03/05      it's an hack to make possible (on ARM) to change frequency for
              DEADLINE tasks (that would possibly delay the SCHED_FIFO worker
              kthread); suggestions on how to do this properly are very welcome
 o 04/05      it's a schedutil change that copes with the fact that DEADLINE
              doesn't require periodic OPP selection triggering point
 o 05/05      implements frequency/cpu invariance for tasks' reservation
              parameters*; which basically means that we implement GRUB-PA [3]

Please have a look. Feedback on how we want to shape this is the sole purpose
of this posting.

In case you would like to test this out:

 git://linux-arm.org/linux-jl.git upstream/deadline/freq-rfd

Best,

- Juri

[1] http://retis.sssup.it/ospm-summit/index.html
[2] https://marc.info/?l=linux-kernel&m=149029880524038
[3] C. Scordino, G. Lipari, A Resource Reservation Algorithm for Power-Aware
    Scheduling of Periodic and Aperiodic Real-Time Tasks, IEEE Transactions
    on Computers, December 2006.

* Notice that this currently breaks !CONFIG_SMP, as arch_scale_{freq,cpu}
_capacity and SCHED_CAPACITY_SCALE are only defined on CONFIG_SMP. Fixing
this particular issue is straightforward, but we should probably look into
making frequency scaling (and PELT averages) available on !CONFIG_SMP as well
(so that schedutil can work on such configurations for example). Since this is
only an RFD and since a proper rework might be non trivial, I decided to leave
it out of scope for the time being.

Juri Lelli (5):
  sched/cpufreq_schedutil: make use of DEADLINE utilization signal
  sched/deadline: move cpu frequency selection triggering points
  sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
  sched/cpufreq_schedutil: always consider all CPUs when deciding next
    freq
  sched/deadline: make bandwidth enforcement scale-invariant

 include/linux/sched.h            |  1 +
 include/linux/sched/cpufreq.h    |  2 --
 include/uapi/linux/sched.h       |  1 +
 kernel/sched/core.c              | 19 +++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 37 ++++++++++++++++++++++---------------
 kernel/sched/deadline.c          | 40 +++++++++++++++++++++++++++++++++-------
 kernel/sched/fair.c              |  2 --
 kernel/sched/sched.h             | 10 +++++++++-
 8 files changed, 83 insertions(+), 29 deletions(-)

-- 
2.10.0
