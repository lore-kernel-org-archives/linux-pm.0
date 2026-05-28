Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1533ADA8
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004556; cv=pass; b=tgHdYCMWaXKkqGI/LtuCPQTc1p6ve4yXAk9rOS5DEMHegOTMpld6Bfye15B7dH5/WV0KPTVeEdSwHwjVg9P/H1Kdm3gJBTRgO7oNOJi5GfzmMwy8bnfb9M2jl/g/k5aY4DE6ytUqMmD7daYISxjd16LwCwkRh5MdAqamGFH9x3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004556; c=relaxed/simple;
	bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zr4UG/PKQx7XjJX1F0HHIoVzVdK6fLNZVNi34O1I7QkNbvByIZO9rPSCFZROxat8hp3SFr4GQylPpuYFzULqnqvP+Go/s//7i/QsUCpumX53M30w3PIk8e0s+yeAH5PpXBvyWZjyDCyNFwG6r2qbI6DmcgakyhnXM+kjTY5PVe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls8wq3x8; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls8wq3x8"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393d6025f99so125513511fa.0
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 14:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780004552; cv=none;
        d=google.com; s=arc-20240605;
        b=e7PKtj9kS0Kgc/UI6PrAP3lK3Mtfm+mPnXv77I4XpoKaqLU0o0Hj0um18/aO8TYR5Y
         ZHLqkN1aFGD6xH0GHHc/OzkjpZvugGCaEj70adUhlb/Y7u402v4ZsJUkOKiYqmE3OT6t
         RrMaUFvkN+AiW2jGTN9fX327CTxFvMzj6HKtC6g8UcTUmAotZ3U8HjTDS8gynVGMdG7Y
         XKq8x4QeotXytJCIcAZDrJozmCtdJdAxhPW6YQbCQSReASoJhH77tNY4gd2WdPUm+mk8
         KaK4NwdFpmINQph7GRwcmJuYr0Id+pTHmAZmYTSjVwV74vNKNewX+7OSBQT/sxpfbBLD
         DdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        fh=fYFZBtrGqzwRlF7JKRKBjVZMqEQRrguCTkFLJ5Ge/ZQ=;
        b=KFkWMeSNbtf8F38gozJpVxWJ13sVIFv/AzjuYhaNrp7W+Bvj0Q5UKPHXgXQ9yWTFii
         9aUXW4ae2RJ1vwehIxsr7H7P3g5P5MVx513tXclxrPnrnRQzRaKRFs2hv9G5iq6KawLC
         UQQ/mMerxgeUgRRLmwVhAuCNcKaRjS1F6jdGxwWkMU5eY6smVZTPHj9E+tLe2qSapYb0
         9TAlk3bAi0yeuhEr/TA/tJd5j5tzT0ToidwlC9exVs4IbF2VrgR8GYWJebHgWhVV6Jj6
         uKEljCosmwr5oalBXKJigsoivQ8qSHXIjStFCW8oAFMwrl4Zwg+5hFzjAeouH4aZIA4b
         9B+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780004552; x=1780609352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        b=ls8wq3x8kzyt7HiA06z5ov+GmK03Y5FbkxXShtTR8+zDslhmsPgzDkJItOwIO6496P
         XusRh2vZG8XbLp2bgEzTyavSpAKV2yNT//DBY1++FtyRKsFYwrHrrJHuLQwegE5BCcge
         2XXXa0IhGyzmQ23dNpLmvZ7gL5m55u2i6xcE4z3HpnPnj6BX6aHMThdRsKDvnhY78z1l
         c33mfHCdz3R8dVtuKD4rfjNhu/sX/EpgxRhmliR+AhQgciqyKu5q+4q4EUryG802VElJ
         n4kZbfpqnoA8XqN1jrhsMNdZ7paFJP9M//gZsLn3zZ97PJeucpT4TFYmt6Evwuygkvmc
         bLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004552; x=1780609352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        b=VQDtAqRWbixVYPAebz1/q4JBpr6Mh0DezomuHDsDaKiqRgo8Hs6dHDzLT4xzVbHlks
         a3ihg3QvJLFrCVKHRtV+0S6zC3nO6FizbxiBtGCJCFuS66xQ/7VJem4elIBHR5tQEkz4
         1cKfN3sTl/XpR6AkczPp8hIfGzgD4jWL22qzKbt+D4JO+0UZR5ixBTkycDrwGi3e92hJ
         G6B/cB+gqrkFC/w+9F2a4jrTb9BvpfQWWNtQKtvLAMZOIyijNtq+cAiJEJ+gqxnqAYCN
         kQX3vXESo1mtMYu0MNoK9c0r91BuI+hAAmD8S0Cm/pSva+poUZ2QMMA7HmnWPiKrEsXa
         fn0A==
