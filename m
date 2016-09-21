From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 04/10] x86/topology: Define x86's arch_update_cpu_topology
Date: Wed, 21 Sep 2016 12:19:06 -0700
Message-ID: <1474485552-141429-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

The scheduler calls arch_update_cpu_topology() to check whether the
scheduler domains have to be rebuilt.

So far x86 has no requirement for this, but the upcoming ITMT support
makes this necessary.

Request the rebuild when the x86 internal update flag is set.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 3e95dfc..323f61f 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -149,4 +149,5 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
+extern bool x86_topology_update;
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6a763a2..38901b3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -109,6 +109,17 @@ static bool logical_packages_frozen __read_mostly;
 /* Maximum number of SMT threads on any online core */
 int __max_smt_threads __read_mostly;
 
+/* Flag to indicate if a complete sched domain rebuild is required */
+bool x86_topology_update;
+
+int arch_update_cpu_topology(void)
+{
+	int retval = x86_topology_update;
+
+	x86_topology_update = false;
+	return retval;
+}
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
-- 
2.7.4
