Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617689;
	b=ztnDZocout/BvHhJsIYtxKZbb6qcBk+imu6bQejBJjVU8czruO7bI92qkyQWonX5vsUI
	 hxQYUdzMP89vyVn30ej3U81VrLZB0mu/uJuEHi5cta1aLFQrbyMA3MCDicT/hLHJuAf8C
	 8FPh5PeHDbEQfJIDWuQCqIcL4/hAAzsdGha049udGNshSzopzSuHIfQ3vtdo+6qlrgwm8
	 Ruh+PEMbwcQdfJZBuxV7Zq+bvhSsdHLE8DvGm6GFY+cpi5aBLqnVOZt3Dcr6uxzJc+875
	 1QmAw0sMaLkCF9OGqcB29Ce42IdOPNklAEUj9aBHvfj6M1xEXqTGznjuDcIlsD8pn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617689;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7DXPCrJavnRLEwyl5yXDcP5FfFWrG3htAzB0Azwe5sQ=;
	b=VcgIG+ou6/xyCop2IjGIk2TFlVz97l0PiH7HwvUv8Zi/FWzlR6kPoMtE2++7dh/sQ6TK
	 cuKxpq9cVkiHwFrOyqQDzAW+T8Ubp9HNAVBa6HyrZ2p6+r7SzXokWg76zC2k7+vGQ01gY
	 H2a3bRW8yTFIV0HIqWde/lhLGQClQ9S82tm+/4yITDhCT5iMghwiiby5LIFw4rnQ+rMbp
	 HlMm82o6q+0L8LjwL03YdMyd6zenqx64jswjNA7DqNZpJW+orsnpv1tjsMGZGzUaIYvFZ
	 a4i5JbI8FqhNHlQksviISnkl2XYzhT4j+B+9xktTs9m/0ziSwvUUQ80rMzj62hY1z3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XHFP6Bui;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DE606A327;
	Mon,  2 Nov 2026 11:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3DE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XHFP6Bui
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7DXPCrJavnRLEwyl5yXDcP5FfFWrG3htAzB0Azwe5sQ=; b=XHFP6BuihMppwPmbS6bxBqCC1B
	WhNdRfMddfOhAMdCf3gNHaS1OWTnxL+wlJVkdui2I9DhnNcH/GMk1529nbKXYjI4vTGJpycJ1AZ1d
	5gjN/YKTCEH6lmQWBNMcwkZ9qWb4PqHB6Fw8oGFJYQTMKHANO4ey6OH8aYCmPKgV2oPmx8B3e3VnD
	ZnIYTb9GJGlmyw1x/wEbtPZTm7diMeFRhulXyHT14XBmtnJaTp+4H+aOp3uXYsa+fRRkG9fhSO5gL
	eqj7+ajvhK7HyH6XJsp4KzmPmSBsc6KlhE/sMODXPLooVrFFr0VL4d/haag7LKvLcj9McMP8WUty2
	SLUjFYMQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNptK-00000002PaO-0yIo;
	Mon, 02 Nov 2026 11:07:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DD014300322; Mon, 02 Nov 2026 12:07:52 +0100 (CET)
Date: Mon, 2 Nov 2026 12:07:52 +0100
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
Message-ID: <20261102110752.GX1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-3-adrian.hunter@intel.com>
 <20261102095750.GS1779021@noisy.programming.kicks-ass.net>
 <ca44daab-662e-41bf-b050-3ff4a94c7948@intel.com>
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
In-Reply-To: <ca44daab-662e-41bf-b050-3ff4a94c7948@intel.com>

On Mon, Nov 02, 2026 at 01:04:59PM +0200, Adrian Hunter wrote:

> > It seems rather unfortunate to issue a RDMSR for state we fully control.
> > Surely we can track this?
> 
> The RDMSR only happens on BDW and only when VMX is on and someone still
> tries to use Intel PT (even though no trace can be produced on BDW
> while VMX is on).
> 
> There is a window between setting vmx_on and clearing TRACEEN.  Dealing
> with that would be complicated, compared with reading the MSR.

So I thought we'd manually clear the thing before VMXON, but you're
saying VMXON itself will clobber that register? I stand by my previous
statement ;-)
