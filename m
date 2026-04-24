Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2420CCDC
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004777; cv=pass; b=VVBJ6kXJwmd/B9yxBd3W2fqOjvYE9TUmCFm4FeYOSENjyCCJlP3kYW3ztMnwBzwaneqzFrmBJxZYE0n9Ej+erO8OC9NQgpCPWjpTPKC5P1I2hAphu2Z/1N5aXXjm6f51f9knNSJzZs3Z+xeUuxtrSJcCEqfRMRKu46FMorrTZr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004777; c=relaxed/simple;
	bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcCnSQG9YM2O+J3/9VuJU/DFzAhYC/DboCTu6wT9t1gCNWf6eIfBxcZd/aQlZKMxPGQhBwLMdUKHVHHY7CAlqUONb0XbCpS+08qsLzscQdChRNLdYfDw8IYk7GdHEQQnGkgwL86wAxqeLIHPUjccPlJwekJ4j4cMgAISjPpD3Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcFiP5/A; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcFiP5/A"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso500565566b.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 21:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777004775; cv=none;
        d=google.com; s=arc-20240605;
        b=jzfwa9IPxeMvnzVYfUaRki2ysC/zvVsYWP6OfIviUn/EZ5F2h9Gg73AcywT+riCx+3
         0T2Eou+5JDSgTtj0LhYUVjh21b2j3tv0A+jDtHnSN9zZQzh3qSrIabG61Ilp8cpKqEVm
         81J/zuslWIDdrzTjLU9DGN9c6G4fupUFIY6li9K1MVznL0ZU6pei5IzwA+v0P3lnG7gk
         pKfsvM3+aF+nRxIoGvJ4UmW/m6xI46AQ+9d080ncSgl/5UNKdhVSyjIm5jQJVDur1Lqo
         wfhZmiLA0c1mkszLdVG/x/pleV4tKHj5adNYDr3KO71NSkpSkTgYWEEUzfDzZhpjIi74
         LnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        fh=yhtk1sMuE/19Az8pSOZ9r6OhGYA1+SXDGxDkOVDS3Mk=;
        b=fl0Z7ZoYMMal5IsKY2G38j519MhWs3dIXo8PIU1Fqbv1+4EKnRWwEsv1cwSeCH3IEM
         1UOpXiM00SHGveiFkfa5w/kiJo44YUXyXLUToy9nYqYebwZc3aAc+2bpZsu8PCzeDpe5
         XVWxwux3F5yAOfT4cvTM6r6VySHkMCTOR9vuH43pWgWx2OY3kEdjX9T/ooNYZ9fGcHJd
         iZtimsfCAMB27XdSzsR261rAR+MlvXRKKOLWNEwU+c32kMg0qwHor1zz73FbQzXChSnA
         ERNVcWfYvCvNSq4faBvUOdZ74Colnx5rJVOdaIRjKK6E6Og0ssl8iuVYNBNLS71lESTW
         jHWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777004775; x=1777609575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        b=jcFiP5/Al5Xwhl4JoG6NyE0iNEX4w/A4Jr+jPw5FuuwJZ4utBjLuX1V5LOpRL7mFY3
         0Sx9EEwo/SyhruXyeHuxquH5IHomvjsUpdZwJXxde/c2XpySXQvYdF80z/Wlw4cFiYb6
         v2MEy2OndyUltBh3tVo67xpwa1ubRxLF/7qRa258PV/UG8DCwVlbh1+bwnM1XtmUaOnn
         LR8shV32nK8yTJP3atNcg10KsL2ghaIFP38ZIInrYp8HXJZs9Hf6M6/POjJ1xmsYDI5X
         jtdnS58aYn7L8amLlF2n/8huquEWLPNe9ayUPlbbPZU0ruhGgCe3vO+LNtYSN5gpVj9b
         BBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777004775; x=1777609575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ik1IXjkQGe/1mCxzMlkTq7jyLpXW+ghrJTKxgI9AJXU=;
        b=a17kTcglZ0J3a5tnnuSs9SRdOkCCNKiWnIY3XpPh8XRAFGJO1woapODdOoZ1oDOZI6
         vVkdRmjSjSJIebhH8+IGKsOkY60tJpg/JzOzmPqYJBIGTZpAF1MofB0x2EyRWbErz191
         un09BCRtEWSzvpI0thsde5QAvzscJ00BJQTQOVC63OB+9f31JCjfSNn/e5D8OnAFmOZF
         rK54ugbU6cZhSiOoTADdP79H7Q//irB4q5UykIspbKUnAjxjDlOL5Fuir9dzi0djE4aZ
         iE2jj6w+EZ9rRXrPYKQJFNBE8bmCjp1wdzCH03fzj+wpCN2hYkEYN7BupoOa+729qdzQ
         1H/w==
