Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605257;
	b=4msMfLlLHQ424GDI+bt5rbLsmv7V52ywhV86T33PK5g7T2aISVdlpEKWpiwxOC8zoFTt
	 Ay5DgaezhO0L40INeR4P83mNR8tIKQpZ3QCkSH4R3QKVugpfHfAvRmA4/+XCC/yt2dN7O
	 kKCVSjPzKl8gfbGYgF02ZK+YO/Jwg22YWOLCx8PIW3b/dW6ta7peFKxT6GkUbJBPW/yIw
	 VnwYIPYtKgHtWxwlZMWA0ba84m/oFq8/ddU2v7UMaxxaufANsIUB/kSd90QLei/QgfGGV
	 mNH7Z/JwpY4nja0EbIXSDE6CD8DQppjCgn+3E7COO3cXagf2u4RQ2d2k8LsfppVoLFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605257;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Organization:
	 Content-Transfer-Encoding;
	bh=CPhb8czvE9Xdht7fm0n0ri1ZxL1wovm/GrL4+C+wKVA=;
	b=gx5R0R+ngWleN1Zu5CkSDgVE1esIjw2uvtZqCmlL3LJE+dbDipnysOfhHz62wb2gHjK0
	 4KMha/L0iOYYqTfF1pikFVt4GOvIiEloCmwgSh/Sw3LR3D7nimw//VeW2tZsE6r0q6WBO
	 9519a+7mQ0KlThLU5bxrnBPg/94HrFS6IQ4S1EKYHR/LJYNST/Zb+bqexLvrFKec149Qm
	 c5WjYAh5m86gfZADatLUqzBoLoCGQ0JZDMdYe2pLXhzhs4Adlz7OIqbOe7XeSvKqJODkT
	 SmJA/R2CX1lR5ElutuFPWNyx30MYQtNVlWIilZzoeg5wf+46444lKEcSyTzl/tHpMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aXqFrP0N;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A6606A326;
	Mon,  2 Nov 2026 07:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1A6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aXqFrP0N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605256; x=1825141256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YxKlnEZUTR2lBbVDdyn5I7/hmP6Old/LuQJQLG4uhGI=;
  b=aXqFrP0Ny2WExkMr+U7Vo9YoOrKLwXbnoLcdPaWhMcjTSXQGtnM29fA2
   zX/5N9OD192drdFT9xGqaguYZyofwQzr5998OgoPClP4cNswc27qWwv1p
   pCIEsnrTAZidtCDUhrR3zBSeGOUhC8TWjFN5RSOnTazLMMF8yix0vvdoM
   xkoIWVJuIG+yiTZEBizazH/KS//PiVqjQSZvjRPflJm38QctnPiNuOMc3
   aOfRVRMBR4K+GmxoObmVV5xs2MW8YBK5Q3vuRSd2fYQ7NaMC2HpYaCopI
   llAGthYA8WilLoAQ/I7BHClRBZbQ/yI7tjUpN72Asbaw9T8ZgskILeaCE
   Q==;
X-CSE-ConnectionGUID: zaMwsBwSTjGSNDVr+hFjrQ==
X-CSE-MsgGUID: eATUNmi4QIqMb+7PUM5mLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300054"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:40:54 -0800
X-CSE-ConnectionGUID: WRNMMPeXQQa6Ib0jPUhH1g==
X-CSE-MsgGUID: FbAbFZLaTz+f8kzfidTMJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6181954"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:40:47 -0800
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
Subject: [PATCH 0/6] perf/x86/intel/pt: Fix tracing across kexec, kdump and suspend
Date: Mon,  2 Nov 2026 09:40:33 +0200
Message-ID: <20261102074039.26983-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
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

Hi

Intel PT writes trace data directly to physical memory, so tracing must
be stopped whenever the trace buffers or the hardware state describing
them can no longer be relied on.  This series fixes several cases where
that does not currently happen:

  - tracing can survive kexec and kdump.  After kexec, Intel PT
    continues writing into buffers configured by the old kernel,
    corrupting memory that the new kernel may have reused

  - suspend-related state loss can leave the driver's cached PT MSR
    state out of sync with hardware, allowing tracing to restart with
    reset output registers and corrupt memory (typically beginning at
    page 0)

  - races can leave TraceEn set in hardware after perf believes tracing
    has stopped, preventing tracing from being reliably disabled and
    potentially causing subsequent PT MSR accesses to #GP

The fixes stop relying solely on perf's software state where it is not
authoritative: TraceEn is cleared directly in hardware during shutdown
and emergency-stop paths, tracing is prevented from restarting once
shutdown begins, cached PT MSR state is invalidated whenever hardware
state may have been lost, and active tracing is stopped and restarted
across suspend on the CPU that remains online.

The first patch is a general irq_work fix, not specific to Intel PT. It
re-raises a lost irq_work self-interrupt after resume, preventing
irq_work from remaining permanently pending if the interrupt state is
lost across suspend.  The final Intel PT suspend fix depends on it.

All patches are marked for stable.  The last patch also depends on commit
2e17bf3a469a ("perf/x86/intel/pt: Fix stop/start with no update") and
its two preparatory patches.

An alternative to the last patch would be for perf core to schedule out
all active events from a syscore suspend callback, and schedule them
back in from the syscore resume callback.  That would be a more general
change, but the last patch keeps the fix within the Intel PT driver.

AI disclosure: all issues addressed by this series were identified using
AI assistance, and AI was also used in development of the patches.
Problems described with reproducer examples in the individual changelogs
were reproduced and fixes validated.  The race fixed by
"perf/x86/intel/pt: Clear TraceEn in hardware in cpu_emergency_stop_pt()"
was identified by analysis and has not been reproduced.


Adrian Hunter (6):
      irq_work: Re-raise pending irq_work after system resume
      perf/x86/intel/pt: Stop tracing if VMXON has not yet happened
      perf/x86/intel/pt: Stop tracing at syscore shutdown
      perf/x86/intel/pt: Clear TraceEn in hardware in cpu_emergency_stop_pt()
      perf/x86/intel/pt: Reset stale MSR state on CPU start and resume
      perf/x86/intel/pt: Stop tracing across system suspend

 arch/x86/events/intel/core.c      |   9 ++
 arch/x86/events/intel/pt.c        | 170 ++++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h        |   6 +-
 arch/x86/events/perf_event.h      |   4 +
 arch/x86/include/asm/perf_event.h |   3 +
 arch/x86/power/cpu.c              |   3 +-
 drivers/base/syscore.c            |  10 +++
 include/linux/irq_work.h          |   2 +
 include/linux/perf_event.h        |   6 --
 kernel/irq_work.c                 |  12 +++
 10 files changed, 208 insertions(+), 17 deletions(-)

base-commit: f96ebf32b3135db4c9eeb868e4cb98e5dfe79ac0


Regards
Adrian
