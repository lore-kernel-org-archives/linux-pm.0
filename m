Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD3175A8A
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051739; cv=pass; b=mPCny8jFX9c7NLMlA0oTjFIVrKiw6u7iD2dtKXTj4ZSVArJuUf8Y/mrDhyn1DVTxLx//DYZhUq4FdjHObugmvvOgD2F1QYBs/UWTvBVm7Cia6NOzyvARf8DSt9TTM0FD+VAeRxwNEzX51uqvnqibTD0ZKShFDJ0tQupGAUu9VeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051739; c=relaxed/simple;
	bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2aPq/9/oGefbWKM9+B0Vr7in7mv9Pe7iOIfkfZY/ZOmpVxatBNk2jvMxtggEgNIuOjS/Wb3XAq463ws8/5+A79BMcUiQjK/IkFug+8ecXEViYoZKm6WnilHMhGNF7hB5BjKefhBiiCGLI6mt7+/OD+6pCnR8jopDZPvE7geRKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPy2owZ6; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPy2owZ6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d64313c39so6314309f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 10:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777051732; cv=none;
        d=google.com; s=arc-20240605;
        b=k7FVZzuadT+642nx+5yoKlQAb2HY1w4ocd/6Sd3zZQIiZaJaCFL/sQbVxs82J1xnGK
         LmCq0tC8XiLKaKdvsTwSn559L8ANIQ3ZugaXit7OJ1ZXOvINYDeJcxmoPBhOjDx9KuST
         D4k5t7RL2ZaSUI34uMJYyjvqZoImOXJx86lBh13NYhlZX4cE6Dp8ppILiWCo4sgdiR7g
         Q4GnsgzciLlPL/ad9YNNb+I+CkuTGshfhyxgDxPRcdxV9s2Kj/i4ERsSOusk3jbebe3D
         DfapT6SBV98IXWsZniHD49TNPZW5TrSexb24BgVvMtcjRG/nD2xh+9Hl9kN8Nt+p3oT/
         z4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        fh=vF+fr6fetFIu1zZEu5mFXpXFlfRc1Wc9YTTvcmfxDD0=;
        b=RQmv4i2IlSxCpLev33AnSyhLHXGH/VJgwTwyUlVLAUFtVLyHL8jr0oS+vfLLXC0nxs
         ZKLloPWORbdTZQK19GuQHKbCcQs8Nd4dcf5ReXdjbsyuVzHGG0L2tMs58SIXzYcBdc/r
         R+ArcYpDmQ6GeL3nWnHEnF42y+NR+lH+hQ6gtcCcFrEJB6l0QmBJgapL08qAeKoIckf2
         /l4CzWXj7BoNyxs1SDy7Ol/9fv7w9JFswkKqD/Xdh1wIu8+rtIjOhCBKvD7xi3yOOrZU
         uU9PJiZ3diTEJIhn7GUpuLFWECeHnS2WiOyE70oHm0+FZRIUPONy/8p0udtAohqRx5JF
         OldQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777051732; x=1777656532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        b=cPy2owZ6YtII4s7HU+IzjLj3EwJfYey6j78hics1B9AV8z2NtwxZF6WRXlZWPQi509
         oxpTfU/Oh021kKW910cbUrVZ1UYiMuTMjpF/VHk6Q3fpYBGpuFWdwgnOxjEefp3ZICjP
         m72RiE+KG1/hmCqKkRQeF1qCNQ+T3TTXN1+O1vYTSAstcl/lgNVbJ5Zj1vwXtAtHCyb9
         CV/+hfqtVHPioT6FppX7v/+6cCcSiBsJQ6E3PXhEWNmYKEGw/jx2HEwuoxfCU5dYb/jA
         9Exi0dBvcqln8yNMB8bJTz05lQ+52ELWeFcyPNnVDFD0z5u+2Q/flQcdyYahS84Kasg8
         LmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777051732; x=1777656532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YidFLTtj8Fy5To1lZWA10VGnbGbsaMEJ758g9oG+2+U=;
        b=AheOIl6gxYoKdMdTWYLTx7XjXAEdUqckp5xfdXe1KFE8KtA6vC18TeT4di5frl/JEP
         xiaLcE77/+eTVbsYVn7a4cY6snFS/ZNFljmm6a4TustFQY+bHTbMTKqoeJJhRAzgtZWU
         vCj5RYt1+EFoCVn53Q8gGrYCOVME16shAak3caN5YJifmcIhAfyiaXrb1xYDzWnhd3ti
         vl0X9y70/Vg8e4nSMOBnhMP0PnXs+oxj4CzFDJJRuKTPRBNExyr2NdHPhmhBwOzPWdpp
         OZ6S3Tt3xp12LyEH266MH5nCFYrP3gy0EmCZMyP3AeYDRQNfNqPoEDeOLEjOSzvqd0DJ
         qBQw==
