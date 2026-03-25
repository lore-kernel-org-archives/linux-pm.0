Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9373D8119;
	Wed, 25 Mar 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440885; cv=none; b=tic8bulMvBqOPWuuWaw1IAw+HizphRNtf7+C7mG7GK1kA80V+YGJj2hvpSOzZoXA3TeuHlreoi2eQfjDzqgcc8g6ihnVrSzvViMzAUOVEnthCEsMDcT58G3WETk6oOg0SNNjCmq4XTZvQuDvp2vmr4tmEOcSf2SYxHoMXsaE/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440885; c=relaxed/simple;
	bh=gjypWeTl+X1LsDsptq0XisCHeTLCc5QNbcnmmT9hU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svodz+5CRhwoh3LVLbnKiRZH3VC/LlTE+rivQ3GfuQk6ivylTNDCgirOuFWYLWfYUVseG34MiEwmjcyKCZr4AqE/DwCObOx7ubYanR0y63EMxathtQFSSVpvhYHn/+/5qziWg4vqYkgt6HURfGqmFSYoGLcoTPTaDfDj3kUS8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=zu6ayGgX; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="zu6ayGgX"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 6AD19BDCF2;
	Wed, 25 Mar 2026 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1774440876;
	bh=qlG0lXGt3ihgGzr2zmzy5cEjDh7Y5/V+vvfJk0BQROA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zu6ayGgXCX0hcZJvTh3J9FChG/6KiLH3P1J7k0JVvWTPTPwZtvYJVhLyJS5uBHtdC
	 6CcIxgxYmZBERel4KjS0dtjFi+Cizpjmz764CTTjAyJAxloip9zr3IM5unS/Ll578z
	 Qr+w0As2/AEnYMg2xU6dWsULHH5gulRX1tOolGdk=
Date: Wed, 25 Mar 2026 12:14:35 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <acPRq1YPeGR8EqMB@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <aa7G1nD7Rd9F4eBH@casper.infradead.org>
 <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
 <aa7dgQDMEz34eadj@casper.infradead.org>
 <20260309151317.7bba06dd@gandalf.local.home>
 <aa8xawMxLeUjkyHx@casper.infradead.org>
 <20260309171700.063318b5@gandalf.local.home>
 <abhAoF5EpiPigsx7@shell.ilvokhin.com>
 <abv4riGLlubast8v@shell.ilvokhin.com>
 <20260324163918.1a3c5c960d85a4243c9ae314@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324163918.1a3c5c960d85a4243c9ae314@linux-foundation.org>

On Tue, Mar 24, 2026 at 04:39:18PM -0700, Andrew Morton wrote:
> On Thu, 19 Mar 2026 13:22:54 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > On Mon, Mar 16, 2026 at 05:40:50PM +0000, Dmitry Ilvokhin wrote:
> > 
> > [...]
> > 
> > > A possible generic solution is a trace_contended_release() for spin
> > > locks, for example:
> > > 
> > >     if (trace_contended_release_enabled() &&
> > >         atomic_read(&lock->val) & ~_Q_LOCKED_MASK)
> > >         trace_contended_release(lock);
> > > 
> > > This might work on x86, but could increase code size and regress
> > > performance on arches where spin_unlock() is inlined, such as arm64
> > > under !PREEMPTION.
> > 
> > I took a stab at this idea and submitted an RFC [1].
> > 
> > The implementation builds on your earlier observation from Matthew that
> > _raw_spin_unlock() is not inlined in most configurations. In those
> > cases, when the tracepoint is disabled, this adds a single NOP on the
> > fast path, with the conditional check staying out of line. The measured
> > text size increase in this configuration is +983 bytes.
> > 
> > For configurations where _raw_spin_unlock() is inlined, the
> > instrumentation does increase code size more noticeably
> > (+71 KB in my measurements), since the check and out of line call is
> > replicated at each call site.
> > 
> > This provides a generic release-side signal for contended locks,
> > allowing: correlation of lock holders with waiters and measurement of
> > contended hold times
> > 
> > This RFC addressing the same visibility gap without introducing per-lock
> > instrumentation.
> > 
> > If this tradeoff is acceptable, this could be a generic alternative to
> > lock-specific tracepoints.
> > 
> > [1]: https://lore.kernel.org/all/51aad0415b78c5a39f2029722118fa01eac77538.1773858853.git.d@ilvokhin.com 
> 
> That submission has met a disappointing response.
> 
> How should I proceed with this series "mm: zone lock tracepoint
> instrumentation"?  It's not urgent so I'm inclined to put this on hold
> while you pursue "locking: Add contended_release tracepoint to spinning
> locks"?

Thanks for the follow-up, Andrew.

My current plan is to focus on the "locking: Add contended_release
tracepoint to spinning locks" work and drive it to a clear conclusion:
either by getting feedback that it's not a good direction, or by getting
it into mainline.

In the meantime, it seems reasonable to drop the "mm: zone lock
tracepoint instrumentation" patchset from mm-new to avoid confusion
until the direction is clearer. I can revisit and respin it if the more
generic locking approach doesn't pan out.

> 
> Please send that v2 sometime and hopefully Steven can help push it along?

I'll send the next version of the generic locking series soon. Any help
in pushing it along would be appreciated.
