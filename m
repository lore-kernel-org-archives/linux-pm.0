From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 2/5] PM / QoS: Add no_constraints_value field to struct pm_qos_constraints
Date: Fri, 17 Jan 2014 15:44:42 +0100
Message-ID: <19067088.JLdRPV4Ja3@vostro.rjw.lan>
References: <5434847.aCyiWHNRe7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5434847.aCyiWHNRe7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new field, no_constraints_value, to struct pm_qos_constraints
representing a list of PM QoS constraint requests to be returned by
pm_qos_get_value() when that list of requests is empty.

That field will be equal to default_value for all of the existing
global PM QoS classes and for the resume latency device PM QoS type,
but it will be different from default_value for the new latency
tolerance device PM QoS type introduced by the next changeset.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/qos.c |    1 +
 include/linux/pm_qos.h   |    1 +
 kernel/power/qos.c       |    5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/qos.c
===================================================================
--- linux-pm.orig/drivers/base/power/qos.c
+++ linux-pm/drivers/base/power/qos.c
@@ -190,6 +190,7 @@ static int dev_pm_qos_constraints_alloca
 	plist_head_init(&c->list);
 	c->target_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->default_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
 	c->notifiers = n;
 
Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -77,6 +77,7 @@ struct pm_qos_constraints {
 	struct plist_head list;
 	s32 target_value;	/* Do not change to 64 bit */
 	s32 default_value;
+	s32 no_constraint_value;
 	enum pm_qos_type type;
 	struct blocking_notifier_head *notifiers;
 };
Index: linux-pm/kernel/power/qos.c
===================================================================
--- linux-pm.orig/kernel/power/qos.c
+++ linux-pm/kernel/power/qos.c
@@ -66,6 +66,7 @@ static struct pm_qos_constraints cpu_dma
 	.list = PLIST_HEAD_INIT(cpu_dma_constraints.list),
 	.target_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
 	.default_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
+	.no_constraint_value = PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
 	.type = PM_QOS_MIN,
 	.notifiers = &cpu_dma_lat_notifier,
 };
@@ -79,6 +80,7 @@ static struct pm_qos_constraints network
 	.list = PLIST_HEAD_INIT(network_lat_constraints.list),
 	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
 	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
+	.no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
 	.type = PM_QOS_MIN,
 	.notifiers = &network_lat_notifier,
 };
@@ -93,6 +95,7 @@ static struct pm_qos_constraints network
 	.list = PLIST_HEAD_INIT(network_tput_constraints.list),
 	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
 	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
+	.no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
 	.type = PM_QOS_MAX,
 	.notifiers = &network_throughput_notifier,
 };
@@ -128,7 +131,7 @@ static const struct file_operations pm_q
 static inline int pm_qos_get_value(struct pm_qos_constraints *c)
 {
 	if (plist_head_empty(&c->list))
-		return c->default_value;
+		return c->no_constraint_value;
 
 	switch (c->type) {
 	case PM_QOS_MIN:
