Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBB3F7A9C
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057128; cv=pass; b=k4n6NWPZhWjqSCL/nFOe5/J0N/oZcqXWZ3BPL0Z20h0sRNX8IaKdNUHeZpa1B7oSoCA2WsrkdivVTP+Ouu6rGoaimY+x/yyJZgPzZNV5SxL8CYKjxZDtUokuKDx30vL7/a+dDHMBL543Zis3d78qgiJIVs3qat5SBF9coeQBgTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057128; c=relaxed/simple;
	bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVRit6ly4kqBGa0lbqsImY1LF4/C38LPIDdwfaWyIyyEvnhDsjkPqbahq71V0MNXpTll2z1jZSwVbApkl/fn4cZJY58/3K35n49F28ZjQjQn1pQq49/VGveCyu/jIG6951VG7jjVusB/ckUHiYULQH3D8E1U3VxfQwPXgkUyON4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCo859/T; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCo859/T"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba6b39871a3so967726866b.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 11:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777057124; cv=none;
        d=google.com; s=arc-20240605;
        b=A/SBSXzIHQoaE0WiFiTcwXuBfyCNB5hdngZgH/r+iCeweb9aNFreKAUymK12DaoAgq
         wlgwIBmF4lsbsu6d3v1l73NQrJk89nqakRubWbxCGF3zT2Nyfzi/q5igH2gN9aJu6u6D
         ctG1YeMUOz16njoNE90NIXazBEthuNEBQUpKP8l4rxGpqK7fA5ZOupa1iORFMunPKiJM
         Bhk7qbtMuIq5A6lYM+CbxvkG5oMcALqb+ii4Foxgm6JGCOhAq+D/ba/u6gPishO6uaPH
         xtiXDGCyEI66nbI1pvLYHSeo/Rf775WHgauk46bhdL1fyFQ3dNwPJ0cA5L1+4D1ppcHP
         J9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        fh=DZXvdhEueZ+uQ5kTaUcICOR7sPS4dJAWGy+wet3QVm4=;
        b=LObxOQFKdpDFRqH8mBE0cVm0rzLMwlEqXoieBK7HYO1wDQSafGSPPXPjHbis2r6JYy
         zEzPhreXp4gFBao51LAVArcYZCXjS1xG2KVXrLddaBCyy+kVj4SflFTbgdxtMd3Azz1Y
         x8YvArJoyhXKy7H/36qwyWg1LRwtkd9hqGaU5VqEJvzmhjqn8jsD6/GgfDGpAwwkoVPg
         nHK4A70iM6tsMOCIkZ7fw0YD/6FNU4FxgAuRJku0f6Ap0/MK/gR3df+lEwbuRwxoGes1
         JKiaU9tj+9+0LHAQebsYRV/UVS1jb1N6lsdcrMqXuVeLX+mIJeJ6n2mwEZWJDlW54O12
         WGMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057124; x=1777661924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        b=iCo859/T5ds85sLELgY5369MrC+xE6q6KwtoDJvqmpHWp5krA9ok9kra+L/VVWkTd+
         tbmonnQpA6mB9dZUUMnfTM7AzawvaMA25e7jhxrcpojIonHim5HjaTxBIW05fcHh68KL
         GWj1tr/5RvjCdpvKOr5R1ABkgCUjaKvszC0pmTvVd2UVTeVpCVdOUq5d1Je+x3S8z5sj
         Gf81N9+UzKQjdjhi9gRLm3pVm5N6SxeX3zhDVdH06uFfryy59F68weDZ9zsLrQJQr97S
         JtiWjiik1nuvJ3efIHegf4ifZUB2lpgzywohR2ymN8gVt6Vmtj46sCPSJk2/GxIinbfZ
         tP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057124; x=1777661924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6t4eZkeokPoyA8oRZ55oWxWJC7v0XmU5akNG3U8o98=;
        b=s35qytth2IUVNvbNZK8G62h48AMD7Y/iN2/chD+OyGxTn0ih4gc0mhvUgRmAnvf1ZD
         c/zoVvkADPBatkdBvSXy873oGMkPEwzsQVOyHv0bJeLGdyE9/EgMf9okG5UXZQloDR0A
         ckyUfw5ZPrbMRgsvr9XZxhuHtak2LjBwv5wVEeTBTL7RV015laED6Hc4HB/UIfTlMUkE
         gss910YFAlh3kNacSTIK0gUWrXWLqorSR/5RzHj81s5uxPjNKZYUu26jptxrTI+vVKQJ
         ug09fr6afV6U8FkOV+JuQF4P2krDAL0NUNeSAZ9ShIhIpEBNBahUQQ/Eq9xyEzy7fRyO
         /nOw==
