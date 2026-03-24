Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD933815F9;
	Tue, 24 Mar 2026 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774395560; cv=none; b=oxHTXgWSF7QUG9+xR8kOpjYWMqNspH9fKSQlsFqpwtTzPedmBKQyHm0pIkAluLZSai7OLUEpZEpTkBVg2W/27C0xl4X9ymYYmINW/fBwzY+GkCa3r3e/qRvmJWKfj5iLVPcFMxpGAnh2bYCIg5FDdS188wqYwopQcOrH+6CZeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774395560; c=relaxed/simple;
	bh=jETE0JFh9GTipM2rvyBs79WhM9MfsbUHhqii5B1SqNc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EPEgnbNkDyOwKB6XMPQnHwsIZiFM4wa35KD8aKP6aFjphjhU44H5dUJTsvVVkTwjuLvcoGxyFVQJU8xsPQRhXzaNqiauKegkx9iEhNkG5Nrqnzv1lJJGrusIkXF1MoDwQd5wahe4M227vkpAsAomfnkV2wQhiWjo2hcTOIFk5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Am+pA5J8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Am+pA5J8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D3DC19424;
	Tue, 24 Mar 2026 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774395560;
	bh=jETE0JFh9GTipM2rvyBs79WhM9MfsbUHhqii5B1SqNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Am+pA5J8RIhJGHXOHNLoJerq3KOkRiSX+TnB+uUK6YAtNjx0bQOs9nsD3kGKZWK2g
	 hHacwO5MIbIxdD1FRQ+HD0QG3qnYPMgc98IpL3QkBHg137OAaEJeTphVvGqAFpYYfv
	 6/nE2/SDD0VEvYSxXKeMbX8afBbcov4AQ+VxXGWs=
Date: Tue, 24 Mar 2026 16:39:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Matthew Wilcox
 <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar
 Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Message-Id: <20260324163918.1a3c5c960d85a4243c9ae314@linux-foundation.org>
In-Reply-To: <abv4riGLlubast8v@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
	<aa7G1nD7Rd9F4eBH@casper.infradead.org>
	<aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
	<aa7dgQDMEz34eadj@casper.infradead.org>
	<20260309151317.7bba06dd@gandalf.local.home>
	<aa8xawMxLeUjkyHx@casper.infradead.org>
	<20260309171700.063318b5@gandalf.local.home>
	<abhAoF5EpiPigsx7@shell.ilvokhin.com>
	<abv4riGLlubast8v@shell.ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 13:22:54 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> On Mon, Mar 16, 2026 at 05:40:50PM +0000, Dmitry Ilvokhin wrote:
> 
> [...]
> 
> > A possible generic solution is a trace_contended_release() for spin
> > locks, for example:
> > 
> >     if (trace_contended_release_enabled() &&
> >         atomic_read(&lock->val) & ~_Q_LOCKED_MASK)
> >         trace_contended_release(lock);
> > 
> > This might work on x86, but could increase code size and regress
> > performance on arches where spin_unlock() is inlined, such as arm64
> > under !PREEMPTION.
> 
> I took a stab at this idea and submitted an RFC [1].
> 
> The implementation builds on your earlier observation from Matthew that
> _raw_spin_unlock() is not inlined in most configurations. In those
> cases, when the tracepoint is disabled, this adds a single NOP on the
> fast path, with the conditional check staying out of line. The measured
> text size increase in this configuration is +983 bytes.
> 
> For configurations where _raw_spin_unlock() is inlined, the
> instrumentation does increase code size more noticeably
> (+71 KB in my measurements), since the check and out of line call is
> replicated at each call site.
> 
> This provides a generic release-side signal for contended locks,
> allowing: correlation of lock holders with waiters and measurement of
> contended hold times
> 
> This RFC addressing the same visibility gap without introducing per-lock
> instrumentation.
> 
> If this tradeoff is acceptable, this could be a generic alternative to
> lock-specific tracepoints.
> 
> [1]: https://lore.kernel.org/all/51aad0415b78c5a39f2029722118fa01eac77538.1773858853.git.d@ilvokhin.com 

That submission has met a disappointing response.

How should I proceed with this series "mm: zone lock tracepoint
instrumentation"?  It's not urgent so I'm inclined to put this on hold
while you pursue "locking: Add contended_release tracepoint to spinning
locks"?

Please send that v2 sometime and hopefully Steven can help push it along?