X-Forwarded-Encrypted: i=1; AFNElJ+lOehZk8Ym7Gq34SEUD0XK9P45lOJ6VMWwdGka25Q3KUd8GQ6F7Mma8QfJYzS+xEVa/CycWq9p7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kn7YewTW5VkSYYahyeAtap/qQBQN5giqIzs2AjLhpsP4TeaZ
	irhFiVl9vfVNGgpKG/bC8sQ5rPxIXgPmASTRzwmxfuxieT85v+GQbHYS9GNsTFcq7oMyL76wfEI
	d0zQs/PZk37HUF8eCdL6ydIEv+7ZtXeQ=
X-Gm-Gg: Acq92OEtNyPQ3i6vUcwbNmTyUU3xOG3HJsK5t3+N8BnXndA52+hdNqFaZLQ/kzX9jzv
	TMvcOarPjdRRIxV/zyewtDOwoh+iQoSbHYMzswppLa8jzw5drSRT8FitIg+Z+7XWJPiCJ5E5Cw7
	HFIPVe6W2lXHeui+mjzAntNoICpu6IydXlYS5lmnC2ULAEEj2WgfUA3KPHYMIwOH9g3vrM9GYWY
	l8GbqJSgimon6dDAwaemgWt3VqSqt5zDfGwUmoNp2DE6wCaHVN0IhNZVyYPe0jKXa1GDq9Ptrj/
	gujQPTTKLvdJJliD/tuV8euQcZxorhW77uZVXK0BfwxZoQIrCw==
X-Received: by 2002:a2e:a695:0:b0:38a:2a56:9546 with SMTP id
 38308e7fff4ca-396536f3de0mr174701fa.13.1780004551665; Thu, 28 May 2026
 14:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505153854.1612033-1-nphamcs@gmail.com> <20260505153854.1612033-2-nphamcs@gmail.com>
 <agJcCZuLqWwU_sSR@google.com>
In-Reply-To: <agJcCZuLqWwU_sSR@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 May 2026 14:42:19 -0700
X-Gm-Features: AVHnY4IQjMrNxr5cCHgyMIwBGAESeNQ717suquaX-CqDf9_dL7Z_N08muuwMcik
Message-ID: <CAKEwX=PZnKqfriUsPV2whZyqxfCRNy67z7gyrHObEvztDF0_zg@mail.gmail.com>
Subject: Re: [PATCH v6 01/22] mm/swap: decouple swap cache from physical swap infrastructure
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

On Mon, May 11, 2026 at 3:46=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, May 05, 2026 at 08:38:30AM -0700, Nhat Pham wrote:
> > When we virtualize the swap space, we will manage swap cache at the
> > virtual swap layer. To prepare for this, decouple swap cache from
> > physical swap infrastructure.
> >
> > We will also remove all the swap cache related helpers of swap table. W=
e
> > will keep the rest of the swap table infrastructure, which will be
> > repurposed to serve as the rmap (physical -> virtual swap mapping)
> > later.
>
> I didn't look through the entire series, but let me ask the same
> high-level question I asked before. Instead of moving things out of the
> swap table, why not reuse the swap table as the representation of the
> virtual swap space? Seems like most/all metadata is already moved there
> in a nice concise format.

The honest answer is I wasn't sure it would work, so I was hacking
quietly a prototype on my own time :)

I finally got something that survives stress-ng and constant
memory.reclaim thrown at it though. I figured I should send it out to
get feedback before digging myself deeper into that hole:

https://lore.kernel.org/all/20260528212955.1912856-1-nphamcs@gmail.com/

There is still a small problem left (the metadata duplication issue
that Johannes brought up). It is potentially fixable, but I haven't
actually tried it out yet, so I don't want to overstate here. But take
a look at it and let me know how you feel about this alternative
approach!
