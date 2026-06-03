Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38806481677
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506784; cv=pass; b=dbNDr4Dfnq0K/YTnrGM+cTECYYNle3leFUwpaT+EkvgUBG6dKP1va4O5AyWAbyZPwqrdIGi3pLKkRJy4L14UfVmDpMezjUd8OFJp0zOdkusHuXUTEQhYnzKYgcEvXMXmkfMIOOs1a8fdPBeD1Qrf6dvOmu3vPUcAQ70qGspWU40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506784; c=relaxed/simple;
	bh=bR57/vgSgd+7/ogqsYz4Sjit5m0TG5LQanN+1n4SIHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvoxwTyV1Ej77NksFk7o5hwL3itFyTmTTYgUtKH4eO2fWKXMSGeMhqH5xemIxcqsqQOkYJ56m3lp6QOu0ewPzdDZtYblJBG34jI4/hRCLfg/QAmvPW+omeLFDGnhxMFy9O5vfxvOaRY9bBlaDlytxAAC8JuHS46GYo1Tk/y0GsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiXcJ77N; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiXcJ77N"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so19116885e9.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506780; cv=none;
        d=google.com; s=arc-20240605;
        b=kJluDSqqS4aZ+R68NByV4RkBiiWl+dRr09LjZJyM7vTcmF4EIGSQEIealkIobYlKwK
         6KHLltiKZgL6ks8JaPLyfPKDI1XdcrRsDDVm3ntBuro0p5UMXPZea3SNvJtj21Q1gm9v
         5aLzK9A8LaKjO3LvQ4l5+93mm4aYNNddnuDoxhDaIyUvBYRojnag25aMt5Gs6oRsxX7+
         0NFWBTYaJPpmx5h4B3uEYatm3Z5FcGm/z/EkAuIYeOSQ4PtCMNJmGezqW/7TFFbdmzA9
         pcjYHQW3AbPfuTe5IaLGWJubhGJ0mYQi1xOMLkS/6GPtU2WBK7cmt+g9PBpHCROuWWjR
         k1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrFjxyk0Z/o0MfnkVA2E8r+AuJihHpuU5moBK75MRoU=;
        fh=YJ3IIPjSFObWF9V8PdInS/B0TzpaOKhBee3m61eOPSY=;
        b=DuB/gid+iJyoqmr/SLeaL9QOfhg1XxxdpcrYtwURrgUs/aMhup9FsbLr6UTBs6PHMM
         l2TJur6Yzq/jJ6hEyafAu1pFG8pHk4sUem5ibXgrX+OWnBA4/WBQjPka/AKh0NE+g4Ee
         ujUJuHLVXNqFGMve8Dddmq59pKcOcJ+jEgJgvCCs0/l30L8G+6gQyDfktEO24gm2fKCe
         jhn2HErSuEUdHJA7hYieHn2EjTDa2c3ZEM+MatGRBrIY9V7fV1MJI/Kn1awN8QFt/9YV
         y4JAVJ9e4mCQ5u1kDwuX6IORD+ySlrpwjdomG5r6sGHvLP8P7jvQd1aQA3la+9knbkbu
         T9Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506780; x=1781111580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrFjxyk0Z/o0MfnkVA2E8r+AuJihHpuU5moBK75MRoU=;
        b=eiXcJ77NfQXQLcGmMJxUzGpZCHSscrnD5lsjWpZMqeQu7mggnN82irXJd+YyqwmdA2
         reHDIWTNY14SzR7Q28gB9PQXfjYMnqZgkpywC+3m09N770Ei7tdD3U/rBkN4fcAMDdmB
         ktu79OWNrG+hhop9wHakI2468Jhu4m/0L71BX363mdKTyexYvdzAf0VcZp8VuEh1q7H9
         sc3w5vKA4wXwsuWrWDFcf9bXhJza84YtmltsQjDfkRZFM0gjs3DFwUtFw2uumGxAdMKO
         OCJyhYLGjLkuyYTk/Oinioy4KkedXNQ0/5rvwOmrezG34hWH8ITOMy/Il4miEgsEuE6t
         gYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506780; x=1781111580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrFjxyk0Z/o0MfnkVA2E8r+AuJihHpuU5moBK75MRoU=;
        b=GwyXCpjlWrmHyQESgI9kS5qmIXMKyq17LhA4JpUV3SlQxQQ4/QrgMhCshHQB0rUqWY
         FTyopu7Uilow2SNAwl9TYFJmbwfuGMHzTx1eTKGhiFQnVmEYrRbHPtu/cYyRmnpVxtDY
         aYLqSPNAXlbQEeNsMFqEknprIFvq8mUS2r1OkszNIEImM641cwx6W0ttNgLn/tb0hyT7
         KB6xKZ/zUpw6HXR9O74Gy06ZXxZqpKd4krqzmUBIuh708bEp5rakcjG31m4uLxHbZ1Qv
         FOtxwoF17WT7EYuhmnsnvcHImXolB+EVb5Ph9AuzfSSZRbUvjWTnZGvSQwMiNFYhqcx3
         8fsw==
