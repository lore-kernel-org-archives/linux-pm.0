Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CB344DA6;
	Mon,  9 Mar 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091029; cv=none; b=GSuEu7AC82IdHeIlDjYDKaLPiDvhJqG8lO+AfLyFNOBKKPlIjYreCKoAkSPubvfXgfGTNDldtwMVVpnQ5G24WkTHqSbps6afH1/DJvh3l4lkjrzo9qRbwGDmtD/1Iaq5evkHxTlUb1usRbpuDz97oPeCDBWYp4rtO+mhHWpbCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091029; c=relaxed/simple;
	bh=bpoLnbYO8/rYrKVacGGqez+t0LmbQW6lVEhzCeRFbVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB71WC3/3aaKgTPqXk8v9VbF76NM4UeBnjuFPLg90V7MROCqZI58KNiIJ+VBLzFRvni/Znau+1AA6yeDPd2W8J22RBmZeOTRWfgLOdsLwybZkIf5XZFTOZ0sGw1PjaxFFVgA4BSN36enP4LuorS/xsR46Zih/Duockicdx0tNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 758CD13A869;
	Mon,  9 Mar 2026 21:16:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id D268820023;
	Mon,  9 Mar 2026 21:16:52 +0000 (UTC)
Date: Mon, 9 Mar 2026 17:17:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
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
Message-ID: <20260309171700.063318b5@gandalf.local.home>
In-Reply-To: <aa8xawMxLeUjkyHx@casper.infradead.org>
References: <cover.1772206930.git.d@ilvokhin.com>
	<aa7G1nD7Rd9F4eBH@casper.infradead.org>
	<aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
	<aa7dgQDMEz34eadj@casper.infradead.org>
	<20260309151317.7bba06dd@gandalf.local.home>
	<aa8xawMxLeUjkyHx@casper.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qdupw3qcx95kesicxk4ef3r4f7icbrgb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D268820023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XFN/gdyLIxDXgLJKAoUlEX1WfcjSP714=
X-HE-Tag: 1773091012-906581
X-HE-Meta: U2FsdGVkX1+E5+zEFu4ouTTuiZydJXGiJVkVKdHWUvbBjy0A4ia2YfSTyqoJGij9+DgAvjweOf+TnyK615f48JvD9s1RuHfJZado60mdmfqgJJ7byQ52vlgQ15huzT2Mhmb2QKsL/SDQw7IheFGj/3BTI6j5nd8jRE4Y8lrR3/zc3b4j9yCDC7Htw7SsvgBcV7RPqLl6gaQB1jtkSoY0hY8X3SVQW1sT3ljl0RQzi5RGmBTU7hvQjIApbEKCso7g+rYLK9oZIRwO9+pKEjTl8uXPyDtQl3PNrK+GDCI9ogqSJQBJEFVq8oyS2DAHL9y2gWhpp+Kix9+yY0dkIGhQETrhMy3kOgMQWYVF3PTc+zFIRt6a+DK9tE1nUM7iwCh8YJV42PxUfgL1xozBUsfgrJgf7BJXda1f

On Mon, 9 Mar 2026 20:45:31 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Mar 09, 2026 at 03:13:17PM -0400, Steven Rostedt wrote:
> > The biggest issue with making a generic light weight LOCK_STAT is that
> > locks are extremely optimized. Any addition of generic lock encoding will
> > cause a noticeable overhead when compiled in, even when disabled.  
> 
> I'm not sure that's true.  Taking the current Debian kernel config
> leads to a "call" instruction to acquire a spinlock:
> 
> void __insert_inode_hash(struct inode *inode, unsigned long hashval)
> {
>         struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);
> 
>         spin_lock(&inode_hash_lock);
>         spin_lock(&inode->i_lock);
>         hlist_add_head_rcu(&inode->i_hash, b);
>         spin_unlock(&inode->i_lock);
>         spin_unlock(&inode_hash_lock);
> }
> 
> compiles to:
> 
> [...]
>      280:       23 35 00 00 00 00       and    0x0(%rip),%esi        # 286 <__insert_inode_hash+0x56>
>                         282: R_X86_64_PC32      .data..ro_after_init+0x10
>      286:       48 8d 2c f0             lea    (%rax,%rsi,8),%rbp
>      28a:       e8 00 00 00 00          call   28f <__insert_inode_hash+0x5f>
>                         28b: R_X86_64_PLT32     _raw_spin_lock-0x4
>      28f:       4c 89 e7                mov    %r12,%rdi
>      292:       e8 00 00 00 00          call   297 <__insert_inode_hash+0x67>
>                         293: R_X86_64_PLT32     _raw_spin_lock-0x4
> [...]

Ah, you're correct. Looks like it's an arch specific thing. I was going
back to my memory from around 2006, but it appears that only a few archs
inline spinlocks anymore. Thomas made it a bit easier to see what does and
does not do that (in 2009).

  6beb000923882 ("locking: Make inlining decision Kconfig based")

So, perhaps adding code to the spinlocks will not be as much of a hit on I$.

> (The spinlock code is too complex for me to follow what config options
> influence whether it's a function call; you probably have enough of it
> in your head that you'd know)

Yeah, I feel like I'm always relearning the code every time I have to jump
in and understand it again.

> 
> > The other issue is the data we store for the lock. A lock is usually just a
> > word (or long) in size, embedded in a structure. LOCKDEP and LOCK_STAT adds
> > a key per lock. This increases the data size of the kernel.  
> 
> It does, but perhaps for a light weight lockstat, we could do better
> than that.  For example it could use the return address to look up
> which lock is being accessed rather than embedding a key in each lock.

Right.

-- Steve
