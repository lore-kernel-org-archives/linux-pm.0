Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C863EC2FF
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187440; cv=pass; b=hG22boooGK+14OtTkUClW5sE2NkzJ50gUx8V+ldQBIOGc3Z3G2wLGZlT47YJmhEjAKjwrMXEC5tmmN8YT/zUp8hZjCuLiis0l9gDLf5vA1AiLxhjr22HJc+BBce/RuUey7LrnAHjEzMO3hFBuy0DROYdpHBnazlCJEXKQOPJg+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187440; c=relaxed/simple;
	bh=fBNd16aMcIO51hrQ2DUJK8LJDyzxvoNpH9dvTIPgUB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+1nbdUhNLTVTbOkGV3rT17gAl3Lu6WuihORUIde/dY9YGYhHkXLl/LSqseKYPuXGW9N8k5CuZlqGlag33vZy42qsAKCHsu+a+9IogdzPoE2/QEV+rmDxn6fCaHTv3YSo+iJQRtfqxI1LZGndqg8ueWmp2yBgCubxorPfq5bRDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4ABFflq; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4ABFflq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso4951223f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 10:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776187434; cv=none;
        d=google.com; s=arc-20240605;
        b=kNpAnVYpstErA+dJDaH7XqJtfC7r802wSZglVpx+/JLv+hnOBk1+4x3wcQ6Os6WuBo
         v2iA5Fdc3yThA+kxsajuHlPv1Y1Xv/0EptfWt+mpyA/UBcHlC5bDTojieStT089cxN2R
         t6bI51/saZ8luJ7VHNbUzWsjJcr2D3tkgAaBeTPLb85nHyizCY3cgICpfWRrIstfCH1B
         PfTdJDsDnoc+cvqPKG19pNKPOTmQlNLVQ1RXRSRLk1aAQzfXXvEuIPbbFZUc+YGtZOOd
         tsQgQi+03elz2z6wIn6oISdUA30xoIdBfGXzH1IszCzr3ld5csOUbQnFdGgo4usV9Hba
         ziTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dp82XmEr+jeti4TR19n6W0flGrbWCgKnTbsqPQVkS+w=;
        fh=GxkUufvwvKBC8HXjZDCxcNuD3yo57LhbgiZAjidYrBQ=;
        b=jW0EgYmZanUM2A+zoWI7BTKZm1geYuunjahFiEIJijduL5/UxuoUAe1uYDPmwyqWD2
         kBhtLsJwRqsHaCfMvxDhMPyUHrtiib00XIOezopzp0yKkHCneXCQaUErW+XrrCLJX3HG
         mgWduS5kBtER42yE0zwXQ48rhPJEieSxjSXVA3og1fW1IdUi47iwREQsp5NX2dxpsMtz
         ZxBWz+kgzAucLg1OqHe0dE5/lrDpBoQIe2PHCTfiBsj1pnxsydehx72Y2j1HxulEuoM/
         o0jiL6+rRXT1Y7MogRcFkaUghnpDT3sgbWoAKbZtJ+Zz/UmoGpFLM6LZcirjPoH9m4ub
         uOSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776187434; x=1776792234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp82XmEr+jeti4TR19n6W0flGrbWCgKnTbsqPQVkS+w=;
        b=P4ABFflqrZcN31vaeETuf/Nk22Bfi2P+w0TFf3QkOwXB0rl3o62OtqrDxs/I/DGDfp
         tEv17UiW/g7vsuHbYAfoVh+18R6OGXh/yez083xWeqIfjuyuXFk8hZjOMt6uGTmnaGm5
         mKlL/4UBVe+KMcl0E1xBo14A0UF+onpjrUKwPazVSezpZE9qEFr8Ecbr+cMyUKspGFqZ
         3p9jrDqDzKxT/hKLh8O6i5h3NxykweI0sT6BcuDG3lpVakRzGJVsMddbx1suGm4AVKH/
         oPlJU5Ih8pXOb0VAs0TMw9xtjdkpbMPUF5hIM031vnu/aDLKUTz+hlcrutzzPghMu1ID
         DM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187434; x=1776792234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp82XmEr+jeti4TR19n6W0flGrbWCgKnTbsqPQVkS+w=;
        b=WAXJoVVMc6MZgRHGaPAHXm9Thwmu2KovnuDZaL1x1c2wMp/LbDE+xowpXZqhl6k00n
         zrNj2Kbq1mQHi7+BWm8aoL1jJHoQz9HwXXN6Q0IU2uzsK0p7vXRX7mudcQ3o8IbroHKV
         bGbSkXut8U1cPxnxZXXPHAW7lR3cI1NaUGsOa0R9uT+KjkYD/GmJ/KlHfDAmXx92AUBO
         iYgL0y6zCudpRnY+qksYMfVA7H15XZAxaSIxGcpqqP6sXY8JxjHVvymy3dtlyRhMCNoS
         FhL+toonYVtTJoQ5gOPR0AdPWHgCvntQ0R7CK693LI+Xsxlz18Hzz2WWTMe0+P4G93x6
         4oMA==
