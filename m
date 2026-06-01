Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10292EBB8C
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330945; cv=pass; b=aUYihoEu/IiLxWlu9XDBUjTpWz964LBbdaV00ymXwjXlzpeRwUjmw2zU36zvAGTX/Ig2LLTuCq4co8ZAdSMa2BvfzjFC3DsAKXlKHQg5U8zDSPYHBVsytfLtgGaIUaNMsck5TOijNgnwQV7FHYvPLyndUCXt2YOSYYpspYYGhIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330945; c=relaxed/simple;
	bh=/Fi30s2ufSVmNT3STVyPDyIcEBwKewau9ptWSY5xCfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz/rKhxiAvBVu1PPeFA+XKcusrVIVZH2fZyhINf3tJb/fFawMDYTUi4esBO3DejQT+Rl54Zu2w0+k4U+VTyImfM/kdG65E++B9DZ41sZdmRKqmOtYWcrLc6XAcrL9paz5CIPmsZb/rV/tw8FIg9QGLvEfUJwCs1HZsNaXCyiIbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfX+r+JO; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfX+r+JO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ed18d8a1bso4005760f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 09:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780330942; cv=none;
        d=google.com; s=arc-20240605;
        b=XIM/yk6GohuOde/X+EotO1qV/QeOELpvwlnihysES8Jz3F1KQaHyPuu/VfhVNS4/Yd
         BY7/uLenXq326j5oE+3CaprR6wF2sl6+2n1VLs59YjCW53O4/VI1OWdEIWIew5b+LoqP
         npcxNnplpwqPDILCTp+RW4WX8WrPoJVY9ipZ5ENuzdGkwNLRSvHB3n3rA8KTTmk+oERN
         QqztPzrhppixeJq/fDZOajZdmhMPIevOaENLi0GDxG6J9G87G6ishQlivN+A9J8AU4ao
         JXgaGzeszHJ+G9goGfhnCAddaZ4JWxYCrjE9R6v+Aga569VRXU5qJq9KLFLmSQb6nmnG
         hwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        fh=QaxiP7DMM7yCsCUyjOCIQhz30nAnD4dhBZjCtj/lHAA=;
        b=ANRc04G6AysWfR8ZNSJxqJ32fI5KaH54DyBXhtgnYDqBr+D2E+B1Mt/bJARJJqRuUq
         4Yboa9A8IwX4mrNKbfRaQ6DS6w6jXuOMkVw6zBYhe/3VrLfch/tycDhK81VDmS+jFaQ7
         Cdag3VAAheCloehKNe18Ve2fr/FkLpiopxATo18kmB7nKFxbJhWtZ+wFDzk6N+cMOFp+
         SN4nlKrnK4bBqmhvkpA6FqP9iW2UkZoFXNQK0k0SaYEBiuQW/OOPpFPbI3e8XzuHXD5Z
         Wup6OSypPVXWWqVLB6BdWKf0RbkkMRD7IPyJ0ORtxRZXMwYtYRKsa67Blg0CFL+p/h7t
         XQiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780330942; x=1780935742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        b=OfX+r+JO2GfNsPNbwL5NOSLKoL3br4Ub1ZTmSd79LaGOnRxWtDgwaa6a+Ggzuhl+3n
         v35D6cuf+OUjdynp4qgS/yc4DUmBJQA56xpUfHTdpMNGgep4/T78hlXhNlkTwhQwW2nE
         ksqZJE7HV4e6UZjLLrJrxHBGrMhkAmNGydezUqbFT+iWBCyF1SC9KPJWgGoDXFPBy98W
         5vK0Tpw+rdDqYDYGa3iQT3TgL/V17ZxVkAzia/f8t5rb4fW0OAvb1QF41ufoRiXINaSg
         ejU6AJcXNUKVbVOnZJsR80/1TXsw0hkC+9pS3VuLRHwqXRSQdUgZPxeT8osYYYL+DGW2
         JiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330942; x=1780935742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        b=AvGdnv8v2CrMAUlbVTh3NhX10r4f669eGquLBkW7CpHhj+Sfmq3bVl712u+onHy/RE
         uEArp/BYlsUXPRLq3OUjh6ga47khTn+72k9z1K2rTJp3z24UaDcc3P/3e2Cmoaw21WDa
         jxPRCeHE3cqaPzTAHDfW5KeeE6EMWQCA+Wf75eGOFbOEtvpWAFFdN3tud8jU6mtQ9rB8
         x+QiMsoKiq3xKHOIchqd9sab5Wzna+7BAg78ACItP595nUxy7rOAvGYGg+stXWYghLVD
         i3ziNGnDZTJRtOQt4Jw/RrC4o2+DXpSLPpgSV2NKfJu3TAoS4VysNOnqECA5C0s8lJvn
         SbFA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZQm/ziJH4lqv/nVIvHhUSSsCWwGDz+x10EQXEt39Ebd9/aRt4eO1MFaRqW2jSxLCpLeHelL1QGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1xCJIHbLZGgaJCk7HHZsxUhQ8K6tIx9hUwZDuliZUJC9Dv5t
	o/xXu/SEKy+w7gRQqKkivxVp6LB9Pa1MAQTKUx+LN3WanRX3LnOmNd2YcV627vFkzHzbkFPV9vK
	lPvTtM0cKGN0z8qYpK3Jdq8D8ho6YNt8=
