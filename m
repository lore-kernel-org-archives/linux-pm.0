From: Konstantin Krivyakin <k.krivyakin@samsung.com>
Subject: [PATCH RFC 0/3] Per-process power consumption measurement facility
Date: Tue, 30 Jul 2013 12:17:36 +0400
Message-ID: <1375172259-9641-1-git-send-email-k.krivyakin@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38486 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IRy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 04:17:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, rjw@sisk.pl, viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org, kgene.kim@samsung.com, linux-pm@vger.kernel.org
Cc: k.krivyakin@samsung.com, i.zhbanov@samsung.com, e.voevodin@samsung.com, kyungmin.park@samsung.com, akpm@linux-foundation.org

This patchset adds per-process power consumption measurement facility.
Power consumption is very important on mobile platforms. This code
allows to measure consumed power in Watts*Hours. The consumed power
for process is updated on scheduler switch and depends on current
CPU voltage and frequency.

The formula for computation is: P = C * V^2 * f, where C is a constant
that reflects capacity of the system, V is the current voltage and
f is the current frequency.
(Taken from: http://en.wikipedia.org/wiki/CPU_power_dissipation).

In this patchset was added implementation for Exynos platform
to demonstrate how it works.

To minimize scheduler impact for each CPU P-state the value of (V^2 *f)
was precomputed at the time of platform initialization.

And to reduce performance impact furthermore, the C constant is multiplied
in userspace.

Konstantin Krivyakin (3):
  Add interface to receive current cpu power
  Add power consumption counter in task_struct.
  Update current cpu power when cpu freq change for exynos.

 drivers/cpufreq/cpufreq.c            |   17 +++++++++++++++++
 drivers/cpufreq/exynos-cpufreq.c     |    2 ++
 drivers/cpufreq/exynos-cpufreq.h     |    1 +
 drivers/cpufreq/exynos4x12-cpufreq.c |   19 ++++++++++++++++++-
 include/linux/cpufreq.h              |    6 ++++++
 include/linux/sched.h                |    2 ++
 include/uapi/linux/taskstats.h       |    2 ++
 kernel/fork.c                        |    1 +
 kernel/sched/core.c                  |    8 ++++++++
 kernel/sched/cputime.c               |   11 +++++++++++
 kernel/tsacct.c                      |    3 +++
 11 files changed, 71 insertions(+), 1 deletion(-)

-- 
1.7.9.5