X-Forwarded-Encrypted: i=1; AFNElJ/hClYZkdMOP4E5ODXomDuyiGsWu+Ce+dOOKMLXG6cf6RBF7C4HITKCTVBLiLnP7Q0YINrcemRMzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR0ogLuKwU38JXQGzpRlMsIPjp7O8ePRsX04iKlHaGUahY2Sm
	SqETEd5hKoVP0FvW0vLhXoyzyrzkfrEfrUHXA7+0WMOS8i0/ZfoPYPVIBNj1tHwZ+hzI8enVzJd
	zQTMAuP6jZ/8rcRL52jBKojQ83/7pXKM=
X-Gm-Gg: AeBDiess4FkSDwUt7113t2BuZCCDHbLN+GPM75nWbEI/PvaC8i64rYe798SPTuuQArx
	3sMYHAOHNZ6Dt59iitFAe2O2cbivIefGlwhfS2jG7w/1NNsP298PYvKpSEz5hYTYhFtfkhvsMTw
	j+PK/9dObk9R2cjbu2Boi+I0ZLDRzDezFECvmYU9UzhaJOhGItB3AsysIQzy28qD/+ozQTwtLZL
	L7m4DbhR2nyWGEdGj2VjL7QAG4O2D5OdZS3Vm5X4QM7eeGkI6lDMWxS/fIcjh6DHSnW4MyeADdS
	5UE/0iHLJ1Z88wl2s1mr/3kx8WnC8TUBJNHb+dI=
X-Received: by 2002:a05:6000:2211:b0:43d:2f92:633f with SMTP id
 ffacd0b85a97d-43d641f97aemr27791434f8f.0.1776187434027; Tue, 14 Apr 2026
 10:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com> <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Apr 2026 10:23:42 -0700
X-Gm-Features: AQROBzCvQ2Y205EwGC1lGKq27IJDyjI-VHhfD6X3kasimC4o5zGPGqT7idYCq1M
Message-ID: <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
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

On Mon, Mar 23, 2026 at 1:05=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Mar 23, 2026 at 12:41=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Mon, Mar 23, 2026 at 11:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > On Mon, Mar 23, 2026 at 6:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.co=
m> wrote:
> > > > > This patch series is based on 6.19. There are a couple more
> > > > > swap-related changes in mainline that I would need to coordinate
> > > > > with, but I still want to send this out as an update for the
> > > > > regressions reported by Kairui Song in [15]. It's probably easier
> > > > > to just build this thing rather than dig through that series of
> > > > > emails to get the fix patch :)
> > > > >
> > > > > Changelog:
> > > > > * v4 -> v5:
> > > > >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> > > > >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_h=
eld(),
> > > > >       and use guard(rcu) in vswap_cpu_dead
> > > > >       (reported by Peter Zijlstra [17]).
> > > > > * v3 -> v4:
> > > > >     * Fix poor swap free batching behavior to alleviate a regress=
ion
> > > > >       (reported by Kairui Song).
> > > >
> > >
> > > Hi Kairui! Thanks a lot for the testing big boss :) I will focus on
> > > the regression in this patch series - we can talk more about
> > > directions in another thread :)

Hi Kairui,