X-Forwarded-Encrypted: i=1; AFNElJ/jGZZ6PXSuz6DqNoz7uIqGnV/562Jm/PxyZcNpjBpMPlBsKHPS+zOWNP+LOed1+DEFA/P9J78hSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn06ms6xUewRSfsJ13R5slURdhajf2Jb7c6fUdMWm/ETiFl99o
	CRnwZL3J4ItMIjVfkwBrzLoXQigwH6xpd8BOSjnDcBvc7JoaYinwqkhP1pAlHsVKR1JBI9/Ke+/
	pQzhHNQxssj4OjJ2X9N6uiMLwDADw8/0=
X-Gm-Gg: Acq92OFROi7aPABDrNcLXcRUKDwMK1U2ZJtGlW7/SB/3D4WQSA7Cz/0R7klXI5GXO9x
	Z+e7hBSz+o5WKaMkd+ORJIHg2xEOM01HZbAri3f1CZh8xkJnR9/omp66KWQ63BWqk/fJcVeBq2G
	McEZBOHp+HIXt71yBw2KL7cjtUhd4PiyOGbxKqKxvW8vwvJXzlClPKeK0APh7q+OcA9LcUSFWGS
	L5CJSedK96egidy2sJEli8Le4vadSpK6kT+5yeiBCNKMcYHYl4M/Wf7D5m1boT4EnOf3DopaQrA
	zm6KYTI+YzH7MO4wPVoEspx+HLxWD5H7vso25905J0GYbg5zSQ==
X-Received: by 2002:a05:600c:3f12:b0:490:b591:b372 with SMTP id
 5b1f17b1804b1-490b60f0030mr77803805e9.26.1780506780336; Wed, 03 Jun 2026
 10:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ah-A2gQ0GPgerXop@google.com>
In-Reply-To: <ah-A2gQ0GPgerXop@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 10:12:48 -0700
X-Gm-Features: AVHnY4I5W7pLtkTwClTAUiBCAvVnzXvNIyCOJB5qfNQcTKUvgB1xOS2GUrN2MI4
Message-ID: <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Yosry Ahmed <yosry@kernel.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
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
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> > II. Design
> >
> > With vswap, pages are assigned virtual swap entries on a ghost device
> > with no backing storage. These entries are backed by zswap, zero pages,
> > or (lazily) physical swap slots. Physical backing is allocated only
> > when needed =E2=80=94 on zswap writeback or reclaim writeout, after the=
 rmap
