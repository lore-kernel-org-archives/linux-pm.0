Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E03CCFAB;
	Thu, 19 Mar 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926584; cv=none; b=bL7uR+HB93UykIR4gf71x1btx7zIBM8Dt+d5dTSsipjpZiJVNjxV/QaLgTLp2WER9yInpU0ye6R40LMjTl1VrZE8uSRznEG0YkNah6EHzWc6xJfC09qXTCNOOsYgWexXCh1aJvRu0z5FLvZuFp99Ya94LcYzS8ie3SHq1k0C1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926584; c=relaxed/simple;
	bh=5fs+rpcx1QZWlWpCtmIg1MXtiCf2rG51YjkIq77DRh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deEPbkYLkKFEcAHvI2p5+HLjUKcGsVN0TxBRwVIrh9LCgwBdgiP1UF2Hh9uy/II5J1aT9QHBbJn6bmi/EfDL0+b8AyjZZIMQLe+s6wIE5LwL4hbNYj+PfJw6Zt3raFyDvA1J8eWBlQ2h7oaH7n/YYifTT7hVBuJwkixGdk59KVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=HpFQYugY; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="HpFQYugY"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 4E696B3EE9;
	Thu, 19 Mar 2026 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773926580;
	bh=K4DZV9IVShl8r7RMOIfqrE8nnZaCpbJPb3iBWGHhKxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpFQYugYCTJcnISd+X4JDGbt1qSBzoGcxkdqKiUjCX728Ajeiv33Df4mGq9q4Q5f9
	 7WuQZjHWCs5IcBhRWQzo6ooZnxaeZTNblIfc7apr0Kyl/DrZFEq7rUj5jbZOqbrlzc
	 RhVXIc0P18ah0acLymFdT9WCT3eHC6BKPU8u45gk=
Date: Thu, 19 Mar 2026 13:22:54 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Message-ID: <abv4riGLlubast8v@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <aa7G1nD7Rd9F4eBH@casper.infradead.org>
 <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
 <aa7dgQDMEz34eadj@casper.infradead.org>
 <20260309151317.7bba06dd@gandalf.local.home>
 <aa8xawMxLeUjkyHx@casper.infradead.org>
 <20260309171700.063318b5@gandalf.local.home>
 <abhAoF5EpiPigsx7@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abhAoF5EpiPigsx7@shell.ilvokhin.com>

On Mon, Mar 16, 2026 at 05:40:50PM +0000, Dmitry Ilvokhin wrote:

[...]

> A possible generic solution is a trace_contended_release() for spin
> locks, for example:
> 
>     if (trace_contended_release_enabled() &&
>         atomic_read(&lock->val) & ~_Q_LOCKED_MASK)
>         trace_contended_release(lock);
> 
> This might work on x86, but could increase code size and regress
> performance on arches where spin_unlock() is inlined, such as arm64
> under !PREEMPTION.

I took a stab at this idea and submitted an RFC [1].

The implementation builds on your earlier observation from Matthew that
_raw_spin_unlock() is not inlined in most configurations. In those
cases, when the tracepoint is disabled, this adds a single NOP on the
fast path, with the conditional check staying out of line. The measured
text size increase in this configuration is +983 bytes.

For configurations where _raw_spin_unlock() is inlined, the
instrumentation does increase code size more noticeably
(+71 KB in my measurements), since the check and out of line call is
replicated at each call site.

This provides a generic release-side signal for contended locks,
allowing: correlation of lock holders with waiters and measurement of
contended hold times

This RFC addressing the same visibility gap without introducing per-lock
instrumentation.

If this tradeoff is acceptable, this could be a generic alternative to
lock-specific tracepoints.

[1]: https://lore.kernel.org/all/51aad0415b78c5a39f2029722118fa01eac77538.1773858853.git.d@ilvokhin.com 
