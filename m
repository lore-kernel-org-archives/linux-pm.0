Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11828469B
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775958059; cv=pass; b=XaFRJv+Q/OZ6E0lOgoMwR5D01TQkbQ31+8zj/fUz6wNs2KOTio18Ei0Pnm0E8WUK0HhREYXryZTyY4poOc1T+GADzNrYGbOp/lWm2uU2MZD/WKV/zXm/TlUosU2/KlQROUFmrb1BYdBz1iGMIDY6qLiMJ5EaT/iJ/UQnWybHyNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775958059; c=relaxed/simple;
	bh=5E5QbGFOnajr/tQmuUwrVb/jTxudxHKJpPBo00XNySY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOzrBlfgfnojhkq0ZlaVT+/wxQwaT5SH6s/GFarPNtjxO2AvdCtq/phak+g1FDcuSXq1LDCt3RbOHLLs9Cq7ui6USw2asL9X4P7+yuDM4v+qdo8hwloPEJoYmfysc+ObfNEsx66TM57+Ormns3UpnGSaRUW+6QqdqJ7ai4ffirM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrFYv38S; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrFYv38S"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2095257f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 18:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775958056; cv=none;
        d=google.com; s=arc-20240605;
        b=e4xtFu6w/D++TXXtkmUfnI+HmckT35dLvBhpRKu5XOSOTGbMrhN6l1bShSTSH5RDl6
         +Diyj/6igVLvu2nVSDz/uzgBgs09M2MgdIoOatBdzWQ1S9YO80LgdASRrFL+NgcQFOcE
         pxPI2996ku77iL6l7l6vvq10qNNDPxxmBfcynJQHbR2xMDcQbgl/QNh1ZIPAUqWtPqlh
         /mSI+fYYGHimclv06JyOuVzLSG4HMxhuaxscECp0ABrss13NaP+81IlLNU9tdmFCmXyK
         cnX1zx6wsm4HkHJ+pIg1KmGW90UwNxynyyQPpcH81JxEYGF1MqX9rjzlYON3IeORF+Vc
         YGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rNNOEzC050HR38tQUwt60z/EV+azgbNAgyZ323Y4lY4=;
        fh=FKCq9nfv2e7sWO0dAfmCD2eayTrbnRc/V8agDpd0q/w=;
        b=P3RJi7SBY6/8yHdFN3t6zWNb94KvkR0AqXPpND7zYQcMhVDffUfbiDYs58pV22Qlq9
         /PzbCY/LeFWKmZsVCTwqNys+swVNSXnRTRzpZKTB/oA50nZs/EiRq9PXRdOETXEzhbTD
         RqKkSGx3zC4ThhJSijdUjjZBpdtH7XM5hb2pvNGIHMgxRrrgVyDjREzIMjaVivEh17f1
         7vzk4uha3vKXl6tgOalwHiboGnjuaQm2p8j4nUIxx1f8CS6g8015xydRHnRSoeC83+Ol
         V5QDPZ4WzY5xzI7vMC7EytDkaHZ5IqD3cz5ACx1zGd9CQwLuqVMJG5Y3vBqVPbekdp74
         RYNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775958056; x=1776562856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNNOEzC050HR38tQUwt60z/EV+azgbNAgyZ323Y4lY4=;
        b=JrFYv38SZoz+XcSNhu5E6iD6qja+UPLdB+doM06n7IfmaBWeAR45le7wLplsI0NAYj
         bHlgd7WM6yTkbdOUXnMJN/Wfb9FX9hoYaY0tYuDr0rN9xrPxZqI41/BxPXomcO/MBzbY
         g6XPrQdD61ESkeAvFmYf2GZwGLjOTodEYlRV7REXkMJxnz/+5lVglWtHCryNxfyBnvXz
         NwjtvdF33TZ6tOjeII/kUkpF5WRtOAPBVvw5d103+ArCnBATXuHCyIZzrot5B2ZN7j3C
         PuMTxvIFyGbrB3nX9lEaNr08GsPI2MyV0euk25kvvvFLje0uS9VFrnckA3Zd3H1xajHt
         BSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775958056; x=1776562856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNNOEzC050HR38tQUwt60z/EV+azgbNAgyZ323Y4lY4=;
        b=aOLEepLlLHEQReTUJS3POdvW6JMbvBCTrUPHMK1+pEK9CzUqaLRwirQY4ZZDOCwxpF
         oQd2irVW483LtJLqJZH/UTH61vMAvubrLRlIj81a1YaYZ2ZeMLtvDyw6hmgAWPATZV1H
         dVYrxp4M2StmUHTWZyS7cuvwaHYahcqUXCYiMUYdyR0jY6V6411KDu7l2uvGyZIscS12
         B1bPDKS5th2jtfcGZBsysqMZowfrNICmqPHGjzjcTlqzcu2qCgvFqBU1YWvtiBUFmdCh
         kwAibFCCF7jYtHqy5FL5E+JepMMhZNkHEAh35BDOJnXNkmnRq5IxezfV/uKa5nmMGh5a
         ztAA==
