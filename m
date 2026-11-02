Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614244;
	b=P9Wzsa49w4WhLmQPD44i1jI3hU4sWkA7B1iiRyfdCAETRc62MehURz44d5nNA8F50wbc
	 e+Q6AzlagLfLVUTVQUTdMUDB4EE3j9cneIJhh0c9aH7fTrLRmCXKwm2bTV4wm2gQ1DScw
	 Ui2be2Gye833Z6EKCO2a98U4augO4U1UE9dYbotUhtseGPpaloJKaJkeNV3QwPM+rVsQh
	 5fCfKKh0j0+2ixShJnXeLyleqnzLXwH/aSEZO5NT8OqQuDAusVaBPrxQjAIgEuAsRxAsT
	 6KIyhB5ZiwOPOo4lTC7WNa78P0qaaHmTo8iITGF92TnhTYTDwE/6oUlQERBDrlRCuZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oLmryoludorxUKAxAQ5hnB9frOZfqvyT8PUcSzQKcts=;
	b=X+Kl17qSoIKJan2lp9EDYObsxFvycJB+dgnO6NF0pYMwqnS5CZFfOIGGU+WdGTuJKn0F
	 SeKT0gXYR9St0zGChmJsXDbTfqMq4KR1z+1F4UBIpUqnMUJKCRzZDBNqtZc4ABeGbEh/z
	 n433siV5E9jBSdBBHZgL3qgL1FH635WgKawlse+DuntyEgG8QE7IUHQ3vbcmM/Kr5Vltw
	 JoGFgnvLlLIe352tHoyFnBuvq53brM5lPlykY6hbBSjDlaZyeBiypEQ2rJVkOr/sWCrNg
	 R4IvRjd8rMyR9m2Qg3ObeypRy90Ex4xKGvRHeNrq7UymmHZtYQ//77CZFJfsOPmNITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jnzjlinA;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F552606A326;
	Mon,  2 Nov 2026 10:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F552606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jnzjlinA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oLmryoludorxUKAxAQ5hnB9frOZfqvyT8PUcSzQKcts=; b=jnzjlinA2vMr/czlRhOwMaL5Bz
	x+d/XHpZu6OpAlySFI4M/tPJCJWNFHnnYuQ54JJg4Qe35TPHn0RueMsfjsc3Rgj3VWZ4oht52moHj
	SQCIZ5/zJJvCk9sxPHkjt1Y80fqw05G8n4JcBQJDVf1LPEsiAENF1+vNw66exzdrHnH5LA8HrXkoK
	F4BFuJfadHDq8BJ2ssQ9pOBL5wSQaZ2yr38FN/ZtXD9b2fx4el5fu6eHmhhVegfRH+gjLPNp1uQL7
	EUIBQlrMUivh2uKyY3VrJyR9D7080kd3oEihvYWmh2lCwPI/OHAoBPfmt88ECcGvl8MVYV9A1GOht
	hxuS9j7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNozr-00000001vzP-3CI9;
	Mon, 02 Nov 2026 10:10:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3476300322; Mon, 02 Nov 2026 11:10:34 +0100 (CET)
Date: Mon, 2 Nov 2026 11:10:34 +0100
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
Subject: Re: [PATCH 0/6] perf/x86/intel/pt: Fix tracing across kexec, kdump
 and suspend
Message-ID: <20261102101034.GV1779021@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102074039.26983-1-adrian.hunter@intel.com>

On Mon, Nov 02, 2026 at 09:40:33AM +0200, Adrian Hunter wrote:
> Hi
> 
> Intel PT writes trace data directly to physical memory, so tracing must
> be stopped whenever the trace buffers or the hardware state describing
> them can no longer be relied on.  This series fixes several cases where
> that does not currently happen:

Same is true for PEBS, no? I also saw that AMD/IBS is already
registering a syscore handler.

Perhaps it should be a perf wide thing, than than having individual bits
and pieces do their own thing?