> > step.
> >
> > Compared to the standalone v6 implementation [1], which introduces a
> > 24-byte per-entry swap descriptor and its own cluster allocator, this
> > edition uses swap_table infrastructure, and share a lot of the allocato=
r
> > logic. Per-slot metadata is stored in a tag-encoded virtual_table
> > (atomic_long_t, 8 bytes per slot), and physical clusters store
> > Pointer-tagged rmap entries in the swap_table for reverse lookup back t=
o
> > the virtual cluster.
> >
> > Here are some data layout diagrams:
> >
> >   Case 1: vswap entry (virtualized)
> >
> >   PTE                  swap_cluster_info_dynamic
> >   vswap_entry          +-------------------------+
> >   (swp_entry_t) ------>| swap_cluster_info (ci)  |
> >                        | +--------------------+  |
> >                        | | swap_table         |  |
> >                        | |   PFN / Shadow     |  |
> >                        | | memcg_table        |  |
> >                        | | count,flags,order  |  |
> >                        | | lock, list         |  |
> >                        | +--------------------+  |
> >                        |                         |
> >                        | virtual_table           |
> >                        | +--------------------+  |
> >                        | | NONE               |  |
> >                        | | PHYS               |  |
> >                        | | ZERO               |  |
> >                        | | ZSWAP(entry*)      |  |
> >                        | | FOLIO(folio*)      |  |
> >                        | +--------------------+  |
> >                        +-------------------------+
> >                               |
> >                               | PHYS resolves to
> >                               v
> >                        PHYSICAL CLUSTER (swap_cluster_info)
> >                        +--------------------------+
> >                        | swap_table per-slot:     |
> >                        |   NULL   - free          |
> >                        |   PFN    - cached folio  |
> >                        |   Shadow - swapped out   |
> >                        |   Pointer- vswap rmap    |
> >                        |   Bad    - unusable      |
> >                        |                          |
> >                        | Vswap-backing slot:      |
> >                        |   Pointer(C|swp_entry_t) |
> >                        |     rmap back to vswap   |
> >                        +--------------------------+
> >
> >   Case 2: direct-mapped physical entry (no vswap)
> >
> >   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
> >   phys_entry           +--------------------------+
> >   (swp_entry_t) ------>| swap_table per-slot:     |
> >                        |   NULL   - free          |
> >                        |   PFN    - cached folio  |
> >                        |   Shadow - swapped out   |
> >                        |   Bad    - unusable      |
> >                        +--------------------------+
> >
> > struct swap_cluster_info_dynamic {
> >     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
> >     unsigned int index;                /* position in xarray */
> >     struct rcu_head rcu;               /* kfree_rcu deferred free */
> >     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> > };
> >
> > Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> > swap_cluster_info struct with a virtual_table array that stores the
> > backend information for each virtual swap entry in the cluster. Each
> > entry is tag-encoded in the low 3 bits to indicate backend types:
> >
> >   NONE:   |----- 0000 ------|000|  free / unbacked
> >   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
> >   ZERO:   |----- 0000 ------|010|  zero-filled page
> >   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
> >   FOLIO:  |--- folio* ------|100|  in-memory folio
> >
> > We still have room for 3 more future backend types, for e.g. CRAM, i.e
> > compressed-CXL-as-swap, which is laid out in [10] and [11]. Worst
> > case scenario, we can add more fields to this extended struct.
> >
> > Other design points:
> > - Both vswap entries (Case 1) and directly-mapped physical entries
> >   (Case 2) coexist as first-class citizens. All the common swap
> >   code paths =E2=80=94 swapout, swapin, swap freeing, swapoff, zswap
> >   writeback, THP swapin, etc. work for both. When CONFIG_VSWAP=3Dn,
> >   the vswap branches compile out and behavior should be identical to
> >   today's swap-table P4 (at least that is my intention).
> > - Pointer-tagged swap_table on physical clusters for rmap (physical
> >   -> virtual) lookup.
> > - Virtual swap slots not backed by physical swap are not charged to
> >   memcg swap counters =E2=80=94 only physical backing is charged (I mad=
e the
> >   case for this in [7]).
> > - Careful separation of vswap and physical swap allocation paths and
> >   structures adds a lot of complexity, but is crucial to make sure
> >   both paths are efficient and do not conflict with each other (for
> >   correctness and performance). I do re-use a lot of the allocation
> >   logic wherever possible though.
>
> Thanks for working on this! I mostly looked at the high-level design and

Thank you for initiating this effort in LSFMMBPF 2023 (god, time
flies). I was very excited by your presentation and decided to take a
stab at it :)

(I'll be sure to mention the full context in a non-RFC version - it
has a lot of gems in our technical discussions).

> the zswap parts, as the swap code has changed a lot since I was familiar
> with it :)

