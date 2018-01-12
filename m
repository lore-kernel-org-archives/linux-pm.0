From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 6/8] irqchip/gic-v3-its: add ability to resend MAPC on resume
Date: Fri, 12 Jan 2018 13:24:20 -0800
Message-ID: <20180112212422.148625-7-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds a DT-binding to resend the MAPC command to an ITS node on
resume. If the ITS is powered down during suspend and the collections
are not backed by memory, the ITS will lose that state. This just sets
up the known state for the collections after the ITS is restored.

Change-Id: I4fe7f3f16500e1d3b14368262f03a43509c0049b
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 85 ++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5cb808e3d0bf..6d2688a2ee67 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_RESEND_MAPC_ON_RESUME		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -1949,52 +1950,53 @@ static void its_cpu_init_lpis(void)
 	dsb(sy);
 }
 
-static void its_cpu_init_collection(void)
+static void its_cpu_init_collection(struct its_node *its)
 {
-	struct its_node *its;
-	int cpu;
-
-	spin_lock(&its_lock);
-	cpu = smp_processor_id();
-
-	list_for_each_entry(its, &its_nodes, entry) {
-		u64 target;
+	int cpu = smp_processor_id();
+	u64 target;
 
-		/* avoid cross node collections and its mapping */
-		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-			struct device_node *cpu_node;
+	/* avoid cross node collections and its mapping */
+	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+		struct device_node *cpu_node;
 
-			cpu_node = of_get_cpu_node(cpu, NULL);
-			if (its->numa_node != NUMA_NO_NODE &&
-				its->numa_node != of_node_to_nid(cpu_node))
-				continue;
-		}
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (its->numa_node != NUMA_NO_NODE &&
+			its->numa_node != of_node_to_nid(cpu_node))
+			return;
+	}
 
+	/*
+	 * We now have to bind each collection to its target
+	 * redistributor.
+	 */
+	if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
 		/*
-		 * We now have to bind each collection to its target
+		 * This ITS wants the physical address of the
 		 * redistributor.
 		 */
-		if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
-			/*
-			 * This ITS wants the physical address of the
-			 * redistributor.
-			 */
-			target = gic_data_rdist()->phys_base;
-		} else {
-			/*
-			 * This ITS wants a linear CPU number.
-			 */
-			target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
-			target = GICR_TYPER_CPU_NUMBER(target) << 16;
-		}
+		target = gic_data_rdist()->phys_base;
+	} else {
+		/* This ITS wants a linear CPU number. */
+		target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+		target = GICR_TYPER_CPU_NUMBER(target) << 16;
+	}
 
-		/* Perform collection mapping */
-		its->collections[cpu].target_address = target;
-		its->collections[cpu].col_id = cpu;
+	/* Perform collection mapping */
+	its->collections[cpu].target_address = target;
+	its->collections[cpu].col_id = cpu;
 
-		its_send_mapc(its, &its->collections[cpu], 1);
-		its_send_invall(its, &its->collections[cpu]);
-	}
+	its_send_mapc(its, &its->collections[cpu], 1);
+	its_send_invall(its, &its->collections[cpu]);
+}
+
+static void its_cpu_init_collections(void)
+{
+	struct its_node *its;
+
+	spin_lock(&its_lock);
+
+	list_for_each_entry(its, &its_nodes, entry)
+		its_cpu_init_collection(its);
 
 	spin_unlock(&its_lock);
 }
@@ -3089,6 +3091,9 @@ void its_restore_enable(void)
 			its_write_baser(its, &its->tables[i],
 					its->tables[i].val);
 		writel_relaxed(ctx->ctlr, base + GITS_CTLR);
+
+		if (its->flags & ITS_FLAGS_RESEND_MAPC_ON_RESUME)
+			its_cpu_init_collection(its);
 	}
 	spin_unlock(&its_lock);
 }
@@ -3312,6 +3317,10 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
+	if (fwnode_property_present(its->fwnode_handle,
+				    "resend-mapc-on-resume"))
+		its->flags |= ITS_FLAGS_RESEND_MAPC_ON_RESUME;
+
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
@@ -3347,7 +3356,7 @@ int its_cpu_init(void)
 			return -ENXIO;
 		}
 		its_cpu_init_lpis();
-		its_cpu_init_collection();
+		its_cpu_init_collections();
 	}
 
 	return 0;
-- 
2.16.0.rc1.238.g530d649a79-goog
