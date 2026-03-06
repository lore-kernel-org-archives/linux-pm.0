Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0013E02A;
	Fri,  6 Mar 2026 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760053; cv=none; b=VMfqbkFO7zBhaEVC2hqXxKPOz1ok1bdwSjg7ApKyX5alX4PdrXbDI+KqO37KVeRakeMBCLiHv6WIZk6ULOJ4z8SKtPSPjQeFSde6zzpocHqLz4+ytK9EWwnmuUZJ40+6DZ5rbuEM6F+wNw2pw15RUstwSbHigZGPvuf9kvzgxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760053; c=relaxed/simple;
	bh=RQH4aynp6t0XOR5kWhYDbiHP8APh0RZqBBOKCMlxrrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmznmXvwqToE7qHvaubf5nyIwsqDTWa0LncM7pbivH+wWlIMaz4SXMaJWhgryj45wQlYfD69OIPq7QhXPt0RBwFAWYYHqXPv6ai+NjF9aoR08vKVe31+My1rVsq3NYhW4k4/2MyptnDRtk6TiWtWMfORG2FE0AldvxD4Wp4XCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToiP5bfC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToiP5bfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F512C116C6;
	Fri,  6 Mar 2026 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772760052;
	bh=RQH4aynp6t0XOR5kWhYDbiHP8APh0RZqBBOKCMlxrrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToiP5bfCUdGGuMpJmpHfySDRyKWwiPdbcfLQHICWLS5rdT0fMO962OGuF4rRL7jx8
	 xN9TMqNmykeuvEKix5t8ErpDiqMzXV8CM3+PtkXGniU17OwfQbMmwbPcDqEKBEZ+Ud
	 uzKB4x8jNtMvMrfzHos2KbQjw47nQkDnWFgFEfoM0iTf8Iy8pV0vfwHxnhX6CqrMD2
	 fVqc6bAHXHPJ6jI6qBbKxUJOdURl4lo7s8/E4ty4G6pDYHHLHp9xANAgNodMDvwrZc
	 voTSMzO2A+lZoNClFmI4Og92oweJlaYTevBxfXpQqkewyWLVs0xknPf3UyR8kTqsE8
	 H/65P06zzGCPg==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Date: Thu,  5 Mar 2026 17:20:42 -0800
Message-ID: <20260306012043.90694-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aanSnywUXTVPaYUj@shell.ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Mar 2026 18:59:43 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
[...]
> Following the suggestion from SJ and Vlastimil, I prepared fixup to
> standardize documentation and comments on the term "zone lock".
> 
> The patch is based on top of the current mm-new.
> 
> Andrew, please let me know if you would prefer a respin of the series
> instead.
> 
> From 267cda3e0e160f97b346009bc48819bfeed92e52 Mon Sep 17 00:00:00 2001
> From: Dmitry Ilvokhin <d@ilvokhin.com>
> Date: Thu, 5 Mar 2026 10:36:17 -0800
> Subject: [PATCH] mm: documentation: standardize on "zone lock" terminology
> 
> During review of the zone lock tracing series it was suggested to
> standardize documentation and comments on the term "zone lock"
> instead of using zone_lock or referring to the internal field
> zone->_lock.
> 
> Update references accordingly.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: SeongJae Park <sj@kernel.org>


THanks,
SJ

[...]
