Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605263;
	b=Je7jagys92fkng+hNeosZz2FiFEQDThoB4hASX6l/7lFyn2T26E9xtpMQDXFLOca+H9v
	 s1D0IuaA7R8NufmDlpm7FjaT6dAhUzdmP3g921CyU617hqRGjLcmI1JZ7LuHTRMm3pv/2
	 1oUNZBsoyZNu7PIo2mDN+5JbwZ9wQIri0DtKa+dYQw/RHViDBK2pGk29HTW2N0U8YLM0F
	 nQ2lfVlMkEv7L4xIREICjotHG+z0KEwSjnggE7Q5aED/f1E4eV4O6153BguMtd//CqorR
	 iHCm+I1MURb8pLGCBr0VkUd1Pyrs/59w3WSoSKcXQTBmpnMQddtN2bruWKmTgWZHQvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Organization:Content-Transfer-Encoding;
	bh=RH2Hnu2Dti7Q+9NWgAUZ00h2CN2wYvdC3cQQu5a/rL0=;
	b=GXUue+gLQspploKka+1erBAhLNZUtQXY2w+8dNlyH5pmBFvWPgSknVBA+EwUsPkwEA+n
	 ncY+F6ZGbvl/FfhI91RPgvEzjQUONJipR7lFuub2lkjoQKx3x9sgZt/QODILbkukdn/90
	 Z6Sp0fMuyYUbyZTKEwC0FmzDwhmaxvrq/6CyPWsg/8J7oAFNj5sBWJC4UqsdD8McHLNAm
	 3nHyJv/mN7Lr1+FCEBrF4uKdQBXFDXfkfIbZeZ6sNzHsO1V/Lcz3jBXilNOl0T3o9PJa9
	 J9DcLRqmK9C1JzcKT4nV/ELl0xGVh1gDIK9y/wOkXlTbx9Zd9sINsf9/3222PDBDcNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YyFmMJkE;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B4606A32F;
	Mon,  2 Nov 2026 07:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182B4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YyFmMJkE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605262; x=1825141262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VLW4mh7uPKNWjdbDLVnZfcxQmi3GS6EFtxsZW3S4z0o=;
  b=YyFmMJkEu9RuVXKMWLAKhbjRVepCfTLuFjDtsjVS4ryvGaRGCt1kV+aF
   NZYeqWV+uOg58P3zc4wKPu3t8OvXs0W+SHlYUEtW5evDyoCg63OA1kIIK
   f5ftbaB0j/A66XbYObxchZIi/Blm87CZx4n7R4eoCuFq1p3ycOESzblFd
   R4qG05FxlUI7QQ3XHqZYfrfulu7XysSLiQJgVUqatoOeZPbW9Rz8JeClJ
   NPmhlCPaIrFg/LLj5x4mebXCn5hLtSrYio7B8Jdmu6348F9I8axU2dA49
   fS3EDpj287HVARZJFL2Xrh4/yk/v6IR1rGqv3Jy48jJsgp6fi0NkNl9B8
   g==;
X-CSE-ConnectionGUID: Ju91IQszT3+wHbiXPGHimQ==
X-CSE-MsgGUID: uofL19KHTGO53fHNXNHL2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300085"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300085"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:01 -0800
X-CSE-ConnectionGUID: TvauPCT9SgK8LZuoeFMPeg==
X-CSE-MsgGUID: 0BAGtZxmT1i4ETFx8WYYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6182151"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:40:54 -0800
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
Subject: [PATCH 1/6] irq_work: Re-raise pending irq_work after system resume
Date: Mon,  2 Nov 2026 09:40:34 +0200
Message-ID: <20261102074039.26983-2-adrian.hunter@intel.com>
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

irq_work_queue() raises the irq_work self-interrupt only when adding
work to an empty raised_list.  Once raised_list is non-empty, further
queueing assumes the interrupt is already pending and will eventually
process the list.

That assumption can fail across system suspend.  irq_work queued after
arch_suspend_disable_irqs() and before the interrupt controller is
suspended, for example from NMI context, may leave its self-interrupt
pending in hardware.  If that pending interrupt state is lost during
suspend, hibernation restore, or kexec jump, raised_list remains
non-empty after resume but nothing will process it.

Subsequent irq_work added to raised_list will not raise another
interrupt because the list is already non-empty.  Architectures that use
an irq_work interrupt and do not process raised_list from the tick can
therefore leave irq_work pending indefinitely.  A caller waiting in
irq_work_sync() may then spin forever, for example when closing a perf
event whose pending irq_work never executes.

