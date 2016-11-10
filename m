From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 2/8] x86/topology: Define x86's arch_update_cpu_topology
Date: Thu, 10 Nov 2016 14:36:34 -0800
Message-ID: <c443045806c75f6810704ab71e66e4a789beff1f.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The scheduler calls arch_update_cpu_topology() to check whether the
scheduler domains have to be rebuilt.

So far x86 has no requirement for this, but the upcoming ITMT support
makes this necessary.

Request the rebuild when the x86 internal update flag is set.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cf75871..a5ca88a 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,4 +146,5 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
+extern bool x86_topology_update;
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 42f5eb7..ac61ee7 100644
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
2.5.5

