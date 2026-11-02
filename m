Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605292;
	b=ArAXz/Pq5GgvbSbBJGKbt5asHFtWOXoJbB7NqEmb+A+PIYoHIh4xwxFzsokwVhOIODfN
	 yjStFEjeAVNVtJnHWgI03Y7cwbf9xRy5As5S+2h6ZiPlDJkiUWhhp9FIGDxvkDlUzBNC/
	 OOUBFAGsO2Ma7nTlBvrIQd+w/ENbkUs05FJ6TMAdXU8g2u9fJcicnFdPiCQFJ6STBVQRj
	 SHgZNni8Bhdeb/xUXhyhdZnMQ66gWALQE4tJczfOzbXHyfj6tA8hPPooJ3w1wF7jjGROo
	 et1/FUygDo9RSKjihrVwFD3udxKdN5DUln/264xdUF66yUQrFnlbw0PK3pDnS0kDFYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605292;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Organization:Content-Transfer-Encoding;
	bh=JUi43PBjxXqcX4hYpItD8jmt5kHgqOK43qLdj1DOhuc=;
	b=U0vM9KRbtHE/w2whqKCrbkwgYV3cSHxdYFFZokQ2VszKw4BvIav4S22joYtDBXClGbAi
	 FE1v8X0BqOQ9PVrJVrb//KGXpb9eYpq5c47Hfw4Tx/nvO3GwftWCyeIBT5MwSPZs57Vza
	 XwE1QyqVCth8jHPFELeeXlSHLKU1JuUn0dNd2lnktGK7lDLCyEPv1EunlCa02J3g6lala
	 q9JmCEKChH0/alZ/kTAsGYGrYc6su7uIGwtaL21bof2PUaZqlE/zSinAIEN0lwll7U6+f
	 vF5Nherr6n5SUAu/8Db8Dk3qhpa1ZaKJ2Y6Rz1eqPMkra5EEbZ6JHNwxuq6r5ddxH1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FniB4ja0;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F8606A335;
	Mon,  2 Nov 2026 07:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A50F8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FniB4ja0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605290; x=1825141290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bYvJS0w66+9dDiI+e8ZYA10JMibCLprpJl6WdEvTFU=;
  b=FniB4ja0xfSLdIaNOGMfXv/kgnp4rR9qZFaN3FVaC5FSF08qIbLSVzZf
   m7xpA1OuDNMe8wx/A+u3tceUJnxuBU9cO+S4SNo/h0zoHan2w1/Lbd39x
   TrWddWB+Kg98iPm77VOoGWH62g32sFOa5deWvkV5yMc/OdAMn5nNsfRYd
   8nANGIk3Q+1DtQz+h9CWcYN8sx/qmLHBsKVene693SnJcT825r4zc59Fu
   OJCUNk7Unu9EeapKxWS/H7zdwjyInkzdjNCEgqo9abOxb25Jf+mIyuLVw
   YrCWf+qM+T9UNxj5p8SMzw+GKD7xu1TCwBUUurRETsBdBsuLM7ekGaGC1
   g==;
X-CSE-ConnectionGUID: Okk+Qm4iT7ewEcJpbfT3hA==
X-CSE-MsgGUID: CRMbOmdsRtq1vk8+omKpCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300198"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300198"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:29 -0800
X-CSE-ConnectionGUID: MbFtvSADTX2n8HPs+S64Rw==
X-CSE-MsgGUID: KzU6cer5QI65EMAUbZ9jnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6182265"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:22 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH 5/6] perf/x86/intel/pt: Reset stale MSR state on CPU start and resume
Date: Mon,  2 Nov 2026 09:40:38 +0200
Message-ID: <20261102074039.26983-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102074039.26983-1-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The Intel PT driver caches the last values written to
IA32_RTIT_OUTPUT_BASE, IA32_RTIT_OUTPUT_MASK_PTRS and IA32_RTIT_ADDRn_A/B,
and skips redundant WRMSRs.  Those cached values are not invalidated when
the hardware state changes outside the driver's control.

After S3, hibernation, CPU replacement, or similar events, the hardware
MSRs may be reset while the cached copies retain their old values.
Conversely, after warm reboot, kexec or kdump, the MSRs may retain values
from a previous kernel while the cached copies start at zero.  In either
case, the cached state no longer matches the hardware state and the
driver can wrongly skip WRMSRs that must be issued.

In particular, after resume the driver can restart tracing with
OUTPUT_BASE left at its reset value of 0.  Depending on the output mode,
this may cause Intel PT to write trace data to unintended physical
addresses (typically page 0) and corrupt arbitrary physical memory,
including kernel memory or MMIO.

