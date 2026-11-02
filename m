Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613908;
	b=G7kHvt6uzsrkhGVA9fAW/aXVTT26Ubsk7RKtVNF23h8q4IXOeU60+YcaurHnOgQq0TRU
	 j6VFBvOxC/VRl7QA6kEbvrp9t/qSwxt1ZyRaXCdTeruRJ7c65iuOHkaZbsnEsQBbImcpT
	 HWvnkXfZsAhU5pw8yIa4JxnRQwLiwbhPZl8uU65yhStGcfBY1enOccImW38gOJheOwjON
	 WghreA4bon+f7usZAUphTChjngVoXQfYKrkwfAOix31CVawQsIhV40WqVqBxUTyrTTjPi
	 FaX4lCBM586f+2AiHmCE0XMtLDGwnoDSN9GlmVvnPRnvpdrOSnVaZQj3y7OBTbCrHvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613908;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RKZ7s2ip4Cd4cJJpbOr8bHm3t7js9mX3q0DKftip8Gc=;
	b=Tsq4kWiRC59DuQMFFfHdwN1sVmjUSJhJsgoLSr6zA9ijczRB4Czkwo0Hd9TbvknCK3dL
	 R9eQL1ESJ7sjUqnaZAh3PyGV/oLFUSFLKQaAPzupGLG3/6ZV3ju92a2Zbd/y5ZDsZOG1b
	 UvqkrBiZ8EPV8mulShyBEakcPSXIgYjFeasuEWUihZ/kdBGiz8NL4jW+J229t6QVAf5go
	 tzz9BsRO8DRbCpoXmiUuZt0vEuifwZHlSMbaveVdSDI0+KIdYY/L9bnKBbU5SQfIHGK4M
	 rWhmGy5aHm7Prap4rWdO6RF0RMicRn4s0LJQcbaHEmoMiZVg2ya9veMeIS6hvc+FX9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=A26p5ROr;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69162606A324;
	Mon,  2 Nov 2026 10:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69162606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=A26p5ROr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RKZ7s2ip4Cd4cJJpbOr8bHm3t7js9mX3q0DKftip8Gc=; b=A26p5ROrXJIXoqZd9ovicq2gE8
	4IhvTmKlHAtSE4b6fsenDnadTTffD7OyQnANMwqco3T8XOYWlN8vcRXmaEL9ojBdy5Y29/V3ZrRyS
	7vX93FJJpkT+nxgnRNCeZ/XkLoxFCzdyD1/dyKy5kQTvrzwSR6UZyPpeXsGmmwWZhMoeH/4OAWHVV
	dkB+H3kIdvWackyW/8CjQfTkawUXpOnMAfd+Myyw/aUVtUfcFqy6v3REIdSDS8awnrOdmxHL5ASl2
	Yjbss90p7sZk33mEOTWHEwHPpvVJ0CnPYUhTKFbbFeBfrR1TaRgG3ZEBkdSlXF25uA+4fREG+w1BX
	PPiIgM/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNouK-00000002Lhl-1sTa;
	Mon, 02 Nov 2026 10:04:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A3B6300322; Mon, 02 Nov 2026 11:04:51 +0100 (CET)
Date: Mon, 2 Nov 2026 11:04:51 +0100
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
Message-ID: <20261102100451.GT1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com>
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
In-Reply-To: <20261102074039.26983-4-adrian.hunter@intel.com>

On Mon, Nov 02, 2026 at 09:40:36AM +0200, Adrian Hunter wrote:
> +static void pt_shutdown_cpu(void *info)
> +{
> +	u64 ctl;
> +
> +	/*
> +	 * After VMXON on CPUs without PT support in VMX operation,
> +	 * TraceEn is already clear and RTIT_CTL must not be written.
> +	 */
> +	rdmsrq(MSR_IA32_RTIT_CTL, ctl);
> +	if (ctl & RTIT_CTL_TRACEEN)
> +		wrmsrq(MSR_IA32_RTIT_CTL, ctl & ~RTIT_CTL_TRACEEN);
> +}

Why not unconditionally do: wrmsrq(MSR_IA32_RTIT_CTL, 0), at this point?
