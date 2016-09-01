From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/8] x86, cpu: provide a function topology_num_packages to enumerate #packages
Date: Thu,  1 Sep 2016 13:33:39 -0700
Message-ID: <1472762024-88771-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11872 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757045AbcIAVIu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 17:08:50 -0400
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Tim Chen <tim.c.chen@linux.intel.com>

We compute the the number of active packages during boot and
topology update.  Provide a function to export this info for
functions that need this topology info.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h | 1 +
 arch/x86/kernel/smpboot.c       | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 98b669d..0bcf3b7 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -129,6 +129,7 @@ static inline int topology_max_smt_threads(void)
 }
 
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
+extern int topology_num_packages(void);
 extern int topology_phys_to_logical_pkg(unsigned int pkg);
 #else
 #define topology_max_packages()			(1)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3782bd4..292df31 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -297,6 +297,11 @@ found:
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