My apologies if I missed your response, but could you share with me
your full benchmark suite? It would be hugely useful, not just for
this series, but for all swap contributions in the future :) We should
do as much homework ourselves as possible :P

And apologies for the delayed response. I kept having to back and
forth between regression investigating, and figuring out what was
going on with the build setups (I missed some of the CONFIGs you had
originally), reducing variance on hosts, etc.

I don't have PMEM, so I have only worked with zram backend so far. I
did manage to reproduce the regressions you showed me (albeit at a
much smaller gap on certain metrics than your cited numbers, which I
suspect is due to zram/pmem difference).

There are two benchmarks that I focused on:

1. Usemem - the exact command I ran is: time ./usemem --init-time -O
-y -x -n 1 56G

My host is 32GB, 52 processor(s) / x86_64.

Build        real (s)          vs base   sys (s)           tput (KB/s)
       free_ms
baseline     175.6 +/- 3.6      =E2=80=94        121.9 +/- 3.3    391,941 +=
/-
8,333  6,992 +/- 204
vss_v5       184.0 +/- 3.9    +4.8%      130.5 +/- 3.8    376,192 +/-
8,581  8,297 +/- 247

(I hope the formatting works, but let me know if it looks weird).

2. Memhog: time memhog 48G

My host for this one is 16 GB, 52 processors, x86_64 too.

Build        real (s)          vs base   sys (s)
baseline      80.5 +/- 1.9      =E2=80=94         62.7 +/- 2.0
vss_v5        83.0 +/- 1.8    +3.1%       65.7 +/- 1.8

On both benchmark, I enable MGLRU, to more closely match the setup you had.

Staring at the run logs (and double check with the logs you sent me to
make sure it's not just on my system), there are some common patterns
I noticed across these runs:

1. Kswapd is slower on the vswap side, which shifts work towards
direct reclaim, and makes compaction have to run harder (which has a
weird contention through zsmalloc - I can expand further, but this is
not vswap-specific, just exacerbated by slower kswapd).

2. Higher swap readahead (albeit with higher hit rate) - this is more
of an artifact of the fact that zero swap pages are no longer backed
by zram swapfile, which skipped readahead in certain paths. We can
ignore this for now, but worth assessing this for fast swap backends
in general (zero swap pages, zswap, so on and so forth).

I spent sometimes perf-ing kswapd, and hack the usemem binary a bit so
that I can perf the free stage of usemem separately. Most of the
vswap-specific overhead lies in the xarray lookups. Some big offenders
on top of my mind:

1. Right now, in the physical swap allocator, whenever we have an
allocated slot in the range we're checking, we check if that slot is
swap-cache-only (i.e no swap count), and if so we try to free it (if
swapfile is almost full etc.). This check is cheap if all swap entry
metadata live in physical swap layer only, but more expensive when you
have to go through another layer of indirection :)

I fixed that by just taking one bit in the reverse map to track
swap-cache-only state, which eliminates this without extra space
overhead (on top of the existing design).

2. On the free path, in swap_pte_batch(), we check cgroup to make sure
that the range we pass to free_swap_and_cache_nr() belongs to the same
cgroup, which has a per-PTE overhead for going to the vswap layer. We
can make this check once-per range instead, to reduce overhead. Even
better - we can skip this check in swap_pte_batch() for the free case,
and deferred this check to later on where we already enter vswap
cluster lock context :)

With a bunch of changes like that, I closed the gap majorly:

usemem:
Build        real (s)          vs base   sys (s)           tput (KB/s)
       free_ms
baseline     175.6 +/- 3.6      =E2=80=94        121.9 +/- 3.3    391,941 +=
/-
8,333  6,992 +/- 204
new_opt_v2   179.8 +/- 3.0    +2.4%      126.1 +/- 2.9    382,536 +/-
6,662  7,105 +/- 183

memhog:
Build        real (s)          vs base   sys (s)
baseline      80.5 +/- 1.9      =E2=80=94         62.7 +/- 2.0
new_opt_v2    79.9 +/- 1.7    -0.8%       62.4 +/- 1.7

