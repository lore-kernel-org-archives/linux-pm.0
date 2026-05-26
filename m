Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B43DD856
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793799; cv=none; b=lMXQgucX+rywlhdqcGu1N12fJzsDUwi7Y8s0TNZSX7BnkE2lYWZ+ZfJ0cft+k7++CeHhR4Ymnbz9Ti8EjGyzrjIXUl+W6/VTj+eZwpGG//0QwtFtcOcVc0JWsabCFe3B3MBg/dP036nHOTz7H9duIxHTZYPjMQ7g2fkaKohE4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793799; c=relaxed/simple;
	bh=RwN3N9c4nk4B12MlaA4H644TwqbEDy/lvfw8/wXDGcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJaYfOGN3yNjlPcESS0zqxIZSyFLUDSJ+U4B+Jq1Y1A1edvs/KzNN/eidS3LB51GatCh+EipqBQ1qyZXGplXuBspy5sJJadiFwPZ4EokDg/nH0lmozqRXO+wSooIeTvzoziJe9/Hk+eyQ9Rf5k6beR7sinsVX15aJ2eTnqZ7XIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/vJ/vLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/vJ/vLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CCA1F00A3E
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793797;
	bh=ThH8fXlp3WXsQYdZjeCGsNsqJ2bdOT5KrXpYEpL7Kys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q/vJ/vLSAnV+RmaNTvcuMFkwL0d6jIC74084QyJCWZmS4a84py4d6eAcdUGgSX+dE
	 C+MioRgHfxlZwyvY0R2X9Rmtzz4OTPcL+wRnJPfOTbHSS4LInjsGGx9+v91YIy20vm
	 AzKhrsKReehBXtgl4FTKQ3TKsj/vIzbyOqPw+S+W06efBLrZU/xcljGGhMbcSmrXm4
	 j/3GFx9VUyzQkX0KVDbKVF8dybsytY2CDwxx72C9dy8sK4kA142/Nyae8BGAjyI5JW
	 gjHth/4LigU815WxJYSeMD8gjGzhosY+GcqTZoIS7pVfzSvxIPiSlLQzuP516kcy68
	 L/1cWCCZsGXoQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa46a95e9eso656637e87.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85PNrZY2mw/GB+9FMq3+ON3tjLuAHwXCCLJEqxRUrXBYNmCsR5cybUQIOqlVHCyDoudH0V40xt0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+2jZBEyyrUEElGd1kpejru0EQUSzhl1xg9DvINPqg5Qeumx7
	fud1D/bHURPnx5Zk25O3wTNv+YqkI77hdm2+v4PuYDA9FU4aJJzkTO3fiLQdtGBMZgROiZjmKN2
	aZwCKDE0gobMdBIwOhpSnMd1pQJm23sc=
X-Received: by 2002:a05:6512:24db:b0:5aa:b6a:738d with SMTP id
 2adb3069b0e04-5aa323b80b6mr3798192e87.43.1779793795724; Tue, 26 May 2026
 04:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522181113.40350-1-alexander@lechthaler.online>
In-Reply-To: <20260522181113.40350-1-alexander@lechthaler.online>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:09:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNL6s33ZUJuA8+Q+1YN+Aim09q9LLQggPvjhD_Xk4aAw@mail.gmail.com>
X-Gm-Features: AVHnY4INTsd9JFj1NTRRvnrpmCQr91-pJ7HYlcpxeRgobXwr8r6nEHYgcmAJh5A
Message-ID: <CAJZ5v0jNL6s33ZUJuA8+Q+1YN+Aim09q9LLQggPvjhD_Xk4aAw@mail.gmail.com>
Subject: Re: [PATCH] power: snapshot: fix missing kernel-doc parameter descriptions
To: alexander@lechthaler.online
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:12=E2=80=AFPM Alexander Lechthaler
<alexander@lechthaler.online> wrote:
>
> Add missing parameter descriptions to kernel-doc comments in
> kernel/power/snapshot.c to silence documentation warnings.