X-Gm-Gg: Acq92OH1pLEERJrg+uzc/wp0N7EFJIekmvQYyeTF4k4P/P29lcMuhB+0ZdS8VKE8+hV
	myKeE2CFXrSvGJvYGuW+k8utUv7S8y65B74OhjscC4fD/q2Iu5GbpFPNwfAjqWAxW9KvCqncf61
	/SdV1av2y1wuhD+tlZ33Bj4udZiLIShnBKeodA/FWjZzRhSUo7UJN1I5w5F3CyCWrbVbcmcTnYx
	khL3p4zyXlMRPMxl5V8fWRxtSenNUcGhxnkYT2x1sFqy+gjCH2SQewxXCPcXrReQPhKtrpWEU97
	lZ/Yt0Vfg7LrkQPE4r4yY8DATcpwaWs2dNhtf/ySLU7zF9pnYQ==
X-Received: by 2002:a05:6000:4606:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-45ef6b7fc88mr21958786f8f.23.1780330941755; Mon, 01 Jun 2026
 09:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
In-Reply-To: <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 09:22:09 -0700
X-Gm-Features: AVHnY4JTa-fR_5tUyRZOpBI2CAX77bPy73iuDZGeYtyu2utS9mSBpebHo1xGb-U
Message-ID: <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Kairui Song <ryncsn@gmail.com>
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

On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > Based on: mm-unstable @ 444fc9435e57 + swap-table phase IV v5 [2].
> > >
> > > I manually adapted Kairui's ghost device implementation (from [4])
> > > for my vswap device. I've credited him as Co-developed-by on Patch I
> > > since a substantial portion of the dynamic-cluster infrastructure is
> > > his (I did propose the idea of using xarray/radix tree for dynamic
> > > swap clusters allocation and management though :P).
> > >
> > > >From here on out, for simplicity, I will refer to swap table phase I=
V
> > > as "P4", and the older v6 virtual swap space implementation as "v6".
> > >
> >
> > ...
> >
> > >
> > > This series reimplements the virtual swap space concept (see [1])
> > > on top of Kairui Song's swap table infrastructure, on top of [2]
> > > and in accordance with his proposal in [3]. The proposal's idea
> > > is interesting, so I decided to give it a shot myself. I'm still not
> > > 100% sure that this is bug-proof, but hey, it compiles, and has
> > > not crashed in my simple stress testing :)
> > >
> > > The prototype here is feature-complete relative to the swap-table P4
> > > baseline =E2=80=94 swapout, swapin, freeing, swapoff, zswap writeback=
, zswap
> > > shrinker, memcg charging, and THP swapin all work for
> > > both vswap and direct-physical entries =E2=80=94 and satisfies all th=
ree
> > > requirements above: no backend coupling (zswap/zero entries hold no
> > > physical slot), dynamic swap space (clusters allocated on demand via
> > > xarray, no static provisioning), and efficient backend transfer
> > > (in-place vtable updates, no PTE/rmap walking).
> > >
> > > II. Design
> > >
> > > With vswap, pages are assigned virtual swap entries on a ghost device
> > > with no backing storage. These entries are backed by zswap, zero page=
s,
> > > or (lazily) physical swap slots. Physical backing is allocated only
> > > when needed =E2=80=94 on zswap writeback or reclaim writeout, after t=
he rmap
> > > step.
> > >
> > > Compared to the standalone v6 implementation [1], which introduces a
> > > 24-byte per-entry swap descriptor and its own cluster allocator, this
> > > edition uses swap_table infrastructure, and share a lot of the alloca=
tor
> > > logic. Per-slot metadata is stored in a tag-encoded virtual_table
> > > (atomic_long_t, 8 bytes per slot), and physical clusters store
> > > Pointer-tagged rmap entries in the swap_table for reverse lookup back=
 to
