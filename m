Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605270;
	b=zVaQPyolfijxer8oKyhjxbpXFytpwLEa/JCL/nzrT+1uv3zjmjrdGEFueubo2PKvDLCK
	 Q7hstCU1+ypf1MLK92ZanlcmICGJE8zw58nPqXCz/f8PrFyggw2fmdOoX/qiXeXVV8Rz4
	 IpoP7/osAphCMP4puY/f+EUfqbItQUmtMIwwdyHx9kdov6WdD+BWwKcwnLVGUEOyWoa98
	 h8Gselo+j6cOKidxkRwxveT8tT5HgcXS20dvwK5jE+8F1z7vdQvGdAgiHZfbTAgQawznG
	 1X3fXtDd6ri/7eOrgWNYBvbAVetVoulhurGe0GjeSiGkBiA7T3sDTS4tPSAcQVeggjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605270;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Organization:Content-Transfer-Encoding;
	bh=RWvaWe3fQrnhnNXMlm0+MG4DLsCk6PnMuuEdTBN2qog=;
	b=xzSK8P0DR9QcfL+gtEvAomXZ40DuUCKSaMrZ4DR33qy+0DvgWX2IL5T0k58f4VyYi/mr
	 LGyBbIC/nSSZmfAr7rvS7njDqvBkTxMQhWBj/WhpjaVNjh4aZ0KLooDq4YDDdc3sL7/BC
	 VuFals44dkZvaRfvn8Ej8W6lMmJjyGhd9jkYvWSlILd4Q/FP1q/MAOgWEv6C6WRfF6pWf
	 Nzx2qV6J8aLB4oDLJX+AABJ+/LReyC+St6fgMtvU4qIB9SeBZxNa/OqmjIs04PftCkB0+
	 rfqPahVuIzzXXNytM4x7O30dIE/bUB5nbg6U0cYawz9NAdNBa+yz9yYGeWhCRa442yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XNvniGJt;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE850606A334;
	Mon,  2 Nov 2026 07:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE850606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XNvniGJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605269; x=1825141269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKwZHaphQF9yKywgOabuA7G4fnw+cforMEHdkv1ePGk=;
  b=XNvniGJtHwP8qYr7NRSHiS7YwLpuH8xWfF+anEHVo//j7AAYS8o2zUDw
   JYLo5Nnc29rh29z/+RLoZPY96wGxqKTDYxyWPdVyvqHGDyji/zOwkVRrq
   hE1ZQuPg5iax59zlTV4ESQQvEOa1S2n2ExJvBxU6fg64AfO4E7g4H54tV
   0e5hxem8hGH0m3qTGPTSFe888E99bN3vOAZlQjjYl25BfllZdWY8u0/E3
   3bqDjac3AUXqf2MKlgP3T+0CM7m9bSD5svWvMAJK2PEpssOuMxKrpgHsH
   IaxEZAQLQRBZ3oGLyAx6zcGxHA8yBcpNzeYcPnUFqocQtKjE0FTaYlIdC
   w==;
X-CSE-ConnectionGUID: pYrgcJjQQMC5a0r0hkAleQ==
X-CSE-MsgGUID: mC+GqT0fQC2wD2anHJQoeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300122"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300122"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:08 -0800
X-CSE-ConnectionGUID: Z+8U3Z8bQSKdMhOR7kiW2g==
X-CSE-MsgGUID: OuZp5KUtSYuIkXvr+8V3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6182222"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:01 -0800
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
Subject: [PATCH 2/6] perf/x86/intel/pt: Stop tracing if VMXON has not yet happened
Date: Mon,  2 Nov 2026 09:40:35 +0200
Message-ID: <20261102074039.26983-3-adrian.hunter@intel.com>
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

On Broadwell, which does not support Intel PT in VMX operation
(IA32_VMX_MISC[14] = 0), VMXON clears IA32_RTIT_CTL.TraceEn and any
subsequent write to IA32_RTIT_CTL causes #GP.

To avoid that, intel_pt_handle_vmx() sets pt->vmx_on so that
pt_config_start() and pt_config_stop() skip writes to
IA32_RTIT_CTL while VMX is active.

