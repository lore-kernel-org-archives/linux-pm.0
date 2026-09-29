Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DB391E76
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702763; cv=none; b=J6DELd9MhV51U89INA+yd4HsaIhRzelrFh+wZ+jGsrORxSvZI/T7mKSD0S5rue2aZRm8T8UWpIPTbJ+6AJmBrYtjCNQ8lyT9k9SadNrAbhfNnefj1eqApETcT7yP1PqrFLawr09QvvNcreIvOk6fzZM/MzQGfXbSewTFEEnbqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702763; c=relaxed/simple;
	bh=mkfBiCMpwWCDcgy4prnMcLNrL6MWyBNP1gJn2fbsPok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUTMv76I8m2vRGLna3YpylIvM67RB3rqJSS2yO1c9N4mCtq6nH7CZ9GpUMOhNT7ye+MUERI36IJIB6S2e90dJ0J3CEgfG72OCw/bwE+1chyzq1TWQt3wOtG0oLiXdBphsTuUkia8Y8lbUsHrPRgWs3ZWpwaLpLC/LM1B+hfAUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzmhBLjJ; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzmhBLjJ"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d2bbcab2so2895955ad.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790702761; x=1791307561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6jepSVcmHm+oxwGNgqeKz9lXh7Z2Z4id6g1VGOo8Vc=;
        b=YzmhBLjJ278BJHpWtTeDyMguKjUFwEztZB7W8JI4HE3Edt/308SRL9JIpuVsyA3Jej
         WR9AWjVXFyu7hCrOi9+3OpYoTbXrozTcfF0sZ/NThdwzI0ngrhSTEk7aP6XeX6/7+dF9
         yJVTr12Mo71ZJlSjl25DK/2/6QLFgbKkCbqsqgQpaqN9U0O5YMWuD//2/AdyImMTg1Ia
         ZG/Otr4rL9VzcfGhNEephC6qgrHVdKCi/IrV8hoDkiCq3bLNzNe8eKDm7Cq+l9RJzEA6
         ypWHvjj/xRxx0tyYj4MioSX9VCqxsyXUD+pnptKxq6rKKLNnims8tNeaExuh4M5xax5C
         QNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702761; x=1791307561;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6jepSVcmHm+oxwGNgqeKz9lXh7Z2Z4id6g1VGOo8Vc=;
        b=qZjoqXoOuOL/204pyYoF/1rKiLYNCIXO9MVmn1YFr37VhQHrgKTTNQH8FIMWq0mKMd
         SDKElv8Wr6+NAB/ZbmnX2eEJQF9mKxFgp/jdET+h85N/OAjBjkGqiMjs8JQq+xLzqqDt
         DL9rj2sSlg9/GZTbfQDrTWA+Y9MT0048WN77kpB6VbFQEYBL9ekMVibyvpFDSE8hDEEV
         MaqUSuMHcyd96PxdNmo6x0sQYq7sYTVWO111Xbmy5UdC1dsXk5rRImeTbGxChYn16qSE
         mwPhW9UJGPWhLMle2OAY1xlaw6PwHTg5nMcdHR2w6zLIJ/1tHN7E/67jelQWpCxS+/ud
         Sw2A==
X-Forwarded-Encrypted: i=1; AKwUvBz8fq0Nt8ySL/mZg5CFxn3yG0Q9Xl+OkfhwCb3Aop008oNUMYeRrcX6VdT74gRO1HSewV08DPxj7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJFJul0DoLpogxj/5xL8vxfJX7v4BsDXXdKotmnISjnDOntyhY
	kr7FW8qcYHgM0e/HTHYL3u8FL9or7XDkWd6ZC6Ll1kiRaDslKOLOsni0
X-Gm-Gg: AYBFou0q1GHm0fqqkOyiQWSTFuD48o7zhFGfmh9nlIOpIHTVKafdWNDOu7r6MBT2jWX
	n7t/0V39iE+TTnh93eopQ/AsS6oaQ4/eJS5DvH4BdSzNPEtBbdrIKfdXMcIGGKwpXroChp/HVJE
	AS/i9jhn00icudvzhx+7RVFjslraRIyvSp+9ZPNJJ0S03I6v1cGM3l/5RKAhQLKTOZnthRZpQSY
	5MuNMCPKE1es083uwXRhLsJhj527U8Bi3wDJ69Lvxeq6an10aSilaKLHnbJSiWOqlRsLX2GmyaG
	TbgkZGhNoLwbhCbhf2WBC8koI9phm+1RlQzo+vMjGWJCU4/2DTPOSUTDg3Y3Nnn8yBbTrNKgjA1
	vTdVlMvSporI/9Ws9TNMnvJfe+rRUCjJwtdhcw3c3wB7Ak5+x5Z0OEPxqJ8bgI+oCkwLX4fPBxz
	pR0TRhxeQS12C2ErhiQnYNw9yfe1M7N8wp/nUKu6iZj/UTK9BvcDkuec9feQK6jezpbjjm29TYm
	JaKv31grKHbrucYReSpof9H7Lp1tDDJJ6KYXK+L
