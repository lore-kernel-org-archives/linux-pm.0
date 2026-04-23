Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B363101B8
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925025; cv=pass; b=Hej4GnREt2eDc9Owf2AsvdcVJ8WEvFaYH1pFsQGg7TeP6fO73M9Lz8KvjZwj09INiOt3V3VYOSdHvwes2pFUNumga6sY1kTgdJ1PR1zOiFOGrYoZaBtbb3Yv4n3GvhcqvcC3JmrIiODYwwoy5P7LZZRse4CFblxOCZizyqxYwv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925025; c=relaxed/simple;
	bh=6qrM7qsAzBHvv/VI+HqLPPP6FQ3qhsBu/FQQBvDaXwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHgtX+iLq45swlRpkT+2MNY4iIwHwLddBvoasaLWctETm/Awa5kyZUw5+BtP2CHn8oOhdCRzjvOL0EhAlk4oLphZoqlnmXMJ1e2keenpDS3583VWS4DGTuqy5460yCl6c9RGdgfAQXuyYTQWMc6a6NNK3FNWJnYiCPff2KeaAQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiE0EZ3N; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiE0EZ3N"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so9532389a12.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 23:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776925022; cv=none;
        d=google.com; s=arc-20240605;
        b=fnSz4Te5HgB3/EOJpfDkyJjwplLAuWhvRMLcgbY6PSKA7kLDG8GYdSRaPnnQYngUXI
         XX6XxpUVL1A5uz2BvFs2mnMzMkqY3Yk61r8c+KQJUynEqTIkpxpq44hs7K0USLqGcW/w
         pAR0pLk65wWVREDmw9zfRNdSU4jLfcXdY01GHo2NV33IonJJuIQjc5EanO9lM1rOuxsX
         jr/yT9aAPirtY/8TIEsjcWcovl6PIaPgeWrJB2CB1zjivtcVG/kT7w095AYH7nShMN85
         FYsirGyysMENTI/wLWvpp8cDADK8mVBBhN/SXG+NYJtHDeIE4ewIyKUYgy5q8zU20rcP
         /r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qrM7qsAzBHvv/VI+HqLPPP6FQ3qhsBu/FQQBvDaXwA=;
        fh=XfjT7zycKvJaG3iTJNhQQPAKHmvE/vs5EjATzjFSR9E=;
        b=EUtKrQY92DoVsDYdBb4dFOpBROD2/kypH42kOhkaPwPsrosV3p+XiElyhbxqwWXRH8
         QD/9ddRII6SIw7WcQK46fgHk90vhWA0AN3FJvznpNBZFjMw6aMl9FqGzTsjex6RgTjjw
         WtzwbsP9VwtWVSz4fYktHg0yUtx/FJ+1VGRAs161LGiulfML/ju7zCD6aWG1jkWEcLzJ
         z2vDhjh3NzPkfF63XJ7kX1ZLDcLqNmLOQ6xcx9FOdE8Dq0hg7wLIXf5vfSlCBbbWYSQN
         asipNWoVCy1XCRrI2Qpt+mNL6iKOdYJ6/d77FXivFK73kuzra+0WoYX1GGfydMZIVrFO
         yVcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776925022; x=1777529822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qrM7qsAzBHvv/VI+HqLPPP6FQ3qhsBu/FQQBvDaXwA=;
        b=QiE0EZ3N0WWs7sjQT9MKYZYIZ2U2YU8qiddqC3SrIzrCXbfj8HCaw2vtaizUqRInkU
         Db0O/lsAUrxbyaAYQ/jnJsfimlP4cx9vLzkw4pv39xmnQXluTdCju+RER4AneGVUNApW
         Zn7lMi5mJ9IWQORoaX+LE0IZxboXD9p0RAVd9vE+TuXLkXsCNjtESrLdM1Q4O1Olo9YB
         k7FuW/QSR+r/o6CdHwr6PQhwzuMKasKKH9ewgYj//5aSimW8dTmAa3UaB86UVPt8aikV
         JLeue3Rlv6+WBg3VnWKJreSuSkCO1pjkwUKXsNXZ7r4uFhH8zBpPILM5rPgbxyN1LWjc
         rm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776925022; x=1777529822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qrM7qsAzBHvv/VI+HqLPPP6FQ3qhsBu/FQQBvDaXwA=;
        b=CTRwasRfw7OjJZZzAEI04xrN0bBbTHECG8qUTpGciOXF2jK1KXQHd1tmF032DAdIFn
         6K3P8ucaMSfOi1M80yiaJWBxL+o/Dt8ma250tGDBLBHcU0jEje5KCxSWXR6y3chSy2pM
         rnqwtddsV3wIYfDiCPo8gxb++nVY+apE84l2k2If5K8SLqVdv166ARlsa95OeJlEhfpt
         gUrDR6uFhPS/cr79mPIx0JmUbpwd76BnTmD37HCEUJ0TBaFEAKwca8IcTuORrtD+lM0E
         SDjlpoli7kmkLAy59Trwka3R+EpvB4dR75tVl7DDI6TiYcmlHzkpm1O3ETM+wSxB0NAW
         dqkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+mtFGBMa+GwjuoPZ6eTDfMjO6HF892cxIQpzKLP1IOiOD7DuXeQg0A3b+jR6/ASEvWy8k96fD7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YziVO2JmDOldkrbbDHT5/0B9Ypz5DRBqZcttivZgLAkGA9MPga/
	I+bGiWTzV6QEGNVjNmHg/KTaTm1nb3MxUids4ICz0IqWJalzM5Qe/a+SQ7JVSvbT1ao4ugj2gb8
	SnWj1EnY8MZOop1sOGm7qOglAB9my/vQ=
