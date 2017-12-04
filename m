From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 0/8] SCHED_DEADLINE freq/cpu invariance and OPP selection
Date: Mon,  4 Dec 2017 11:23:17 +0100
Message-ID: <20171204102325.5110-1-juri.lelli@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40428 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdLDKYC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Dec 2017 05:24:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so7043614wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 02:24:02 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, alessio.balsini@arm.com, juri.lelli@redhat.com

Hi,

v2 of the RFC set implementing frequency/cpu invariance and OPP selection for
SCHED_DEADLINE [1]. The set is based on mainline as of today (ae64f9bd1d36).

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

Changes w.r.t. RFCv1:

 - rebase on mainline
 - return -EINVAL for user trying to use the new flag (Peter)
 - s/SPECIAL/SUGOV/ in the flag name (several comments from people to
   find better naming, Steve thinks SUGOV is more greppable than others)
 - give worker kthread a fake (unused) bandwidth, so that if priority
   inheritance is triggered we don't BUG_ON on zero runtime
 - filter out fake bandwidth when computing SCHED_DEADLINE bandwidth (fix by
   Claudio Scordino)

Please have a look. Feedback and comments are, as usual, more than welcome.

In case you would like to test this out:

 https://github.com/jlelli/linux.git upstream/deadline/freq-rfc-v2

Best,

- Juri

[1] v0: https://lkml.org/lkml/2017/5/23/249
    v1: https://lkml.org/lkml/2017/7/5/139
[2] C. Scordino, G. Lipari, A Resource Reservation Algorithm for
    Power-Aware Scheduling of Periodic and Aperiodic Real-Time Tasks,
    IEEE Transactions on Computers, December 2006

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

 include/linux/arch_topology.h    |   2 +-
 include/linux/sched.h            |   1 +
 include/linux/sched/cpufreq.h    |   2 -
 include/linux/sched/topology.h   |  12 ++--
 kernel/sched/core.c              |  15 ++++-
 kernel/sched/cpufreq_schedutil.c |  84 +++++++++++++++---------
 kernel/sched/deadline.c          | 136 ++++++++++++++++++++++++++++-----------
 kernel/sched/fair.c              |   4 +-
 kernel/sched/sched.h             |  53 +++++++++++----
 9 files changed, 217 insertions(+), 92 deletions(-)

-- 
2.14.3
