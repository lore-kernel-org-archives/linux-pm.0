Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613494;
	b=j45Segmysx40BzSs9SL4SjXdSrWVBFyEQjpqot0u+TMgiaZ99GKqGwdZfOmXLNh4VaTN
	 oDAzzKwmlUZqymv7TVl7ctc5S/QuskQ/5g3Z3PYrm74J/jzGNfCoNXX6YTK95Sl9eJt1J
	 EQEhKm7V424TZodFii7N4HH2+6GWCE9hv4DU0ycYFQ4xIedzYmFunImoTTmHRYzCxamAW
	 WJJ7G4Cpl1iygNAIIHiDZ+VeVjn61W78uazA4gRTrR/T1FHwFuuuRDJMFA9AMJU31YCgq
	 90Q1UXlLOy3Sdkfon1nL9Z/grOJh4cnsUq8eBkU/bfXNOOo6RqZHsPtebSmY7+sBfIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613494;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UKyyZUOWJVkvc/oMwUTT4h7l57WEWjnuZvJf4U3Jj9g=;
	b=ty5FTiWbVMq2ePvaftV7+m3ZeELX9hiwR9wv9+IMzY4yt1rmGYk8g2NGDryRKoLYY3NE
	 /80Ukojr9yLkyJ1AYBhSJZP1dLmePfDEkAxDIn3wb3qurJOJO377RPvaGPKkxsgcVM47v
	 SgGIlf8fXgF0OyjY48PoxEl37klchGAcqa8yTMkw9YBdNfH+ifMPol/sx+lNV7blpBVcT
	 DjERwBvLss1JlIVF9iFHCU1Tg1HP53PhfGiBsk/KTSdFNMQuexIrvimDfZ/2B7CoFOzkd
	 52Ov6+hv7MPUwvydr7nCTW0m5bK4f/BKOaNFdO8Ac9n6ycOMedM8OYUrINroJuXyAkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=peNr0I8O;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA5606A324;
	Mon,  2 Nov 2026 09:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56EA5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=peNr0I8O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKyyZUOWJVkvc/oMwUTT4h7l57WEWjnuZvJf4U3Jj9g=; b=peNr0I8O1r4HRfm9ZOZYdjyxS4
	kprbs4zQBBtMnV5UOs/rSx/Wf28Gy9e1a13tZYH7TQDGU0+AGNUuwR7eKWcANgd6oFP8D/LzX0wki
	R8PtZiErjBfLYtZIPg+5hhKViG+0ZZkCZlhNHSzN5SEvvDjABn+f2gDtYJVq92eJ3wQ067hWCW74B
	U0BuGZcbzDQs1Gndbbm7rteMSWL2kf+x0tl6uv5nMUjQXv8fRDIwZnKj5qeBzZWYmG+EolOYpkT3c
	am9ifVWrfO+7kwnwGUYiMhZ0nrs/e7rXFX8UTuQ5HfqNzIApdBKH56YZMrDQjDnuSz+avyk9mIs5d
	v3sUJUIQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNonZ-00000002L6h-3hQt;
	Mon, 02 Nov 2026 09:57:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00239300312; Mon, 02 Nov 2026 10:57:50 +0100 (CET)
Date: Mon, 2 Nov 2026 10:57:50 +0100
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
Subject: Re: [PATCH 2/6] perf/x86/intel/pt: Stop tracing if VMXON has not yet
 happened
Message-ID: <20261102095750.GS1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-3-adrian.hunter@intel.com>
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
In-Reply-To: <20261102074039.26983-3-adrian.hunter@intel.com>

On Mon, Nov 02, 2026 at 09:40:35AM +0200, Adrian Hunter wrote:

>  arch/x86/events/intel/pt.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 49349afee611..36bf039668d7 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -567,6 +567,15 @@ static void pt_config(struct perf_event *event)
>  	pt_config_enable(event);
>  }
>  
> +static bool pt_trace_enabled(void)
> +{
> +	u64 ctl;
> +
> +	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
> +
> +	return ctl & RTIT_CTL_TRACEEN;
> +}
> +
>  static void pt_config_stop(struct perf_event *event)
>  {
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
> @@ -577,7 +586,12 @@ static void pt_config_stop(struct perf_event *event)
>  		return;
>  
>  	ctl &= ~RTIT_CTL_TRACEEN;
> -	if (!READ_ONCE(pt->vmx_on))
> +	/*
> +	 * vmx_on is set before VMXON, so tracing may not have stopped yet.
> +	 * RTIT_CTL can be written until VMXON, and after VMXON TraceEn is
> +	 * clear, so still write RTIT_CTL if TraceEn is set.
> +	 */
> +	if (!READ_ONCE(pt->vmx_on) || pt_trace_enabled())
>  		wrmsrq(MSR_IA32_RTIT_CTL, ctl);
>  
>  	WRITE_ONCE(event->hw.aux_config, ctl);

It seems rather unfortunate to issue a RDMSR for state we fully control.
Surely we can track this?
