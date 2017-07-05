From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v1 0/8] SCHED_DEADLINE freq/cpu invariance and OPP selection
Date: Wed,  5 Jul 2017 09:58:57 +0100
Message-ID: <20170705085905.6558-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbdGEJAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 05:00:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, juri.lelli@arm.com

Hi,

v1 of the RFC set implementing frequency/cpu invariance and OPP selection for
SCHED_DEADLINE [1]. The set is based on tip/sched/core as of today
(72298e5c92c5), which now already includes Luca's "CPU reclaiming for
SCHED_DEADLINE".

Thanks a lot for reviewing RFCv0!

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
              parameters; which basically means that we implement GRUB-PA [2]

Changes w.r.t. RFCv0:

 - rebase on tip/sched/core
 - make use of BW_SHIFT for calculations (Peter)
 - added a comment about guaranteed/requested frequency (Peter)
 - use a high bit for sched_flags SCHED_FLAG_SPECIAL hack; don't expose it to
   userspace and add comments (Peter)
 - refactor aggregation of utilization from scheduling classes

Please have a look. Feedback and comments are, as usual, more than welcome.

In case you would like to test this out:

 git://linux-arm.org/linux-jl.git upstream/deadline/freq-rfc-v1

Best,

- Juri


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
 include/linux/sched/topology.h   | 12 +++----
 kernel/sched/core.c              | 15 ++++++--
 kernel/sched/cpufreq_schedutil.c | 77 ++++++++++++++++++++++++++--------------
 kernel/sched/deadline.c          | 46 ++++++++++++++++++++----
 kernel/sched/fair.c              |  4 +--
 kernel/sched/sched.h             | 51 +++++++++++++++++++-------
 8 files changed, 149 insertions(+), 59 deletions(-)

-- 
2.11.0
