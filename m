Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355D328B58;
	Mon, 16 Mar 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682853; cv=none; b=h8ZEA0pi+YeyJK98cjwZkJp/tJ1yv7M9vGppwzaxtdE1niETT8NmVoL13JVYV/E+MvA95t/IjHk1eiyHs/Q5lPkaw1cWUi586g7jMWi0C84qDvH80fQ4ZFVlWubCzMYLitMMMgMb+A100AXD4EC6eahN9LZqq5Q24z8lxBOFvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682853; c=relaxed/simple;
	bh=i5PwwlE0Erxpfq9BYUPkFLkHrCDQPEvfsDQxy0XNePg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WheapCLHABJhGxuSC+n1Up6o9PNYNlyKi54a7rsoa3wv9LJdf3Tyn+Otc5mW6xJckTFgmkkswaK7eJr72mSn54TlhQwpgrh9kaGVVAoNCB2H0GNpULZO0+OIKcVVIDzZuRx/bKQOuSG/4JnrS6Ua0erzw7ZpinHGi08jBVRy+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=dTS6csCv; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="dTS6csCv"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id CE69CB3C52;
	Mon, 16 Mar 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773682850;
	bh=PYKf7aY84Fm2Usf9vwKrE8cpw7bghTbRx6rsJcLbz+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dTS6csCvLTM1SQTIz3SKBrpcK4/YVI8zJ4qyJCVZoEHV1Vxlqnqgvu9skkc2esslD
	 kPcBYa04hvvJJkdQNZF8Ul3irDYeARFq9+DGb6fdeupxhpdV46YjtsdJjsbnUv6nf2
	 VFicRtsQGemIELk2SvKmdV2I0TqcYlkkroeR9yuQ=
Date: Mon, 16 Mar 2026 17:40:48 +0000
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
Message-ID: <abhAoF5EpiPigsx7@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <aa7G1nD7Rd9F4eBH@casper.infradead.org>
 <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
 <aa7dgQDMEz34eadj@casper.infradead.org>
 <20260309151317.7bba06dd@gandalf.local.home>
 <aa8xawMxLeUjkyHx@casper.infradead.org>
 <20260309171700.063318b5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309171700.063318b5@gandalf.local.home>

Thanks for the discussion and for the feedback on generic lock
instrumentation.

Following up on the earlier points about lightweight LOCK_STAT and
tracepoints.

While the thread has focused on spin_lock() calls, the real gap is on
the unlock path: there is currently no release-side tracepoint to
correlate holders and waiters or measure contended hold times.

A possible generic solution is a trace_contended_release() for spin
locks, for example:

    if (trace_contended_release_enabled() &&
        atomic_read(&lock->val) & ~_Q_LOCKED_MASK)
        trace_contended_release(lock);

This might work on x86, but could increase code size and regress
performance on arches where spin_unlock() is inlined, such as arm64
under !PREEMPTION.

So even a generic release-side tracepoint has nontrivial downsides (not
to mention lightweight LOCK_STAT, since a disabled tracepoint is about
as lightweight as it gets, the more stats we add, the less lightweight
the mechanism becomes).

The zone lock wrappers provide a practical, production-safe solution to
observe this specific high-contention lock, if the generic approach
proves impractical.