It has changed a lot since 6.19, when I was working on v6. Very
exciting time to be a (z)swap developer right now - we have new ideas
and new features every other week :) Reviewing code has been quite a
joy (albeit a lot of work).

>
> It seems like the direction being taken here is that we have one
> (massive) vswap swap device, and we keep normal physical swap devices
> around as well.

Yep.

>
> A vswap entry can point at a physical swap entry, or zswap, or zeromap.
> If a vswap entry points at a physical swap entry, then the physical swap
> entry points back at the vswap entry (a reverse mapping).

Yep.

>
> I assume the main reason here is to avoid the extra overhead if
> everything uses vswap, which would mainly be the reverse mapping
> overhead? I guess there's also some simplicity that comes from reusing
> the swap info infra as a whole, including the swap table.

Yeah it helps a lot that we don't have to rewrite the whole allocator
and swap entry reference counting logic again :)

>
> I don't like that the code bifurcates for vswap vs. normal swap entries
> though. Not sure if this is an issue that can be fixed with proper
> abstractions to hide it, or if the design needs modifications. I was
> honestly really hoping we don't end up with this. I was hoping that the
> physical swap device no longer uses a full swap table and all, and
> everything goes through vswap.
>
> I hoping that if redirection isn't needed (e.g. zswap is disabled),
> vswap can directly encode the physical swap slot so that the reverse
> mapping isn't needed -- so we avoid the overhead without keeping the
> physical swap device using a fully-fledged swap table.

Can you expand on "vswap can directly encode the physical swap slot"?
I'm not sure I follow here.

>
> All that being said, perhaps I am too out of touch with the code to
> realize it's simply not possible.
>
> Honestly, if the main reason we can't have a single swap table for vswap
> is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
> argument, even if we can't optimize the reverse mapping away. But maybe
> I am also out of touch with RAM prices :)

In terms of the space overhead I do agree, FWIW :)

I think the other concern is the indirection overhead with going
through the xarray for every swap operation, hence the per-CPU vswap
cluster lookup caching idea:

https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.com/

>
> I at least hope that, the current design is not painting us into a
> corner (e.g. through userspace interfaces), and we can still achieve a
> vswap-for-all implementation in the future (maybe that's what you have
> in mind already?).

That's still my plan. Operationally speaking, I want to make this
completely transparent to users, with minimal to no performance
overhead.

The next action item is to optimize for vswap-on-fast-swapfile case -
that was Kairui's main concerns regarding performance. I spent a lot
of time perfing and fixing issues for this case in v6. The issues with
the most egregious effects and simplest fix (vswap-less
swap-cache-only check for e.g) are already fixed in this new design,
and eventually I will move the rest (lookup caching) and more to here.

>
> Aside from the swap code, the only sticking point for me is the logic
> bifurcation in zswap. Why does zswap need to handle vswap vs. not vswap?
> I thought the point of the design is to use vswap when zswap is used,
> and otherwise use a normal swap table. In a way, one of the goals is to
> make zswap a first class swap citizen, but it doesn't seem like we are
> achieving that?

We already have all the machinery to make zswap completely
independent. Right now, if you use vswap, you'll skip the zswap's
internal xarray entirely, and just store a zswap entry in the virtual
swap cluster's vtable.

I just haven't removed the old code for 2 reasons:

1. Reduce the delta on this RFC, to ease the burden for reviewers (and
definitely not because I'm lazy :P)

2. The only other practical reason is so that we can let users compile
with !CONFIG_VSWAP and still uses zswap on top of the old swapfile
setup during the transition/experimentation period for now.

But logically and conceptually speaking, there is no reason I can come
up with to use zswap on without vswap. The CPU indirection overhead is
already partially there (since zswap uses an xarray) and further
optimized (cluster loopup caching etc.), as well as the space overhead
(vswap replaces the zswap xarray). I actually wrote a whole paragraph
about how we should always go for vswap if we're using zswap, but then
decide to remove it since there's no code for it yet.

If folks like it, what I can do is have CONFIG_ZSWAP depends on
CONFIG_VSWAP, removes all the non-vswap logic, and call it a day? :)
Then, on the swap allocation side, if vswap allocation fail and zswap
writeback is disabled, we can error out early.
