Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1F1A6810
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004170; cv=pass; b=pC7yuHMV2aeJzKuKic2mbCfHxRHj4h6u7fKZpOhZs341IEQ/RvFD54fdK0gF7HNonsOFCmtICIj1s/vrDm3Rzp5oD+/R4L2tjnJmTXS3uYImUyKNiNf/NBk2QyXUMdplfhxEcwrexM1GByyVQJw2AKYBUIU6tuR4u1PPyl9E+AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004170; c=relaxed/simple;
	bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBIBQ4dxD1kMk5eraFY0HcKAcQjOpGcueYRjHYiHX/4xOHZ0IYBOoYCvj8MX76MPulbOtOQKQgUAb5772vtu1T/r1lKQqoG8Q6KE5GRtQMQMJ0l4tULfGMLALEzFr1s/T+csVG8zgqWlzPsdNu72/gUc8QcWLMQzzr8NpuXidWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2+UmzKi; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2+UmzKi"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671c24f23b1so10694284a12.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 21:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777004167; cv=none;
        d=google.com; s=arc-20240605;
        b=XVbyjCohhEoGO9Vj3GcsvGjT66ox05E/WMEIfl7dvX1dohCGGsZqPiyBQJXMgxLLaC
         /E3wOLnoHOmug3qFSOARkn7I3Wrcu2SL4ke5LKBVskdHTVerNdoHLdKwkVY1Bj7iieit
         HZh66/nBH4TOxwONRShKD/Ck0MPoNbKwoP2dZ7DXgAgL09xEII/Y54MKyF1jbsnSu8li
         wo3jBPdt17WLjPxUbODt3T6vqlFm+mI7qiUR7K08Ccxy7gTXUGialMosqHKpGXjXd7+2
         Nn9oFbwVxzNqGTBEtub4i62oZSydPzECGXLY5BHTse1pTQvVy9rajfmCpl/C3GjpjbD5
         lzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        fh=0DUAN3VCu7yAY8M6hJVEMqYsE4wzYJSUr3fgE+jJvvM=;
        b=RtwnJELZtbCLsVmVl1UVzTiWe6aLbqXJyIix+eLbVnTXpZGDmMBNgY+nUickGoIf6n
         vSO8q7A+HhF1/1jZjBETOTifBQNcgnrtw05jNbr/kWY8eqkBDzM7XtXwQVw+awTtwl4c
         3ccnLXKcbYB/CDqEtDbkRVYtf2aGDoukkRPG8UbjGbenfAM1OshkKxdrV4NNs9QuSrZ2
         yemKfN5pfQQtUsBZq7CxLPWOXhkFO8YLLQUJOufmFJ55TBDwgsmxsAQmvqi2Gw+NgFvq
         G8/L7Vm0B03ndaOSio1n0YJIDvDr4ChB4TMVlvvM1zflP7XlZzJ7xbgEvgJG09Bragjy
         fJog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777004167; x=1777608967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        b=L2+UmzKioJNWV4vcQdznhpNv6iXWw4TRAlZWZLKNBsyaKBGbr0xuXS5Vk55tbhYEAn
         aZeKgu/iO6Y18b+HXWgRVm9ZC2vlW6fuJrhXL6xnR6JM+0K+rlDbbL4nyZv4JYYDZHBw
         KqCMsXg+oj573jfNyXEEvWjgFD8+vGc9bTEH5f/LiYkGJl2RnpBSPSyBNr0pob4lLxOw
         wxZzH4jXgEp8zWVVCdFarGOp4qj04NVMyEaDzGLYaEIZphQZCYCYHqrjAXTC/Hy9ZgEl
         +1CzJNMeFY3wJdVSv5fxydgbFegktRBK9pTvuwO3rgzHcon9BMncI1e8qJaqTxtsOVj9
         Lcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777004167; x=1777608967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMJoD6eFWUzy/CojiSR3e6UD5DqEouSLYBTdudhICzA=;
        b=cLRjqOk4Dm0U0KAFnIUOd4AMJNeStEW99kx4Xl9fR47sC8/wmbzF0PBURDUFkVUQd4
         rgjfskuYDo3Ie5X/i0eKr9MGSbH3D/3bBARe/4IDrHGzJmkpDLg2ZvxTQFE6EfY4BbqN
         d5C6vrSAZ8IkHGIzcGRI95caJmzzwUfjLsxBjBXUPtMveOUwl1o95CJpYUA+/d0UCjxk
         Zz77tXV/qchSs+yW620GzpjVK/RtvxjFBEnTK1S9F3r3IWXbJw0v8OXRPePkcSQQLHtK
         rRiYTbB8UROZdyj8SLD3/IP5vlTGXMHL5U1H4KnWxQ3w7SLDiLLCCNGrkO/P0Ej7jr5f
         kMTA==
