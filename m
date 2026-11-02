Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605278;
	b=ylWPUQ+UhxqPKMif/k2t5hgOdk7Chx36mkqIkNzpVZWt9aOcs1m/MpS2NpSvW96gSkFm
	 6DkBUxYspFk/69/5EmkCOp65lnZeKEHzKY9zK4NTP5DzCBdBRcy/hJuWajNvclC0jwqF7
	 YceHNgluN/v0zwyb107gYAw7jnNANrWuE/SVmnnDvKqJh0d3CqbuSiCM4PLb2HlN048qs
	 eIMO0+9QWFw2kdp4rzxLUbTTZZSDLUb2hU8hDD70+CO/YDLi1hL3MxiGVb0EaBl3yGP/s
	 Gd/cipJqqH/uIu3STVPM88ym3+hAnMlQp7o/eLlD+MpR9riyeAz7Jw2UHg9XwBz3Jbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Organization:Content-Transfer-Encoding;
	bh=Y+JrBrvv9TALMnKkcDN+SfJ03veLpPfW6QH2UWl2NCs=;
	b=mtc/HaQ/bQ0dHOshP4KRkzWi1GGbsFox9JdkLBQ38Lrj8D1QbF5s9ygo3hNeEgwv3nfF
	 /ER6xaQFXT+KDeGBFiejJX7S2yheuV8596OGvMoJaDzux7K2OCUWyhAW/6Dn7Rp9aePrQ
	 Td0DtKrsubL5QcZtzWNN4cM5dGESRUuhVTPGQ0QFb6fSfkqyS0hKsGq55phiC7ogZ5M/0
	 AUCwA9YL1tKz2G5CLkiQswJCiQcuy4cB5BBk3z8cqfaCL1to5lJqrA0Hgakub7gHht83M
	 0F7nUNe8T0oZalpo7rIHXf8r+pQsUNX83bieYgx6lDirQCoFkDnn4kA6F3aEmOotR+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yoi9rA88;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D82606A339;
	Mon,  2 Nov 2026 07:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D82606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yoi9rA88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605276; x=1825141276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RB3Mt1NVY7U7NGufMY5kpN1ZGENSSimSaTe0EXkvqQ=;
  b=Yoi9rA88Tr2C4od4G4XagKacRnB3QyL6x53pil2m9agObucLTUXjGR7J
   i5c5MF8Bkn9QSKB1Izn/jw7zFVUamxx94gO+lICx2Y9GhLXSjZKdUcnbl
   n77T/bvVJiKo5QuEfyhUgtb35aX/+AqcVOjp4XYftYlPv0vmkqOP13kf/
   OW8BDvefcVKgGq3uXQTA7Pp1y8CbbgJ1HQkdOYa1QIj7wSXqKl6TYt4Ji
   kQ1c+GsFIDctOdlUxzwF/5oCSJ7MfINXrl1QIGRnb8NWV+OxInSepLp5E
   gy01so6IfI8p9gdDied8ujIdEVpvZP9+Zn/EZ7ICtzqrfYT7uwsLKNUHr
   w==;
X-CSE-ConnectionGUID: rv4dcg2HSZOGdCnIW4582Q==
X-CSE-MsgGUID: 1mv0yOysQXuLatETV8/v4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300147"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300147"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:15 -0800
X-CSE-ConnectionGUID: h3ql/C8oTna0vbi90nTK9Q==
X-CSE-MsgGUID: pDzw3HqxR9+EzSyKL1oNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6182240"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:08 -0800
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
Subject: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
Date: Mon,  2 Nov 2026 09:40:36 +0200
Message-ID: <20261102074039.26983-4-adrian.hunter@intel.com>
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

Intel PT tracing can survive a shutdown sequence and continue into a
kexec'ed kernel.

The perf reboot notifier removes only per-CPU events, so per-task
events can remain active, for example:

        perf record -e intel_pt// -- kexec -e

Tracing can also remain enabled on CPUs running traced tasks when
stop_other_cpus() halts them.  On systems where Intel PT is unavailable
in VMX operation (IA32_VMX_MISC[14] = 0), VMXOFF during KVM shutdown can
re-enable TraceEn via intel_pt_handle_vmx(0) if a tracing event is
still active.

As a result, the new kernel may inherit TraceEn set and Intel PT can
continue writing into buffers allocated by the old kernel.  Those pages
may subsequently be reused for unrelated purposes.  In addition,
pt_init() detects TraceEn already enabled and refuses to register the
PMU.

