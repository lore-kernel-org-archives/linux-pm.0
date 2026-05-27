Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53C3C945B;
	Wed, 27 May 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867572; cv=pass; b=SJHdOnWsQXOfw03ddiyiz/V813YzJwqE8mkyYJKzrtlnOPQlqRtm7caKl1+wfBOZuTHPFV3Buozk6zrqRTI/lc2oQa4CNAjXv7Eb7kSMgQqx7zUVkvHB/QSM+YhfyC+TATBpv6I6aBAY/eY8fBRYZCDNDnGAckP4z79TfAVE/RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867572; c=relaxed/simple;
	bh=pXPW/nXpGbQld+Hckyjd9fLieEtjotxDgp7EPR3V0do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaJPdR/E1AQL/JAYWRGA6B/73No7azb7fxFHX+eB/0eJdZm2ApVb4EDEN/gaEcGfwwWBtMNqR9+C8r6u5n56dju2/61KVg9rzLOxQPpNmsCbgLVDqzDEHe8vcLIrkJt7Ko8tUgohvYovmKVaOoSuNr/f/Ios+YVI3PfU1YeIejM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lechthaler.online; spf=none smtp.mailfrom=lechthaler.online; dkim=pass (2048-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b=ZnF712CY; dkim=permerror (0-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b=58A8fxlM; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lechthaler.online
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lechthaler.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b="ZnF712CY";
	dkim=permerror (0-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b="58A8fxlM"
ARC-Seal: i=1; a=rsa-sha256; t=1779867388; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p5V+fnnSi1vLCEhXwuyo1lfDZRAfhb9nd805tM4ZgRpCsuVw6jjtPAlw3Ht3AAyuUL
    0UEUGOhrRVIhKoLdb8Lps+IBMVw6ORUnRroE9jTYw+fpAAUxxUgzXByiHosRk3V9BEmQ
    UruccskZMYMqqrhiMPT2kiin69h4CaC4h2IisXUqLAs+maDos55/uOvxjoG/QgXAD1/q
    9BeE6o8prVNm6hj3P2YdgInnSbURQ5L6bCJPbioYjZ5p2UP9XRP5mzWj+SB+Tg3yrn1d
    PqZA3aR06ULeWsenNLfAyzy4Y42Y+XVzzABcofRI1KgmjNHY7bzgNbW8/0i+4jtSX3tr
    xRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779867388;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eJtH7ii6+yHNXsZIFOqJuRL18J6pEveBiwPmTt8JMmc=;
    b=qnVeoSdiDr04LWDlWOChg6pJiy9iAxHoIAsueJ79dsP8L0o6t6y2i7veTwBl365yWv
    1t4GOruHeLw99vtT3pOnQoYxu+QvdnjczVd3XqJijwlRT/JfYaEH9n0hL3ffrafm3jBv
    bz+FV8EcPP65purEGXPszUGMO+Q64poQ8RKtgQvgRJ18QU+2BQWx6hz6GsVj/4wJfFnH
    gh1eYJnwqr9UapDHYlo7WEmkG8Ugn5pqKz7wy3Qch6ed5lZ6qA8vc0LiBrk3wzbDX1Bd
    8xGaVT4DAbh+ZMTSfpFp00DSXHjiVbzmldh4icruoYHwB959FupE2ReJe12h4KK1HuAh
    WK7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779867388;
    s=strato-dkim-0002; d=lechthaler.online;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eJtH7ii6+yHNXsZIFOqJuRL18J6pEveBiwPmTt8JMmc=;
    b=ZnF712CY3qs5R8GSH3XDF5ETULdAWWH7petfLGxcipQtQ3/x18XNWI3HsK6wiFd1Sv
    MKuO6fRoveufNOQDlPimFprNRpZXWK421jte1MncldE9r6gJYhbpYi2bITcFsQGLvnRW
    0b8K3ecLQj9ZZ23clL6ovwDoTDMZGx3idfhD7ZxXzu4mRtEgJc/05sSCZ5UKqNcaeR6k
    RlhN5OQCFftbwi1Hs/tLJDXuPdmyK3rlJEO3/URycEx18xMaW8nTPOGvvYOQqVPZP70O
    Zylg9QljKEv/t1I0lEqVACWk2Ei2oM0PCl6W7045u1xAIiFWcxVkqValeLuLUM5sFKDe
    UY5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779867388;
    s=strato-dkim-0003; d=lechthaler.online;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eJtH7ii6+yHNXsZIFOqJuRL18J6pEveBiwPmTt8JMmc=;
    b=58A8fxlMLQZRaXH0dYocIAqYu10Cagg1uo9BT+MO9VXk24BdssR/sqlepzYi8kNBbb
    n3SBqxHKILXeCRq8OrDA==
X-RZG-AUTH: ":LWABbUGmf/p3GWz138t3dAG4+iFy9XUTxnN94F8mUwTghZauya1bHdwWZANyhT7JUoBGg72fwp4OIxY="
Received: from [192.168.0.101]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id j78f5a24R7aR7Kv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 27 May 2026 09:36:27 +0200 (CEST)
Message-ID: <acdcb8c9-7814-48c5-8ffd-abbaec22955b@lechthaler.online>
Date: Wed, 27 May 2026 09:36:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: snapshot: fix missing kernel-doc parameter
 descriptions
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522181113.40350-1-alexander@lechthaler.online>
 <CAJZ5v0jNL6s33ZUJuA8+Q+1YN+Aim09q9LLQggPvjhD_Xk4aAw@mail.gmail.com>
Content-Language: en-US
From: Alexander Lechthaler <alexander@lechthaler.online>
In-Reply-To: <CAJZ5v0jNL6s33ZUJuA8+Q+1YN+Aim09q9LLQggPvjhD_Xk4aAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/26 13:09, Rafael J. Wysocki wrote:
> On Fri, May 22, 2026 at 8:12 PM Alexander Lechthaler
> <alexander@lechthaler.online> wrote:
>>
>> Add missing parameter descriptions to kernel-doc comments in
>> kernel/power/snapshot.c to silence documentation warnings.
> 
> All of the functions in question are static AFAICS, so they don't
> really deserve kerneldoc comments in the first place.  Why don't you
> replace the kerneldoc /** marker with the regular comment start marker
> /* in all of those comments?
> 
>> Signed-off-by: Alexander Lechthaler <alexander@lechthaler.online>
>> ---
>>   kernel/power/snapshot.c | 52 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index a564650734dc..153c27439972 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -460,6 +460,10 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
>>
>>   /**
>>    * add_rtree_block - Add a new leave node to the radix tree.
>> + * @zone: Radix tree where node gets added.
>> + * @gfp_mask: GFP mask for the allocation.
>> + * @safe_needed: Get pages not used before hibernation (restore only).
>> + * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
>>    *
>>    * The leave nodes need to be allocated in order to keep the leaves
>>    * linked list in order. This is guaranteed by the zone->blocks
>> @@ -530,6 +534,11 @@ static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
>>
>>   /**
>>    * create_zone_bm_rtree - Create a radix tree for one zone.
>> + * @gfp_mask: GFP mask for the allocation.
>> + * @safe_needed: Get pages not used before hibernation (restore only).
>> + * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
>> + * @start: First page frame number (PFN) in the zone to build the tree for.
>> + * @end: PFN one past the last page covered by the tree.
>>    *
>>    * Allocated the mem_zone_bm_rtree structure and initializes it.
>>    * This function also allocated and builds the radix tree for the
>> @@ -568,6 +577,8 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
>>
>>   /**
>>    * free_zone_bm_rtree - Free the memory of the radix tree.
>> + * @zone: Radix tree to free node pages from.
>> + * @clear_nosave_free: If set, clear the PageNosaveFree bit for the pages.
>>    *
>>    * Free all node pages of the radix tree. The mem_zone_bm_rtree
>>    * structure itself is not freed here nor are the rtree_node
>> @@ -680,6 +691,9 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
>>
>>   /**
>>    * memory_bm_create - Allocate memory for a memory bitmap.
>> + * @bm: Memory bitmap.
>> + * @gfp_mask: Mask to use for memory allocations.
>> + * @safe_needed: Get pages not used before hibernation (restore only).
>>    */
>>   static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
>>                              int safe_needed)
>> @@ -723,6 +737,7 @@ static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
>>   /**
>>    * memory_bm_free - Free memory occupied by the memory bitmap.
>>    * @bm: Memory bitmap.
>> + * @clear_nosave_free: If set, clear the PageNosaveFree bit for the pages.
>>    */
>>   static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
>>   {
>> @@ -738,9 +753,14 @@ static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
>>
>>   /**
>>    * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
>> + * @bm: Memory bitmap.
>> + * @pfn: Page Frame Number (PFN).
>> + * @addr: Returned address of the bitmap storage containing the bit.
>> + * @bit_nr: Returned bit number within @addr.
>>    *
>>    * Find the bit in memory bitmap @bm that corresponds to the given PFN.
>> - * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
>> + * The cur.zone, cur.node, cur.node_pfn and cur.cur_pfn members
>> + * of @bm are updated.
>>    *
>>    * Walk the radix tree to find the page containing the bit that represents @pfn
>>    * and return the position of the bit in @addr and @bit_nr.
>> @@ -879,8 +899,9 @@ static bool memory_bm_pfn_present(struct memory_bitmap *bm, unsigned long pfn)
>>          return !memory_bm_find_bit(bm, pfn, &addr, &bit);
>>   }
>>
>> -/*
>> +/**
>>    * rtree_next_node - Jump to the next leaf node.
>> + * @bm: Memory bitmap.
>>    *
>>    * Set the position to the beginning of the next node in the
>>    * memory bitmap. This is either the next node in the current
>> @@ -990,6 +1011,8 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
>>
>>   /**
>>    * register_nosave_region - Register a region of unsaveable memory.
>> + * @start_pfn: Start page frame number (PFN).
>> + * @end_pfn: End page frame number (PFN).
>>    *
>>    * Register a range of page frames the contents of which should not be saved
>>    * during hibernation (to be used in the early initialization code).
>> @@ -1307,6 +1330,8 @@ static unsigned int count_free_highmem_pages(void)
>>
>>   /**
>>    * saveable_highmem_page - Check if a highmem page is saveable.
>> + * @zone: Zone containing the PFN.
>> + * @pfn: Page frame number to check.
>>    *
>>    * Determine whether a highmem page should be included in a hibernation image.
>>    *
>> @@ -1364,6 +1389,8 @@ static unsigned int count_highmem_pages(void)
>>
>>   /**
>>    * saveable_page - Check if the given page is saveable.
>> + * @zone: Zone containing the PFN.
>> + * @pfn: Page frame number to check.
>>    *
>>    * Determine whether a non-highmem page should be included in a hibernation
>>    * image.
>> @@ -1442,6 +1469,8 @@ static inline bool do_copy_page(long *dst, long *src)
>>
>>   /**
>>    * safe_copy_page - Copy a page in a safe way.
>> + * @dst: Destination page.
>> + * @s_page: Source page.
>>    *
>>    * Check if the page we are going to copy is marked as present in the kernel
>>    * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
>> @@ -1689,6 +1718,9 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
>>
>>   /**
>>    *  __fraction - Compute (an approximation of) x * (multiplier / base).
>> + * @x: Value the fraction is applied to.
>> + * @multiplier: Fraction numerator.
>> + * @base: Fraction denominator.
>>    */
>>   static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
>>   {
>> @@ -1984,6 +2016,7 @@ int hibernate_preallocate_memory(void)
>>   #ifdef CONFIG_HIGHMEM
>>   /**
>>    * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
>> + * @nr_highmem: Number of highmem pages to copy.
>>    *
>>    * Compute the number of non-highmem pages that will be necessary for creating
>>    * copies of highmem pages.
>> @@ -2005,6 +2038,8 @@ static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0;
>>
>>   /**
>>    * enough_free_mem - Check if there is enough free memory for the image.
>> + * @nr_pages: Number of normal pages required for the image.
>> + * @nr_highmem: Number of highmem pages required for the image.
>>    */
>>   static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
>>   {
>> @@ -2025,6 +2060,7 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
>>   #ifdef CONFIG_HIGHMEM
>>   /**
>>    * get_highmem_buffer - Allocate a buffer for highmem pages.
>> + * @safe_needed: Whether a safe buffer for copying highmem pages is needed.
>>    *
>>    * If there are some highmem pages in the hibernation image, we may need a
>>    * buffer to copy them and/or load their data.
>> @@ -2037,6 +2073,8 @@ static inline int get_highmem_buffer(int safe_needed)
>>
>>   /**
>>    * alloc_highmem_pages - Allocate some highmem pages for the image.
>> + * @bm: Bitmap to mark allocated pages in.
>> + * @nr_highmem: Number of highmem pages to allocate.
>>    *
>>    * Try to allocate as many pages as needed, but if the number of free highmem
>>    * pages is less than that, allocate them all.
>> @@ -2067,6 +2105,9 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
>>
>>   /**
>>    * swsusp_alloc - Allocate memory for hibernation image.
>> + * @copy_bm: Bitmap to mark allocated pages in.
>> + * @nr_pages: Number of normal pages to allocate.
>> + * @nr_highmem: Number of highmem pages to allocate.
>>    *
>>    * We first try to allocate as many highmem pages as there are
>>    * saveable highmem pages in the system.  If that fails, we allocate
>> @@ -2294,6 +2335,7 @@ static void duplicate_memory_bitmap(struct memory_bitmap *dst,
>>
>>   /**
>>    * mark_unsafe_pages - Mark pages that were used before hibernation.
>> + * @bm: Bitmap containing PFNs of pages used before hibernation.
>>    *
>>    * Mark the pages that cannot be used for storing the image during restoration,
>>    * because they conflict with the pages that had been used before hibernation.
>> @@ -2332,6 +2374,7 @@ static int check_header(struct swsusp_info *info)
>>
>>   /**
>>    * load_header - Check the image header and copy the data from it.
>> + * @info: Pointer to the structure to copy the header data to.
>>    */
>>   static int load_header(struct swsusp_info *info)
>>   {
>> @@ -2485,6 +2528,8 @@ static struct page *last_highmem_page;
>>
>>   /**
>>    * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
>> + * @page: Page structure of the highmem image page to be loaded.
>> + * @ca: Chain allocator to allocate memory for the page copy if needed.
>>    *
>>    * For a given highmem image page get a buffer that suspend_write_next() should
>>    * return to its caller to write to.
>> @@ -2708,6 +2753,8 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
>>
>>   /**
>>    * get_buffer - Get the address to store the next image data page.
>> + * @bm: Memory bitmap with the "original" PFNs of the image pages.
>> + * @ca: Chain allocator to allocate memory for the page copy if needed.
>>    *
>>    * Get the address that snapshot_write_next() should return to its caller to
>>    * write to.
>> @@ -2845,6 +2892,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
>>
>>   /**
>>    * snapshot_write_finalize - Complete the loading of a hibernation image.
>> + * @handle: Snapshot handle structure used for the loading.
>>    *
>>    * Must be called after the last call to snapshot_write_next() in case the last
>>    * page in the image happens to be a highmem page and its contents should be
>> --
>> 2.43.0
>>

Thanks for the feedback. Makes sense. I have send a v2 a minute ago.