X-Forwarded-Encrypted: i=1; AFNElJ9F2eaXR/QjBAUO5t2MocqkSwwqDJVgO17ll+/hu9HdGxLyxArZNQpV82l1aN3sxMqhXykTKRCE8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQloGgkuTKAt/cZBAnV0gQ9aeYSd5Jn7yRC/fThYqytiyvN6L
	mZh1sV2fFBd12s3jLZfX3GvzS5MotD87O2jzPP29ArryR1vCuQE032YHnftUV/ZufwSQ3iSk/Pn
	XJuQyA78tGR/QsDSCUhxMMYMp0kEBpy8=
X-Gm-Gg: AeBDieuujg0TTUUUAffQhsrEVCYo7yWepTw2dnhx4U60jrm3Xy6PBz7B6YBsxt/gslE
	IpsoUZXJV3aVDFuTvxjeVPbnqzuGb1ZaRueb4Xtl5QJ2hNWFCK7VBTi+khYY56JxKdZ5qceTbrh
	dPCJulzHAqvUZ6iFrI7R1tHx3/viLmRuDabYXz2TD/eT7Z8Nxs9Sr/I7b15oniAv4RRw1Hn5J+9
	4o6JsczEeZSFNCTL3m/TYllPxQNss9T9XIXLmMWT1PmimsuXMzN3Spfgoq9lV+tZ7rnOoLK7Qxm
	hcFexD2aYwk5ngxysuF87SuVuZ/ZBTyZAahUcMworb1r+5laRBs=
X-Received: by 2002:a17:907:7209:b0:baa:67b9:57a0 with SMTP id
 a640c23a62f3a-baa67b95a5fmr713004866b.3.1777057123475; Fri, 24 Apr 2026
 11:58:43 -0700 (PDT)
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
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com> <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
In-Reply-To: <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 25 Apr 2026 02:58:06 +0800
X-Gm-Features: AQROBzAaIu04DPxOg3P-cwpIEdvMhxhii3pwiMT8HK0UdOYxD8nmrK7NsGSDAaE
Message-ID: <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
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

On Sat, Apr 25, 2026 at 2:08=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Apr 23, 2026 at 9:16=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > Yosry Ahmed <yosry@kernel.org> =E4=BA=8E 2026=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > Using a swapfile does have its benefits, though. For example, the
> > > > virtual layer could act as an ordinary tier following YoungJun's
> > > > design:
> > > > https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.p=
ark@lge.com/
> > >
> > > Hmm I didn't look too closely at this but I don't understand how
> > > making it a swapfile helps with tiering? If anything, I think it make=
s
> > > tiering more difficult. For tiering to work, we need an
> > > abstraction/redirection layer, such that we don't need to update the
> > > page tables (or shmem pagecache) if we demote/promote pages. That is
> > > exactly the use case for a virtual swap layer. The page tables point
> > > at a virtual swap ID and the backend could change transparently (e.g.
> > > for zswap writeback, or tiering).
> > >
> > > If we make the virtual layer a swapfile, how do we demote/promote
> > > without updating page tables?
> > >
> > > IOW, I think the whole reason we want a virtual layer is to separate
> > > the backends, which would facilitate tiering. If the virtual layer is
> > > itself a swapfile, wouldn't it become one of the tiers?
> >
> > That's exactly what I hoped, virtual layer being part of the tier.
> > Tier could be set up per task / cgroup. So is the virtual tier.
>
> Just to clarify. I don't think virtual swap should be one of the
> tiers. I think it should be the mechanism through which we implement
> tiering (see above). I am not sure if that's what you meant.

