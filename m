Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189B3803CF
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933335; cv=none; b=Xfn4c5hayMHnnmAbV+Wk74f1BaflxZVpX1Fw9eyEnrKRWMmxGI7OGlcq9sb9bFwzuMMOUGFftBfOS+W4TSbAAtRzcEyIAAierAi4WlzDXxZ1YCTpisf4+b5zQTYaNEMR9UpbHpqzXtNCOoEO552Hzt4fOkf1Oor2n24kHsJEbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933335; c=relaxed/simple;
	bh=mV7jxebzJNVb+5lsUW2VQ5ClZ8zp8PK1uGUOtrrIR3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr+J3F6WpS7aisnRuvBeUWw22s4P17gyZyr+t6xRWGqRxO7gBMmhMKL/hPkt8YZnxnqWzZxH9DwhAzwqiXw/6VNWIwCLzWfzTLMwJ00wiuJpsI74SZN/C2EJY99duzQucwz1pyVbVqdV4Po8SFZTG30ZLcHgQyVDKnk2WkXm3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 24 Feb 2026 20:42:06 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 24 Feb 2026 20:42:06 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Carsten Grohmann <mail@carstengrohmann.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	taejoon.song@lge.com,
	"hyungjun.cho@lge.com Carsten Grohmann" <carstengrohmann@gmx.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm, swap: speed up hibernation allocation and
 writeout
Message-ID: <aZ2Ojp5aSREwIaFB@yjaykim-PowerEdge-T330>
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
 <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com>
 <aZ1X1OwbAUq1k+C6@yjaykim-PowerEdge-T330>
 <CAMgjq7BeA4cr5DSjpdaTVRRmcb_Pq+68yGZiiDg21fNPfGUQNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BeA4cr5DSjpdaTVRRmcb_Pq+68yGZiiDg21fNPfGUQNg@mail.gmail.com>

Thanks for the quick feedback :)

> Yes, that's definitely doable, but requires the hibernation side
> to change how it uses the API, which could be a long term
> workitem.

I can't claim to know the hibernation code inside out either,
but I think the picture would come together if we grab the
reference at find_first_swap / swap_type_of and just set the
put at the right place.

Let me look into this a bit more and bring it up if it turns
out to be worthwhile.

> I think you got this part wrong here. We need the lock because
> it will call this_cpu_xxx operations later. And GFP_KERNEL
> doesn't assume a lock locked context. Instead it needs to
> release the lock for a sleep alloc if the ATOMIC alloc fails,
> and that could happen here.

Ah right, sorry for the confusing wording. What I meant was
exactly what you described — the locks need to be released for
the GFP_KERNEL allocation, and the current code assumes the
local lock is always held at that point.

> But I agree we can definitely simplify this with some
> abstraction or wrapper.

What comes to mind right away is hoisting the alloc table
routine and distinguishing the path via the folio param. I'll
think about how to make it a clean design and propose a patch
if it makes sense :)

> I'm not sure how much code change it will involve and is it
> worth it.
>
> Hibernation is supposed to stop every process, so concurrent
> memory

I was thinking it might be possible with the ioctl-based
uswsusp path, but as you said, it probably wouldn't give us
a meaningful benefit.

> Definitely! I have a patch that introduced a hibernation /
> exclusive type in the swap table. Remember the is_countable
> macro you commented about previously? That's reserved for this.
> For hibernation type, it's not countable (exclusive to
> hibernation, maybe I need a better name though) so readahead or
> any accidental IO will always skip it. By then this ugly
> try_to_reclaim will be gone.

Nice!

> > Thanks for your work!
>
> And thanks for your review :)

Thanks 
Youngjun Park