Stopping events from a shutdown callback is not sufficient because they
may be scheduled back in until interrupts are finally disabled.
Instead, add a syscore shutdown handler that:

  - prevents TraceEn from being enabled again, and
  - clears TraceEn on every CPU.

syscore_shutdown() is executed for kexec, reboot, halt and poweroff,
and still runs while CPUs can service IPIs.

To block tracing from restarting, introduce a shutdown flag checked by
both pt_config_start() and intel_pt_handle_vmx(), the only places that
can enable TraceEn.  After shutdown begins, events remain in a
self-consistent perf state but no longer generate trace data, matching
the existing VMX-on handling.

Clear TraceEn by reading IA32_RTIT_CTL on each CPU and updating the
hardware state directly rather than relying on aux_config, ensuring
tracing is disabled regardless of perf's software state.  Once the
shutdown flag is set, no racing path can re-enable TraceEn.

kexec jump (KEXEC_PRESERVE_CONTEXT) is not covered because it does not
execute syscore shutdown.  kdump continues to rely on
cpu_emergency_stop_pt().

Example:

    On first kernel:

	perf record -e intel_pt// -- kexec -e

    On second kernel:

	# Without the fix, PT is enabled at boot
	dmesg | grep -i 'PT is enabled at boot time'
	[    2.065889] pt: PT is enabled at boot time, doing nothing

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/pt.c | 46 +++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 36bf039668d7..7453e9880b25 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/kvm_types.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
@@ -34,6 +35,9 @@ static DEFINE_PER_CPU(struct pt, pt_ctx);
 
 static struct pt_pmu pt_pmu;
 
+/* Set at shutdown, after which TraceEn must not be set */
+static bool pt_shutdown;
+
 /*
  * Capabilities of Intel PT hardware, such as number of address bits or
  * supported output schemes, are cached and exported to userspace as "caps"
@@ -425,7 +429,7 @@ static void pt_config_start(struct perf_event *event)
 		return;
 
 	ctl |= RTIT_CTL_TRACEEN;
-	if (READ_ONCE(pt->vmx_on))
+	if (READ_ONCE(pt->vmx_on) || READ_ONCE(pt_shutdown))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
 	else
 		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
@@ -1609,7 +1613,7 @@ void intel_pt_handle_vmx(int on)
 		                     PERF_AUX_FLAG_PARTIAL);
 
 	/* Turn PTs back on */
-	if (!on && event)
+	if (!on && event && !READ_ONCE(pt_shutdown))
 		wrmsrq(MSR_IA32_RTIT_CTL, event->hw.aux_config);
 
 	local_irq_restore(flags);
@@ -1860,6 +1864,38 @@ static int pt_event_init(struct perf_event *event)
 	return 0;
 }
 
+static void pt_shutdown_cpu(void *info)
+{
+	u64 ctl;
+
+	/*
+	 * After VMXON on CPUs without PT support in VMX operation,
+	 * TraceEn is already clear and RTIT_CTL must not be written.
+	 */
+	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
+	if (ctl & RTIT_CTL_TRACEEN)
+		wrmsrq(MSR_IA32_RTIT_CTL, ctl & ~RTIT_CTL_TRACEEN);
+}
+
+/*
+ * Tracing must not continue into a kexec'ed kernel, which may reuse the
+ * trace buffer memory, so stop tracing on all CPUs and prevent it from
+ * being started again. Events are left in place, but record nothing more.
+ */
+static void pt_syscore_shutdown(void *data)
+{
+	WRITE_ONCE(pt_shutdown, true);
+	on_each_cpu(pt_shutdown_cpu, NULL, 1);
+}
+
+static const struct syscore_ops pt_syscore_ops = {
+	.shutdown	= pt_syscore_shutdown,
+};
+
+static struct syscore pt_syscore = {
+	.ops = &pt_syscore_ops,
+};
+
 void cpu_emergency_stop_pt(void)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
@@ -1933,7 +1969,11 @@ static __init int pt_init(void)
 		intel_pt_validate_hw_cap(PT_CAP_num_address_ranges);
 
 	ret = perf_pmu_register(&pt_pmu.pmu, "intel_pt", -1);
+	if (ret)
+		return ret;
 
-	return ret;
+	register_syscore(&pt_syscore);
+
+	return 0;
 }
 arch_initcall(pt_init);
-- 
2.53.0

