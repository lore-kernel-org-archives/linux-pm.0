Received: from lgeamrelo12.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4117D6
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519588; cv=none; b=sqbiROQ4auyR5rU6ZLCxK36ec7h4L/rB2QVJ8IHw70xwy6QcRBkuIi81BCV06uHc1d+N0LE46uq8cZAQaGY8ck5GjJaAZE9GOjLC8nKoXf/9qtqB9j0EkLmhfluRzmucNlIQrLg+E3pPOyP9uOCxG5ezy3c1VTBjJGBYqqZOVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519588; c=relaxed/simple;
	bh=oNae0jPMs84rqZGQvCI76mNOSR1C+hlJOxxxt90FaX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/tBZD6XSBZ9Ekkfq42iyCx9karL8SC9eoBx1IsEBAWv+3x1tXuSgdDMlcvFOOMmLtrSuPtOFd4L/z+QDbXoCMShfiIDJIjXgXnCqFIgLtv2sYm0fCgsoo5WWIepBIcFzCNu6QmKmhsMznOIUEcIYdgmOvwty2cwzBpjQC4wbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.52 with ESMTP; 27 Sep 2026 23:03:00 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: trieu2.huynh@lge.com
Received: from unknown (HELO trieu2-huynh-trieuhpn-ubuntu24.beeworker.bee-live.svc.cluster.local) (10.159.39.43)
	by 156.147.1.125 with ESMTP; 27 Sep 2026 23:03:00 +0900
X-Original-SENDERIP: 10.159.39.43
X-Original-MAILFROM: trieu2.huynh@lge.com
Date: Sun, 27 Sep 2026 23:03:00 +0900
From: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: exclude unusable free pages from image
 preallocation
Message-ID: <ako2gojuxas6p7lxa5rehn36ofswmq2cicyzq7i2l7nzjty6sp@yg4ukrvlsknl>
References: <20260921101446.1193565-1-trieu2.huynh@lge.com>
 <CAJZ5v0iViUTTPBpfi10uHptoc98DbC_H2GP9BBuqNHA2d9vQkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iViUTTPBpfi10uHptoc98DbC_H2GP9BBuqNHA2d9vQkw@mail.gmail.com>