YoungJun's swap tier have been working pretty well without the virtual part=
:
https://lore.kernel.org/linux-mm/20260421055323.940344-1-youngjun.park@lge.=
com/

> >
> > A standalone implementation of the virtual layer is more heavy than
> > being a swapfile. Actually I think at this point, it is the word
> > "swapfile" is misleading now. We may rename it to "swap mapping" or
> > something. A swap mapping could be physical or virtual. Virtual
> > mapping can realloc from physical ones (redirect), and swapoff of
> > physical ones just read its data into virtual mapping's swap cache.
>
> I don't understand this part, please clarify. In my mind, all
> references to swap entries from outside backend code should refer to a
> virtual swap ID, which could be pointing to physical swap or zswap or
> something else.

For example just reserve a type (e.g. type 0) as the virtual type?
(type is really a bad naming though).

The that swap file (or swap mapping) will be

I was trying that based on this:
https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-15-104795d19815@=
tencent.com/

It seems to work and the only thing we need is actually just something
like this one in VSS:
https://lore.kernel.org/linux-mm/20260320192735.748051-15-nphamcs@gmail.com=
/

This part:
+ /* fall back to physical swap device */
+ if (!vswap_alloc_swap_slot(folio)) {

We do a folio_realloc_swap if folio->swap have type 0.

Which means, if there is no virtual device / mapping / file / space
(I'm not sure how to name it at this point :) ), the ordinary swap
routine is just still there untouched.

If there is one, and it's being used, then, it is still the ordinary
swap routine, just do an extra allocation (and the extra allocation
strictly follows YoungJun's tier rule), which is same with VSS, but
everything is reused. From a user or high level interface perspective,
this can be designed with no difference as VSS. Just with a few
bonuses: being per memcg / task / runtime optional, zero overhead if
not enabled, and reusing all the infra.

BTW this deferred allocation (in VSS or dynamic swap mapping, similar
thing) is actually a bit concerning to me as well. It changes the
common swapout routine and maybe worth reconsideration (e.g.
activate_locked_split and mTHP stats is now ignored?), being optional
for now also seems safer.

> I *think* what you're saying is that we should make that optional, but
> I don't see how this would work. If a page table is pointing at a swap
> slot in a swapfile, we cannot do tiering or zswap writeback or
> anything dynamic without updating page tables. So even if the system
> starts off with one swapfile, we cannot assume we won't add more and
> set up tiering (or enable zswap) after that, right?
>
> I guess we'll keep the swap table in the swapfile and then we'll have
> it point to a different backend, but I really don't like this design.
> It's unnecessarily complicated in my opinion. Page tables will either
> refer to a virtual swap ID or a physical swap slot.

Or in another word, they are all just swap entries, and the swap layer
handles things internally.

> I think we can simply have swap tables representing the virtual swap
> space and pointing at the backend directly, whether or not we have
> zswap or tiering set up or not. Is the overhead really that bad?

Right... I mean with two layers you will likely have >16 bytes
overhead, and double lookup. And I have been thinking about cutting
down the memory usage to 3 bytes. And you can't make the lower /
physical layer just a bitmap if you want a reverse mapping, and so far
many things do require that. If we make the reverse mapping optional
it might be more complicated than the thing we discussed.

I don't think the thing I described above is that complicated reading
all the code and solutions so far. Maybe some better abstraction can
help?

I've seen some vendors doing swap using UFFD just to cut down the
overhead or having a highly customized backend solution for swap, so I
was hoping the kernel part could be as minimal as possible.
