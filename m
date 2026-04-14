Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F8280318
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137365; cv=pass; b=Wzm3VNS0YZqqsA+3HJ3o+VLgviTd10Erf9vPXVtUZtZjPirZGHygcD2idUgn8GycZKlhMj8ZNDYjF82/tqetSRvXi8L9PcYBlwSCu/1Ccs0/ZBmby7rdKNxwk30hrOuIpCOeWxrUOc9sBMEmpm+vjBHLhUxrZTuP2fURn/x0jDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137365; c=relaxed/simple;
	bh=02XAKz/14kc6zksPNYP7oVuf6DQGS1WSgbuT+EiabeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/EvlPQiuhhDxJIMSrYoH4c8FGpQeE37xitrnrBY22iw7TvH7FKqVLlXy83uv2rnsSZP6VF546feNX96W0ltH+tAJhsMEOzPAZcQLLN90e1YA+WmOGjQRjqJkzZUPLJ8rR74gfdLc+2qVAFh1RKTwleOktUCNI/SisATEXiElv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecjj8Qxf; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecjj8Qxf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671a901584eso1712448a12.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776137363; cv=none;
        d=google.com; s=arc-20240605;
        b=KX0KTdrgyqPRlzn+r/q5unr5rUHBqt5/Q6ms9eb212KuyGohr+aYXsZgu9kBFKOSj8
         Y/PetO8FsRII/CwH08Yxnr7TLz/OuwBMgtQeKvgRD0cuXL8pla0QqytYmoXbdealFteS
         Quj4RtgaTWFVRZ5sMNsEVa/aZgr6tvEexgHxQbXF9RtBjl5cYHMQlEMYA2oOPdjDsvxF
         DfX8iVYFJgCNaleNWOGep35euWhUup5QuFrdbZ1bJUGVv6UckkQnpwEzcjJV2P+bT1Iw
         0sLK8VwCxlR63t0aMSZUuQSy2p5S5e2Baj/HGPc47bDyy1eHGUi3OPP5uijbyq3OI9A2
         C5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        fh=egO3QUQ2oN8WKRddMamPu8wZvbU3KI6jShwqIgTSu5s=;
        b=f83y16gsmry0szwN0pvAnCahNarH+Q/sWSCYKiLZKxlUJ7LPfNM71MpkBW/X5F0Myx
         kK7zVRlDj+Xc7nH1jSnbVFCs1b8/7fWi8cVb1IamnGy0Cj4a9B1mv8WmUohkqtg0qf1k
         ntavdGC28ljQv6iZcTEOaVFPgWgMSCaHaFRq05wcxRqNhritNeBjxYM4IlAd56Vk0N0N
         PRAgMHC6IH5+5VF0STojhxVPD6ore1l/ECLFkOB3FD5DxyZAyTy+tsn7rPEBQCkilyzA
         tT9fIZnUslq6LFpzEv4hzBRSRRqbJT0XtCSDGK6cSjCWM+1UQLTTe9QsLAub0tJ/R9Po
         xujg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776137363; x=1776742163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        b=ecjj8QxfO+rMnQFYOxQV86Jd652ldg0OD4W28l93J4/sj8NQ+ZfQEh0EHaWD4XEvuI
         05FA9dC/aeNhXL0T0RQTA+Uz0EcAf/sSzOaMA5OuwVfGdh2U8VS7F20Vow4dB1RGoyO6
         jod3M3+DM6/ei+b3V3vGG1WvDyGbTTHoerXlUq0KQ88gDfmLgCT9QWUYlXvYJa2yQnwz
         VB91bqZMN40QaLyQJ+Wo07uRpstQJvhzdLlJPItFYcnOVz9aMrMauAuQnO6Fdp8eOcnh
         7g+6JrNdXZFyRniEGzHbbfkPBdD+izGJ72XpIkYrHmc/Mx47Kz1QBaT1qfVkT9I/IIsE
         l/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776137363; x=1776742163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        b=h/bVNQNpDy8YcjZW0YwPvAGlP+EIKx+sNlWcWpdBltWycmkRfW53H3rUtsOygAWtZw
         Kv4AurxwL6PKDx3jhqTZHdRJfoaAsEQglDNQAuyON6xyi2Ma4s2XrLuxBvC8q37SLdPb
         r8Cb9UcmZR5SeFLaKLZOAsx9UGncM+IK0m8oUNnvXrmD7y9DWlWXm+7X7qVZlDB1UzzX
         ogeXZdPYD3Q5781ckSJQIWQIye5KR4l1eWFYX8gd2Hw+EAJw2rBm56gQh+8XcKrqViXb
         wmLNRntlr6tKnjb+ogRLnTKdC32tVdi9KNGOXh+5Zl3Fzvb6oIr7hzSRjQSFZWjW4pxB
         +x6A==
X-Forwarded-Encrypted: i=1; AFNElJ97xersKeE+O6HG66tI5Qbchq6xfZwtEuoEsQAfdFCp/ZqEg6V+n84AIjZgDIuXPVD3SrzELz6x9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3pb138q08eTKF9Wr1Rpny13rhrg9eNeK5f8at+s7BAxn0dY8
	+loJxnKpRuK2CmQNg0LwchrWisZLkh1hhHcB3M7OF8JWRnEapjdaRIVmsvHtVI9njJSjVoxMawN
	cFXH8sGKIxziUnGUjyflQBGgvcb4N9fU=