IA32_RTIT_STATUS can also retain Error or Stopped bits from a previous
kernel.  Because STATUS is only cleared on an event's first start, stale
bits can suppress packet generation and trigger spurious "ToPA ERROR"
messages.

Add intel_pt_reset_cpu_state() to invalidate all cached PT MSR values and
clear stale STATUS bits.  Call it from intel_pmu_cpu_starting() (every
CPU with Intel PT also has architectural perfmon), ensuring that PT state
is reinitialized whenever a CPU comes online, and also call it from
restore_processor_state() to handle the boot CPU.

intel_pt_reset_cpu_state() is an Intel PMU implementation detail.  Rather
than expose it directly to arch/x86/power, add a single x86 perf hook,
perf_restore_processor_state(), declared in <asm/perf_event.h>, that
restores all perf state lost across suspend and resume.  The new hook
invokes both perf_restore_debug_store() and intel_pt_reset_cpu_state().
As a result, perf_restore_debug_store() no longer needs a public
declaration in <linux/perf_event.h>, and can be moved into the x86 perf
internals.

Use BIT_ULL(63) as the invalid cached value because it is not a valid
value for any of the affected PT MSRs.  Replace the cached pt_filters
structure with dedicated u64 arrays so the invalid value can also be
represented on 32-bit systems.

Note, an event that remains active on the boot CPU across S3 or
hibernation is not addressed here.

Example showing page 0 corruption with S3:

 After S3, when Intel PT is scheduled back in, the MSRs match the
 saved values, so are not updated, but IA32_RTIT_OUTPUT_BASE is 0.

 # cat /sys/power/mem_sleep
 s2idle [deep]
 # dd if=/dev/mem bs=4096 count=1 | od -t x1 -A x
 1+0 records in
 1+0 records out
 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000237849 s, 4.1 MB/s
 000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 001000
 # perf record -e intel_pt// -- rtcwake -m mem -s 10
 rtcwake: wakeup from "mem" using /dev/rtc0 at Mon Oct 26 18:04:26 2026
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 5.343 MB perf.data ]
 # dd if=/dev/mem bs=4096 count=1 | od -t x1 -A x
 1+0 records in
 1+0 records out
 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000236374 s, 4.1 MB/s
 000000 80 d2 06 59 03 b2 c8 dc be ae ce c0 ec 82 b4 0c
 000010 59 04 82 9a c0 e8 84 cc e6 92 b8 fc de 04 59 05
 000020 bc 86 b0 8a d4 82 b4 c0 ac d0 8a d4 82 b4 c0 59
 000030 06 ac d0 8a d4 82 b4 c0 ac 34 59 07 82 b4 c0 ac
 ...

Fixes: 295c52ee1485 ("perf/x86/intel/pt: Prevent redundant WRMSRs")
Fixes: eadf48cab4b6 ("perf/x86/intel/pt: Add support for address range filtering in PT")
Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every schedule-in")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c      |  9 +++++++
 arch/x86/events/intel/pt.c        | 39 +++++++++++++++++++++++++++----
 arch/x86/events/intel/pt.h        |  6 +++--
 arch/x86/events/perf_event.h      |  4 ++++
 arch/x86/include/asm/perf_event.h |  3 +++
 arch/x86/power/cpu.c              |  3 ++-
 include/linux/perf_event.h        |  6 -----
 7 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..88281559026d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6489,6 +6489,8 @@ static void intel_pmu_cpu_starting(int cpu)
 	int core_id = topology_core_id(cpu);
 	int i;
 
+	intel_pt_reset_cpu_state();
+
 	if (is_hybrid() && !init_hybrid_pmu(cpu))
 		return;
 
@@ -6573,6 +6575,13 @@ static void intel_pmu_cpu_starting(int cpu)
 	}
 }
 