For suspend, hibernation, and kexec jump, only the CPU that remains
online is affected.  The other CPUs are taken offline beforehand, and
smpcfd_dying_cpu() runs irq_work_run() on each CPU before it is removed,
so checking the local raised_list is sufficient.

Add irq_work_resend(), which re-raises the irq_work self-interrupt when
raised_list is non-empty, and invoke it from syscore_resume() after
interrupt controllers have been restored.  Also invoke it from the
syscore_suspend() failure path, after the already-suspended callbacks
have been resumed, because callers do not call syscore_resume() in that
case.  This restores a lost irq_work interrupt on the CPU that remains
online for suspend-to-RAM, hibernation, and kexec jump.

If the original interrupt was not lost, the extra self-interrupt is
harmless.

Example S3 with perf record that always loses a self-IPI:

 # echo deep > /sys/power/mem_sleep
 # cat /sys/power/mem_sleep
 s2idle [deep]
 # perf record -e power:suspend_resume --no-buffering -C 0 -o /tmp/s3.data &
 [2] 2147
 # rtcwake -m mem -s 10
 rtcwake: wakeup from "mem" using /dev/rtc0
 # kill -INT %2
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.892 MB /tmp/s3.data ]

 Now perf record is stuck in irq_work_sync() which spins forever:

 # perf record -C 0 -- sleep 1 | perf report --stdio
 # Overhead  Command  Shared Object      Symbol
 # ........  .......  .................  ................................
 #
     99.98%  perf     [kernel.kallsyms]  [k] irq_work_sync
      0.02%  perf     [kernel.kallsyms]  [k] ktime_get_update_offsets_now

 Eventually resulting in hung tasks:

 INFO: task kworker/u8:1:35 blocked for more than 122 seconds.
       Not tainted 7.3.0 #2
 task:kworker/u8:1    state:D stack:0     pid:35    tgid:35    ppid:2      task_flags:0x4208060 flags:0x00080000
 Workqueue: events_unbound fsnotify_mark_destroy_workfn

Fixes: 76a33061b932 ("irq_work: Force raised irq work to run on irq work interrupt")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/base/syscore.c   | 10 ++++++++++
 include/linux/irq_work.h |  2 ++
 kernel/irq_work.c        | 12 ++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
index 483adb796654..3f645da46e77 100644
--- a/drivers/base/syscore.c
+++ b/drivers/base/syscore.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/syscore_ops.h>
+#include <linux/irq_work.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
@@ -81,6 +82,8 @@ int syscore_suspend(void)
 		if (syscore->ops->resume)
 			syscore->ops->resume(syscore->data);
 
+	irq_work_resend();
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(syscore_suspend);
@@ -106,6 +109,13 @@ void syscore_resume(void)
 				"Interrupts enabled after %pS\n",
 				syscore->ops->resume);
 		}
+
+	/*
+	 * A pending irq_work self-interrupt may have been lost while suspended.
+	 * Resend it now that interrupt controllers have been restored.
+	 */
+	irq_work_resend();
+
 	trace_suspend_resume(TPS("syscore_resume"), 0, false);
 }
 EXPORT_SYMBOL_GPL(syscore_resume);
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 7184e1273965..0040ea94a4fe 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -62,6 +62,7 @@ void irq_work_run(void);
 void irq_work_run_cpu(unsigned int cpu);
 bool irq_work_needs_cpu(void);
 void irq_work_single(void *arg);
+void irq_work_resend(void);
 
 void arch_irq_work_raise(void);
 
@@ -70,6 +71,7 @@ static inline bool irq_work_needs_cpu(void) { return false; }
 static inline void irq_work_run(void) { }
 static inline void irq_work_run_cpu(unsigned int cpu) { }
 static inline void irq_work_single(void *arg) { }
+static inline void irq_work_resend(void) { }
 #endif
 
 #endif /* _LINUX_IRQ_WORK_H */
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73eabcbdcd50..5d186ec35770 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -274,6 +274,18 @@ void irq_work_run_cpu(unsigned int cpu)
 	irq_work_run_list(per_cpu_ptr(&lazy_list, cpu));
 }
 
+/*
+ * Raise the self-interrupt again if irq_work is queued, because it may have
+ * been lost across system suspend.
+ */
+void irq_work_resend(void)
+{
+	lockdep_assert_preemption_disabled();
+
+	if (!llist_empty(this_cpu_ptr(&raised_list)))
+		arch_irq_work_raise();
+}
+
 void irq_work_tick(void)
 {
 	struct llist_head *raised = this_cpu_ptr(&raised_list);
-- 
2.53.0