On Fri, Sep 25, 2026 at 09:56:01PM +0200, Rafael J. Wysocki (Intel) wrote:
>On Mon, Sep 21, 2026 at 12:14 PM Nhat-Trieu Huynh-Pham
><trieu2.huynh@lge.com> wrote:
>>
>> hibernate_preallocate_memory() derives the number of page frames to
>> preallocate for the image from the per-zone NR_FREE_PAGES counters.
>> Those counters count every free pageblock regardless of its migratetype,
>> including MIGRATE_HIGHATOMIC and MIGRATE_CMA pageblocks. Such pages are
>> free from the buddy allocator's point of view, but they cannot be used
>> by the order-0, non-movable, non-reserve GFP_KERNEL allocations with
>> which the image is preallocated (GFP_IMAGE = GFP_KERNEL|__GFP_NOWARN).
>>
>> (*) Reported free vs usable free:
>>
>> The mm subsystem already accounts for this in
>> __zone_watermark_unusable_free(). For order-0 GFP_KERNEL neither
>> ALLOC_RESERVES nor ALLOC_CMA is set, so the allocator subtracts the
>> high-order atomic reserve and the free CMA pages from the free count before
>> checking the watermarks. The hibernation preallocation, however, computes
>> its target from the unadjusted NR_FREE_PAGES value, so it asks for about
>> half of the unusable pages more than the allocator can deliver. On arm64
>> (no CONFIG_HIGHMEM) the highmem fallback in the failure path is a no-op,
>> hence even a small shortfall aborts hibernation, see [3] for example.
>>
>> (*) Why those pages are not usable by GFP_KERNEL:
>>
>> (**) CMA is reserved for movable allocations, so GFP_KERNEL has no
>> ALLOC_CMA, and MIGRATE_CMA is not in the unmovable fallback list. Free
>> CMA pages are therefore never handed to these allocations.
>>
>> (**) The high-order atomic reserve is only handed out to atomic, order > 0,
>> __GFP_HIGH allocations (ALLOC_HIGHATOMIC), which GFP_KERNEL order-0 is not.
>> These pages can be unreserved under memory pressure, but only all but one
>> pageblock per zone and only after an allocation has already failed,
>> so counting them as available still overestimates what the preallocation
>> can obtain without failing first. Excluding them is conservative.
>>
>> (*) Consequence of not excluding the unusable pages:
>>
>> With M = managed, S = saveable, F = free, U = highatomic + CMA and
>> R = reclaimable, count = S + F - totalreserve and alloc is about
>> count / 2, while the allocator can actually provide about (F - U) + R
>> pages. The shortfall is therefore inflated by exactly U compared with
>> the usable memory.
>>
>> From, with U = 11430 unusable free pages (5120 highatomic + 6310
>> CMA), the preallocation target is inflated by about U / 2 = 5715 pages,
>> while the allocator ends up 1247 pages short and hibernation is aborted
>> even though the system is able to create the image.
>>
>> (*) What changes after excluding the unusable pages:
>>
>> Subtract U from the per-zone free accounting used to compute count and
>> avail_normal. Then count' = count - U and, since max_size is roughly
>> count / 2, max_size' = max_size - U / 2 and alloc' = alloc - U / 2.
>> max_size' remains well above minimum_image_size() in practice, so the
>> resulting image is effectively unchanged while hibernation no longer
>> aborts unnecessarily.
>>
>> Testing
>> =======
>> (*) SA6155P running on AAOS with S2D feature
>> (*) backport locally on GKI 6.1
>>
>> References
>> ==========
>> [1]
>> commit f27ce0e14088 ("page_alloc: consider highatomic reserve in watermark fast")
>> [2]
>> commit ac3f3b0a5551 ("mm: page_alloc: unreserve highatomic page blocks before oom")
>> [3] Example of an abort:
>>     Mem-Info:
>>      free:344621 free_pcp:931 free_cma:6310
>>     DMA32 free:973864kB reserved_highatomic:8192KB free_cma:25240kB
>>     Normal free:404620kB reserved_highatomic:12288KB free_cma:0kB
>>     PM: hibernation: Image allocation is 1247 pages short
>>
>> Signed-off-by: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
>
>Please see Sashiko's feedback on this:
>
>https://sashiko.dev/#/patchset/20260921101446.1193565-1-trieu2.huynh%40lge.com
>
>and let me know what you think.
Hi Rafel, thank you so much for the point.
I'd like to address the concerns, see below:
>
>Thanks!
>
>> ---
>>  kernel/power/snapshot.c | 25 +++++++++++++++++++++++--
>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index b209712cb2c3..fd6164aea272 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1867,11 +1867,32 @@ int hibernate_preallocate_memory(void)
>>         highmem = save_highmem;
>>         size = 0;
>>         for_each_populated_zone(zone) {
>> +               unsigned long free, unusable;
>> +
>>                 size += snapshot_additional_pages(zone);
>> +
>> +               /*
>> +                * Pages reserved for high-order atomic allocations
>> +                * (MIGRATE_HIGHATOMIC) and free CMA pages cannot be used by
>> +                * the order-0 non-movable GFP_KERNEL allocations that
>> +                * preallocate the image, so do not count them as available.
>> +                * This mirrors __zone_watermark_unusable_free().
>> +                */
>> +               free = zone_page_state(zone, NR_FREE_PAGES);
>> +               unusable = zone->nr_reserved_highatomic;
(1) Sashiko review:
"Does this incorrectly use the total highatomic reserve capacity instead
of just the free pages within the reserve?
Since zone_page_state(zone, NR_FREE_PAGES) only counts pages that are actually
free, using zone->nr_reserved_highatomic (which tracks the total capacity
of highatomic pageblocks, including already-allocated pages) effectively
includes allocated highatomic pages in the unusable count."

d'oh, I was misread that I developed and tested this change on a
6.1-based tree, where struct zone only has nr_reserved_highatomic and
__zone_watermark_unusable_free() still uses it; nr_free_highatomic was
introduced later by [1]. It should be changed to:

unusable = READ_ONCE(zone->nr_free_highatomic)

>> +#ifdef CONFIG_CMA
>> +               unusable += zone_page_state(zone, NR_FREE_CMA_PAGES);
>> +#endif
>> +               /*
>> +                * nr_reserved_highatomic counts whole reserved pageblocks,
>> +                * so it can exceed the actual free pages.
>> +                */
>> +               unusable = min(unusable, free);
>> +
>>                 if (is_highmem(zone))
>> -                       highmem += zone_page_state(zone, NR_FREE_PAGES);
>> +                       highmem += free - unusable;
>>                 else
>> -                       count += zone_page_state(zone, NR_FREE_PAGES);
(2) Sashiko review:
"Could this subtraction of the inflated unusable count underestimate the
usable free memory?
If so, this might cause the preallocation phase in
hibernate_preallocate_memory() to allocate fewer pages than it optimally
could, resulting in an unnecessarily larger hibernation image."

Yes, that is the other half of the same problem. Subtracting an inflated
value makes count and avail_normal smaller than the memory that is
actually usable, so preallocate_image_memory() stops early and the image
ends up larger than necessary. The same change fixes it as point #1: with
nr_free_highatomic the value subtracted is exactly the amount the
allocator cannot hand out, so the estimate is no longer inflated.
>> +                       count += free - unusable;
>>         }
>>         avail_normal = count;
>>         count += highmem;
>> --
>> 2.43.0
>> 
I'll submit v2 accordingly if there's no further concern.

[1] commit c928807f6f6b ("mm/page_alloc: keep track of free highatomic")

BRs,
