From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 05/12 v2] CONFIG for Workload Consolidation
Date: Mon, 12 May 2014 02:16:54 +0800
Message-ID: <1399832221-8314-6-git-send-email-yuyang.du@intel.com>
References: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

Add CONFIG_WORKLOAD_CONSOLIDATION in arch/x86/Kconfig. This CONFIG enables
and disables CPU workload consolidation in scheduler's load balancing.

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 arch/x86/Kconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9bfac8d..0999c16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -808,6 +808,16 @@ config CPU_CONCURRENCY
 	  load balancing for power efficiency without sacrificing performance.
 	  If unsure say N here.
 
+config WORKLOAD_CONSOLIDATION
+	bool "CPU Workload Consolidation"
+	default n
+	depends on CPU_CONCURRENCY
+	---help---
+	  CPU Workload Consolidation is a new CPU PM module, which uses the CPU
+	  concurrency of the CPU, and allows asymmetric concurrency across CPUs to
+	  reduce the SW and HW overhead to increase load balance efficiency and
+	  conserve energy. If unsure say N here.
+
 source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
-- 
1.7.9.5
