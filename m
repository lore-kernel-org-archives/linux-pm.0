From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 03/10] x86/topology: Provide topology_num_packages()
Date: Wed, 21 Sep 2016 12:19:05 -0700
Message-ID: <1474485552-141429-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Returns number of cpu packages discovered.

This information is needed to determine the size of the platform and
decide if the Intel Turbo Boost Max Technology 3.0 (ITMT) feature
should be turned on by default.  The ITMT feature is more effective on
single socket client like system that uses small number of cores most
of the time.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h | 3 +++
 arch/x86/kernel/smpboot.c       | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cf75871..3e95dfc 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -129,10 +129,13 @@ static inline int topology_max_smt_threads(void)
 }
 
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
+extern int topology_num_packages(void);
 extern int topology_phys_to_logical_pkg(unsigned int pkg);
 #else
 #define topology_max_packages()			(1)
 static inline int
+topology_num_packages(void) { return 1; }
+static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7137ec4..6a763a2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -295,6 +295,11 @@ found:
 	return 0;
 }
 
+int topology_num_packages(void)
+{
+	return logical_packages;
+}
+
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
-- 
2.7.4