X-Gm-Gg: AeBDiesDet6AmEv7nzlSE/FvpLSUHDfKcbi5ngf+KyMAXgw+O5YcV9nqTk/4DYpOGCe
	o3ZmbW6M5oRVtluJG95GoBAgT8BQa5QA+RXTYbPAdqCdhSDN4+KY0Bkc6SuZHN01ZOD2XoKMpSN
	bcjVtzRaceaWERrnExqJ3bBf6IjgFL2sCFZXtllYuRkeKKKZjd7DN1c7KobxcSMO8K10+ARnRSO
	S1kfeAF+4BFkwg6Tp2YboZPSoQIf1CH+IRF+WpqM/Cr+dJEvYubhstSXADMdLKbrfW6vg12eRDv
	L1meP7BJ1PrHYJB5G3+AoP2Ro63VZTL3kg4aMOKPGqd455mk8pM=
X-Received: by 2002:a05:6402:24cd:b0:66b:aa56:ee5c with SMTP id
 4fb4d7f45d1cf-672bffd3a22mr10256938a12.28.1776925021636; Wed, 22 Apr 2026
 23:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com> <aektdlD4npMVThu3@google.com>
In-Reply-To: <aektdlD4npMVThu3@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 23 Apr 2026 14:16:24 +0800
X-Gm-Features: AQROBzBVGp3guci_2n97e7eFyFpR7BCikY1iYf4lyc9Y4ueJzJNdB9B8Zs-KyXM
Message-ID: <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 4:27=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Apr 22, 2026 at 10:18:35AM +0800, Kairui Song wrote:
> > On Wed, Apr 22, 2026 at 8:26=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> > > >
> > > > This patch series implements the virtual swap space idea, based on =
Yosry's
> > > > proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> > > > inputs from Johannes Weiner. The same idea (with different
> > > > implementation details) has been floated by Rik van Riel since at l=
east
> > > > 2011 (see [8]).
> > >
> > > Unfortuantely, I haven't been able to keep up with virtual swap and s=
wap
> > > table development, as my time is mostly being spent elsewhere these
> > > days. I do have a question tho, which might have already been answere=
d
> > > or is too naive/stupid -- so apologies in advance.
> >
> > Hi Yosry,
> >
> > Not a stupid question at all=E2=80=94it's actually spot on. :)
> >
> > >
> > > Given the recent advancements in the swap table and that most metadat=
a
> > > and the swap cache are already being pulled into it, is it possible t=
o
> > > use the swap table in the virtual swap layer instead of the xarray?
> > >
> > > Basically pull the swap table one layer higher, and have it point to
> > > either a zswap entry or a physical swap slot (or others in the future=
)?
> > > If my understanding is correct, we kinda get the best of both worlds =
and
> > > reuse the integration already done by the swap table with the swap
> > > cache, as well as the lock paritioning.
> > >
> > > In this world, the clusters would be in the virtual swap space, and w=
e'd
> > > create the clusters on-demand as needed.
> > >
> > > Does this even work or make the least amount of sense (I guess the
> > > question is for both Nhat and Kairui)?
> > >
> >
> > Yes, this absolutely works. In fact, I previously posted a working RFC
> > based on this idea. In that series, clusters are dynamically
> > allocated, allowing the swap space to be dynamically sized
> > (essentially infinite) while reusing all the existing infrastructure:
> > https://lore.kernel.org/all/20260220-swap-table-p4-v1-0-104795d19815@te=
ncent.com/
>
> There are a few aspects that I don't agree with in this RFC, and I think
> Nhat and Johannes raised most of them. Mostly that I don't want to
> expose ghost swapfiles or similar to userspace.
>
> I think userspace's view of swapfiles should remain the same and reflect
> the physical swap slots. The virtual swap layer should be completely
> transparent in this case. Userspace shouldn't need to configure it in
> any way.