All of the functions in question are static AFAICS, so they don't
really deserve kerneldoc comments in the first place.  Why don't you
replace the kerneldoc /** marker with the regular comment start marker
/* in all of those comments?

> Signed-off-by: Alexander Lechthaler <alexander@lechthaler.online>
> ---
>  kernel/power/snapshot.c | 52 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index a564650734dc..153c27439972 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -460,6 +460,10 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp=
_mask, int safe_needed,
>
>  /**
>   * add_rtree_block - Add a new leave node to the radix tree.
> + * @zone: Radix tree where node gets added.
> + * @gfp_mask: GFP mask for the allocation.
> + * @safe_needed: Get pages not used before hibernation (restore only).
> + * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
>   *
>   * The leave nodes need to be allocated in order to keep the leaves
>   * linked list in order. This is guaranteed by the zone->blocks
> @@ -530,6 +534,11 @@ static void free_zone_bm_rtree(struct mem_zone_bm_rt=
ree *zone,
>
>  /**
>   * create_zone_bm_rtree - Create a radix tree for one zone.
> + * @gfp_mask: GFP mask for the allocation.
> + * @safe_needed: Get pages not used before hibernation (restore only).
> + * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
> + * @start: First page frame number (PFN) in the zone to build the tree f=
or.
> + * @end: PFN one past the last page covered by the tree.
>   *
>   * Allocated the mem_zone_bm_rtree structure and initializes it.
>   * This function also allocated and builds the radix tree for the
> @@ -568,6 +577,8 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree=
(gfp_t gfp_mask,
>
>  /**
>   * free_zone_bm_rtree - Free the memory of the radix tree.
> + * @zone: Radix tree to free node pages from.
> + * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page=
s.
>   *
>   * Free all node pages of the radix tree. The mem_zone_bm_rtree
>   * structure itself is not freed here nor are the rtree_node
> @@ -680,6 +691,9 @@ static int create_mem_extents(struct list_head *list,=
 gfp_t gfp_mask)
>
>  /**
>   * memory_bm_create - Allocate memory for a memory bitmap.
> + * @bm: Memory bitmap.
> + * @gfp_mask: Mask to use for memory allocations.
> + * @safe_needed: Get pages not used before hibernation (restore only).
>   */
>  static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
>                             int safe_needed)
> @@ -723,6 +737,7 @@ static int memory_bm_create(struct memory_bitmap *bm,=
 gfp_t gfp_mask,
>  /**
>   * memory_bm_free - Free memory occupied by the memory bitmap.
>   * @bm: Memory bitmap.
> + * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page=
s.
>   */
>  static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_fr=
ee)
>  {
> @@ -738,9 +753,14 @@ static void memory_bm_free(struct memory_bitmap *bm,=
 int clear_nosave_free)
>
>  /**
>   * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
> + * @bm: Memory bitmap.
> + * @pfn: Page Frame Number (PFN).
> + * @addr: Returned address of the bitmap storage containing the bit.
> + * @bit_nr: Returned bit number within @addr.
>   *
>   * Find the bit in memory bitmap @bm that corresponds to the given PFN.
> - * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
> + * The cur.zone, cur.node, cur.node_pfn and cur.cur_pfn members
> + * of @bm are updated.
>   *
>   * Walk the radix tree to find the page containing the bit that represen=
ts @pfn
>   * and return the position of the bit in @addr and @bit_nr.
> @@ -879,8 +899,9 @@ static bool memory_bm_pfn_present(struct memory_bitma=
p *bm, unsigned long pfn)
>         return !memory_bm_find_bit(bm, pfn, &addr, &bit);
>  }
>
> -/*
> +/**
>   * rtree_next_node - Jump to the next leaf node.
> + * @bm: Memory bitmap.
>   *
>   * Set the position to the beginning of the next node in the
>   * memory bitmap. This is either the next node in the current
> @@ -990,6 +1011,8 @@ static void memory_bm_recycle(struct memory_bitmap *=
bm)
>
>  /**
>   * register_nosave_region - Register a region of unsaveable memory.
> + * @start_pfn: Start page frame number (PFN).
> + * @end_pfn: End page frame number (PFN).
>   *
>   * Register a range of page frames the contents of which should not be s=
aved
>   * during hibernation (to be used in the early initialization code).
> @@ -1307,6 +1330,8 @@ static unsigned int count_free_highmem_pages(void)
>
>  /**
>   * saveable_highmem_page - Check if a highmem page is saveable.
> + * @zone: Zone containing the PFN.
> + * @pfn: Page frame number to check.
>   *
>   * Determine whether a highmem page should be included in a hibernation =
image.
>   *
> @@ -1364,6 +1389,8 @@ static unsigned int count_highmem_pages(void)
>
>  /**
>   * saveable_page - Check if the given page is saveable.
> + * @zone: Zone containing the PFN.
> + * @pfn: Page frame number to check.
>   *
>   * Determine whether a non-highmem page should be included in a hibernat=
ion
>   * image.
> @@ -1442,6 +1469,8 @@ static inline bool do_copy_page(long *dst, long *sr=
c)
>
>  /**
>   * safe_copy_page - Copy a page in a safe way.
> + * @dst: Destination page.
> + * @s_page: Source page.
>   *
>   * Check if the page we are going to copy is marked as present in the ke=
rnel
>   * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
> @@ -1689,6 +1718,9 @@ static unsigned long preallocate_image_highmem(unsi=
gned long nr_pages)
>
>  /**
>   *  __fraction - Compute (an approximation of) x * (multiplier / base).
> + * @x: Value the fraction is applied to.
> + * @multiplier: Fraction numerator.
> + * @base: Fraction denominator.
>   */
>  static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
>  {
> @@ -1984,6 +2016,7 @@ int hibernate_preallocate_memory(void)
>  #ifdef CONFIG_HIGHMEM
>  /**
>   * count_pages_for_highmem - Count non-highmem pages needed for copying =
highmem.
> + * @nr_highmem: Number of highmem pages to copy.
>   *
>   * Compute the number of non-highmem pages that will be necessary for cr=
eating
>   * copies of highmem pages.
> @@ -2005,6 +2038,8 @@ static unsigned int count_pages_for_highmem(unsigne=
d int nr_highmem) { return 0;
>
>  /**
>   * enough_free_mem - Check if there is enough free memory for the image.
> + * @nr_pages: Number of normal pages required for the image.
> + * @nr_highmem: Number of highmem pages required for the image.
>   */
>  static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highme=
m)
>  {
> @@ -2025,6 +2060,7 @@ static int enough_free_mem(unsigned int nr_pages, u=
nsigned int nr_highmem)
>  #ifdef CONFIG_HIGHMEM
>  /**
>   * get_highmem_buffer - Allocate a buffer for highmem pages.
> + * @safe_needed: Whether a safe buffer for copying highmem pages is need=
ed.
>   *
>   * If there are some highmem pages in the hibernation image, we may need=
 a
>   * buffer to copy them and/or load their data.
> @@ -2037,6 +2073,8 @@ static inline int get_highmem_buffer(int safe_neede=
d)
>
>  /**
>   * alloc_highmem_pages - Allocate some highmem pages for the image.
> + * @bm: Bitmap to mark allocated pages in.
> + * @nr_highmem: Number of highmem pages to allocate.
>   *
>   * Try to allocate as many pages as needed, but if the number of free hi=
ghmem
>   * pages is less than that, allocate them all.
> @@ -2067,6 +2105,9 @@ static inline unsigned int alloc_highmem_pages(stru=
ct memory_bitmap *bm,
>
>  /**
>   * swsusp_alloc - Allocate memory for hibernation image.
> + * @copy_bm: Bitmap to mark allocated pages in.
> + * @nr_pages: Number of normal pages to allocate.
> + * @nr_highmem: Number of highmem pages to allocate.
>   *
>   * We first try to allocate as many highmem pages as there are
>   * saveable highmem pages in the system.  If that fails, we allocate
> @@ -2294,6 +2335,7 @@ static void duplicate_memory_bitmap(struct memory_b=
itmap *dst,
>
>  /**
>   * mark_unsafe_pages - Mark pages that were used before hibernation.
> + * @bm: Bitmap containing PFNs of pages used before hibernation.
>   *
>   * Mark the pages that cannot be used for storing the image during resto=
ration,
>   * because they conflict with the pages that had been used before hibern=
ation.
> @@ -2332,6 +2374,7 @@ static int check_header(struct swsusp_info *info)
>
>  /**
>   * load_header - Check the image header and copy the data from it.
> + * @info: Pointer to the structure to copy the header data to.
>   */
>  static int load_header(struct swsusp_info *info)
>  {
> @@ -2485,6 +2528,8 @@ static struct page *last_highmem_page;
>
>  /**
>   * get_highmem_page_buffer - Prepare a buffer to store a highmem image p=
age.
> + * @page: Page structure of the highmem image page to be loaded.
> + * @ca: Chain allocator to allocate memory for the page copy if needed.
>   *
>   * For a given highmem image page get a buffer that suspend_write_next()=
 should
>   * return to its caller to write to.
> @@ -2708,6 +2753,8 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>
>  /**
>   * get_buffer - Get the address to store the next image data page.
> + * @bm: Memory bitmap with the "original" PFNs of the image pages.
> + * @ca: Chain allocator to allocate memory for the page copy if needed.
>   *
>   * Get the address that snapshot_write_next() should return to its calle=
r to
>   * write to.
> @@ -2845,6 +2892,7 @@ int snapshot_write_next(struct snapshot_handle *han=
dle)
>
>  /**
>   * snapshot_write_finalize - Complete the loading of a hibernation image=
.
> + * @handle: Snapshot handle structure used for the loading.
>   *
>   * Must be called after the last call to snapshot_write_next() in case t=
he last
>   * page in the image happens to be a highmem page and its contents shoul=
d be
> --
> 2.43.0
>
