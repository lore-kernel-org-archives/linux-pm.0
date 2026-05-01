Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D41AA1F4
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645012; cv=pass; b=mrEijRBOnEfqiB+KQ1F6OkkX7kJktRolk1l7WNkKHbQcdzrNk89JFbuym9rpJRz/G9lK21yQVI1cCim0Uy8C2qCGyTk5O04tBbMVEiQ7THZDavufgozJXlyM8TqovzVLWXcaq8FpGlPnPifU8TU3lquFKjb/8YjJ6M2dU8cv6Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645012; c=relaxed/simple;
	bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYSEnYUiOuTz0jQR/r4Ez2yMGtT7jEZCHIMTJ9q2oiBtHD8tPUGFtL7huZSpSPKptKI1kFFZhZ4f9FN0fQfO0/gne3jEiB1h/zg0nJQan9oYNq3FAWjvw23TX8OTzad3YgKqmrdD1p+5yrkr6Q0s4mkItoTv60asueOk5yf03hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUHr5zHT; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUHr5zHT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31626155e9.2
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 07:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777645009; cv=none;
        d=google.com; s=arc-20240605;
        b=bpdHMGHMfEU0Ygbjg3QLWijEspKfRpxtMgEMk/5n1i/KKMqI/pfUxOsovHH2IzjlP1
         9mmIoKupXsZL+Hgv0hqicJExrRJF2LrC+42SLcKhi/b2DDafWxQSIbJ4Al02+6euANCY
         RBQju0RPiSMvubykm//ltcbVL2BQM+qVhCDV/IN0vsmHgpGbRaLuU9FBlUXjwUpgMe+c
         LcAcDiwmwhE2fGXF8/FOHwC48Vh+L7VUYAQMJhFbsXeM+7eREW6hSNL8BueVPpkPMdof
         Ju4KWBs0J52VjGsf4UbjgIKjYgxnO2uVAhjoIqbRsWudqTJwT/b4UERynYNpv/BunK4h
         AqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        fh=LlgVWX2inJYIEAhz781qTdl86aWzKvZLVWWn0fEJhTw=;
        b=MIxq3MT/azzqwKlBHfeZMKhDb5ocad9R3jkp5ij6EaL1rtvFfNDjFE5KrWTThZEZGH
         q2tT5RpN3wmaXpL0W9cDSTJis0tmsgMJpXTb2/DptLuIDRzi94mvYfqxaUFZkQaU1gaf
         t8ZbVlCX8B9MphCqFaxhipmRmBjoFKqa4GdR2xUwHz0gD72GDzA3pg0dOWUumfysfIPM
         tYdDdGil2zYZm+GRuSJg8M4yUJWG/lQatPtORSqhI17XTawPQikeJuSergnoQ9QNU+zQ
         1b+er3YmzB54mIBCIYGFStewkxfH14SEeqQB6zDkv6WeH75yHiSuT/tGw4KC6H6jNl4d
         2Iqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777645009; x=1778249809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        b=SUHr5zHTioHWahgwan9GjDdTjIpEOJfXlegsgWiG+x648RiTFOPf+YH7NwTnR/rrbV
         sjr7ZEBa3N8bY1Y1RLNK8WfdyZYnqP6THZKCnSbyIsqqFV6uUwlEOWOldHfCxjepREhJ
         OZcnMP0XYRvTCkBBdbII0NQ4lNtY8MN2KatqvkcVs8LilFnP0J3zYgGY+1JrYN571KtK
         2s64MdhdgH6eZGmAFJXTBQcojzDW9fqFGoS1IfIQAWvy5c9NJFvpJuoaz/6AA4Vnc9er
         BOWlCVv8UZFuEH7snsDNZMpn/BR835poTuN5grlb+kOk9bN7hFlRg44V4hbBKQQ3lYVA
         SiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777645009; x=1778249809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0Id2xfJjyn/73uT0S8lwE8udvk16qyKJSuD4Abx5Bg=;
        b=SXyxW/XIhVDmqX5d57JI+1k1YcFcJ108lppJxoPNaO94qgCbwx5dKYc5PVmg3aM4/o
         QydmRp3Fustzi8ZlMkm5UID8ciVEOcNPXdauG9u1baOwMh4yzT73sL+CxJ47akbHA5GE
         9M7f9XocsVY3krCsalbt3FXQqBzZZLPtYRnmONhz/XCwFrDlcgVeEZXyPGusg+GJpvvb
         PZzvZfmp2AXcYmZgtEEzoapoKAmFZVDyKR6QcDrEDX/wrxKr0RU3UqfixPvqB3d3iYqg
         7GgbMM/KISHGv+qMPIlJnBwStvnxxtCiEBbon2KKDvAJ2Z1YZ6lWstEI8CVWKEcIBXTQ
         E0iw==
