Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662413368BB
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365243; cv=pass; b=Z9R7Vq9hyThSrU7F0NFWcRyHMjpkFQoQdCfg2KwIXJWb5N3tPRB2iXPhSqJZNdyHhj+vPa3FOGgleMtYBihtxb1gIwlMyHRAYTdOIcxHvXn9ALkMdkn0Lp9w+Rvx6DJXYaCkBY2DvVdJ3eG7k9i2HZmqhBO501WZgKOBd6lzm4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365243; c=relaxed/simple;
	bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORxLBKIVjHSlFMzae/rPR4GQq139C9u1di9JZT7KtK/w96Ot3E4dR+xaioIHkQ+3zjs6O8E7DAjmWFqasL/LNX5LsvtmYXwlCE9xXVumGyJDBrFkgEWadlU6pYXUR3FwUhmQiKEkjmlDO7AB5iL1hSmHvtWevJsljfO5LwnWnUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS2JxY6A; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS2JxY6A"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso10962226a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 11:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365241; cv=none;
        d=google.com; s=arc-20240605;
        b=hBTkCMv8+oJRmJ4rMiKcdoUwLxykPOm/szDJE9kV6ZMtrCfYf6+yr9Qyw1GkbdK5qj
         as2hTocDky5oCSlywCIewWkCK7j2GmoqMkxTjjzJacc8m51nlkZyWMncCCwPWsKe8DEI
         rguh2N796Mhw76N8LrP3sZlOuSaMS1SOHoHDa7jaS044q29EUawOn+guGgZIJw0yLlXQ
         yDuTRSdZG+wQVaYah6kcgN8yFNkL4C1KHCgZN+4OIGE10NO5cgJGTDssLid6HCBcz+Pl
         K1/ndmxRFQqxjGukb4y5IO3a7M3JZjY5H7x/HLa5BtIaC8RLatqizwvW7Djt8NEgjI3A
         yVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        fh=shcLoDT+k6j2ioUF0Xkwlv944V0fxtxXfrijX8J5wZA=;
        b=WQyF7uxgDpWU800oXLGmx7jk/DkRsBWsVTIWP9ajudXxgpsZecFaV5s0rkXGkSU+84
         RsD77taKsvBKB+Qy7FyEpy13bwGhKiznBwbbc+xVNh2ok5e8I1narb4WCja7Wz3XLgCE
         pND4MWaLpCMut5exC7M9Eq/Eh3oxNNePmN9OAfaTSYnUiioDsyP4rBZ7zK1Irwa+9uDX
         oihqUGGq+55D79g5pkpRm1i8qtQKC2+wOzvU2A/Cp/KP6ibBzfp5eITQ7yR52wWRYte6
         081/fpkMV9MwOS+ykSpyvhHQIuADPxO5nCK572wrCj5vIWbV24SMAnllUPuYFCzuYXCv
         OWAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365241; x=1776970041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        b=AS2JxY6AqH78LVAAiyxMbMhBYBAA1WfWIdagz413k3sjQv5uvHoY4/I1fOx6K5kVRS
         iki/0jo/s2DQdF36k1ouFk7Izut/dxJWqN3ggoej+VZzeaNphDL9FDZaKbywTHh7o3r+
         8+KBoNbUiMjsgoAN/6YPbSKxrqEsvwhww2otklYuyN367Z9ZJUtTvBQpNTmxJaa4Jlck
         Nq3HJ7J4VGcRkRsfFWabc247+Z8RLhbOJMG3a/NqXM/b0jvsLekYYIdtaKJEwyyPkPoq
         Q2KqFTFDZXgUSoqvrfM2jMYJQTVzql2nYM+ee0C4dk1D9XT1oQBkiCO/OusfKEDnb5i9
         VvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365241; x=1776970041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        b=URz8gnkNh2t+xtRgeeDVpAbfNWoB4T9dDlsg5brGVXnChAqjuXymX+dHw8tiFHhQ7d
         9VKKQD3eiNWFUJe7m83TciPCHAbl/WJ12gTB5f1cp7nKtpzRKf3Wpg3x5a5p6BF7B1Iv
         nyw4HbwyopJ8XKm11vV0UVnoqC2yWWDvW5Jg5lvRJOBN1K6iMmxTWm1Hod2y4Bq9FwR8
         8T3Rvqgf6MJPPzj4k1b78e2uac/MVpFUQHnmaWYLMw7UvZg8eaoM3VMCgCzoVYY72ZCF
         FHBvt/k2HuLNOYc4opv4XVFMbBVnksWGU9UZzk8IfdgI2pXsD2PJzBXw22Y9aCUzJJ0e
         tQVg==
X-Forwarded-Encrypted: i=1; AFNElJ9zRKw8bZLIxiOctHO6BC1yVwKRZjrsWLCqx0DZHOL+Gef1akONu8LrJEjxm9SMvKYpUwInDYlcnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbegNFdTnWP+BUcBclk+DrdfeJn7ksuagLffa8Gv340Z35Yi0Y
	jGgMFuec7Zwzq3f3KURkhQODzHstP9JYugYCdIr1s2YL/v7sqx5onGyKtV4UwMJXMqk0Y351Sh9
	Q/tfTGAprUAbpuw12WMuChYQ/KoJjA5I=
