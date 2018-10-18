From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 2/2] sched/cpufreq: Add the SPDX tags
Date: Thu, 18 Oct 2018 11:44:15 +0200
Message-ID: <1539855869-13524-2-git-send-email-daniel.lezcano@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539855869-13524-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, mingo@kernel.org
Cc: thara.gopinath@linaro.org, linux-kernel@vger.kernel.org, peterz@infradead.org, rui.zhang@intel.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, javi.merino@kernel.org, edubezval@gmail.com, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

The SPDX tags are not present in core.c and metrics.c.

Replace the license description by the SPDX tags.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/cpufreq/core.c    | 4 +---
 kernel/sched/cpufreq/metrics.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq/core.c b/kernel/sched/cpufreq/core.c
index 8c17a63..7a1400c 100644
--- a/kernel/sched/cpufreq/core.c
+++ b/kernel/sched/cpufreq/core.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Scheduler code and data structures related to cpufreq.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include "../sched.h"
 
diff --git a/kernel/sched/cpufreq/metrics.c b/kernel/sched/cpufreq/metrics.c
index 597df47..9083a70 100644
--- a/kernel/sched/cpufreq/metrics.c
+++ b/kernel/sched/cpufreq/metrics.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPUFreq governor based on scheduler-provided CPU utilization data.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.7.4
