Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7F1CAA7D
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000153; cv=none; b=iI6fJ7w/lM/R7CUVt2G5iU0PLJUo5MP3bznuz0sklS/nBmPbSILTgM+GRrQXMaGEu+4RrSOoXASDz2whC5z81PJRDnsftCbX7DsAD3g2xGKw802KSADkeJzBnLeJnOmGhsKH3jrYxheU2KgRttoZXr3lmSi8kuYX/eqGpdKHqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000153; c=relaxed/simple;
	bh=Io54O6sl8h6cXg1GfthKvH+E9QCewoNAxgUpDygpDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT6fe5eR7tgm6CnAduF13xt1V6YZD4xxu7EakYh6sGPO4bmU3GbX1kALz7A7LDPpEL868jm+oCjpbLKyi6FeVQkrGq2PkxOJlUbVPuJ2ce81aawZLZpx3LCuhRp90Q+Apt0gwBiHt6hoaaRHT1i4KwIVZJedBaAqOTXm4Fv++VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 20 Mar 2026 18:49:06 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 20 Mar 2026 18:49:06 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-mm@kvack.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Fix swapoff race and cleanup in hibernation swap
 path
Message-ID: <ab0YEn+Fd41q6LM7@yjaykim-PowerEdge-T330>
References: <20260319142404.3683019-1-youngjun.park@lge.com>
 <20260319195032.5c3b187d5779cf43cd63fcd0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319195032.5c3b187d5779cf43cd63fcd0@linux-foundation.org>

On Thu, Mar 19, 2026 at 07:50:32PM -0700, Andrew Morton wrote:
> On Thu, 19 Mar 2026 23:24:01 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > Currently, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the type
> > is acquired, subsequent slot allocations operate on a stale swap device.
> > 
> > Additionally, grabbing and releasing the swap device reference on every
> > slot allocation is inefficient across the entire hibernation swap path.
> 
> AI review has questions:
> 	https://sashiko.dev/#/patchset/20260319142404.3683019-1-youngjun.park%40lge.com

Hi Andrew,

Thanks for sharing the AI review. Some comments are indeed good catches.

patch 2 comments are wrong.
patch 3 comments are right.

Regarding patch 2, the AI review raised the following concerns:

> If this race occurs, swapoff clears SWP_WRITEOK and calls try_to_unuse()
> to scan and evict swap slots. Without the SWP_WRITEOK check here, it
> looks like uswsusp could successfully allocate slots while
> try_to_unuse() is actively scanning.

Right. but..

> If try_to_unuse() encounters these newly allocated slots, wouldn't it
> attempt to page them in and subsequently free them via
> folio_free_swap()?

I believe this concern is not valid.

swapoff calls try_to_unuse(), which scans swap_map[] entries:
(this logic is slightly different from each kerenl version but, fundamental is same)
    ...
    for (i = prev + 1; i < si->max; i++) {
            count = READ_ONCE(si->swap_map[i]);
            if (count && swap_count(count) != SWAP_MAP_BAD)
                    break;
    }
    ...

However, hibernation allocations marked with SWAP_HAS_CACHE are not
visible via this swap_map[] scanning logic, so they cannot be found
or reclaimed in that path.

As a result swapoff keeps retrying while swap_usage_in_pages(si) is
non-zero until user signal is delivered., rather than freeing those entrie.

I will also verify this behavior at runtime to be absolutely sure.

For patch 3, I agree with the comment and have responded in Rafael’s
thread.

I will update the series shortly.

Thanks,
Youngjun Park