X-Forwarded-Encrypted: i=1; AFNElJ8okqWqFV41I78zIFro58Gp1tOHvJI5/HYFdixyvaaK5CIJWaL8epxsAu5efEJ5toHrA4NX1e2zGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iA5Pdc4G9uiQK/PM1CNCMR2qLxprn5WFtqYXkWItT7qGNAaW
	0/5c2RM2l1R4S/zuZrO+ZGShN2y9tXE7VS2SqLjzjCln0CvQ0EiU3Wrm5EdLWwVY6D60zEd7i1/
	nqWpS4aq3EQfVZoE/j2TWMjpscwLSx3Q=
X-Gm-Gg: AeBDietDE8Kzle5eTIGbPt/ifji4jZgsxUt+O8ZeqIBgqnil9vPu0qmOno8DpLYagFF
	vgFbu7/lZuoT+24smiipWbdf9TEe6wV6HXjKdUpaI61hYgeyxRMsmasyugyt7nO8nJCNp/PmSEP
	oMyxWMlZ4pLkVGQM8PemLTdOI+OWGxrWl28gGgHtmC41wMnahUBLEodaYoEWXlFphvOfKjt/RGT
	JmF+90An7MtegrFAHOVj0lz+hKZcC9xk1A7+01y6Rvd09xzH1O2KJplUsZaP3xjeTQL1mE+eRV2
	VCs1tIoclgZgBPbVwE+WvQ0doIuf9r9pnWBidQ==
X-Received: by 2002:a05:6000:1847:b0:43d:3004:5fef with SMTP id
 ffacd0b85a97d-43d64274a7fmr12585642f8f.7.1775958055842; Sat, 11 Apr 2026
 18:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
In-Reply-To: <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 11 Apr 2026 18:40:44 -0700
X-Gm-Features: AQROBzDroNuERyKabe8GygVxq5Z0i9E7OcIym5VR0h4i9PyTzTJ9gMs3fd__1QA
Message-ID: <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
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
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

n Wed, Mar 25, 2026 at 11:36=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> >
> > This patch series is based on 6.19. There are a couple more
> > swap-related changes in mainline that I would need to coordinate
> > with, but I still want to send this out as an update for the
> > regressions reported by Kairui Song in [15]. It's probably easier
> > to just build this thing rather than dig through that series of
> > emails to get the fix patch :)
>
> Hi Nhat,
>
> I wanted to fully understand the patches before asking questions,
> but reviewing everything takes time, and I didn't want to miss the
> timing. So let me share some thoughts and ask about your direction.
>
> These are the perspectives I'm coming from:
>
> Pros:
> - The architecture is very clean.
> - Zero entries currently consume swap space, which can prevent
>   actual swap usage in some cases.

Yeah not just zero entries. Compressed entries consuming a static
space also makes no sense to me.

> - It resolves zswap's dependency on swap device size.
> - And so on.
>
> Cons:
> - An additional virtual allocation step is introduced per every swap.
> - not easy to merge (change swap infrastructure totally?)
>
> To address the cons, I think if we can demonstrate that the
> benefits always outweigh the costs, it could fully replace the
> existing mechanism. However, if this can be applied selectively,
> we get only the pros without the cons.
>
> 1. Modularization
>
> You removed CONFIG_* and went with a unified approach. I recall
> you were also considering a module-based structure at some point.
> What are your thoughts on that direction?
>

