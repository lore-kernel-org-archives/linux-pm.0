Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614091;
	b=D0Rniv4Oo6UiK9j5RaoYuFFvGkTP4MCRMlq5MJUjlYDgr3XR22bk2bGWTbSAj7jJ7IyP
	 X52Wghr/g8+5iTBMfm5lPSxEHvxvsZ7e4i1QioM3AOIKm3JVDUfqxPnrsdR7UPI5/S11u
	 qrJS4G2b5z+zcq4+L2YFIi9W5ikZgtrUaGzeWQ2e5MrFP6MZqaQXeLIxX9nkuj0PD8pOq
	 UkPypGEgQ/xYp9kXjmcrFkxdtPQyFrUdfWWhLzaJJfZLuCOr68gABkCPFRRsI4gBbhqJn
	 y7OWqIBAZG4yGwTh765I8ITOO7clCpJPw6Vm8gocniWG4ctG+3yjMDBqNtzS/Pw9SMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614091;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2YB7xrA0JT0IFETP3BjX0Ypy94aXSCDzJ2+kb+881MA=;
	b=VhI83An0GAYdGlUoVGidT3TnrWe5FghMrnQ4w5eNzrvcDa/rcvUAog/PO6mwFfuws9GE
	 HNv8fCdrV+b9wxhfOaSVsUtp1mKLeli8bCjUmBXFrVtA+Do9Gl4o7vmrZCttNpZF2og2y
	 ihiE9k6WIfQ3uCh3weqBqGc/6MPH5ntLwBCxb8Ay/78ybuuQ22q7Oe/eTQpI5X1ei0dK5
	 tf6NsXljunUKMgufGiMoIRyT94JRFTXalWgg4iWIxuuYitn8017hDCGoznijRPfYudsSE
	 JRWnLGsvGli/FoaFtxW2rRCI3O2TJQ/+TOB2l6Bo4nDt6f/Ez9S1hVOlVRllLytShQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OeXhwYeb;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC8606A329;
	Mon,  2 Nov 2026 10:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFC8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OeXhwYeb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2YB7xrA0JT0IFETP3BjX0Ypy94aXSCDzJ2+kb+881MA=; b=OeXhwYebvQGFMpo78KVF8COSNC
	s4ZkGjVtr8ODxaygIo0W+sgGZFVw1z4p1IJkqwFTB3ul+tHO445HGeIEzP8hdQyduX0TaGkn3wMyD
	fvo/WblPxF7eLX+6V6jpOKzG//ovQbZLn5GFZRnRYq9AJwbNLmolOMlCAzTHzh6uN9IaVK/CsJ/PO
	DR9/W+/hZr3D5E6z8Z7YDrxtJ3YVUsQaYHQJ1CNu0ZA1U2SPkGUj+zvr/ZPTCtJpynseWjG3sTvYv
	Ttek4tSct5LFBidErl1NjNz+jIKKhT7ebNdtDo2E2iBv92RY1D5u+RuHdLMTcS/lDTrdaW/pQ/akQ
	4fHI79tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNoxD-00000002Lrl-1a4P;
	Mon, 02 Nov 2026 10:07:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1258E300312; Mon, 02 Nov 2026 11:07:50 +0100 (CET)
Date: Mon, 2 Nov 2026 11:07:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH 4/6] perf/x86/intel/pt: Clear TraceEn in hardware in
 cpu_emergency_stop_pt()
Message-ID: <20261102100750.GU1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-5-adrian.hunter@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102074039.26983-5-adrian.hunter@intel.com>

On Mon, Nov 02, 2026 at 09:40:37AM +0200, Adrian Hunter wrote:
> cpu_emergency_stop_pt() stops tracing through pt_event_stop(), which
> assumes the software state accurately reflects whether tracing is
> enabled.  That assumption can fail when a crash NMI interrupts
> pt_config_start().
> 
> pt_config_start() sets TraceEn in IA32_RTIT_CTL before updating
> event->hw.aux_config.  If a crash NMI arrives in that window,
> pt_config_stop() sees TraceEn clear in aux_config and skips the MSR
> write needed to disable tracing.  Tracing remains active in hardware.
> 
> Alternatively, an earlier NMI in the same window can stop the event
> without restarting it, for example a group throttle calling
> pt_event_stop(event, 0), or a PT PMI for which perf_aux_output_begin()
> fails.  pt_config_stop() again skips the write, so the event is stopped
> only in software: TraceEn remains set in IA32_RTIT_CTL, and
> pt->handle.event becomes NULL.  When pt_config_start() continues, it
> sets TraceEn in aux_config, so tracing continues until the event is
> next stopped.  If a crash occurs before then, cpu_emergency_stop_pt()
> sees no event and does nothing.
> 
> In both cases tracing can remain active into the kdump kernel.  Moreover,
> pt_event_stop() may access PT MSRs while tracing is still enabled and
> can trigger a #GP by writing IA32_RTIT_STATUS with TraceEn set.
> 
> Fix this by making cpu_emergency_stop_pt() disable tracing directly from
> the hardware state.  Set pt_shutdown and invoke pt_shutdown_cpu(), which
> reads IA32_RTIT_CTL and clears TraceEn whenever it is set, independent
> of perf's software state.  The shutdown flag prevents any path from
> re-enabling tracing afterwards, including intel_pt_handle_vmx(0) during
> the emergency VMXOFF sequence on other CPUs.
> 
> Continue to call pt_event_stop() afterwards so that AUX state, including
> the buffer head, is updated for vmcore collection.  Its PT MSR accesses
> now occur with tracing disabled.
> 
> Do this only if the driver initialized successfully.  In particular, if
> pt_init() finds tracing already enabled at boot, it leaves Intel PT
> alone, and the emergency path must do the same.
> 
> The race is reachable only through restart paths that call
> pt_config_start() with TraceEn clear in the software copy.  These were
> introduced by the commits with the Fixes tags below.  The restart path
> in the PT PMI handler runs in NMI context, so only a machine check can
> interrupt it.
> 
> Fixes: 8e105a1fc2a0 ("perf/x86/intel/pt: Factor out pt_config_start()")
> Fixes: 25e8920b301c ("perf/x86/intel/pt: Add sampling support")
> Fixes: 08c7454ceb94 ("perf/x86/intel/pt: Add support for pause / resume")
> Fixes: 2e17bf3a469a ("perf/x86/intel/pt: Fix stop/start with no update")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/pt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 7453e9880b25..8d71c00f9ff6 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -38,6 +38,8 @@ static struct pt_pmu pt_pmu;
>  /* Set at shutdown, after which TraceEn must not be set */
>  static bool pt_shutdown;
>  
> +static bool pt_initialized __ro_after_init;
> +
>  /*
>   * Capabilities of Intel PT hardware, such as number of address bits or
>   * supported output schemes, are cached and exported to userspace as "caps"
> @@ -1900,6 +1902,12 @@ void cpu_emergency_stop_pt(void)
>  {
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>  
> +	if (!pt_initialized)
> +		return;
> +
> +	WRITE_ONCE(pt_shutdown, true);
> +	pt_shutdown_cpu(NULL);
> +
>  	if (pt->handle.event)
>  		pt_event_stop(pt->handle.event, PERF_EF_UPDATE);

So in general pmu::stop() is reachable from PTI/NMI context, through
things like throttling. So arguably it not functioning correctly when
interleaving with pmu::start() is a problem.


