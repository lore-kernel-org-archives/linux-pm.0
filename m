From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 0/8] schedutil enhancements
Date: Sun, 13 Mar 2016 22:22:04 -0700
Message-ID: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35354 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbcCNF0M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 01:26:12 -0400
Received: by mail-pa0-f47.google.com with SMTP id td3so121779875pab.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 22:26:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

I'm happy that scheduler-driven cpu frequency selection is getting some
attention. Rafael's recent schedutil governor is a step in the right direction.
This series builds on top of Rafael's schedutil governor, bringing it to parity
with some of the features in the schedfreq series posted by Steve[0], as well
as adding a couple of new things.

Patch 1 removes cpufreq_trigger_update()

Patches 2-4 move the cfs capacity margin out of the governor and into
cfs. This value is made tunable by a sysfs control in schedutil.

Patches 5-6 make cpufreq_update_util() aware of multiple scheduler
classes (cfs, rt & dl), and add storage & summation of these per-class
utilization values into schedutil.

Patches 7-8 introduces Dietmar's generic cpufreq implementation[1] of the
frequency invariance hook and changes the preprocessor magic in sched.h to
favor the cpufreq implementation over arch- or platform-specific ones.

If accepted, this series makes it trivial to port Steve and Juri's fine-grained
frequency selection in cfs and Vincent's rt utilization patch to the schedutil
governor.[2-6]

[0] lkml.kernel.org/r/1456190570-4475-1-git-send-email-smuckle@linaro.org
[1] https://git.linaro.org/people/steve.muckle/kernel.git/commit/1b7e57f89f14f7600e75e6fde42bf22d72927b3d
[2] lkml.kernel.org/r/1456190570-4475-5-git-send-email-smuckle@linaro.org
[3] lkml.kernel.org/r/1456190570-4475-6-git-send-email-smuckle@linaro.org
[4] lkml.kernel.org/r/1456190570-4475-7-git-send-email-smuckle@linaro.org
[5] lkml.kernel.org/r/1456190570-4475-8-git-send-email-smuckle@linaro.org
[6] lkml.kernel.org/r/1456190570-4475-11-git-send-email-smuckle@linaro.org

Dietmar Eggemann (1):
  cpufreq: Frequency invariant scheduler load-tracking support

Michael Turquette (7):
  sched/cpufreq: remove cpufreq_trigger_update()
  sched/fair: add margin to utilization update
  sched/cpufreq: new cfs capacity margin helpers
  cpufreq/schedutil: sysfs capacity margin tunable
  sched/cpufreq: pass sched class into cpufreq_update_util
  cpufreq/schedutil: sum per-sched class utilization
  sched: prefer cpufreq_scale_freq_capacity

 drivers/cpufreq/cpufreq.c           | 29 ++++++++++++
 drivers/cpufreq/cpufreq_governor.c  |  5 +-
 drivers/cpufreq/cpufreq_schedutil.c | 70 ++++++++++++++++++++++++----
 drivers/cpufreq/intel_pstate.c      |  5 +-
 include/linux/cpufreq.h             |  3 ++
 include/linux/sched.h               | 19 ++++++--
 kernel/sched/cpufreq.c              | 92 +++++++++++++++++++++++++------------
 kernel/sched/deadline.c             |  2 +-
 kernel/sched/fair.c                 | 18 +++++++-
 kernel/sched/rt.c                   |  2 +-
 kernel/sched/sched.h                | 29 +++++++++---
 11 files changed, 219 insertions(+), 55 deletions(-)

-- 
2.1.4

