Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D7175A89;
	Mon,  2 Mar 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458969; cv=none; b=lint2v0xudFbTQxgBoJh+E31T5UFQhz9CAiMn+RZRhVWzZHsD6h0WfNXVDphxuD8RzTQcanfRsyWgAaf67erNWkXJTnHf9HbGVuZdCa5/hDBZfbP/IIuhfcNCeOq123XITjXt81IgvXVHi/o3hkMy1bVQknUpnyrdOf0yGefe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458969; c=relaxed/simple;
	bh=T4ELE2GlSVO5CmnLs/7hGrzjhmHmj0CYFEE/iaXHyhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KshRr61LJdykvbvlHVNn7pdaG1apqwspclzicKesWk/7wSVb2QmUlEi3GQjEFF9RvboBCr36f1SBGnDQTGDLGTkkmckzSCU/KLOiO1CFITM2TePXIHkMDO8gGawjuWL6VwrVW/8AhtGVbJDZQgsW4S2Ecp02pfCGZqCsEDd4Mlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1c4sB+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1c4sB+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D80C19423;
	Mon,  2 Mar 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772458968;
	bh=T4ELE2GlSVO5CmnLs/7hGrzjhmHmj0CYFEE/iaXHyhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V1c4sB+krAO6rzRO/3BlZXIkReiTa+ctQFZ2SSgJsfzM6L3rNjATxtDInNdN5WDJU
	 SvsOiKiYjNzjT13mS3ZXu4VU2HJwSBVgvfjM6O/nAYJ/N3lneoUlCQBrfQ1wZ53plX
	 9/P7s2XoQ4uc3JcmUhEGXQXseHnftgmB1in8SfS8fZR3+vqQe55z9A/fmxr+TAE+xl
	 9d6rTSJJJPH7UqznRs/aTMLRtEz8YG5d+jEAjuyyoZX8MvGbPjTs0+gFaxH6Qa9nfy
	 tuYvLqBntsibmTWP6ykzHiUdCP5V8Ufby5roOZQ+DAzHmGiEsbZP7yiAPXNyvjh9Yn
	 ldNSLHYvatfmA==
Message-ID: <75655aa3-7d53-441c-aa08-59b99b999991@kernel.org>
Date: Mon, 2 Mar 2026 14:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] mm: convert zone lock users to wrappers
Content-Language: en-US
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-cxl@vger.kernel.orgkernel-team"@meta.com,
 SeongJae Park <sj@kernel.org>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d26a43ebed2f0f1edb9cfe4fbed16dd31c7a069c.1772206930.git.d@ilvokhin.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <d26a43ebed2f0f1edb9cfe4fbed16dd31c7a069c.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> Replace direct zone lock acquire/release operations with the
> newly introduced wrappers.
> 
> The changes are purely mechanical substitutions. No functional change
> intended. Locking semantics and ordering remain unchanged.
> 
> The compaction path is left unchanged for now and will be
> handled separately in the following patch due to additional
> non-trivial modifications.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

