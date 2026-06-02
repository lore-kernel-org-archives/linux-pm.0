Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C593EDE46
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414104; cv=pass; b=H92ITVhSL0D0gK60Hv8CWuPUZcOkNbjFaZ/+Sr3uQBZZtBWrRpntRR0wefHpAak2yMFIZGehqIfbqmQAesSHzvHTO+H/e8BKWoVs81k+uSoEYojEgz1gLfRHH0Gc1p3mMEdqwrDW9Aj46JXN23A4lMtMu/8pTk4vRc5E2Wh8ruY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414104; c=relaxed/simple;
	bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYTiavYW2eEmKer6RmfL3xLzzJP1RIJ07ToruK1PA+TMPwFRg6k2SruBwVfaXdqTxP9BT+FkYUiKWlmR76YjZAfDIRfeeR52WVRkvcv4T3oMaYf8PNYaR3pFJd3Iq2BFqBDueYBs4MO0273H2fNTalBLZ65fVLdiO61q22JMHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZJisVyW; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZJisVyW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef372c58aso2252774f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 08:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780414101; cv=none;
        d=google.com; s=arc-20240605;
        b=MbOABBSad/pqwlApg0iTWIfNGNQQi4S4/2dgpQsoLo7WgAJnJhZhazUusGaGevKodm
         k/3lMj4TcyqFTxXashhyGRun/wbPR3ATMLAN+2tFA4ar//0322nJFNX/S9OosVRaO7Vj
         c/tXuyYsySbu2hNuaVGyjHagepYjl+LUFQUZK+M+ODAXStdlG/f2498FwCMbYC3ouKe+
         kFbhohvQ97WX/CiTU0lRYsTX8AMNZeCDZ65izcXCL3Vh2OtBfD/KpBr+tCN0eluTCJzM
         wA9W4BRlPMnVnhkXXpBqbi1uT1O8+1oAYkXkGYMB4p2cIUJ3R0tjwvL3QQuaK5dZpZfm
         jkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        fh=BGlxz9+xA40Hs9NuRtBFg+23QZ7xyxktqp07hwe9PTk=;
        b=Yj1W0AOJh4Rn1XL/W9yvIscFTQUBa+o4kG9hEiscYwLFuwau8DEBCEY9mfbHVru5GS
         +GyUv2LgssJrQkyZ38I8qY0v+5BsKr/xatJyt8IrZWg2SxNQwk2PuereU4VZ03j9UxiX
         T/pgNMGfkN5o5pnXBKatR1Fn293fyhDmTaaZapXj4M+sht9gvKlbhuFoiFQuISvBVXN1
         79Hni964GGFjZ7PnBZCkE6t+Wb7zYer6blmWzyzIyE4v5Ykb0CQ4SDn2NbqiIFUGG7KS
         5gEw4NthemIfRWMNUelOyfKvuKnLIMR8VgGX5UmTQCPb4JK695+S8FUFnf0HvVQKm3Vq
         bpAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414101; x=1781018901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        b=mZJisVyWXmXPsPq1B+4RWVJXsEAcwnVm2eooLuPaonvGk5UuSz/RcfRnYDtaXFt1jr
         lrzNhKSFhOKb9M5nvWDdGdBQ/stkgH/VByDF7fSn4tTHpXm3Q6TZvdKjxDpRp9QsqD/c
         9pEmbNrI2DqujUzI1G22wDd9A22nC6jjZXH9C1yPOX1zafbGpaOZHWKRbLSlCU9IoMDd
         6h71mvbZ4CFPTGUBAIxyVebOS3WOWDWF626Eozevs+puG3putEyoDLgA8EsCmEsIKC79
         T99vcQTxJW4cRLJaCVY4NRFVdVFXKErPfy9zR0BTilyp31D0X/rBdl8iyePJNN0Z8Fe6
         HtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414101; x=1781018901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KioD6muOq73KOuZgXUdfc8mghtZCf5WX4ci2/jt07rE=;
        b=J01VbdR1NqwDfeNhwaHRFwtOwmpZlEmr97NdDAoPvZyb3cJ+UEiDzsDKk7Qwns6RzL
         3lBsiyt1Q3RLkGW8xBsIqnDvu+X7+6CdMMDUuaffd7MS9RVV5SfSwgp30MPCThvxwnHb
         gvja1LuKsqh3rmgkLP7C9zZ3nMA7crXJHqf1Jp7kWRD++toEsm+e8DO0cx8dkkF/n+yi
         ziT/YZ1sGjMAfA5p07KIv/zus2zFDXpaBFoH7U67iU/SRh1niQ+YFB+lRpvpaEVKs4LI
         zUif8WppCLMMb1No+3fF3Te2JhM7RImWxs08qVlRkc228tLiS0XelAiK0PP45/t72xYM
         LFbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8p98G64d95+E1da4hggHX105KIFO3TEWYRAXh1K4qlhN/jVYN5qN8FigvoSLP5ldR/wMqDIlmSUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnvUQhKcQEE4HzXwikakvjf3X4CmPV1hHwT2Lixtvs376RGPL
	APxJe2YDU1CQ11tvSnlN4VQD5qn+51Jljo9QfgXlvKRfNBddHg8xDn/4oae9O2Z9w/OYCS+depu
	3OkfNZB61Qez+lpWtUUrc+FAUn2LH5x4=
