From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [RFC PATCH 6/6] drivers: base: arch_topology.c: Enable EAS for arm/arm64 platforms
Date: Tue, 20 Mar 2018 09:43:12 +0000
Message-ID: <20180320094312.24081-7-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

Energy Aware Scheduling (EAS) has to be started from the arch code.
This commit enables it from the arch topology driver for arm/arm64
systems, hence enabling a better support for Arm big.LITTLE and future
DynamIQ architectures.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 52ec5174bcb1..e2206ea16538 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/sched/energy.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -204,6 +205,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
+		init_sched_energy();
 	}
 
 	return 0;
-- 
2.11.0