X-Forwarded-Encrypted: i=1; AFNElJ9IZ3h87hXGpQxRmfmRDopX7xWVDVQoO6HEcwWiM7HD88qkN6EhvrYX2rWo5VQHiYls8jg2UAZIMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW7PX94gWWxoAvibxUccKvEY4Yhfzk+NaFzhda3S7JLNATK4O
	q+BG27AhyHEhScJUveEZX6DFyNrYku0UrDidFaE5xVUoW3+ARKuxi7YsUhbxBSZTKtDYbi2VzWW
	sxisQPLO4y8jXb4B8k141QPPle9gMOyg=
X-Gm-Gg: AeBDiestLUSumwFkPGMR5/bnpM4iJLRJq6MCGL09msBMDHYuBlL5DRmyalQcuEzj0a2
	wzrcwRJRHtCZZD0+7YnNfj3XAOWduUlIotZN+2D6UgBs6mFbTNL3cdtsafmogjd+if3ksl5Mlk8
	Dnu7mUTlF1GFntVch6wTg937cg+JnskLZU5Nyi7r6o2pyqOjVDY+/I1lY5/+HkyBNUy1klR8hk/
	RMRCvpZr4s8AH+2mg1Lq0GIzRd1WEicGeyjhpxownxKxSzwX9pQA3b0o3tFxNmDBQAXpgC8wlBc
	GlPYYgZkWxdP68FWkQHYus4lyErtxwjMwhBK/Q0kN97xB3OS0BqK5GlVcb7ASED0oA==
X-Received: by 2002:a05:600c:4a9f:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48a95627aa2mr9093625e9.24.1777645009250; Fri, 01 May 2026
 07:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
 <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
 <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
 <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com> <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