X-Gm-Gg: Acq92OHIhlhcfPAxrSqiJkJGIXpzwKAv3oct/k20eLkTsHrAOBqL9mmva3ecm/REr46
	ObAp133hgmC+8fGx1yOFqW/OCZHCAyfVRILXijfO8jhot2+KM41fdYZtlz5Jay70iKfjBFN8RTl
	shfD7+p2dXLgGclX9YMJI9MyWw7BINbXRi3+uyeptqvSCdVhx0cbPOX9jNr55rLBTaz6j9uwO7o
	nyO/pK1D+f0QmcHcZfWRo54jY6oA9G7xl22TnaLgFiFZDZM5sYKr9YwewcNlWeFjs4Wyl7+d4eP
	6TFi8yfTebToC6KpuVqDd9gv3k/tZw7hGZxusbLoBTIr7I7p0A==
X-Received: by 2002:a5d:5401:0:b0:45e:d6b2:e6a5 with SMTP id
 ffacd0b85a97d-45ef6b83764mr21337268f8f.34.1780414101045; Tue, 02 Jun 2026
 08:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
 <CAMgjq7BhOn48xEyC=2j837R7qddfjeBVHMiRqdx8no4ZEBpBLg@mail.gmail.com>
 <CAKEwX=PmwzaJhfjBrho3+kQ8HXFUC0WiegQrsguBc-_pmn5bSA@mail.gmail.com> <CAMgjq7D4XsAD4NGDL7FC2kaYAQAP8PDJdn4bpzGZwXYtjEpJ6w@mail.gmail.com>
In-Reply-To: <CAMgjq7D4XsAD4NGDL7FC2kaYAQAP8PDJdn4bpzGZwXYtjEpJ6w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 2 Jun 2026 08:28:09 -0700
X-Gm-Features: AVHnY4IWURpsnvI312VbRdsgEkqVndHtTZWSNA7JxRNHqCQ-2eUuyz0lSoO1lo4
Message-ID: <CAKEwX=OZL+ykwTjZJzUDAEnTOO6B0mibc6dxiYtmnoLReB7TYA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
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
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:25=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Jun 2, 2026 at 2:06=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Mon, Jun 1, 2026 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Mon, Jun 1, 2026 at 11:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > > >
> > > > Are you suggesting we merge the virtual table with main swap table?
> > > >
> > > > Man, I'd love to do this. There is a problem though - we have a cas=
e
> > > > where we occupy both backing physical swap AND swap cache. Do you
> > > > think we can fit both the physical swap slot handle and the swap ca=
che
> > > > PFN into the same slot in virtual table? Maybe with some expanding.=
..?
> > >
> > > I don't really get why we would need to do that? If you put the PFN
> > > info in the virtual / upper layer, then the count info, locking, and
> > > all swap IO synchronization (via folio lock), dup (current protected
> > > by ci lock / folio lock), and allocation (folio_alloc_swap), are all
> > > handled in this layer.
> > >
> > > The physical / lower layer will just hold a reverse entry on
> > > folio_realloc_swap, or no entry at all (no physical layer used, zswap=
,
> > > or after swap allocation but before IO) right?
> > >
> > > Looking up the actual folio from the physical layer will be a bit
> > > slower since it needs to resolve the reverse entry, but the only plac=
e
> > > we need to do that is things like migrate, compaction (none of them
> > > exist yet) which seems totally fine?
> >
> > All of this is correct, but consider swaping in a vswap entry backed
> > by pswap. There are cases where you still want to maintain the pswap
> > slots around backing vswap entry, while having the swap cache folio as
> > well.
> >
> > For e.g, at swap in time, we add the folio into the swap cache. First
> > of all, we need to hold on to the physical swap slot for IO step. But
> > even after IO succeeds, there are cases where you would still like to
> > keep physical swap slots around (for e.g, to avoid swapping out again
> > if the folio is only speculatively fetched).
>
> A reverse entry is enough to hold the physical swap, just like how the
> current hibernation works with a fake shadow, you don't need a PFN
> just for holding that.
>
> >
> > So you have to make sure we have space for both the physical swap
> > slot, and the swap cache folio's PFN at the same time for each vswap
> > entry. So we still need the vtable extension (well maybe the other
> > approach I mentioned could work, but I'm not 100% sure).
>
> Right, vtable extension is fine, there is no redundant data. I just
> mean you don't need to set the PFN twice (for vswap & pswap). So
> simply reusing the PFN format in the vswap layer and solving
> everything there should be enough.

Ah yeah, then I might have misunderstood you here. I thought you were
proposing a way to remove vtable :)

"don't need to set the PFN twice" completely agree. I'm pretty sure I
did not here, but do let me know if I accidentally set it twice. I'm
be sure to check this myself for the next version.

