Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A52E3397;
	Mon, 18 May 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137293; cv=none; b=IKwtnpqzp+gAnaCZlcVpzTmxCFnSxLO2hCT+C86SlnALB/CU9D1/f1gFmb+AZJFAEnlftwA2yGD2jFhYSjmD+NO/0j9VJngpBLepZFYXFxYoGNQIvxvyqCF24tG5ZvZa6cGmPEOZlYK2uOe538U+S/WbK4NoB/EiK5NMN13HTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137293; c=relaxed/simple;
	bh=joOMMQqoY4Hed3o1XhdUg7enY/Eja9HeFgHFbnxcITM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eiPRwID9hLA5cIDtDce65aSR4swGImh34MJS20SmHvpE+qaOC78yDPeF9s3hwMJ6u/faQ5cAS6TAIIL9n1pUwyAFtYJeKW4o7AWpl6nGGu+RMuR6UwDJrk0T0C3vxNIIqRYCA3ZX2GtxxCzvk619AqAh2IU+iqFYi783ZKHJ+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MJ0cLJF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MJ0cLJF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FEEC2BCB7;
	Mon, 18 May 2026 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1779137292;
	bh=joOMMQqoY4Hed3o1XhdUg7enY/Eja9HeFgHFbnxcITM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJ0cLJF5aYkDaqqzxdWy6a1/DIGaVrLWBa8/saU8TVHuH9TdrDfQ59X7DjpKIxocu
	 /gQPf2Edx3J8qC5b6Ywu0O5JMERUiALwA3u/sngIXYvfkNWHjuq8QwM0Hqhbb6orMN
	 1aFnwN9w+pLS5AIRoKNiJMGcVQCupJ39i7dVlSlk=
Date: Mon, 18 May 2026 13:48:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: misc cleanups from __GFP_UNMAPPED series
Message-Id: <20260518134811.b2b78352779d7519e8123597@linux-foundation.org>
In-Reply-To: <DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
	<20260518111546.3baebae99dc3f2a4fd65e605@linux-foundation.org>
	<DIM2YAI5ORUU.2YLTV7PWKE516@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 20:20:50 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> On Mon May 18, 2026 at 6:15 PM UTC, Andrew Morton wrote:
> > On Wed, 13 May 2026 12:35:12 +0000 Brendan Jackman <jackmanb@google.com> wrote:
> >
> >> In v2 of the __GFP_UNMAPPED series [0], we realised that some of the patches
> >> could potentially be merged as independent cleanups.
> >> 
> >> These are all independent of one another, if you think some are useful
> >> cleanups and others are pointless churn, it should be fine to just pick
> >> whatever subset you prefer.
> >> 
> >> No functional change intended.
> >
> > Thanks, Brendan.  I added this to mm.git's mm-new branch for testing,
> > along with a note that [4/4] may be getting an update arising from
> > Vlastimil's feedback.
> 
> Cool thanks, (also I got the "added to mm-new branch notification" and
> realised why I missed it last time, broken mail filter).
> 
> The 4/4 update is already up, in reply to the thread.

Is that "mm/page_alloc: tidy up pindex helpers"?

For some reason I didn't receive that email, directly or via any
mailing list.  I do have the similar "mm/page_alloc: remove ifdefs from
pindex helpers" from May 13.

Oh well, please check tomorrow's mm.git and send along whatever is
needed?
