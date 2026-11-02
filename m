Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610376;
	b=G13hraZ6kmI1mhg6g5sl80rffVjcEzWf7LE+iIRJv4Vp1nB6YhXAEqGAbqHtjabILkXg
	 bxcdjnrUDwh6axw66XgoXZYMya6uJfx+4q+6yOpYKAgrcDraQ7thy0mtQEwBRoj/YSeCO
	 rW5Mw75QqAb92q6enM6ND42ml7btGGZDDPNhOsMCt0y7T1oGAbddfHc6Ay4EhyKLRJMdb
	 jtDt744M6cNXJ79nI28zJE2yFMDdcTOhAZJLbG0Nd6I+DEcKiAHhUBr0qwqVyxzH2rVn9
	 L4wNBFrN1Xx2ovC5yWGQ9eykhlVoe2pNLeyN1B3c3fVj+D0Cxg8I3VhukBmFOR7GSTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610376;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=77Xvm1RZi1fMUkErP5AZnNQjl3KUFV3T8alLBOD3IkA=;
	b=l+fnSlqKdn2T2yv9G/oAtfTCPHO12ToI+uRE7i6OWobPiPiAlGjV/oqtM8sRWPLcmeb9
	 dFrvsfJC1vqKHOXKyRyh5CBe08ziciB6+jQwy5Z31YYiATYjwrOnXFb+t3f0my7rK9Tak
	 JhZD8mEFXkYx43lgxXgZ6kx85PN9Qwpn0xdYPkC99Bst1ZRs6ljdJ5ynUSemtylSI8aAM
	 0FqshbZdaVlZiGH419xx4qNDLWJUNfXQgaZuh7WFQjVcCtjg4Ns1JSFdRxh0HipK+lDhW
	 wQKnQTJuq76M24J3IkNESKZHq/HM1u1DozN45E0GyXGClxYF9x/0Qm5Jh0QDXasJ+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SuhR9+vn;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C05606A324;
	Mon,  2 Nov 2026 09:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65C05606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SuhR9+vn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=77Xvm1RZi1fMUkErP5AZnNQjl3KUFV3T8alLBOD3IkA=; b=SuhR9+vnaTOUcvs25RDk/YBx7U
	DD+eBRPNPIrYJxMnypkeuCgCUYcC3KH8Pve/4VJOBP7UEilytwKIBC6Nujr/VxuGLPF3U/HGB2SG5
	GMcYRXk5ztdK6oiyVtaCYe2O9FUa/T7fSvhyuezjnUgdEAuV9Yrzp/G80DG1vLf4/UNhEUmndwfcd
	/gc/facHFTAvWiOM6HwTYv5YG7x+xpML4zM0IZczXrLu6kp4DZuoBaur/8DHmdo5p65xLI5+LuDFk
	aR4a4e+TTXtR/T95Wy9RSDvPEWlYX414XnRoVKvp05FP06O95dJpovAtM2uIQx31xv1JH0H+HYgxt
	oM9NpRbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNnzR-00000001eC4-0uDX;
	Mon, 02 Nov 2026 09:06:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3DA4300312; Mon, 02 Nov 2026 10:06:04 +0100 (CET)
Date: Mon, 2 Nov 2026 10:06:04 +0100
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
Subject: Re: [PATCH 1/6] irq_work: Re-raise pending irq_work after system
 resume
Message-ID: <20261102090604.GR1779021@noisy.programming.kicks-ass.net>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-2-adrian.hunter@intel.com>
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
In-Reply-To: <20261102074039.26983-2-adrian.hunter@intel.com>

On Mon, Nov 02, 2026 at 09:40:34AM +0200, Adrian Hunter wrote:
> irq_work_queue() raises the irq_work self-interrupt only when adding
> work to an empty raised_list.  Once raised_list is non-empty, further
> queueing assumes the interrupt is already pending and will eventually
> process the list.
> 
> That assumption can fail across system suspend.  irq_work queued after
> arch_suspend_disable_irqs() and before the interrupt controller is
> suspended, for example from NMI context, may leave its self-interrupt
> pending in hardware.  If that pending interrupt state is lost during
> suspend, hibernation restore, or kexec jump, raised_list remains
> non-empty after resume but nothing will process it.
> 
> Subsequent irq_work added to raised_list will not raise another
> interrupt because the list is already non-empty.  Architectures that use
> an irq_work interrupt and do not process raised_list from the tick can
> therefore leave irq_work pending indefinitely.  A caller waiting in
> irq_work_sync() may then spin forever, for example when closing a perf
> event whose pending irq_work never executes.
> 
> For suspend, hibernation, and kexec jump, only the CPU that remains
> online is affected.  The other CPUs are taken offline beforehand, and
> smpcfd_dying_cpu() runs irq_work_run() on each CPU before it is removed,
> so checking the local raised_list is sufficient.

I thought here was a suspend2idle option where all the CPUs remain
online?

Anyway, I'm torn; I would much rather make this trigger a WARN and have
suspend pause/resume perf in a more controlled manner. Also, ISTR there
being hooks in kexec, but I can't seem to find them :/