In-Reply-To: <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 1 May 2026 15:16:36 +0100
X-Gm-Features: AVHnY4JpHB4eIrG5SgzyWnvdTJaCS5EqLLry8xKYoE_XxqUlALfldRFV_NWt4b0
Message-ID: <CAKEwX=NR5dkKduTPwDHWiSMFwJ9ZmvindFvUNbPgQu690W_m+A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	Alistair Popple <apopple@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote
> > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.par=
k@lge.com/
> >
> > Does this do promotion/demotion of swap entries?
>
> Not yet, let's do things step by step.
>
> > > For example just reserve a type (e.g. type 0) as the virtual type?
> > > (type is really a bad naming though).
> > >
> > > The that swap file (or swap mapping) will be
> > >
> > > I was trying that based on this:
> > > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d=
19815@tencent.com/
> > >
> > > It seems to work and the only thing we need is actually just somethin=
g
> > > like this one in VSS:
> > > https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gma=
il.com/
> > >
> > > This part:
> > > + /* fall back to physical swap device */
> > > + if (!vswap_alloc_swap_slot(folio)) {
> > >
> > > We do a folio_realloc_swap if folio->swap have type 0.
> > >
> > > Which means, if there is no virtual device / mapping / file / space
> > > (I'm not sure how to name it at this point :) ), the ordinary swap
> > > routine is just still there untouched.
> > >
> > > If there is one, and it's being used, then, it is still the ordinary
> > > swap routine, just do an extra allocation (and the extra allocation
> > > strictly follows YoungJun's tier rule), which is same with VSS, but
> > > everything is reused. From a user or high level interface perspective=
,
> > > this can be designed with no difference as VSS. Just with a few
> > > bonuses: being per memcg / task / runtime optional, zero overhead if
> > > not enabled, and reusing all the infra.
> > >
> > > BTW this deferred allocation (in VSS or dynamic swap mapping, similar
> > > thing) is actually a bit concerning to me as well. It changes the
> > > common swapout routine and maybe worth reconsideration (e.g.
> > > activate_locked_split and mTHP stats is now ignored?), being optional
> > > for now also seems safer.
> >
> > I am not sure if I understand you correctly. I think what you're propos=
ing is:
> >
> > - Page tables either point directly to a swap slot, or to a virtual swa=
p entry.
> > - By default, page tables just point to swap slots maintaining current =
behavior.
>
> I mean, they are all swap entries, nothing special from the page table
> side. Swap subsystems handle things internally.
>
> > - If we have multiple backends (e.g. zswap or tiering), we use virtual
> > swap entry instead.
>
> Actually that can just follow the swap priority, or tier rule. Even if
> virtual mapping exists, it can be bypassed. e.g. you have a large NBD
> and don't care about either fragmentation or compression for offline
> workload cgroups, then why use a virtual layer for them which could
> double the kmem usage or spend more CPU? Setup is a different issue
> which can be discussed.

I assume NBD =3D=3D network block device here?

If you use a NBD, I think vswap overhead is not going to be the
bottleneck here :)

And, what about reliability. Say you allocate a slot on the NBD, unmap
the page from the PTEs, then proceed to swap_writeout(). What if the
NBD device is no longer available? What if IO fails? If you already
encode the physical swap slot location in the PTEs, then it's very
expensive to correct this mistake. Whereas with vswap, you can fall
back to another device if you so choose, and all it takes is just a
simple backend change at the vswap layer.

Another issue with the current physical swapfile allocator is that
induces physical contiguity where it's absolutely not needed. I don't
know if this is the case with an NBD, but for flash device for e.g,
obviously contiguity makes thing more efficient, but it would be nice
if we can fallback to discontiguous swapout as a fallback.

I feel like NBD is an argument FOR virtualization, not against.

>
> > - The physical swapfile has clusters and swap tables (status quo).
> > - Virtual swap is implemented with clusters and swap tables in a
> > virtual space, and each table entry points to an underlying swap slot
> > or zswap entry.
> > - If a page table has a physical swap slot, and we need to do tiering,
> > we basically "make it virtual" by making the swap table of the
> > physical swapfile point at a virtual swap entry? or another physical
> > swapfile? Not sure.
>
> They are still ordinary swap entries, nothing special. The virtual
> space is also just a ordinary swap file (or swap mapping), which is
> easy to do:
> https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d1981=
5@tencent.com/
>
> Then its virtual_table will have a different set of swap entries. (I
> left that part undone though).
>
> > > Right... I mean with two layers you will likely have >16 bytes
> > > overhead, and double lookup.
> >
> > Why >16 bytes? Do we need anything extra other than the reverse
> > mapping? Also why do we need a double lookup?
>
> You will have to store at least the following info: memcg (2 bytes),
> shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
> bytes, since you have to address a full virtual swap space). And some
> type info is also needed. Part of them can be shrinked but still,
> scientifically, merging two layers into one is considered a kind of
> optimization.

Optimization is always a worthwhile pursuit of course. But you have to
gauge it with what we can buy with a more flexbility design, which
might end up buying us more performance win down the line

In the immediate term, vswap buys you a dynamic compressed layer +
maintain the ability to write back.

Looking a bit longer term, I don't think you can do the following
without a layer of indirection here:

1. Compressed writeback.

2. Discontiguous swapouts. I think we need this as a fallback for THP
swapping (see [1] for the discussion).

3. Mixed backend swapin.

4. Optimizing swap IO - if sequential patterns matter for example, you
need the ability to delay or change backend allocation. The current
model is way too inflexible to allow for that.

5. Adding new swap backends. We want to decouple what the MM subsystem
needs (which is minimally captured in the virtual layer), with what
the backend itself wants.

Youngjun's paper is a case study for what you can buy with virtualization:

[1]: https://lore.kernel.org/all/6869b7f0-84e1-fb93-03f1-9442cdfe476b@googl=
e.com/
[2]: https://ieeexplore.ieee.org/document/8662047

>
> You need lookup the virtual layer, then the lower layer for many
> decision making, is was discussed before to introduce more cache bit
> or things like that and I think that is getting over complex, reminds
> me of the slot cache or HAS_CACHE thing...:
> https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyz=
VOKE14-O+Dw@mail.gmail.com/
>
> > I don't think I quite understand it yet, maybe I am the problem :)
>
> Haha, not at all! Blame me for the poor explanation. To be honest, the
> design is still evolving and there are definitely details that need to
> be improved. It's hard to discuss these abstractions purely in theory,
> so it's probably best just keep the works moving forward in a clean
> way, and make things simpler and better be opt-in first.