The CONFIG-based approach was a huge mess. It makes me not want to
look at the code, and I'm the author :)

> If we take that approach, we could extend the recent swap ops
> patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-bhe@re=
dhat.com/)
> as follows:
> - Make vswap a swap module
> - Have cluster allocation functions reside in swapops
> - Enable vswap through swapon

Hmmmmm.


>
> I think this could result in a similar structure. An additional
> benefit would be that it enables various configurations:
>
> - vswap + regular swap together
> - vswap only
> - And other combinations
>
> And merge is not that hard. it is not the total change of swap infra stru=
cture.
>
> But, swapoff fastness might disappear? it is not that critical as I think=
.

Yeah that's not critical. It's a cool beans optimization but nobody
does swapoff and expect fast ;)

(It is a lot cleaner tho but again not my first priority).

>
> 2. Flash-friendly swap integration (for my use case)
>
> I've been thinking about the flash-friendly swap concept that
> I mentioned before and recently proposed:
> (https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdge-T330=
/)
>
> One of its core functions requires buffering RAM-swapped pages
> and writing them sequentially at an appropriate time -- not
> immediately, but in proper block-sized units, sequentially.
>
> This means allocated offsets must essentially be virtual, and
> physical offsets need to be managed separately at the actual
> write time.
>
> If we integrate this into the current vswap, we would either
> need vswap itself to handle the sequential writes (bypassing
> the physical device and receiving pages directly), or swapon
> a swap device and have vswap obtain physical offsets from it.
> But since those offsets cannot be used directly (due to
> buffering and sequential write requirements), they become
> virtual too, resulting in:
>
>   virtual -> virtual -> physical
>
> This triple indirection is not ideal.
>
> However, if the modularization from point 1 is achieved and
> vswap acts as a swap device itself, then we can cleanly
> establish a:
>
>   virtual -> physical

I read that thread sometimes ago. Some remarks:

1. I think Christoph has a point. Seems like some of your ideas ( are
broadly applicable to swap in general. Maybe fixing swap infra
generally would make a lot of sense?

2. Why do we need to do two virtual layers here? For example, If you
want to buffer multiple swap outs and turn them into a sequential
request, you can:

a. Allocate virtual swap space for them as you wish. They don't even
need to be sequential.

b. At swap_writeout() time, don't allocate physical swap space for
them right away. Instead, accumulate them into a buffer. You can add a
new virtual swap entry type to flag it if necessary.

c. Once that buffer reaches a certain size, you can now allocate
contiguous physical swap space for them. Then flush etc. You can flush
at swap_writeout() time, or use a dedicated threads etc.

Deduplication sounds like something that should live at a lower layer
- I was thinking about it for zswap/zsmalloc back then. I mean, I
assume you don't want content sharing across different swap media? :)
Something along the line of:

1. Maintain an content index for swapped out pages.

2. For the swap media that support deduplication, you'll need to add
some sort of reference count (more overhead ew).

3. Each time we swapped out, we can content-check to see if the same
piece of conent has been swapped out before. If so, set the vswap
backend to the physical location of the data, increment some sort of
reference count (perhaps we can use swap count) of the older entry,
and have the swap type point to it.

But have you considered the implications of sharing swap data like
this? I need to read the paper you cite - seems like a potential fun
read. But what happen when these two pages that share the content
belong to two different cgroups? How does the
charging/uncharging/charge transferring story work? That's one of the
things that made me pause when I wanted to implement deduplication for
zswap/zsmalloc. Zram does not charge memory towards cgroup, but zswap
does, so we'll need to handle this somehow, and at that point all the
complexity might no longer be worth it.

>
> relationship within it.
>
> I noticed you seem to be exploring collaboration with Kairui
> as well. I'm curious whether you have a compromise direction
> in mind, or if you plan to stick with the current approach.

I do have some ideas while discussing with Kairui. I'm still figuring
that part out though.

What I'm working on right now is tracing all the inherent overhead of
swap virtualization, regardless of the method we use.

>
> P.S. I definitely want to review the vswap code in detail
> when I get the time. great work and code.
>
> Thanks,
> Youngjun Park
>
