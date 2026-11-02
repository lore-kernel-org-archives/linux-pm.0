Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617331;
	b=D+X4/UQyzrxqR7MtmakZU8z5Qqwkt7ieEDQ8jvqo4UG+ZoRCQrhamT8fE9yteLZUMRFE
	 LKa23NsXk+j9gHl6DR0Xe1wqhydw2HzbkcOrZGfI0tV3iBzanScIr2S3F8z55rUO2K8Ck
	 aX/rlPMey+HFmhNZXv3ajL8PLwBYyDpOkBSGgF5/RfpcgRUiWgw5NY7EyLpgGN9trqZ2l
	 vhqwxRQCsJdltIBS9R29dPcoW09QQBLxPMSV83I+wSJy253qeYKzmE4wTi0EaEKQS1fVt
	 iIjYqvvr5AQglhqTqwSA2JIUU59ctZJEdZv6ezRHbpOjPG9YEqUzBCzWUSXmy/PbUaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617331;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4U44tyM9rIQqvE/aal0rqvdOLJnVYtfYiLLnwvN3EA4=;
	b=k9dRgKqXJ50yb0jmf/IMb4QiuQn1BUSW3dQsvYWov2uuOEeegbe2DjbIdPBlZvtlrGpC
	 bD5cuvz75Lc4+6Bn87Sgt46CMqn8JxcOrmjK/xKI/1feG2AbmDPF8ZFxcgqc8u3q5IDYV
	 TfM4BzW9o0S3od8tjMOtfqeYleEAV8rXFoTi9aa7KYigr9CuayyLOMwVACkRig6CAGoxb
	 s9XTAY6xN5c49WjyuRvuQthojydYUOMniNtNBf0U+n9uAGSwiNseW1/YfAHWdnwE4sPTi
	 47mzmjKVnlomq/ltDLkFxvHC+ck64DkWGixMkPSDf/ZrYi9y4AUk62yHzK76J13NOnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nbM1qdyL;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E661606A324;
	Mon,  2 Nov 2026 11:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E661606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=nbM1qdyL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4U44tyM9rIQqvE/aal0rqvdOLJnVYtfYiLLnwvN3EA4=; b=nbM1qdyLyua88iak+CnnYnpVBy
	A1BLNFiUQECLsqB1mBS05ytv3y/Hu3eNb6xt8YECvyZ1+/1GinHSbprhZsH/L5iLTFJVfhRzqoUM7
	RNHg53XBizU0Km6DuMJaaP5e03/BbLnaGaY5iwqFEeGab7MWJMfl3fW3Jq/3AOCLquw2OesEQKTma
	vu2+J/uV/G9OaJcBjCd3jCJ8lBR2SzYR++lxpmVBJQksabU08H4MLYSJ6x3uHu6A0n9jGcRi61miM
	IImDficcUenSX91Xc9UVX8k/HGPXW8wHeCf97lockJPE54fn/NFJG4d6Ryo+uY+0qa3TuiSS5xWJ+
	IqDtJ9qw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpnb-00000002PG9-3Imb;
	Mon, 02 Nov 2026 11:02:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93D073002ED; Mon, 02 Nov 2026 12:01:58 +0100 (CET)
Date: Mon, 2 Nov 2026 12:01:58 +0100
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
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
Message-ID: <20261102110158.GW1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com>
 <20261102100451.GT1779021@noisy.programming.kicks-ass.net>
 <8cd3d3f3-c866-4ed3-a41f-a4210e2d73c2@intel.com>
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
In-Reply-To: <8cd3d3f3-c866-4ed3-a41f-a4210e2d73c2@intel.com>

On Mon, Nov 02, 2026 at 12:23:57PM +0200, Adrian Hunter wrote:
> On 02/11/2026 12:04, Peter Zijlstra wrote:
> > On Mon, Nov 02, 2026 at 09:40:36AM +0200, Adrian Hunter wrote:
> >> +static void pt_shutdown_cpu(void *info)
> >> +{
> >> +	u64 ctl;
> >> +
> >> +	/*
> >> +	 * After VMXON on CPUs without PT support in VMX operation,
> >> +	 * TraceEn is already clear and RTIT_CTL must not be written.
> >> +	 */
> >> +	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
> >> +	if (ctl & RTIT_CTL_TRACEEN)
> >> +		wrmsrq(MSR_IA32_RTIT_CTL, ctl & ~RTIT_CTL_TRACEEN);
> >> +}
> > 
> > Why not unconditionally do: wrmsrq(MSR_IA32_RTIT_CTL, 0), at this point?
> 
> Writing 0 instead of ctl & ~RTIT_CTL_TRACEEN would be fine, but the
> condition is needed.  The comment tries to explain.
> 
> The first processor to support Intel PT (BDW) will #GP if a write is
> made to RTIT_CTL while VMX is on.  Since VMXON clears TRACEEN,
> if TRACEEN is set, then the write is safe.

I hate computers...