> > > the virtual cluster.
> > >
> > > Here are some data layout diagrams:
> > >
> > >   Case 1: vswap entry (virtualized)
> > >
> > >   PTE                  swap_cluster_info_dynamic
> > >   vswap_entry          +-------------------------+
> > >   (swp_entry_t) ------>| swap_cluster_info (ci)  |
> > >                        | +--------------------+  |
> > >                        | | swap_table         |  |
> > >                        | |   PFN / Shadow     |  |
> > >                        | | memcg_table        |  |
> > >                        | | count,flags,order  |  |
> > >                        | | lock, list         |  |
> > >                        | +--------------------+  |
> > >                        |                         |
> > >                        | virtual_table           |
> > >                        | +--------------------+  |
> > >                        | | NONE               |  |
> > >                        | | PHYS               |  |
> > >                        | | ZERO               |  |
> > >                        | | ZSWAP(entry*)      |  |
> > >                        | | FOLIO(folio*)      |  |
> > >                        | +--------------------+  |
> > >                        +-------------------------+
> > >                               |
> > >                               | PHYS resolves to
> > >                               v
> > >                        PHYSICAL CLUSTER (swap_cluster_info)
> > >                        +--------------------------+
> > >                        | swap_table per-slot:     |
> > >                        |   NULL   - free          |
> > >                        |   PFN    - cached folio  |
> > >                        |   Shadow - swapped out   |
> > >                        |   Pointer- vswap rmap    |
> > >                        |   Bad    - unusable      |
> > >                        |                          |
> > >                        | Vswap-backing slot:      |
> > >                        |   Pointer(C|swp_entry_t) |
> > >                        |     rmap back to vswap   |
> > >                        +--------------------------+
> > >
> > >   Case 2: direct-mapped physical entry (no vswap)
> > >
> > >   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
> > >   phys_entry           +--------------------------+
> > >   (swp_entry_t) ------>| swap_table per-slot:     |
> > >                        |   NULL   - free          |
> > >                        |   PFN    - cached folio  |
> > >                        |   Shadow - swapped out   |
> > >                        |   Bad    - unusable      |
> > >                        +--------------------------+
> > >
> > > struct swap_cluster_info_dynamic {
> > >     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
> > >     unsigned int index;                /* position in xarray */
> > >     struct rcu_head rcu;               /* kfree_rcu deferred free */
> > >     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> > > };
> > >
> > > Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> > > swap_cluster_info struct with a virtual_table array that stores the
> > > backend information for each virtual swap entry in the cluster. Each
> > > entry is tag-encoded in the low 3 bits to indicate backend types:
> > >
> > >   NONE:   |----- 0000 ------|000|  free / unbacked
> > >   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
> > >   ZERO:   |----- 0000 ------|010|  zero-filled page
> > >   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
> > >   FOLIO:  |--- folio* ------|100|  in-memory folio
> >
> > Thanks for trying this approach!
>
> Thanks for the suggestions. I hope going forward we have sth concrete
> to tinker with, rather than abstractions :P
>
> >
> > For the format part, PHYS don't need that much bits I think,
> > so by slightly adjust the format vswap device could be share
> > mostly the same format with ordinary device.
> >
> > For example typical modern system don't have a address space larger
> > than 52 bit. (Even with full 64 bits used for addressing, shift it
> > by 12 we get 52). Plus 5 for type, you get 57, so you can have a
> > marker that should work as long as it shorter than 1000000 for PHYS,
> > and shared for all table format since it's not in conflict with
> > anything. You have also use a few extra bits so a single swap space
> > can be 8 times larger than RAM space, and since we can help
> > multiple swap type I think that should be far than enough?
> >
> > Then you have Shadow back at 001, and zero bit in shadow. The only
> > special one is Zswap, which will be 100 now, and that's exactly the
> > reserved pointer format in current swap table format, on seeing
> > si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)
>
> Are you suggesting we merge the virtual table with main swap table?
>
> Man, I'd love to do this. There is a problem though - we have a case
> where we occupy both backing physical swap AND swap cache. Do you
> think we can fit both the physical swap slot handle and the swap cache
> PFN into the same slot in virtual table? Maybe with some expanding...?
>
> Another option is we can be a bit smart about it - if a virtual swap
> entry is in swap cache AND occupies physical swap slot, then put the
> folio at the physical swap's table, use folio->swap as the rmap.
>
> (I think you recommend this approach somewhere but for the life of me
> I can't find the reference - apologies if I'm putting words into your
> mouth :))
>
> But this is a bit more complicated - extra care is needed for rmap
> handling at the physical swap layer, and swap cache handling at the
> virtual swap layer. Maybe a follow-up? :)
>
> >
> > Folio / PFN can still be 010 as in the current swap table format.
> >
> > Then everything seems clean and aligned, no more special handling
> > for vswap needed, there are detailed to sort out, but it should work.
> >
> > > - Pointer-tagged swap_table on physical clusters for rmap (physical
> > >   -> virtual) lookup.
> >
> > Or reuse the PHYS format (rename it maybe) since point back to vswap
> > is also pointing to a si.
>
> Noted. I'm just doing the simplest thing right now - working
> prototype. I mean, we have enough bits :)
>
> >
> > > III. Follow-ups:
> > >
> > > In no particular order (and most of which can be done as follow-up
> > > patch series rather than shoving everything in the initial landing):
> > >
> > > - More thorough stress testing is very much needed.
> > >
> > > - Performance benchmarks to make sure I don't accidentally regress
> > >   the vswap-less case, and that the vswap's case performance is
> > >   good. I suspect I will have to port a lot of the
> > >   optimizations I implemented in v6 over here - some of the
> > >   inefficiencies are inherent in any swap virtualization, and
> > >   would require the same fix (for e.g the MRU cluster caching
> > >   for faster cluster lookup - see [8] and [9]).
> >
> > This could be imporved by per-si percpu cluster. Both YoungJun's
> > tiering and Baoquan's previous swap ops mentioned this is needed,
> > and now vswap also need that. If the vswap is also a si, then it will
> > make use of this too.

Oh and the MRU cluster caching I mentioned here is not the allocation
caching. It's the lookup caching, basically to avoid doing the
xa_load() to look up clusters for consecutive swap operations on the
same vswap cluster (which is the common case with vswap). For v6, it
massively reduces this indirection lookup overhead. Performance-wise
it's an absolute winner, just more complexity (because I need to
handle reference counting carefully).

I also just realized we'll induce the indirection overhead on
allocation here too, even if the cached cluster still have slots for
allocation, because we look up the cluster (which is basically free
for static swap device, but not free for vswap devices). Might need to
take care of that to maintain vswap performance (but it will then
diverge from your existing code...).
