Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B4283FD4;
	Sat, 28 Feb 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296289; cv=none; b=D86ggneiisvO61NuIdySPUmtvBPo4ePOZ9kOOfV1pRJiQOX7H0VfQfQAS2CCC1Khx5X5JC7KLIrJoVLVlSC8KJM9C9ToIxp3BBLjYsK8YQvj9iwolhHRJjnZOXZhnp216ejZ2FEeJUH5tQFTwXeiuE2ncpY9Sb1LTc6hITPHP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296289; c=relaxed/simple;
	bh=ZGHQINXzynbWw/TBUkaU3ArxtEBNGigaXhn1b5sfigg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUe4J7lB+PhXReTHFpZlMTHx2hDFgRn2PLKNo/jNMGqfjRrGUSBeL3LdFMlq5Z0f8WubFg8kImFbX3tUjfU0BCRV+nmpCX6K94yNN/d6rXkSc8s7hHNWNYRdNsIfzDLbosEGRWl5UKb03svqbAvqSK5+Za8RgLfM3b/3YqV+ya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE7ahF95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE7ahF95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5742EC116D0;
	Sat, 28 Feb 2026 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772296289;
	bh=ZGHQINXzynbWw/TBUkaU3ArxtEBNGigaXhn1b5sfigg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dE7ahF95IFImF7XwKhFLpqADbq1bNgCkAi6Ebj6rFrZX3oiwx+smXcRMaDx9bpKNU
	 zTkKFGpUU0gSrGGe7zqurS6SIrvFOvXk/EjPQMAMhbOMABM0/eLU+E2/JlEhlFLx71
	 TxI8oGcmX9LfShn3cmjGZAzjAg5vQrtdjuihqma3l2Er4M/cAg8eMqtt2/rl+eeyns
	 JsEM4RfzGgcEHJCiT5m7XqpR1zuiwifIwpY81tfgymd56wjuikZ5b8KBRBRWDYVWLw
	 uTb+20pkakjwRWnJH3i6tMX1hvGKvLIhaJNcfKl4PhTb4DiHT1VZ2ZfvRbIclCs17C
	 TTtq6nqpIiKYg==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"linux-cxl@vger.kernel.orgkernel-team"@meta.com
Subject: Re: [PATCH v4 3/5] mm: convert compaction to zone lock wrappers
Date: Sat, 28 Feb 2026 08:31:20 -0800
Message-ID: <20260228163121.213665-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3a09e46f52cf9f709b0725bc2b648cc5212843b2.1772206930.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Feb 2026 16:00:25 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Compaction uses compact_lock_irqsave(), which currently operates
> on a raw spinlock_t pointer so it can be used for both zone->lock
> and lruvec->lru_lock. Since zone lock operations are now wrapped,
> compact_lock_irqsave() can no longer directly operate on a
> spinlock_t when the lock belongs to a zone.
> 
> Split the helper into compact_zone_lock_irqsave() and
> compact_lruvec_lock_irqsave(), duplicating the small amount of
> shared logic. As there are only two call sites and both statically
> know the lock type, this avoids introducing additional abstraction
> or runtime dispatch in the compaction path.
> 
> No functional change intended.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
