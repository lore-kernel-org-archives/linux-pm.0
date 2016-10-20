From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v6 2/9] x86/topology: Provide topology_num_packages()
Date: Thu, 20 Oct 2016 14:59:56 -0700
Message-ID: <94727cbcda5e768227ecad61f584045c6d4b13c3.1477000078.git.tim.c.chen@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477000078.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1477000078.git.tim.c.chen@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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
index 951f093..4234e52 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -295,6 +295,11 @@ int topology_update_package_map(unsigned int apicid, unsigned int cpu)
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
2.5.5