I would like to also point out that, some of this overhead is specific
to the swapfile backend case, which is why we don't see this in zswap
in the stats I included in V5. Zswap does not require this
swap-cache-only dance, because in virtual swap, zswap only needs the
virtual swap slot as the index (on top of much more negligible space
overhead thanks to zswap tree merging into vswap cluster, no swap
charging, no double allocation, etc.).

Anyway, still a small gap. The next idea that I have is inspired by
TLB, which cache virtual->physical memory address translation. I added
a per-CPU MRU virtual cluster. The idea is that a lot of consecutive
swap operations operate on the same range of swap entries - merging
these operations of course makes the most sense, but sometimes it's
not convenient to do it. The non-vswap, old design sometimes lock the
physical swap cluster and expose the swap cluster struct to callers to
pass around, but I would like to avoid that if possible :)

With this change, we close the gap even further - exceeding the
baseline in average in certain cases, but as you can see it's within
noises so I wouldn't conclude too much out of it:

usemem:
Build        real (s)          vs base   sys (s)           tput (KB/s)
       free_ms
baseline     175.6 +/- 3.6      =E2=80=94        121.9 +/- 3.3    391,941 +=
/-
8,333  6,992 +/- 204
cc_v2        176.4 +/- 5.3    +0.4%      123.6 +/- 5.4    390,405 +/-
12,792 6,987 +/- 296


memhog:
Build        real (s)          vs base   sys (s)
baseline      80.5 +/- 1.9      =E2=80=94         62.7 +/- 2.0
cc_v2         79.9 +/- 0.9    -0.8%       62.1 +/- 1.5

The reclaim and compaction stats tell a similar story:

Reclaim / Compaction (usemem)
Metric                               baseline
vss_v5                   new_opt_v2                        cc_v2
allocstall                 167,787 +/- 10,292           170,532 +/-
15,185           169,782 +/- 9,903            168,635 +/- 13,526
pgsteal_kswapd          6,932,143 +/- 186,411        6,965,962 +/-
288,323        6,968,188 +/- 286,383        7,038,513 +/- 202,696
pgsteal_direct          9,759,350 +/- 480,674        9,978,721 +/-
765,543        9,899,698 +/- 480,781        9,845,668 +/- 544,319
swap_ra                        82.9 +/- 22.6             5994.8 +/-
2817.5            4976.8 +/- 1484.2            4718.2 +/- 1510.5
pgmigrate               1,029,901 +/- 428,416        1,687,072 +/-
399,505        1,260,451 +/- 202,603        1,144,560 +/- 490,177

Reclaim / Compaction (memhog)
Metric                               baseline
vss_v5                   new_opt_v2                        cc_v2
allocstall                 101,245 +/- 6,271            109,320 +/-
12,180           100,207 +/- 11,053            99,223 +/- 9,905
pgsteal_kswapd          8,817,264 +/- 432,519        8,436,548 +/-
265,763        8,728,944 +/- 305,101        8,962,443 +/- 589,012
pgsteal_direct          5,408,046 +/- 394,775        5,932,611 +/-
584,873        5,419,891 +/- 551,226        5,349,352 +/- 601,655
swap_ra                        66.5 +/- 22.8             8589.5 +/-
3325.1            8954.5 +/- 2661.9            8703.1 +/- 1746.6
pgmigrate                  239,410 +/- 46,014           277,193 +/-
71,487           320,672 +/- 59,488          243,989 +/- 136,129

You can see that the latter versions gradually restore the behaviors
of baseline in terms of reclaim dynamics :)

Some final remarks:
* I still think there's a good chance we can *significantly* close the
gap overall between a design with virtual swap and a design without.
It's a bit premature to commit to a vswap-optional route (which to be
completely honest I'm still not confident is possible to satisfy all
of our requirements).

* Regardless of the direction we take, these are all pitfalls that
will be problematic for virtual swap design, and more generally some
of them will affect any dynamic swap design (which has to go through
some sort of indirection or a dynamic data structure like xarray that
will induce some amount of lookup overhead). I hope my work here can
be useful in this sense too, outside of this specific vswap direction
:)

I will clean things up a bit and send you a v6 for further inspection.
Once again, I'd like to express my gratitude for your engagement and
feedback.
