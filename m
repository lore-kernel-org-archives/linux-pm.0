Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F333DEF7;
	Mon,  2 Mar 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464739; cv=none; b=A/zmFluESaOjgA41BWGs4ARGSeooUbIRM5w0WLZVHQ9Inuowyf0a8wbdY8F01PBgqZ+yzRLQ4geuvXdBm/XfSSAfVkXUTy1XmV1rJXX/tV7NbO60SNWC111ZchUccJGZ773J05QRllp1YXh6B+AmeZTcjTIUT47PJkFHNJ/63hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464739; c=relaxed/simple;
	bh=dwmK2EnSIsQl57kTURLOvNMIQmr9D+99Bbr5VpbqFSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn/9tTC7tnC/BKxzxmt/pUdm/s79RKt4MT6463zk1GhyuHW9NMjI5oGR0y3XV+YwVZBfIpxX4EfYuZFaq+6GIqyQFHIQb1ZjNI2zfZeuznK7gCfD+jTGpTIgF5uV5tpGKTxvUellM4fkcSJkPr40uVcjVJjLEX5tIvAz4oN3VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=oXpdMlRz; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="oXpdMlRz"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id A32A2B3085;
	Mon, 02 Mar 2026 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772464730;
	bh=BFYzZEBixlS+zcZl7LsuEKBEMzuKJceTVNM40UE/LP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oXpdMlRzh3dhWg4L7e1wNlTox7fVWTR42Pud1whiidbKQmr2FQfBFHS0BOCTKSpBe
	 R2DIdS6d5ws7XChDY9B/cUn27jM6mwloRl+Pgb1LAhHjBvlEMht6wQWyutSDnREvtR
	 IOe0L9Ulmzror287UzM5h85fSgdc4Gtg+B8D00DE=
Date: Mon, 2 Mar 2026 15:18:45 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 5/5] mm: add tracepoints for zone lock
Message-ID: <aaWqVZ4t5AaJfih7@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <ae145fe890f028409f727b4921904b547346fa0b.1772206930.git.d@ilvokhin.com>
 <20260227144649.3dbff742@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227144649.3dbff742@gandalf.local.home>

On Fri, Feb 27, 2026 at 02:46:49PM -0500, Steven Rostedt wrote:
> On Fri, 27 Feb 2026 16:00:27 +0000
> Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> >  static inline void zone_lock_init(struct zone *zone)
> >  {
> > @@ -12,26 +59,41 @@ static inline void zone_lock_init(struct zone *zone)
> >  
> >  #define zone_lock_irqsave(zone, flags)				\
> >  do {								\
> > +	bool success = true;					\
> > +								\
> > +	__zone_lock_trace_start_locking(zone);			\
> >  	spin_lock_irqsave(&(zone)->_lock, flags);		\
> > +	__zone_lock_trace_acquire_returned(zone, success);	\
> 
> Why the "success" variable and not just:
> 
> 	__zone_lock_trace_acquire_returned(zone, true);
> 
>  ?

Good point, passing true directly is cleaner. Happy to respin if needed.