X-Gm-Gg: AeBDiethi+Uw+mZ3rT8HLSHXaiC+DwAnYQe/ACRWqtGeQ7X3i+zsPxS9iVqcIiAO+l/
	2fPohUew9U0fWZoWRt8862eSdtMtMm5jnpV8E1CKdDO3H5rWtydXO/rxjVVKlb/DHK9+/kooQOp
	QINnCIw24Xe6FOyJdBW9jOyCPPOjUT6HEKH1akiY2nIbYwW+F6XmXM7aU6K4QvyEqvNI/x0INhl
	zIguG6+/BtF30eOoQLorK1bhSB5NJxsaDz3zp+qHpiSWo6qu+YWGeQhboszlV3u/gbawrBXyfhC
	QQeQe7eUh8bzxhbrQ6HV/8/JIiWmzzFvRBqEpseV5AVFpv58lkY=
X-Received: by 2002:a05:6402:3513:b0:670:8b30:a8a7 with SMTP id
 4fb4d7f45d1cf-672bd216aefmr183464a12.0.1776365240497; Thu, 16 Apr 2026
 11:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
 <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com> <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
In-Reply-To: <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 17 Apr 2026 02:46:42 +0800
X-Gm-Features: AQROBzCEgUiZi2O6FzTs1ms_GwJiz6hkD3Or1x7kVqF5Vc65bqWpNQK9z7Fsc8M
Message-ID: <CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyzVOKE14-O+Dw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 1:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
> Hi Kairui,
>
> My apologies if I missed your response, but could you share with me
> your full benchmark suite? It would be hugely useful, not just for
> this series, but for all swap contributions in the future :) We should
> do as much homework ourselves as possible :P
>
> And apologies for the delayed response. I kept having to back and
> forth between regression investigating, and figuring out what was
> going on with the build setups (I missed some of the CONFIGs you had
> originally), reducing variance on hosts, etc.
>

Hello Nhat!

No worries, I was also thinking about submitting some in tree test for
that so testing will be easier, but got really busy with some other
issues, series and the incommong LSFMM, will find some time to do
that.

>
> 1. Kswapd is slower on the vswap side, which shifts work towards
> direct reclaim, and makes compaction have to run harder (which has a
> weird contention through zsmalloc - I can expand further, but this is
> not vswap-specific, just exacerbated by slower kswapd).

It might be related, e.g. could the dynamic alloc and RCU free of
vswap data cause more fragmentation hence more pressure?

> 2. Higher swap readahead (albeit with higher hit rate) - this is more
> of an artifact of the fact that zero swap pages are no longer backed
> by zram swapfile, which skipped readahead in certain paths. We can
> ignore this for now, but worth assessing this for fast swap backends
> in general (zero swap pages, zswap, so on and so forth).

Hmm... That just brought up another question, you can't tell the
backend type or properly do readahead until you look down through the
virtual layer I guess?

> I spent sometimes perf-ing kswapd, and hack the usemem binary a bit so
> that I can perf the free stage of usemem separately. Most of the
> vswap-specific overhead lies in the xarray lookups. Some big offenders
> on top of my mind:
>
> 1. Right now, in the physical swap allocator, whenever we have an
> allocated slot in the range we're checking, we check if that slot is
> swap-cache-only (i.e no swap count), and if so we try to free it (if
> swapfile is almost full etc.). This check is cheap if all swap entry
> metadata live in physical swap layer only, but more expensive when you
> have to go through another layer of indirection :)
>
> I fixed that by just taking one bit in the reverse map to track
> swap-cache-only state, which eliminates this without extra space
> overhead (on top of the existing design).

Isn't that HAS_CACHE :) ?

> 2. On the free path, in swap_pte_batch(), we check cgroup to make sure
> that the range we pass to free_swap_and_cache_nr() belongs to the same
> cgroup, which has a per-PTE overhead for going to the vswap layer. We

This might be helpful:
https://lore.kernel.org/linux-mm/20260417-swap-table-p4-v2-8-17f5d1015428@t=
encent.com/

I observed a similar but much smaller issue with the current swap too.
Deferring the cgroup lookup to the swap-cache layer, where we already
grab the cluster (in a later commit), should reduce a lot of overhead.
It requires some unification of allocation though as shown in that
series, things will be much easier after that :)

> Anyway, still a small gap. The next idea that I have is inspired by
> TLB, which cache virtual->physical memory address translation. I added

I think this is getting over complex... You got a mandatory virtual
layer, which already comes with some cluster cache inside, and the
lower physical allocator has its own cluster cache, and then a new set
of cache on top of the virtual layer?

>
> Some final remarks:
> * I still think there's a good chance we can *significantly* close the
> gap overall between a design with virtual swap and a design without.
> It's a bit premature to commit to a vswap-optional route (which to be
> completely honest I'm still not confident is possible to satisfy all
> of our requirements).
>
> * Regardless of the direction we take, these are all pitfalls that
> will be problematic for virtual swap design, and more generally some
> of them will affect any dynamic swap design (which has to go through
> some sort of indirection or a dynamic data structure like xarray that
> will induce some amount of lookup overhead). I hope my work here can
> be useful in this sense too, outside of this specific vswap direction
> :)

Glad to know things are getting better! We can definitely work
something out. But besides the problem above, I think there are some
other concerns that need to be solved too. Good part is I think
everyone agrees that some kind of intermediate layer is needed.
