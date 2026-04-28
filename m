Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059634779B0
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402015; cv=pass; b=QTrQ1sX1ZyJWfKE16/GJ0VrQH6nGMUPTD97hCGlIj28llMfvOqE06szyPCXDoHSgdVT22rPzesvy9BIH6i2ix5zRTC4DBwL7ZefRgZRYUc9yL5X3bc+O0ymWxxtEg5hRWxw4PaVbw2cYPuXvBc8Q8SpF4vqkB50aDnxaFXHWnLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402015; c=relaxed/simple;
	bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptsCEjZLjWR2oaidwhXYu2B3pKPc1OXRd7XjK4TQvzS4vu6M1NPkyhdzx/36Gvvuf2nANV1vw/g1sLvYb7E3bkVXStDPjZMNSNKy1DXCqcaAiYiMiGQd0aJlSNLB4iheIZTLnUwoDxX63xHlqDspg7Q4WiQeyqFAdbA+8lOQGuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifd83xBd; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifd83xBd"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-671d60ef9c6so16320435a12.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 11:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777402012; cv=none;
        d=google.com; s=arc-20240605;
        b=EmcRCLNyWjFuZDdVSsfcXVQmtHtpivtwWqdn/NBljULTtzpQpb31P5LypiUXVoy3c6
         P4AvP83zi+RyqboUbQcJTW9/tzozG9nNBGvs3sBNGsVuHxf+mHyIInte1VhYnammlVM2
         dttEesF8o0lq5bZCWL4MlkLaHl+pzaYkk4XvWH2sDuvMZajWA3y7B7rnOqUAEK+AIHmz
         ZCSmsTB0f39t4wTGpRmSBlbPBSjk0YZgcSS1B7rCQFNoYXdc2icirA1wOboIlV2Q6rgy
         2L06H7AA7h3i/me5ezPWjvWfZH1mV9GYfKXKwUerxbxNfk86i6DbYdvLwjYRcDhlgIvh
         sQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        fh=S6h+2X66xHyiYobs4iPHzS7HER2A73e1BAWfDM6hNGw=;
        b=KddGKGklv5YeeKVA2UE2sQQQNJJQHlwf091nbevTMOSld4bjPLEa5gS7vOUPzkfMT8
         slW4qaJAN5lISr/Cm3hbLUJfumjYHvMkBncXzjBSocNHbDEEicopNxUQO+njRNAO2H4F
         KTb0d8XIxwfTwfeT4NaFFWN2hhvZToEhKqIHfIBv1zDaYKVmR/KNXme57K8FZVXSrNbp
         IfCBPjZik+ia5EgqZUdy/IQRYJ0spiY65i5n0X4CFhp2OLoLw1hFMd8rhQ81OaZjDoWT
         Eem2yUH/ntaAbM9SGy3xTb2bFDxzFaUtdNSuuFnEHQ0BRNVDxss804TA7YAfYRpbqxYu
         mL5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777402012; x=1778006812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        b=Ifd83xBd9a48T6zVcOCH/JADVnoDZqlx2S+0AZOWlIAKt1nLA1ZB9lMupz6AS2uAHO
         SKbiml2TJZO4fnLBzpECnNjOydpHYwHIreTmEc9DjWUOnP/XWlEkXHAxolnIKBVGjgE5
         QpSQ5XcWoUPEi0w0yCYXUDX0lyqtoVsiiMwD3wGyW1fQbnjLoI9TKIi0WgCib7wh02B8
         L1OIbS6xWUfSv3oJRM1k0aJSLXuc54pLtKjb1qqUn+D9BoOjyx+mgo2R1hsM2awqFfzh
         bQr6Ii/AXWLwp/fDAukV5mNiw0l019VhZrdM4MzDwJO4PJ0sMPqAjTprua2wM94N5+bo
         MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777402012; x=1778006812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        b=FeuQbFA0HM/7IfNcBHeXLLYA9hlpTrBaOiHdP+j21HnWxuA7UvhaVmJEB80X+zkysy
         hM61W6ZDdUgFpghHcsHa6f1BjZeQdhkbkBhBmt947kOew8VboBOjSHZJ1wtnWPv6Epws
         9Qd0SsrTepRON7Nh3WbKk86RkP8fd2eh0mvpsNyTHwqffG2ODLt2BgQHw3Cz6cJxblPJ
         ZlnUt5URgfRIIAvggntWXTu1uoOCV3WT2EsVbjnDOdsdLfFxnHYBtOj0Q5KaENGIwttI
         5Yrw3g1EIM7FWJq8P0ouZEjIVOIwPmgyhSuZShlHJd6ChW5MErhedlupJ5oT8RzQ0cIM
         kvwg==
