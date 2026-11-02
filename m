Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605298;
	b=lxDYiKl6/u1F2HUqY3t/qisrOp6TaW7vh7vL//lU729ClcATOlNEF5GZRvIbRVNDhZqX
	 sKgzpNaMPrJmIIAqjqYCMY83M5yduoiXFnlWQy1sQTOcAhJ5wlvNd0TYao7L8ZTvM2v5u
	 xwDBwqOxff+QN5WBm5fZmzWRb93udi8T94Ugn5lyQ7HtKkwE1PJlniqdmZYh46o+PEbgG
	 wcp3FpGXjxEMvhWsZ6omKhrwMjmQajn9bsgWela1hF58PCu9fRxGR/n5vxqxr1A5h9omZ
	 7amaH807QIiC8E59QuraJ1fvRJTVVkprA7Cs5gpxRXTLGqeIOnIa8MWRR15OPlKucZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605298;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Organization:Content-Transfer-Encoding;
	bh=+oZ1lR8ai99DubT220UT7e3b62UgZS6S7+f0O1weT4o=;
	b=Dp0Ewb8yj7A2aGUWk/mqHD9OjvsxbWEfjqeE/solIyfHbfyTHPchoTuoFOq49pfxVi0o
	 3v9YTxKJib6GrDTstQ95F2Oxv8ey8co7f+akvn5xoHhLqcQpBVUjTIWRJCAE6pW4kgTvK
	 uCNxihVMCx2JmEeY8/WzIYFZK/TidLkD+ONC4hp/Zll+ymSLbOD6Q1if3ebDsFu8rXNSh
	 rda7LCnkLq6xTcbs16W95fL/33iaHeehyln1nhD5eZRMTkRzgGz32ds0CjDjplQBKz7MT
	 bauOa4JqmvJk+wB07sXQXzrAGsFIYTK8YRbXBrnXMn2lm8W3qM14pfVEoXVdyNKfvhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItylkfbW;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06A606A32F;
	Mon,  2 Nov 2026 07:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C06A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItylkfbW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793605297; x=1825141297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bad/Faw2+hvP14KuKCFKS+k2Z9pGOeEVApANpFF9YhY=;
  b=ItylkfbWzi7WoReF+BFnz7lAXLUD41tXKZnKLp6JkcbVlyW1/+nJ70g+
   D8WFcotrb/eegqCDU3h+dKZROR+4okw5+xFpTxefusMyQOUDVzCo97Wj/
   Xq8iayaFu+0b1MgdwpryKGOjAy05gJtI38Eym03n7KOLiUem0nKb2JuTb
   RYNyjNeuua6aArNdgy0PwUezNNEfLUU0k/IqmZxYyA11hKlmeI8XP272g
   /NSINxXMIVtxo7jSxWU+rk9oBFlx+lQ95oJQQ+ogn4mOJ/SAYEqbnhvFe
   Z5JaNiOGC+0JKobQLqhaKjPMMbawDdKOKOsdntQ9Fv5wqd5TFqW6/PDFu
   A==;
X-CSE-ConnectionGUID: 58k9ol4MTfChyjFxFs+Gkw==
X-CSE-MsgGUID: UqNgK/D6TKaZ1/u9ZGygwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300221"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300221"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:36 -0800
X-CSE-ConnectionGUID: S/TocA1jQPGUeMPN6tCknQ==
X-CSE-MsgGUID: VZjYApVdS2Smbr/6hOQLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6182280"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:41:29 -0800
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
Subject: [PATCH 6/6] perf/x86/intel/pt: Stop tracing across system suspend
Date: Mon,  2 Nov 2026 09:40:39 +0200
Message-ID: <20261102074039.26983-7-adrian.hunter@intel.com>
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

During S3, hibernation and kexec jump, all CPUs except one are taken
offline, stopping their Intel PT events.  The CPU that remains online
retains an active event, but its Intel PT state is lost when power is
removed.

After resume, perf still believes the event is running even though the
PT MSRs have returned to their reset values.  Paths that set TraceEn
without fully reprogramming Intel PT can therefore resume tracing with
invalid OUTPUT_BASE/OUTPUT_MASK state.  In ToPA mode, stopping such an
event reads back OUTPUT_BASE = 0 and derives an invalid AUX head from
it.

Stop the remaining Intel PT event in a syscore suspend callback and
restart it from a syscore resume callback.  By resume time,
perf_restore_processor_state() has invalidated the cached PT MSR values,
so the restart path reprograms them.

Normal mode already updates the AUX head when the event is stopped and
starts a new AUX transaction on restart.  Snapshot mode requires
additional handling because a stop without PERF_EF_UPDATE leaves the AUX
transaction open and a subsequent restart would normally only re-enable
TraceEn.  Save the output offsets during suspend and force the full
configuration path on resume so that the output MSRs are restored from
the saved state.  Until resume has reprogrammed the output MSRs, use the
saved offsets so that an NMI (for example an AUX sample) cannot consume
reset PT MSR values.

Stopping the event can queue irq_work when ending the AUX transaction,
for example a wakeup or a deferred disable when the buffer becomes full.
The irq_work self-interrupt may be lost across suspend, but
irq_work_resend() re-raises it during syscore_resume().  The irq_work
then executes normally once interrupts are enabled.

A deferred disable queued during suspend is therefore processed after
the event has been restarted, as it would be without suspend.

