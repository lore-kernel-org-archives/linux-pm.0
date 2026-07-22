Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62D3BBFB6
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721943; cv=none; b=fkwCYSpY81M9pvVFzr9aWXi2rQ3lAHhJzDPIr7g/iNdIKvLWbbUDlWd6xI9+KZkzgeSmEqgEob0mJWpraZxPXqpNA7Sg1q0oGImGrMKc74KcGAk209iJ3tnBhgrMJjDgwNv3pfAiI4KiiaUHuTaYf4h6h2fv8qHybEPgutzuBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721943; c=relaxed/simple;
	bh=V+io0wsTinWn6oD1Zx+gfASkPSLTa7UT8PRA70m/HeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGA7JvWOAvnGNnJ1kyczavF1B4gfEZI9mfEmzgHIQb9tiJJXiSGIrxjEoUoCEHQf0krKq592Vpd2ahByavqMul7lecy7EHxs6EtQ2AeCblQg4mk7IejdZWLhr3ABbcC4BIJi+TvjFTputfLODn1msk/3vA1CtvrT+EOdE7OBE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzRtsYtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzRtsYtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540BA1F00A3E
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784721942;
	bh=q53a9xtYgK3+D61si9DmOvBLJsk88HnK6t4GhuJGx+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AzRtsYtgVJW7Ko14oaMYxoG4mxJlBdQyinOQxlSBE2xyO8CF852Rum9je+S7r/2S6
	 ERuwEmjNaoJDdQDVc5HxB7UudEa7puCdQPsrLSqL+C7T4PyZt6Q9nnwsa4r1DOoO9N
	 bpdMpnXBaiqTcCqZnVwHgIleeaqp8fe3ptRHzsem/xxkzJLajs4fZllFVedhEGU0kW
	 Y1dI/bjHYKMFpJD4mgOI5w01/dOE64rxC4odCiMbdal3loeHv9jubEq0kwU2u1Gokx
	 FtiSkl2Vatjpdr3beWCQxYf2z5U5sEIU5EmhgAdtpq6ZJ1+WBRRL6fyRJQPdz91R7U
	 7iayXwXn0TqnA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c86945164so108588721fa.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 05:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+5MDe7tkUvVUFyEs57TqCaqUvnL4NRbaoNEmsXoOrE0nteayn8mF0tqmHhI8S7zU2y9MsoZfXcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcXiRIQlVmMLGspshi/O/1msL2G98GcApLBvvF+ch8TmxWjeu
	BDyd89LViuTS+CM2YqdzgsRucYoZe1OfzPWuepy8H9QnECTyOQ/jY5nLUPq8vTgphCqm5RXVC0I
	KdO3yv7TEfbXHF+ErcJeugviHB78tHt8=
X-Received: by 2002:a2e:90c5:0:b0:39a:cfea:f17 with SMTP id
 38308e7fff4ca-39eb29145f4mr35999801fa.30.1784721940680; Wed, 22 Jul 2026
 05:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609231626.38839-1-adinata.softwareengineer@gmail.com>