>
> > > Thanks. Not too complicated, actually our internal kernel
> > > implementation still using si->percpu cluster, and use a counter for
> > > the rotation and each order have a counter :P, it's a bit ugly but
> > > works fine. It still serves pretty well just like the global percpu
> > > cluster, YoungJun's previous per ci percpu cluster also still provide=
s
> > > the fast path, many ways to do that.
> >
> > Sounds like something that should be upstreamed? ;)
>
> I'd love to :), there is a lot of work going on as you can see and
> people seem to have many different proposals about this so I didn't
> prioritize it. I'll try as things settle down.

Yeah understandable. It's a very volatile codebase, with a lot of
folks trying to improve different aspects.

Hopefully we're close to a unified design :)

I'll keep my dedicated vswap per-cpu alloc caching for now, but I'll
get rid of it whenever the per-CPU per-si cache is ready.

>
> > > > >
> > > > > For patch 2, a few routines like vswap_can_swapin_thp seems not
> > > > > needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> > > > > same as swap cache folio check, which is already covered. Same fo=
r
> > > > > zero checking, and VSWAP_NONE which is same as swap count check
> > > > > I think. That way we not only save a lot of code, we also no
> > > > > longer need to treat vswap specially.
> > > >
> > > > Unfortunately, I think a lot of this complexity is still needed. Vs=
wap
> > > > adds a new layer, which means new complications :)
> > > >
> > > > For instance, I think you still need vswap_can_swapin_thp. It
> > > > basically enforces that the backend must be something
> > > > swap_read_folio() can handle. That means:
> > > >
> > > > 1. No zswap.
> > > >
> > > > 2. No mixed backend.
> > >
> > > If mixed backend means phys vs zero vs zswap, then we already have
> > > part of that covered with the current swap cache except for the phys
> > > part (zswap part seems very doable with fujunjie's work).
> > > swap_cache_alloc_folio will ensure there is no mixed zerobit, it can
> > > be easily extended to ensure there is no mixed zswap as well
> > > (according to what I've learned from fujunjie's code). Similar logic
> > > for phys detection I think.
> >
> > Yeah it's basically generalizing that check, and handle the case where
> > we can have indirection.
> >
> > I mean I can open-code it, but it has to be there :) And I figure it
> > might be useful to check this opportunistically (at swap_pte_batch,
> > even if it's not guaranteed to be correct down the line) before we
> > even attempt to allocate a large folio etc. to avoid large folio
> > allocation.
>
> Right, but swap_cache_alloc_folio with orders=3D<large order> won't
> attempt a large allocation if the batch check fails, so that's fine.
>
> > > > Basically:
> > > >
> > > > 1. For vswap entry, not backed by phys swap: record swap memcg, hol=
d
> > > > reference to pin the memcg, but not charging towards swap.current.
> > >
> > > Maybe you don't need to record memcg here since folio->memcg already
> > > have that info?
> > >
> > > I previously had a patch:
> > > https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-7-104795d1=
9815@tencent.com/
> > >
> > > The defers the recording of memcg, the behavior is almost identical t=
o
> > > before, but charging & recording should be cleaner and you don't need
> > > to record memcg at allocation time hence maybe reduce the possibility
> > > of pinning a memcg. I didn't include that in P4 just to reduce LOC,
> > > maybe can be resent or included.
> >
> > That works-ish when the folio is sitll in swap cache, but say if it's
> > vswap backed by zswap (and the swap cache folio has been reclaimed),
> > you need a place to store the memcg, no?
>
> "Backed by zswap" means the actual swapout already happened, which is
> the case where we always have to record the memcg info because the
> folio is gone, seems still fit in the model.

Hmmm I might have misunderstood you in my last response here.

So what you are doing in that patch:

1. Charge towards folio->memcg when we allocate swap slots, but do not
record or take reference yet.

2. Once we reclaimed the folio after swap out, then we record and
acquire reference to pin.

You know what - this would simplify my usecase. For vswap entries not
backing by pswap, it *basically* just means I skip step 1 for vswap
backend. Step 2 is shared for all cases. Donezo.

You're right. This is simpler :) Let me brew on it a bit longer in
case there might be something we're missing. but it does seem like
this will reduce complexity (and with the added benefits of me not
having to come up with names for helpers).

>
> > Just seems cleaner to centralize this info at vswap layer when it is
> > presented, for now anyway, rather than juggling this on a per-backend
> > basis.
>
> Zswap charge could be merged with vswap I think but pswap we just
> discussed that we might want to charge it differently? And actually
> vswap charge is still quite different from zswap charge if you want to
> make vswap infinitely large? I think we can figure out this part as we
> progress; it's not a major problem at this point.

That was because I misunderstood your suggestions. My bad :)

Anyway, please keep the suggestions and recommendations coming :) I'm
playing with some of your suggestions right now, and waiting for other
folks' inputs as well. Will send out the next version at some point.
If there is no fundamental design flaws, I will un-RFC once I've
addressed all the main issues.