X-Gm-Gg: AeBDietn/kkxrlSq1uQIr6cAGUt9r9K9PJ9E8trR2cLhx2NFoA5p7Lamm3vzSj6Bu6b
	2b0JBqfhJGNNEZtSYOiP1FcjQeZT706VU3dppaiJFXIovFovq42EdkZYJC6zp6SlnhSJ7gBfYx6
	/5kEzOulitliSMsm1IFFEqu3xezwS+AT8UQTsBTz4SsXtSxVDhEdbGTrbD1ljSgK+2EWydDkHOw
	TlksjyzNhhKcg+c+fZuHhK44Cn4jOJIuyHpN0ayGUGWxRXyEexefX7wC6aOKgohRY4/uV5CLGsB
	R3dqHh03JlQp7tx60iBqOn0fnXzIzIXIHed723iD
X-Received: by 2002:a05:6402:a54d:20b0:670:8d90:e861 with SMTP id
 4fb4d7f45d1cf-6708d90f131mr5258361a12.6.1776137362474; Mon, 13 Apr 2026
 20:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
 <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com> <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330>
In-Reply-To: <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 14 Apr 2026 11:28:46 +0800
X-Gm-Features: AQROBzBcwys1sJE14-sqswOYWhGVy-YykuPt2kRn0gHSFefB_BbHyO5y_ejkPqk
Message-ID: <CAMgjq7BO6SLZPfNXDh1F-7RAOqDAfqMQ4PM=qjAq1mCsWyD0LQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
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

On Tue, Apr 14, 2026 at 11:05=E2=80=AFAM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>

Hi All,

> On Sat, Apr 11, 2026 at 06:40:44PM -0700, Nhat Pham wrote:
> > > 1. Modularization
> > >
> > > You removed CONFIG_* and went with a unified approach. I recall
> > > you were also considering a module-based structure at some point.
> > > What are your thoughts on that direction?
> > >
> >
> > The CONFIG-based approach was a huge mess. It makes me not want to
> > look at the code, and I'm the author :)
> >
> > > If we take that approach, we could extend the recent swap ops
> > > patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-bh=
e@redhat.com/)
> > > as follows:
> > > - Make vswap a swap module
> > > - Have cluster allocation functions reside in swapops
> > > - Enable vswap through swapon
> >
> > Hmmmmm.
>
> I think this would be a happy world, but I wonder what others think.
> Anyway, I'm looking forward to the future direction.
>

Yeah, I agree with this.

And I do think swapoff of the virtual space itself is also necessary,
we really need a failsafe, e.g. a clean way to drop the swap
cache and data, kind of like drop_caches or shrinker fs are
commonly used.

> > > 2. Flash-friendly swap integration (for my use case)
> > >
> > > I've been thinking about the flash-friendly swap concept that
> > > I mentioned before and recently proposed:
> > > (https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdge-=
T330/)
> > >
> > > One of its core functions requires buffering RAM-swapped pages
> > > and writing them sequentially at an appropriate time -- not
> > > immediately, but in proper block-sized units, sequentially.
> > >
> > > This means allocated offsets must essentially be virtual, and
> > > physical offsets need to be managed separately at the actual
> > > write time.
> > >
> > > If we integrate this into the current vswap, we would either
> > > need vswap itself to handle the sequential writes (bypassing
> > > the physical device and receiving pages directly), or swapon
> > > a swap device and have vswap obtain physical offsets from it.
> > > But since those offsets cannot be used directly (due to
> > > buffering and sequential write requirements), they become
> > > virtual too, resulting in:
> > >
> > >   virtual -> virtual -> physical
> > >
> > > This triple indirection is not ideal.
> > >
> > > However, if the modularization from point 1 is achieved and
> > > vswap acts as a swap device itself, then we can cleanly
> > > establish a:
> > >
> > >   virtual -> physical
> >
> > I read that thread sometimes ago. Some remarks:
> >
> > 1. I think Christoph has a point. Seems like some of your ideas ( are
> > broadly applicable to swap in general. Maybe fixing swap infra
> > generally would make a lot of sense?
>
> Broadly speaking, there are two main ideas:
> 1. Swap I/O buffering (which is also tied to cluster management issues)
> 2. Deduplication
>
> Are you leaning towards the view that these two should be placed in a
> higher layer?

IMHO the swap infra should be doing less, not more, so we can have
more flexible design, and different backends can implement their own
way to manage the data and layer. e.g. Having one backend being
flash friendly and it can do this without caring or affecting other devices
or backends.

> If it goes into ZSWAP, there would definitely be a clear advantage of
> seeing dedup benefits across all swap devices. It's a technically
> interesting area, and I'd like to discuss it in a separate thread if
> I have more ideas or thoughts.

Just branstorm... Why don't we just merge these identical pages like
KSM? Maybe at least zero folios might benefit a lot if we keep them
mapped as RO instead of recording them in swap, seems better in the
long term?