That approach is definitely doable. For example, with that RFC we
could simply drop the interface I introduced and enable it via a
different knob, and that would be very close to it. :)

Using a swapfile to represent the virtual layer externally just made
it more flexible. I agree that the RFC design was a bit confusing and
could be improved. There is no technical difficulty in hiding it from
userspace; it's mostly a design choice. And even if we don't use a
swapfile to represent it internally, all the other infrastructure can
still be reused without much modification.

Using a swapfile does have its benefits, though. For example, the
virtual layer could act as an ordinary tier following YoungJun's
design:
https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.=
com/
It also means we wouldn't need to introduce things like a new,
virtual-specific swapoff mechanism.

> In an ideal world, the only noticeable change from userspace is that
> with zswap, compressed pages would stop using slots in the swapfile and
> charging the memcg for them -- and that zswap would work even without a
> swapfile, by just enabling it. This is admittedly a user-visible
> behavioral change, but I am hoping that's a good one that we can live
> with.

Totally agree with the ideal end goal for zswap. just not sure if
that's the right place to start for this usage, zswap doesn't always
apply. For instance, we have SSDs with built-in compression,
software-based storage stacks with built-in compression and
deduplication, swap over RDMA, and, most notably, ZRAM users. They
don't necessarily need zswap or a virtual layer, and the upper layer
better be as much simplified as possible.

> If there are real concerns about this, we can discuss things like a knob
> or config option to keep charging zswap pages as swap slots (ew..) or
> only allow zswap with a real swapfile (double ew..). But I am really
> hoping we can get away with changing the semantics without doing this.
>
> We can add extra interfaces for virtual swap as needed, e.g. virtual
> swapoff that you mentioned to clear the swap cache, or stats about the
> virtual swap space (which translates to memory overhead).

Good suggestions.

> > It cleans up a lot of allocation and ordering, as well as memcg
> > swap lookups. Since some of these problems were also observed in the
> > vss discussion, I think this will make things easier for all of us:
> > https://lore.kernel.org/all/20260421-swap-table-p4-v3-0-2f23759a76bc@te=
ncent.com/
>
> Yeah I saw that (but didn't really have time to do anything else about
> it). Splitting this out is definitely the right thing to do, and the
> series looks great from a very high level. Awesome work, as usual :)

Thanks!