However, pt->vmx_on is set before VMXON executes. An NMI in the window
between setting pt->vmx_on and executing VMXON can then observe
vmx_on == true while tracing is still enabled.

In that case pt_config_stop() skips the write that would clear TraceEn,
leaving tracing active. This can subsequently cause:

  - intel_pt_interrupt() to reprogram PT output registers while
    TraceEn is set, resulting in #GP, or
  - cpu_emergency_stop_pt() to leave tracing active during kdump,
    allowing tracing to continue into the capture kernel.

If pt->vmx_on is set, read IA32_RTIT_CTL and still clear TraceEn when
it remains enabled.  Writing IA32_RTIT_CTL is valid until VMXON
executes, while after VMXON TraceEn is guaranteed clear and cannot be
re-enabled.  Consequently no write is attempted while VMX is active.

Example (on a Broadwell):

    Instrument x86_vmx_enable_virtualization_cpu() to enlarge the
    window e.g.

	 	intel_pt_handle_vmx(1);

	+	for (int j = 0; j < 6; j ++) {
	+		int cpu = smp_processor_id();
	+
	+		pr_info("VMX: cpu %d: spinning %d\n", cpu, j);
	+		for (int i = 0; i < 10000; i++)
	+			cpu_relax();
	+	}

	 	r = x86_virt_cpu_vmxon();

    Start Intel PT tracing on a CPU:

	perf record -e intel_pt//k -C 1 &

    Load KVM:

	modprobe kvm_intel

    Observe kernel messages.  Without the fix, there is an unchecked
    MSR access:

	VMX: cpu 1: spinning 0
	VMX: cpu 1: spinning 1
	VMX: cpu 1: spinning 2
	VMX: cpu 1: spinning 3
	unchecked MSR access error: WRMSR to 0x571 ...
	Call Trace:
	 <NMI>
	 intel_pt_interrupt+0x190/0x490
	 handle_pmi_common+0x6fc/0xc10
	 intel_pmu_handle_irq+0x1c9/0x5e0
	 perf_event_nmi_handler+0x62/0x90
	 nmi_handle.part.0+0xbd/0x270
	 default_do_nmi+0x3c/0x120
	 exc_nmi+0xe3/0x110
	 <TASK>
	 x86_vmx_enable_virtualization_cpu+0x88/0xd0
	 x86_virt_get_ref+0x3f/0x80
	 kvm_arch_enable_virtualization_cpu+0x1c4/0x820 [kvm]
	 kvm_online_cpu+0x31/0x50 [kvm]
	 cpuhp_invoke_callback+0x25c/0xf90
	 cpuhp_thread_fun+0x298/0x7e0
	 smpboot_thread_fn+0x28c/0x6d0
	 kthread+0x2cb/0x3a0
	 ret_from_fork+0x5ff/0x7f0

Fixes: 1c5ac21a0e9b ("perf/x86/intel/pt: Don't die on VMXON")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/pt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 49349afee611..36bf039668d7 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -567,6 +567,15 @@ static void pt_config(struct perf_event *event)
 	pt_config_enable(event);
 }
 
+static bool pt_trace_enabled(void)
+{
+	u64 ctl;
+
+	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
+
+	return ctl & RTIT_CTL_TRACEEN;
+}
+
 static void pt_config_stop(struct perf_event *event)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
@@ -577,7 +586,12 @@ static void pt_config_stop(struct perf_event *event)
 		return;
 
 	ctl &= ~RTIT_CTL_TRACEEN;
-	if (!READ_ONCE(pt->vmx_on))
+	/*
+	 * vmx_on is set before VMXON, so tracing may not have stopped yet.
+	 * RTIT_CTL can be written until VMXON, and after VMXON TraceEn is
+	 * clear, so still write RTIT_CTL if TraceEn is set.
+	 */
+	if (!READ_ONCE(pt->vmx_on) || pt_trace_enabled())
 		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
 
 	WRITE_ONCE(event->hw.aux_config, ctl);
-- 
2.53.0