X-Forwarded-Encrypted: i=1; AFNElJ/1Wd/EzA05Am7v8FyNIrXmUrhNFWX8a8aLn/Iw8ab8U5N7KM82EBUmYpu1p2hxaAP5jVxviDq/uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPidWsHTwxFTA/u3LhnxzXUNVUcKyOU/YHjJw3uN3oaJoCsJs
	Nwa+8OpCpG1IJZQSIpdkywMpEaobcFGq7oJ7fQ8Mqc0QkmZ0JiJ8BaF5JFQSGRTLLDhml/yOBiS
	K4gQ46cR+rGNbLlTsUchsi/KN1hizjKU=
X-Gm-Gg: AeBDietVd36yeFF46FXLR3Tc6sIcXAkE39Pa2/IoQ4WAOlctWXJgKoDK3ylotYLwHd9
	RUiCz+cKDyvQcKtt8xbdWZwJhDv93gjEuyjUV3ckAd+aiqgpXqGEu/6A7ayRFrHjaLbpQRYePmz
	fLf8AC9b7JMb3Lx6OjiiJijat0kkHQdUs756as818Rhm5S6PJrAOlHD0RwlDJXww927Sy+3JND9
	Rk8Nimx4ZCKlwRCPMPBr5SdloKdwpyccOXXsdYmvqSfNp/ldUcSp/LzwseaQuSQiCI6Oei3ij+4
	g2sZnOKSpamPweFK707Z8GBWUjTtoOuOmg4XvLpXMMOU/LFmNw==
X-Received: by 2002:a17:907:7f94:b0:baa:3cf6:4f53 with SMTP id
 a640c23a62f3a-baa3d0598e6mr755922966b.5.1777004774432; Thu, 23 Apr 2026
 21:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com> <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
In-Reply-To: <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Apr 2026 12:25:37 +0800
X-Gm-Features: AQROBzDSTb6IkbZFirEBaP59AWqfa9zcQlpgQGNGPOmXf4DwwEQvNG1RpzWB-PY
Message-ID: <CAMgjq7D-xpzWz=v5jj76vuRRBJwaEkt-gJKaviJALLY7UX76cw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Byungchul Park <byungchul@sk.com>, 
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

On Fri, Apr 24, 2026 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > Using a swapfile does have its benefits, though. For example, the
> > > virtual layer could act as an ordinary tier following YoungJun's
> > > design:
> > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.par=
k@lge.com/
> >
> > Hmm I didn't look too closely at this but I don't understand how
> > making it a swapfile helps with tiering? If anything, I think it makes
> > tiering more difficult. For tiering to work, we need an
> > abstraction/redirection layer, such that we don't need to update the
> > page tables (or shmem pagecache) if we demote/promote pages. That is
> > exactly the use case for a virtual swap layer. The page tables point
> > at a virtual swap ID and the backend could change transparently (e.g.
> > for zswap writeback, or tiering).
> >
> > If we make the virtual layer a swapfile, how do we demote/promote
> > without updating page tables?
> >
> > IOW, I think the whole reason we want a virtual layer is to separate
> > the backends, which would facilitate tiering. If the virtual layer is
> > itself a swapfile, wouldn't it become one of the tiers?
>
> That's exactly what I hoped, virtual layer being part of the tier.
> Tier could be set up per task / cgroup. So is the virtual tier.
>
> A standalone implementation of the virtual layer is more heavy than
> being a swapfile. Actually I think at this point, it is the word
> "swapfile" is misleading now. We may rename it to "swap mapping" or
> something. A swap mapping could be physical or virtual. Virtual
> mapping can realloc from physical ones (redirect), and swapoff of
> physical ones just read its data into virtual mapping's swap cache.
>
> I think it's actually functionally very similar to Nhat's design
> already from a high level, the only difference is we don't need
> standalone infra for virtual parts.
>
> For swapoff or migration you don't need to touch the page table, same
> as in this series, just update the virtual swap mapping to be cached
> or update the entry, it's identical to what this series is doing.

BTW it does look like file mapping. In the long term maybe we can
merge part of the swap mapping with file mapping again, not sure
though. Swap mapping is a bit different as it's integrated with
allocator, and previously it was reusing file mapping, but we had to
use a lot of strange techniques e.g. split the mapping to avoid lock
contention / special lookup routine / synchronization / handling
writeback in an entirely different way. Just an idea and reference
here.
