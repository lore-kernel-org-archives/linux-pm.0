From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 01/12 v2] CONFIG for CPU ConCurrency
Date: Mon, 12 May 2014 02:16:50 +0800
Message-ID: <1399832221-8314-2-git-send-email-yuyang.du@intel.com>
References: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399832221-8314-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com, yuyang.du@intel.com
List-Id: linux-pm@vger.kernel.org

Add CONFIG_CPU_CONCURRENCY in arch/x86/Kconfig. This CONFIG enables/disables
CPU ConCurrency load metric tracking.

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 arch/x86/Kconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 25d2c6f..9bfac8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -797,6 +797,17 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config CPU_CONCURRENCY
+	bool "CPU ConCurency (CC)"
+	default n
+	depends on SMP
+	---help---
+	  CPU ConCurrency (CC) is a new CPU load metric that measures the CPU
+	  load by averaging the number of running tasks. Using CC, the scheduler
+	  can evaluate the load of CPUs and may consolidate workloads on CPUs in
+	  load balancing for power efficiency without sacrificing performance.
+	  If unsure say N here.
+
 source "kernel/Kconfig.preempt"
 
 config X86_UP_APIC
-- 
1.7.9.5