X-Forwarded-Encrypted: i=1; AFNElJ+Qvr4MJbwqFVWa/8LZAlY/YL0TwvWYb/AblejAq9uCA/ZeX6LJZ4wz53DL1NICI5qkOdyzdirCLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxodxnacnA9xiTzFQx7UcvQiNxbWV+5eJagTtiEk5l34WI6Rkmu
	SdBefGZE2Qt5ewW0PqgsTvZHrRxdKA2zIoVfJ+ZQPaLkfLDwy67PHgZQmq/YWiAqRyTxuvvWmR9
	+9Kzf7PS91k+IbfJedu3TeGGNVpU90FY=
X-Gm-Gg: AeBDieuyGbfHf+jG7RcvcWSr/X8gsr5ZwvUjRoZ/IxJGWmXoD1qTSE3gV7oVkT+UmNI
	xcYDhoZMJwab6w6LubF5RCBuV6VRqq3loRDuJI9oybhBbSkZl9EGcHxD5I7aslxzPNaWLGgUHV/
	vbis39+bYE5XMie6DpoKQan6VHwFLy91ttBBdXJEi0PyAClhKaAwqVbqw/iwEyeFgqZlOhlacX0
	j6gWL7CHj8x5nH4jI5uzXYnNPwq9bfGTh0pT8VPIyLaYJYRz5eBe0Uh4IIJWqtdi86Xg+JKNCC+
	NEHY7frfjMywxVURfMQh2q0MgZ3Uf1NlFn4by2s6TmW4XaTgxYAB/ccY50GDFw==
X-Received: by 2002:a05:6402:4544:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-67b1fce62e4mr516715a12.0.1777402012124; Tue, 28 Apr 2026
 11:46:52 -0700 (PDT)
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
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
 <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
 <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
 <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
 <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com> <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
In-Reply-To: <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Apr 2026 02:46:15 +0800
X-Gm-Features: AVHnY4KwMPQSKOHLniO-vRRmC7fG6-z8dUk1aqr3V42lrdSb0J0CfA2hErWWeCU
Message-ID: <CAMgjq7BZpU5K1xHyFiqpsjeFe6CZUouGY_gOGMwbkM2Duq-vGg@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 2:23=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Apr 24, 2026 at 12:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote
> > > Why >16 bytes? Do we need anything extra other than the reverse
> > > mapping? Also why do we need a double lookup?
> >
> > You will have to store at least the following info: memcg (2 bytes),
> > shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
> > bytes, since you have to address a full virtual swap space). And some
> > type info is also needed. Part of them can be shrinked but still,
> > scientifically, merging two layers into one is considered a kind of
> > optimization.
> >
> > You need lookup the virtual layer, then the lower layer for many
> > decision making, is was discussed before to introduce more cache bit
> > or things like that and I think that is getting over complex, reminds
> > me of the slot cache or HAS_CACHE thing...:
> > https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fc=
yzVOKE14-O+Dw@mail.gmail.com/
>
> I think that's where the disconnect is. You are considering these two
> separate layers, each with its own metadata. The metadata should only
> live in one place.
>
> If we only have swap tables in the virtual swap layer (with the
> metadata), backends do not have to carry the metadata. In this case,
> backends should only have a reverse mapping (if needed), and some
> internal data structure (e.g. bitmaps) to track usage.

Ah, you are right. This is currently an intermediate state, that
problem might be gone if we unified everything.

> This is difficult to achieve if the virtual swap layer is optional,
> because then the metadata can live in different places. This is why I

But that's not difficult to achieve at all with an optional layer, and
actually will be achieved naturally without any design change with the
RFC I posted. Swap count / cgroup / shadow all stay in the top layer,
lower layer is "reverse map" only (the undone part though, it will
require to move the cluster cache from global to device level, which
is also required for YoungJun's tier or any functional tiering to
work, we may run into more and more detail issue like this).

Might even be easier that way, it's pretty close to the unified states I th=
ink.