X-Received: by 2002:a17:903:38cc:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2e2aa174e56mr51304225ad.58.1790702761038;
        Tue, 29 Sep 2026 10:26:01 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9143a3aasm60994385ad.53.2026.09.29.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:26:00 -0700 (PDT)
Date: Wed, 30 Sep 2026 01:25:54 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, her0gyugyu@gmail.com, 
	taejoon.song@lge.com
Subject: Re: [RFC PATCH 00/10] mm/swap, PM: hibernate: improve image slot
 allocation and I/O
Message-ID: <aruGQpdsq7_O-AC8@KASONG-MC4>
References: <20260915031658.1505680-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915031658.1505680-1-youngjun.park@lge.com>

On Tue, Sep 15, 2026 at 12:16:48PM +0800, Youngjun Park wrote:
> This series improves how hibernation allocates swap slots for its
> image.  It starts from a few observations about what happens while
> the image is written.  With them the allocator can hand the image
> contiguous runs, the image I/O can be batched per run, and
> hibernation gets faster. Contiguous I/O pattern is friendly to flash device also.
> 
> Slot allocation matters for hibernation speed.  After commit
> 0ff67f990bd4 ("mm, swap: remove swap slot cache") in v6.15, writing
> the image was about ten times slower on some SSDs [1], until
> commit 396f57b57200 ("mm, swap: speed up hibernation allocation and
> writeout") fixed it in v7.1.
> 
> Note
>  - I was responsible for the observation and design, 
>  while receiving substantial support from LLMs throughout the series.
> -  Submitting this patch to confirm whether this work is progressing or not.

Hi Youngjun

Thanks for the patch!

Splitting out the hibernation specific part out of swapfile.c
looks a good idea to me. We can then compile that file conditionally
rather than having a huge ifdef block in swapfile.c.  Would be nice
to get more feedback from hibnernation side.

> 
> Observations
> ============
> 
> 1. While the image is written, swap can only hand out slots that are
>    already free.  Swap cache cannot be reclaimed to make more.
> 
>    folio_swapcache_freeable() refuses every folio while storage is
>    suspended.  The image may already hold a folio as clean swap cache.
>    If its slot were freed and reused for the image, the resumed kernel
>    could later drop that folio and read it back from the slot, now
>    with the wrong data.
> 
>    Storage is suspended before the image is written, so every
>    allocation for the image falls in that window.
> 
>      hibernate()
>        freeze_processes()                user space is frozen
>        hibernation_snapshot()
>          freeze_kernel_threads()         kswapd is frozen
>          hibernate_preallocate_memory()  may swap out to shrink memory
>          pm_restrict_gfp_mask()          storage is suspended from here
>          create_image()                  the snapshot is taken
>        swsusp_write()                    image slots are allocated here
>        power_down()

...

> 2. Image slots are not freed and reused while the image is written.
>    And whatever the allocator changes during the write is gone at
>    resume, because the resumed kernel is the snapshot.
> 
>    With observation 1, once the image owns a free cluster it can use
>    all of it.  Nothing has to be recorded per slot, neither in the
>    swap table nor as a memcg id.

That's pretty nice indeed. But I'm a bit concerned about having a
specific cluster isolation path for hibernation.

Will it be cleaner to provide a more generic cluster sized
allocation (PMD sized) so common swap can benefit too?

And I'm not sure is IO batching working properly before?
How much performance gain is due to the cluster sized IO?

But if other appraoches won't work or hibernation is really
special, and we can keep all the hibernation tricky clean and
simple in just one place, maybe it's not too bad.

> 3. User space and kswapd do not swap out while the image is written,
>    and allocations from the page allocator cannot start swap I/O.
>    What is left is rare.  DAMON pageout and the memcg high work can
>    still reach swap(This is all I found. anything else?), 
>    and both were seen running in that window.
> 
>    So the allocator can favor the image then.  Other users take slots
>    from the nonfull and frag clusters and leave the free clusters to
>    the image.
> 
> With these the allocator gets simpler and faster, and batching the
> image read and write becomes easy.
> 
> What the series does
> ====================
> 
>   1-2    fixes, a slot leak after a failed test_resume and a NULL
>          dereference for a swapfile with no block device (some bug fix)
>   3      move the hibernation code to mm/swap_hibernate.c (refactor)
>   4      skip swap cache reclaim while storage is suspended (optimization)
>   5-6    hand the image whole free clusters, in disk order (exploit contiguous space)
>   7-8    write and read the image one bio per run (batch I/O)
>   9-10   optional reservation at swapon, hibernate=reserve (assure contiguous space)
> 
> Based on mm-new (383fc05d4650) with patches 2 to 4 of [3] under it.
> Patch 1 of [3] is in mm-new as 10d9012e83ef.
> 
> Note.  [3] gives hibernation slots their own swap table entry, keeps
> readahead off them, and frees them by offset alone.  The single slot
> path of patch 5 builds on that.

Nice, maybe that series need a refresh to get merged first.

> 
> Results
> =======
> 
> Setup
>   - qemu, 12G RAM, 4 CPUs, no KVM.  Times only compare against each
>     other.
>   - swap on virtio-blk as a non-rotational device
>   - image 5.0G, written with hibernate=nocompress
>   - 3 reps of two hibernations each.  Times are medians of the 4 to 6
>     samples per cell that no host load hit.
>   - base is patch 3 and allocates as mm-new does, allocator is
>     patch 6, allocator + bio is patch 8
> 
> Rows.  runs is how many contiguous stretches of the device the image
> ends up in.  bios is how many bios the kernel allocates and submits to
> write it.  In both cases the image fits in free clusters, so the
> fallback to nonfull and frag clusters is not measured.  Percentages
> are against base.
> 
> Shuffled free list.  A device that has been in use, emptied.
>   - 6G swap, 5.4G of 2M tmpfs files swapped out, then all removed in
>     random order
>   - every cluster is free, the free list is in free order, not in
>     disk order
> 
>                         base       allocator   allocator + bio
>   write, s             10.60     9.32 (-12%)       7.94 (-25%)
>   read, s               9.15     8.92  (-3%)       8.10 (-11%)
>   runs                  3560               1                 1
>   bios                 1.30M           1.30M             12.7K
> 
> Holes in nonfull clusters.  What taking free clusters first buys.
>   - 12G swap, one 4G file swapped out, every other 64K of it freed
>   - 2G of 64K holes in 2048 clusters, 8G of free clusters
>   - mm-new fills the holes first, the series takes the free clusters
> 
>                         base       allocator   allocator + bio
>   write, s             10.69    10.07  (-6%)       8.81 (-18%)
>   read, s              12.21    10.89 (-11%)       9.78 (-20%)
>   runs                 31899               1                 1
>   bios                 1.30M           1.30M             12.8K
> 
> Summary against base
>   - the allocator cuts write time by 6 to 12%
>   - allocator + bio cuts write time by 18 to 25% and read time by
>     11 to 20%
> 
> These are VM numbers without compression.  Compression, the default,
> and real hardware are still to be checked.
> 
> Next steps
> ==========
> 
> Things to keep working on after this RFC.  Comments are welcome.
> 
> 1. Dropping swap cache before hibernation starts, so more slots are
>    free.  This series does not do that.
> 
> 2. Whether the reservation in patches 9 and 10 is worth keeping.  It
>    makes sure the image gets contiguous slots when swap has room to
>    spare.
> 
> 3. A block device of its own for hibernation instead of swap.  Not
>    taken for now.  Sharing one device keeps the spare space useful, the
>    existing infrastructure stays, and the ideas above give much the same
>    effect.

So is the idea for 2 and 3 here to make sure hibernation always success by
avoid the allocator using too much for common swap?

We only want one of them I think, and we need to be careful here to not
make the maintainance messup by adding too many knobs...

> 
> 4. Whether the extent tree can go.  A normal hibernation never walks
>    it, the swap state comes back as it was at the snapshot.  It is only
>    walked to free the slots after an error or a wake from hybrid sleep.
>    With the slots marked in the swap table [3] and taken as whole
>    clusters, a free could find them without it.

The extent tree is not a hibernation issue right? At least for block based
swap the extent tree is useless (only one node). I think swap_ops can be
used to make this limited to certain swap_ops (e.g. file swap ops).

And maybe, the swap_ops can provide some interface for hibenation usage to
make things cleaner?

> 
> 5. Whether SNAPSHOT_ALLOC_SWAP_PAGE should refuse a request made before
>    storage is suspended.  Such a request gets single slots from the
>    normal allocator today, and s2disk only asks after
>    SNAPSHOT_CREATE_IMAGE anyway.

Is that a even a right thing to do during hibernation?

> 6. Two cases are not measured yet.  A device with both a shuffled free
>    list and partly used clusters.  An image bigger than the free
>    clusters, so part of it comes from nonfull and frag clusters.

I think that's fine, free cluster shuffle should not effect the
performance much as 2M is a pretty big IO unit. For the
fragmentation batching IO should be very helpful.