In-Reply-To: <20260609231626.38839-1-adinata.softwareengineer@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 14:05:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hM+sGrH4wt3Ce__QwzH6fE_JsgXeTPZAypyye8R2NALA@mail.gmail.com>
X-Gm-Features: AUfX_mwdPtI5tBefmHwa47xkd8_oaJOWWTw7Sf74CGGeDSuNB5VuHokWX-kuf5c
Message-ID: <CAJZ5v0hM+sGrH4wt3Ce__QwzH6fE_JsgXeTPZAypyye8R2NALA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Mark undocumented snapshot helpers as non-kernel-doc
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: rafael@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:16=E2=80=AFAM Adi Nata
<adinata.softwareengineer@gmail.com> wrote:
>
> Several helpers in snapshot.c are introduced with kernel-doc (/**)
> comment blocks but do not describe their parameters with @param
> tags.This emits warnings when building
> with extra warnings enabled (make W=3D1), for example:
> kernel/power/snapshot.c:469: warning: Function parameter or member
>     'zone' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or member
>     'gfp_mask' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or member
>     'safe_needed' not described in 'add_rtree_block'
> kernel/power/snapshot.c:469: warning: Function parameter or member
>     'ca' not described in 'add_rtree_block'
>
> These are file-local implementation details, not part of the
> exported kernel API documented under Documentation/. Replace the
> kernel-doc markers with plain block comments for the affected
> functions.
>
> Properly documented symbols such as
> alloc_rtree_node(), snapshot_read_next() and snapshot_write_next()
> remain unchanged.
>
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  kernel/power/snapshot.c | 42 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index a564650734dc..552958f58359 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -458,7 +458,7 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_=
mask, int safe_needed,
>         return node;
>  }
>
> -/**
> +/*
>   * add_rtree_block - Add a new leave node to the radix tree.
>   *
>   * The leave nodes need to be allocated in order to keep the leaves
> @@ -528,7 +528,7 @@ static int add_rtree_block(struct mem_zone_bm_rtree *=
zone, gfp_t gfp_mask,
>  static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
>                                int clear_nosave_free);
>
> -/**
> +/*
>   * create_zone_bm_rtree - Create a radix tree for one zone.
>   *
>   * Allocated the mem_zone_bm_rtree structure and initializes it.
> @@ -566,7 +566,7 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree=
(gfp_t gfp_mask,
>         return zone;
>  }
>
> -/**
> +/*
>   * free_zone_bm_rtree - Free the memory of the radix tree.
>   *
>   * Free all node pages of the radix tree. The mem_zone_bm_rtree
> @@ -678,7 +678,7 @@ static int create_mem_extents(struct list_head *list,=
 gfp_t gfp_mask)
>         return 0;
>  }
>
> -/**
> +/*
>   * memory_bm_create - Allocate memory for a memory bitmap.
>   */
>  static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
> @@ -720,7 +720,7 @@ static int memory_bm_create(struct memory_bitmap *bm,=
 gfp_t gfp_mask,
>         goto Exit;
>  }
>
> -/**
> +/*
>   * memory_bm_free - Free memory occupied by the memory bitmap.
>   * @bm: Memory bitmap.
>   */
> @@ -736,7 +736,7 @@ static void memory_bm_free(struct memory_bitmap *bm, =
int clear_nosave_free)
>         INIT_LIST_HEAD(&bm->zones);
>  }
>
> -/**
> +/*
>   * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
>   *
>   * Find the bit in memory bitmap @bm that corresponds to the given PFN.
> @@ -988,7 +988,7 @@ static void memory_bm_recycle(struct memory_bitmap *b=
m)
>         }
>  }
>
> -/**
> +/*
>   * register_nosave_region - Register a region of unsaveable memory.
>   *
>   * Register a range of page frames the contents of which should not be s=
aved
> @@ -1305,7 +1305,7 @@ static unsigned int count_free_highmem_pages(void)
>         return cnt;
>  }
>
> -/**
> +/*
>   * saveable_highmem_page - Check if a highmem page is saveable.
>   *
>   * Determine whether a highmem page should be included in a hibernation =
image.
> @@ -1362,7 +1362,7 @@ static unsigned int count_highmem_pages(void)
>  }
>  #endif /* CONFIG_HIGHMEM */
>
> -/**
> +/*
>   * saveable_page - Check if the given page is saveable.
>   *
>   * Determine whether a non-highmem page should be included in a hibernat=
ion
> @@ -1440,7 +1440,7 @@ static inline bool do_copy_page(long *dst, long *sr=
c)
>         return !z;
>  }
>
> -/**
> +/*
>   * safe_copy_page - Copy a page in a safe way.
>   *
>   * Check if the page we are going to copy is marked as present in the ke=
rnel
> @@ -1687,7 +1687,7 @@ static unsigned long preallocate_image_highmem(unsi=
gned long nr_pages)
>         return preallocate_image_pages(nr_pages, GFP_IMAGE | __GFP_HIGHME=
M);
>  }
>
> -/**
> +/*
>   *  __fraction - Compute (an approximation of) x * (multiplier / base).
>   */
>  static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
> @@ -1982,7 +1982,7 @@ int hibernate_preallocate_memory(void)
>  }
>
>  #ifdef CONFIG_HIGHMEM
> -/**
> +/*
>   * count_pages_for_highmem - Count non-highmem pages needed for copying =
highmem.
>   *
>   * Compute the number of non-highmem pages that will be necessary for cr=
eating
> @@ -2003,7 +2003,7 @@ static unsigned int count_pages_for_highmem(unsigne=
d int nr_highmem)
>  static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { r=
eturn 0; }
>  #endif /* CONFIG_HIGHMEM */
>
> -/**
> +/*
>   * enough_free_mem - Check if there is enough free memory for the image.
>   */
>  static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highme=
m)
> @@ -2023,7 +2023,7 @@ static int enough_free_mem(unsigned int nr_pages, u=
nsigned int nr_highmem)
>  }
>
>  #ifdef CONFIG_HIGHMEM
> -/**
> +/*
>   * get_highmem_buffer - Allocate a buffer for highmem pages.
>   *
>   * If there are some highmem pages in the hibernation image, we may need=
 a
> @@ -2035,7 +2035,7 @@ static inline int get_highmem_buffer(int safe_neede=
d)
>         return buffer ? 0 : -ENOMEM;
>  }
>
> -/**
> +/*
>   * alloc_highmem_pages - Allocate some highmem pages for the image.
>   *
>   * Try to allocate as many pages as needed, but if the number of free hi=
ghmem
> @@ -2065,7 +2065,7 @@ static inline unsigned int alloc_highmem_pages(stru=
ct memory_bitmap *bm,
>                                                unsigned int n) { return 0=
; }
>  #endif /* CONFIG_HIGHMEM */
>
> -/**
> +/*
>   * swsusp_alloc - Allocate memory for hibernation image.
>   *
>   * We first try to allocate as many highmem pages as there are
> @@ -2292,7 +2292,7 @@ static void duplicate_memory_bitmap(struct memory_b=
itmap *dst,
>         }
>  }
>
> -/**
> +/*
>   * mark_unsafe_pages - Mark pages that were used before hibernation.
>   *
>   * Mark the pages that cannot be used for storing the image during resto=
ration,
> @@ -2330,7 +2330,7 @@ static int check_header(struct swsusp_info *info)
>         return 0;
>  }
>
> -/**
> +/*
>   * load_header - Check the image header and copy the data from it.
>   */
>  static int load_header(struct swsusp_info *info)
> @@ -2483,7 +2483,7 @@ static int prepare_highmem_image(struct memory_bitm=
ap *bm,
>
>  static struct page *last_highmem_page;
>
> -/**
> +/*
>   * get_highmem_page_buffer - Prepare a buffer to store a highmem image p=
age.
>   *
>   * For a given highmem image page get a buffer that suspend_write_next()=
 should
> @@ -2706,7 +2706,7 @@ static int prepare_image(struct memory_bitmap *new_=
bm, struct memory_bitmap *bm,
>         return error;
>  }
>
> -/**
> +/*
>   * get_buffer - Get the address to store the next image data page.
>   *
>   * Get the address that snapshot_write_next() should return to its calle=
r to
> @@ -2843,7 +2843,7 @@ int snapshot_write_next(struct snapshot_handle *han=
dle)
>         return PAGE_SIZE;
>  }
>
> -/**
> +/*
>   * snapshot_write_finalize - Complete the loading of a hibernation image=
.
>   *
>   * Must be called after the last call to snapshot_write_next() in case t=
he last
> --

Applied (under a modified subject) as 7.3 material, thanks!
