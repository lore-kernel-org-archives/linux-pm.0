Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD9246778
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135550; cv=none; b=Kwe6JNbmJ6QEqbZ3RqRz/qhb8Ng/v//vzZfNZuP1UcE17CCCwyB3fF2aetxBTTmdzeLPCMVWcFnHQjmbMS1kCuh/Kj4asQIiY6xFYgkeBTvCjNqtp99l3bw7lZbc9boQ3YyXktBGkLca8kVr1i4KVApjYNlt509/xGDPLLofe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135550; c=relaxed/simple;
	bh=k7NDarGQBY1roZevuE8hMj8jzk5fqXmdOWpP7ukAGUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6KWFTVSuqcHJWhy9g4LF3vvLOlJzLTQ1Mh4tU+5IytNofRzXFpdNRfr82g/N8lXh0QDlJfnHUwXqtrL5LoOGU14Cqb1D5LYt+jH5R3VDhAW8YIYhk4vq3s9Cq54LLT7oIhLO1tcusovD13u+UpwCMkBHFqbPFY4dN9ZkFTfEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIN4yIvo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIN4yIvo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6d28aa26cso4859545ad.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791135548; x=1791740348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6hJVS5+jE0uXV92n3fYslDINcPr4GX7oGIj8l2+wqvM=;
        b=UIN4yIvoXGkZvshxfRAYX8ynUTpkJeQf+nOnRo+Wim/RSTOfhqFKsu4ptaOY0Yrncb
         baHecusFN7v1Dm4jtyWZdAkAjNdhsRD118MRGZrkGW5quNlfSbtghWO1QXOeiSOOStdx
         eV47QHgXiCIuv4kUOarSEpdnJ8NogCyjK83hBCHrxeg7+6RsBwQCdY/KUOFADPuyhZE4
         PjEpWz1uyhX/srDDXG5dTRXnM9/Df6jT5+gi03ZchR2NDhMTtqrRwcq5VUHVVZmSBzue
         ZKGhEEyc5PtBZXbEOaX47oBVLyzi7hlltnRTkty989Kmstf94+M2j/Q68ia6isUaAYy2
         S3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135548; x=1791740348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6hJVS5+jE0uXV92n3fYslDINcPr4GX7oGIj8l2+wqvM=;
        b=QhGGr+8nSdaGgyrAns9gy9QYA0dYK2tkn2wK8z4XVKMu9wZ1m7lK22ouBWDs3Fiv7j
         yKiEK5DTwsHDCGTo+8+4zNb7dvsPDIpaWiwefkKdsoL8FExqdjQ+s3hYe27Wx7egASvV
         MX3c0blUiNNitcKNZ7h4KjUxgIO9VxSJRDbu0SCnZ0S1bIW20+DEggIgKWDGhqxij35i
         1WEcqe5Qc3seVhyggFQFjSatbrnWRr6SMyNwewteuOFPDpF+D7kQf/P1Sg7ZiOg5p6Vk
         2YeDiZA8CBIPvbRXFViupyW5eBXs5I7gTayhUfQF+7/OPM306eYocegzJtGd04Q1IP2S
         oCTA==
X-Forwarded-Encrypted: i=1; AKwUvBxaclFv9bdlh4R/viq72i83Kk6bFJzB29VLts+ood/TMH8s0YsB7nZfWMAYKiU6wcWGUJcCFMnXyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+wr18xSpcoCaFRRf02G+7dUF2HFLO75b1OYeibIdJLWPqEODw
	qv9lYwhcp/gEEVHPPUKzs45TK/4+s9UmsJe/oUV6sCt72H5OFZXrMysx
X-Gm-Gg: AYBFou2mN+wTNLv9xAAB2eAp5+gB5a7nkNyEAw5svTBUpLWMH4ZRKwgf9nZlc3niIeW
	Wp0kya3W11tBuoisn1mMu+11ZJjqgqWVSJbrUStLhNt3GdZi1Mh+eCL5X4Iv/fD+R6qAHky+mTO
	9OASf89HJiUYW+o225XclU9u2ZPO9W/MAFXsTSjUetMUyLsaBsIM1tNOpJ8spWqXV58pzI1SW2q
	XkUqJ7HNKGcK6hFgOboz7feuax78znxspgL4p88kBavMeK4AeIUuL0ksAYCW531XYNCPpe2Je+C
	mVCRXLMpd2I2vyKuWoXhsC+X0MUnQrrztZNwCyQlTxjORFMedDm3jgBNZWJylAAgjWYCWkUm9bB
	lPJtmjrEK8eVW0uFl/Ppw6MSCaa2SViQB6E/zhZMtE/3xFg1EQTua4lV4BFwMEZpDopb5YyYVgF
	eypE9iYi9OqlhLsMhbFJcu6fYQ0IfIv6/M9ZbbhjGBGJxnylr1ur6B8FMwrJ82j612eSOxhekpm
	iabj4YWj2/t4IvbroapFsdLvTL7kZkfZ90d6pKoNQ==
X-Received: by 2002:a17:902:cf03:b0:2e5:33a5:36ec with SMTP id d9443c01a7336-2e533a538b5mr43880885ad.4.1791135548480;
        Sun, 04 Oct 2026 10:39:08 -0700 (PDT)