+/* The boot CPU is not hotplugged across S3, hibernation or kexec jump */
+void perf_restore_processor_state(void)
+{
+	perf_restore_debug_store();
+	intel_pt_reset_cpu_state();
+}
+
 static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 {
 	struct intel_excl_cntrs *c;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8d71c00f9ff6..272808f2b483 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -492,14 +492,14 @@ static u64 pt_config_filters(struct perf_event *event)
 		 */
 
 		/* avoid redundant msr writes */
-		if (pt->filters.filter[range].msr_a != filter->msr_a) {
+		if (pt->addr_a[range] != filter->msr_a) {
 			wrmsrq(pt_address_ranges[range].msr_a, filter->msr_a);
-			pt->filters.filter[range].msr_a = filter->msr_a;
+			pt->addr_a[range] = filter->msr_a;
 		}
 
-		if (pt->filters.filter[range].msr_b != filter->msr_b) {
+		if (pt->addr_b[range] != filter->msr_b) {
 			wrmsrq(pt_address_ranges[range].msr_b, filter->msr_b);
-			pt->filters.filter[range].msr_b = filter->msr_b;
+			pt->addr_b[range] = filter->msr_b;
 		}
 
 		rtit_ctl |= (u64)filter->config << pt_address_ranges[range].reg_off;
@@ -1912,6 +1912,37 @@ void cpu_emergency_stop_pt(void)
 		pt_event_stop(pt->handle.event, PERF_EF_UPDATE);
 }
 
+/* Not a valid value for any of the cached Intel PT MSRs */
+#define PT_MSR_INVALID	BIT_ULL(63)
+
+/*
+ * Intel PT MSRs may have been reset, or left set by a previous kernel, so
+ * invalidate the cached copies and clear stale STATUS bits.
+ */
+void intel_pt_reset_cpu_state(void)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	u64 status;
+	int i;
+
+	/* Can run before pt_init(), so check the feature bit */
+	if (!boot_cpu_has(X86_FEATURE_INTEL_PT))
+		return;
+
+	pt->output_base = PT_MSR_INVALID;
+	pt->output_mask = PT_MSR_INVALID;
+	for (i = 0; i < PT_FILTERS_NUM; i++) {
+		pt->addr_a[i] = PT_MSR_INVALID;
+		pt->addr_b[i] = PT_MSR_INVALID;
+	}
+
+	rdmsrq(MSR_IA32_RTIT_STATUS, status);
+	if (status & (RTIT_STATUS_ERROR | RTIT_STATUS_STOPPED)) {
+		/* Fails if a previous kernel left TraceEn set */
+		wrmsrq_safe(MSR_IA32_RTIT_STATUS, 0);
+	}
+}
+
 int is_intel_pt_event(struct perf_event *event)
 {
 	return event->pmu == &pt_pmu.pmu;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 700e1a915d25..9fd2c02a90e1 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -111,7 +111,8 @@ struct pt_filters {
 /**
  * struct pt - per-cpu pt context
  * @handle:		perf output handle
- * @filters:		last configured filters
+ * @addr_a:		cached RTIT_ADDRn_A MSR values
+ * @addr_b:		cached RTIT_ADDRn_B MSR values
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
  * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
@@ -121,7 +122,8 @@ struct pt_filters {
  */
 struct pt {
 	struct perf_output_handle handle;
-	struct pt_filters	filters;
+	u64			addr_a[PT_FILTERS_NUM];
+	u64			addr_b[PT_FILTERS_NUM];
 	int			handle_nmi;
 	int			vmx_on;
 	int			pause_allowed;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e274802ef062..32f1297fd9fe 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1867,6 +1867,8 @@ void init_debug_store_on_cpu(int cpu);
 
 void fini_debug_store_on_cpu(int cpu);
 
+void perf_restore_debug_store(void);
+
 void release_ds_buffers(void);
 
 void reserve_ds_buffers(void);
@@ -2035,6 +2037,8 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
 
+void intel_pt_reset_cpu_state(void);
+
 int intel_bts_interrupt(void);
 
 void intel_bts_enable_local(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5c92d43bbef8..49130b28a21a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -828,6 +828,7 @@ struct x86_guest_pebs {
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
 							 struct x86_guest_pebs *guest_pebs);
 extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
+extern void perf_restore_processor_state(void);
 #else
 struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
 						  struct x86_guest_pebs *guest_pebs);
@@ -835,6 +836,8 @@ static inline void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	memset(lbr, 0, sizeof(*lbr));
 }
+
+static inline void perf_restore_processor_state(void) { }
 #endif
 
 #ifdef CONFIG_CPU_SUP_INTEL
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 702f30eaf9c4..ad8108faa743 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -29,6 +29,7 @@
 #include <asm/microcode.h>
 #include <asm/msr.h>
 #include <asm/fred.h>
+#include <asm/perf_event.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -278,7 +279,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
 	cache_bp_restore();
-	perf_restore_debug_store();
+	perf_restore_processor_state();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eb3f7bab498c..4551de15efbe 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2031,12 +2031,6 @@ static inline int perf_allow_tracepoint(void)
 
 #endif /* !CONFIG_PERF_EVENTS */
 
-#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
-extern void perf_restore_debug_store(void);
-#else
-static inline void perf_restore_debug_store(void)			{ }
-#endif
-
 #define perf_output_put(handle, x)	perf_output_copy((handle), &(x), sizeof(x))
 
 struct perf_pmu_events_attr {
-- 
2.53.0

