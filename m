Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C939DBCF;
	Wed, 13 May 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692033; cv=none; b=RVqGgHQpIiR0tXr6R+dbGrALPPAO+nRTvyRHEijgDe/tUhfbMdoCcyDPlz+cwoWHHU1u3+qeeyQhT749CDilvghtQQW829z5CGLb4Y6BiRSbuKs13lE07X6bhFTSxEWNSk4HNvcumu9WbTJ3s+CLrQa8rHUq+ONFBefRC/xGpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692033; c=relaxed/simple;
	bh=qiSbjD0HsEMFkBlESilc/oehVlYZCkejPoNwyL6NTpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdHb0eBO/z1AODZ8uL/y01sv78IO485vHeD4/irVZylKwiOq3HdWjUSWsicU9roPanf53vY5TbjjMtyqipsfPip8WqzrQFv43mP5fqrngmpp0y+Y5aRdWNHAdxw+66JtmRRW9wCge7T2SGZ7mS1WzVIqp/Xl4QpZJL6cfy9Zl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=didtX2jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="didtX2jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D183DC19425;
	Wed, 13 May 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692032;
	bh=qiSbjD0HsEMFkBlESilc/oehVlYZCkejPoNwyL6NTpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=didtX2jygd/WXuBLpFGPT/RGCaDqpWw+VTGdp5SayNalQM5nwkzB0P4HNfRa7/GyS
	 iHDHvRWgNAJJfW5gMxc/PRZIPyDd90HCY/fUW85UL9Nmv8Zx2OhcFjV3CnfVj2LV9n
	 glDqbPopvlLBrtp1i6JjiOfq2L9OHM50UzRGjlrz8AP68WsVelLvXDKP34PhG451kz
	 +koWUAwY2Q3KfdEPq1dxLa7UqYsaBWRUaDtt3faSTmhzosXHYokiaXneFs1DQ97yVC
	 9V+ZJwgi4p2dntvpwZ6EKbSGdG6J6FfggT1B7pp8WwrxIhmTS3OBDYJPz8Lhet30iv
	 f+6BMZK22LkbA==
Message-ID: <1d1c5f42-2f90-4770-93e4-24b2958c0c4c@kernel.org>
Date: Wed, 13 May 2026 19:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: introduce for_each_free_list()
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260513-page_alloc-unmapped-prep-v1-1-dacdf5402be8@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-1-dacdf5402be8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 14:35, Brendan Jackman wrote:
> There are a couple of places that iterate over the freelists with
> awareness of the data structures' layout.
> 
> It seems ideally, code outside of mm should not be aware of the page
> allocator's freelists at all. But, this patch just doesn't hide them
> completely, it's just a meek incremental step in that direction: provide
> a macro to iterate over it without needing to be aware of the actual
> struct fields.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

