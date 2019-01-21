From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 1/3] PM / EM: Fix broken kerneldoc
Date: Mon, 21 Jan 2019 11:17:22 +0000
Message-ID: <20190121111724.18234-2-quentin.perret@arm.com>
References: <20190121111724.18234-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121111724.18234-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net, juri.lelli@redhat.com
Cc: mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some of the kerneldoc comments about the Energy Model framework are
slightly broken, hence causing errors when compiling the html doc.

Fix them.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 4 ++--
 kernel/power/energy_model.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..57889589e638 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_ENERGY_MODEL
 /**
- * em_cap_state - Capacity state of a performance domain
+ * struct em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
  * @power:	The power consumed by 1 CPU at this level, in milli-watts
  * @cost:	The cost coefficient associated with this level, used during
@@ -24,7 +24,7 @@ struct em_cap_state {
 };
 
 /**
- * em_perf_domain - Performance domain
+ * struct em_perf_domain - Performance domain
  * @table:		List of capacity states, in ascending order
  * @nr_cap_states:	Number of capacity states
  * @cpus:		Cpumask covering the CPUs of the domain
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9dc2c38764a..1e3a88ea4728 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -137,7 +137,7 @@ EXPORT_SYMBOL_GPL(em_cpu_get);
  * If multiple clients register the same performance domain, all but the first
  * registration will be ignored.
  *
- * Return 0 on success
+ * Return: 0 on success
  */
 int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
 						struct em_data_callback *cb)
-- 
2.20.1