Restart tracing only if the event remains in PERF_EVENT_STATE_ACTIVE.
Nothing currently changes the event state between the syscore callbacks,
but this avoids restarting the event if perf core were ever to schedule
it out in the meantime.

This also prevents the CPU that remains online during kexec jump from
continuing to trace into the other kernel image.

s2idle does not lose Intel PT state and does not invoke syscore
callbacks.

Example showing page 0 corruption with S3:

 After S3, Intel PT driver samples the trace data (snapshot mode)
 by stopping, copying, and restarting the trace without amending
 the configuration - but IA32_RTIT_OUTPUT_BASE is 0.

 # cat /sys/power/mem_sleep
 s2idle [deep]
 # dd if=/dev/mem bs=4096 count=1 | od -t x1 -A x
 000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 001000
 # perf record -C 0 --aux-sample -c100000 -e '{intel_pt//,cycles}' -- rtcwake -m mem -s 10
 rtcwake: wakeup from "mem" using /dev/rtc0 at Mon Oct 26 19:17:35 2026
 [ perf record: Woken up 6 times to write data ]
 [ perf record: Captured and wrote 2.781 MB perf.data ]
 # dd if=/dev/mem bs=4096 count=2 | od -t x1 -A x
 000000 bc 9c 1e 59 1e 22 59 1f 08 59 20 06 4d 20 c4 97
 000010 96 06 4d b0 9f 56 96 59 21 18 5d 8b c3 5f 96 01
 000020 53 8a 77 73 59 11 6d 80 00 20 96 ff ff 02 43 00
 000030 30 88 00 00 00 e0 90 80 04 59 12 e0 8c 59 13 de
 ...

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # c6df51779618: perf/x86/intel/pt: Factor out pt_config_enable()
Cc: stable@vger.kernel.org # 265bb4ef75fa: perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
Cc: stable@vger.kernel.org # 2e17bf3a469a: perf/x86/intel/pt: Fix stop/start with no update
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/pt.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 272808f2b483..1d304ba6d9c6 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -40,6 +40,8 @@ static bool pt_shutdown;
 
 static bool pt_initialized __ro_after_init;
 
+static struct perf_event *pt_suspended_event;
+
 /*
  * Capabilities of Intel PT hardware, such as number of address bits or
  * supported output schemes, are cached and exported to userspace as "caps"
@@ -1012,6 +1014,10 @@ static void pt_read_offset(struct pt_buffer *buf)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	struct topa_page *tp;
 
+	/* MSRs may be reset across suspend, so use saved offsets */
+	if (READ_ONCE(pt_suspended_event))
+		return;
+
 	if (!buf->single) {
 		rdmsrq(MSR_IA32_RTIT_OUTPUT_BASE, pt->output_base);
 		tp = phys_to_virt(pt->output_base);
@@ -1659,6 +1665,11 @@ static void pt_event_start(struct perf_event *event, int mode)
 	 */
 	if (!(hwc->state & PERF_HES_UPTODATE)) {
 		hwc->state &= ~PERF_HES_STOPPED;
+		/* After suspend, need to fully re-configure */
+		if (READ_ONCE(pt_suspended_event)) {
+			buf = perf_get_aux(&pt->handle);
+			goto fully_configure;
+		}
 		pt_config_enable(event);
 		return;
 	}
@@ -1675,7 +1686,11 @@ static void pt_event_start(struct perf_event *event, int mode)
 
 	hwc->state &= ~(PERF_HES_STOPPED | PERF_HES_UPTODATE);
 
+fully_configure:
 	pt_config_buffer(buf);
+	/* Output MSRs are valid again, so pt_read_offset() may read them */
+	if (unlikely(READ_ONCE(pt_suspended_event)))
+		WRITE_ONCE(pt_suspended_event, NULL);
 	pt_config(event);
 
 	return;
@@ -1866,6 +1881,49 @@ static int pt_event_init(struct perf_event *event)
 	return 0;
 }
 
+/*
+ * The CPU that stays online during system suspend may lose its PT state, so
+ * stop its event beforehand and start it again afterwards. The other CPUs
+ * were taken offline, which stopped their events.
+ */
+static int pt_syscore_suspend(void *data)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	struct perf_event *event = pt->handle.event;
+	struct pt_buffer *buf;
+
+	if (!event)
+		return 0;
+
+	pt_event_stop(event, 0);
+
+	/*
+	 * Save the output offsets while the MSRs are still valid, for
+	 * pt_event_snapshot_aux() and for reprogramming them on resume.
+	 */
+	buf = perf_get_aux(&pt->handle);
+	if (buf && buf->snapshot)
+		pt_read_offset(buf);
+
+	WRITE_ONCE(pt_suspended_event, event);
+
+	return 0;
+}
+
+static void pt_syscore_resume(void *data)
+{
+	struct perf_event *event = pt_suspended_event;
+
+	if (!event)
+		return;
+
+	/* Guard against perf core having scheduled the event out meanwhile */
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		pt_event_start(event, 0);
+
+	WRITE_ONCE(pt_suspended_event, NULL);
+}
+
 static void pt_shutdown_cpu(void *info)
 {
 	u64 ctl;
@@ -1891,6 +1949,8 @@ static void pt_syscore_shutdown(void *data)
 }
 
 static const struct syscore_ops pt_syscore_ops = {
+	.suspend	= pm_sleep_ptr(pt_syscore_suspend),
+	.resume		= pm_sleep_ptr(pt_syscore_resume),
 	.shutdown	= pt_syscore_shutdown,
 };
 
-- 
2.53.0

