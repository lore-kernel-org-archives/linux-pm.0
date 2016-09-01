From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/8] sched, x86: use arch_update_cpu_topology to indicate x86 need sched domain rebuild
Date: Thu,  1 Sep 2016 13:33:40 -0700
Message-ID: <1472762024-88771-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Provides x86 with arch_update_cpu_topology function. This function
allows us to indicate that a condition is detected that the sched
domain of x86 needs a complete rebuild.  This is done by setting the
x86_topology_update flag.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/smpboot.c       | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 0bcf3b7..8d6df77 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -147,6 +147,8 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
+extern bool x86_topology_update;
+
 #ifdef CONFIG_SCHED_ITMT
 extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
 #endif /* CONFIG_SCHED_ITMT */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 292df31..737b9edf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -110,6 +110,17 @@ static bool logical_packages_frozen __read_mostly;
 int __max_smt_threads __read_mostly;
 
 unsigned int __read_mostly sysctl_sched_itmt_enabled;
+/* Flag to indicate if a complete sched domain rebuild is required */
+bool x86_topology_update;
+
+int arch_update_cpu_topology(void)
+{
+	if (x86_topology_update) {
+		x86_topology_update = false;
+		return 1;
+	} else
+		return 0;
+}
 
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
-- 
2.7.4