X-Forwarded-Encrypted: i=1; AFNElJ+kksBagKZjq9WXveU4QvVlyxSMKSGwOoE8EdyBwE8tXzvDeNuDvKhl5KSLPvTRpEPjyXe42PUPaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08pD0FHAvepaUU2dt+pTEgxmRGMg+ePBiV/viwu8r+DylqMnh
	LGFyej2ce9zs/tTxtJZR0XdR7r24+MfzsSAN6R9FcPutSPdWzhyklNnbKfc6xhC3jLlT7qnybix
	STThhKKfyPdfoOoNh40ubRHALk4bfqYA=
X-Gm-Gg: AeBDievkb/prKJ6bEDY+rJuqvWOac0flHUqOqhulmif6IEFaw2q5DfMZZZhDmdHmTkT
	A0iZtmfkcJLYusMAdaAo/iFEiZ0IBcAsH82rN2RFyZhHF3Pj6RHlss6D9Qyxyp6jhackOR2OF3f
	0EDMb06OMqc3thu78c0GiS6tnnlZO+76U6JGrpjp42hK1qY+AuWpegAWfdz5LCM/g6CdwA4Xode
	YXILHfdFNu43M86GVQgPj49UpvIQQ1DV8a/DxpNAK2X6XjPQZYFCXySUmI5XIzK5iwthodda5QH
	h250AiDCtWX/jA3v52krWCm7/mQUZlsLd01TwNFS9U+mBvNtR9kil8gnSeQ0/MWPAg==
X-Received: by 2002:a5d:5f96:0:b0:43d:7d24:b4ff with SMTP id
 ffacd0b85a97d-43fe3e0ae9dmr49334811f8f.40.1777051731295; Fri, 24 Apr 2026
 10:28:51 -0700 (PDT)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 24 Apr 2026 10:28:39 -0700
X-Gm-Features: AQROBzCRP5S3HopOvqFdpMFjj9C-mi3ioQAh-7_Tr6thiAF3WyHAmOj6A97QdRo
Message-ID: <CAKEwX=ORdgAwaJLv8CidOQZ0r6ZBHkDYVUxZv1k2PiaZi3qe+g@mail.gmail.com>
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

On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:

My apologies for delayed response - I'm cleaning things up, and
fighting with some memsw issue. I changed the semantic of the
memory.swap counter a bit, but that makes it diverge operationally
from memsw. Need to be careful not double charging or double
uncharging here.

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

Well yeah, great minds think alike ;)

As you have noticed, I have also converged towards a lot of your
metadata design and operational arrangement.

Case in point is the delaying of cgroup check merging with swap
freeing - I did not notice that patch you had in your series, but I
realized I had to do it as well after studying the regression for
awhile.

(I did think about proposing that outside of the vswap series, but I
was thinking it would not be a problem at all with the current code.
But in hindsight, since you're also merging swap cgroup with swap
table, it will have a similar implications, albeit less expensive due
to no xarray indirection).

Hopefully we can iron out the rest of the differences. I have a couple
more use cases in mind (compressed writeback from zswap, discontiguous
fallback for swapout, etc.), but without virtualization they seem like
a deadend :(

And Gregory's cram stuff too - I think it's not undoable without
vswap, but it's just a lot hairier :(

>
> For swapoff or migration you don't need to touch the page table, same
> as in this series, just update the virtual swap mapping to be cached
> or update the entry, it's identical to what this series is doing.

Yeah the swapoff is no big deal.