X-Forwarded-Encrypted: i=1; AFNElJ+wrzANChjyqaXkukEEBcibCuP1qO8mWfwYlf5YWOe/otlyEb8rEGs9SGajrs7UQgqD/OGuld8vXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGh+1+teh+vYSIfsSHCvJBAzA/W0dnTpE7DNCy8zikHQnJTCS+
	Oo/UfwYLIf8Eozrlxs4VuYaugJZd9/IgFLzStft5uItC5lYPUAUMJ58Yd97dySf66S6pC0O0pBr
	LHecbW3vtvg03Jd0Bhwdme+cMFBHxirc=
X-Gm-Gg: AeBDievlGnaH9SKD43otIUih0AH0BuFyev+e1eVBv8ubO9Zg2HBis6bU97Wgv4oqX/p
	+3iihJHJc1+n0urXVX+UDyGUjumvWzUOFVxitNQfWkRran+3Hj5br4Inm29lxy+QttFP3+8PuGB
	bjWgrY8arBSdribe+vjFdPAvFme9TwMvU5bJ348fgQdihMlyhtsCjiipOUhCnZVad3R8L4uEtkC
	8yDrZCV5C8+rG5nLEn4JkG7QM4o93dRcb+kTHoFEgC9RAMZIKIZpYYhvyL3x0hGYEZReCSppiG2
	ibD2WyA43igGcm9fQel0tweL9kCSk8NNLeaNOQreC9yxzup65l3FQtopswdP
X-Received: by 2002:a05:6402:e9c:b0:672:8f26:8a9a with SMTP id
 4fb4d7f45d1cf-672bfd980ccmr11896233a12.8.1777004167137; Thu, 23 Apr 2026
 21:16:07 -0700 (PDT)
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
In-Reply-To: <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Apr 2026 12:15:30 +0800
X-Gm-Features: AQROBzDNkzH6IklDt1vdQEkd4AMoZMIvTXZzrHzuAO6eatZU4lRXpIb_XntAKmY
Message-ID: <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
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

Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > Using a swapfile does have its benefits, though. For example, the
> > virtual layer could act as an ordinary tier following YoungJun's
> > design:
> > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@=
lge.com/
>
> Hmm I didn't look too closely at this but I don't understand how
> making it a swapfile helps with tiering? If anything, I think it makes
> tiering more difficult. For tiering to work, we need an
> abstraction/redirection layer, such that we don't need to update the
> page tables (or shmem pagecache) if we demote/promote pages. That is
> exactly the use case for a virtual swap layer. The page tables point
> at a virtual swap ID and the backend could change transparently (e.g.
> for zswap writeback, or tiering).
>
> If we make the virtual layer a swapfile, how do we demote/promote
> without updating page tables?
>
> IOW, I think the whole reason we want a virtual layer is to separate
> the backends, which would facilitate tiering. If the virtual layer is
> itself a swapfile, wouldn't it become one of the tiers?

That's exactly what I hoped, virtual layer being part of the tier.
Tier could be set up per task / cgroup. So is the virtual tier.

A standalone implementation of the virtual layer is more heavy than
being a swapfile. Actually I think at this point, it is the word
"swapfile" is misleading now. We may rename it to "swap mapping" or
something. A swap mapping could be physical or virtual. Virtual
mapping can realloc from physical ones (redirect), and swapoff of
physical ones just read its data into virtual mapping's swap cache.

I think it's actually functionally very similar to Nhat's design
already from a high level, the only difference is we don't need
standalone infra for virtual parts.

For swapoff or migration you don't need to touch the page table, same
as in this series, just update the virtual swap mapping to be cached
or update the entry, it's identical to what this series is doing.