Received: from gmail.com ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6fe249sm24473095ad.61.2026.10.04.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:39:07 -0700 (PDT)
Date: Mon, 5 Oct 2026 02:39:03 +0900
From: Youngjun Park <her0gyugyu@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, taejoon.song@lge.com
Subject: Re: [RFC PATCH 00/10] mm/swap, PM: hibernate: improve image slot
 allocation and I/O
Message-ID: <asKPN6X_Rs5h8n3N@gmail.com>
References: <20260915031658.1505680-1-youngjun.park@lge.com>
 <aruGQpdsq7_O-AC8@KASONG-MC4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aruGQpdsq7_O-AC8@KASONG-MC4>

> Hi Youngjun
>
> Thanks for the patch!

Hi Kairui,

Sorry for the late reply. I was away on a family trip.

Some of your questions and points need more thought, so I'll follow up
on those once I've reached a conclusion.

> Splitting out the hibernation specific part out of swapfile.c
> looks a good idea to me. We can then compile that file conditionally
> rather than having a huge ifdef block in swapfile.c.  Would be nice
> to get more feedback from hibnernation side.

Ack, I will keep going that way. :)

> That's pretty nice indeed. But I'm a bit concerned about having a
> specific cluster isolation path for hibernation.
>
> Will it be cleaner to provide a more generic cluster sized
> allocation (PMD sized) so common swap can benefit too?

I am still thinking about it. For now I am not sure what common swap
would gain. The gain would be mostly cleanup, e.g. the allocator would
no longer treat an allocation without a folio as hibernation.

> And I'm not sure is IO batching working properly before?

It depended on the case! Before this series the image is written with
a bio per page, and the block layer merges them back only while the
slots are contiguous. They are not always contiguous. Two cases come
to mind.

  1. The image shares the per-CPU cluster with other swap-outs on that
     CPU, so their slots can fall in between.
  2. When nonfull clusters have holes, the image fills the holes first.

When these happen often, batching does not work well.

And plus, on this RFC I manually collect bio before submit.
batch will work well from this patch as I think.

> How much performance gain is due to the cluster sized IO?

By cluster sized IO, do you mean the batched I/O of patches 7 and 8?
Sometimes it is cluster same sized, small sized and bigger sized(little situation maybe).

If so, allocator + bio cut the write time by 18 to 25% and the read
time by 11 to 20% in the cover's tests. The large contiguous I/O is
also friendlier to flash as I think

> But if other appraoches won't work or hibernation is really
> special, and we can keep all the hibernation tricky clean and
> simple in just one place, maybe it's not too bad.

Since you prefer the common swap code, I will try it in the existing
allocation path and compare it with the current swap_hibernate.c
approach. I will come back on this with the next series.

> > Note.  [3] gives hibernation slots their own swap table entry, keeps
> > readahead off them, and frees them by offset alone.  The single slot
> > path of patch 5 builds on that.
>
> Nice, maybe that series need a refresh to get merged first.

Yes, I will refresh and resend it soon. :)

> > 2. Whether the reservation in patches 9 and 10 is worth keeping.  It
> >    makes sure the image gets contiguous slots when swap has room to
> >    spare.
> >
> > 3. A block device of its own for hibernation instead of swap.  Not
> >    taken for now.  Sharing one device keeps the spare space useful, the
> >    existing infrastructure stays, and the ideas above give much the same
> >    effect.
>
> So is the idea for 2 and 3 here to make sure hibernation always success by
> avoid the allocator using too much for common swap?
>
> We only want one of them I think, and we need to be careful here to not
> make the maintainance messup by adding too many knobs...

Yes, that's right. Both keep space for the image that normal swap
cannot use, so hibernation has room and gets it contiguous. I agree we
only want one. 3 looks like too much to me, so I would like comments
on 2.

> > 4. Whether the extent tree can go.  A normal hibernation never walks
> >    it, the swap state comes back as it was at the snapshot.  It is only
> >    walked to free the slots after an error or a wake from hybrid sleep.
> >    With the slots marked in the swap table [3] and taken as whole
> >    clusters, a free could find them without it.
>
> The extent tree is not a hibernation issue right? At least for block based
> swap the extent tree is useless (only one node). I think swap_ops can be
> used to make this limited to certain swap_ops (e.g. file swap ops).

To clarify, item 4 is about hibernation's own tree, swsusp_extents in
kernel/power/swap.c, not the swap device's extent tree. It records the
image's slots so they can be freed later.

> And maybe, the swap_ops can provide some interface for hibenation usage to
> make things cleaner?

I need to think more about swap_ops here. Nothing concrete comes to
mind yet.

> > 5. Whether SNAPSHOT_ALLOC_SWAP_PAGE should refuse a request made before
> >    storage is suspended.  Such a request gets single slots from the
> >    normal allocator today, and s2disk only asks after
> >    SNAPSHOT_CREATE_IMAGE anyway.
>
> Is that a even a right thing to do during hibernation?

Sorry, I don't quite get the question (intention). Could you clarify it?

> > 6. Two cases are not measured yet.  A device with both a shuffled free
> >    list and partly used clusters.  An image bigger than the free
> >    clusters, so part of it comes from nonfull and frag clusters.
>
> I think that's fine, free cluster shuffle should not effect the
> performance much as 2M is a pretty big IO unit. For the
> fragmentation batching IO should be very helpful.

You are right. I listed it only because it is the worst case for the
long runs this RFC builds. For the I/O, cluster sized runs are enough.
Longer runs mainly help the allocator, which can then hand out more
slots at once.

Thanks!
Youngjun Park

