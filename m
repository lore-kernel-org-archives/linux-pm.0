Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673B313E24
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824356; cv=pass; b=P/PQgtPUHfnx0//VDVL5Pu2fURR87a3TNNL5PEJu/mKAO41nrTMazf1jUlZuCCeZio8R7IzYg3EZPtoOdA4Yo059CXm4MQVM6UiXt3bwllSwRcafSbCqmziAIcpR90P3cLw+oBIzTrSEyaYimQ80aWheXeCl0VP8KOTgRd5BGwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824356; c=relaxed/simple;
	bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF7irLnHF66YhFUQxSwwT2wFWopERmwczThkQaUdEhk2vwvFOzUdnXzU46VUQG9EQTBHNHLCbvR/qAn7fix7AV0Y4OIcF1tVwNN3cKdSxaPY3CWKVjry5HGmKwTg4l8/2u/qIlS6BVcqaDgZAi2L0nFI8EcKuWFxzuK2GZaAxR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjZn0BUQ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjZn0BUQ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-676fec7e946so61041a12.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 19:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776824354; cv=none;
        d=google.com; s=arc-20240605;
        b=GUr9KzRt4Ed6q60XZmBuD4W8h6GVYJdBFJI7pi/IHQqBVAJ7szZCA/A/zCzqPDfXiI
         9xZP5UOxbySCnouLXWUKY/sjOJhqDEJ8OoacYgWLLnfxDg9KOvQZXFEB8tLCjBOdHrPG
         xRDRgtqIRSYWR9PI3SahYfZuEtPU0zd4Gpe41rkguutTf9Jhi5lnhDfyEHsUJbsLYjev
         nBQE5ps0wrf8/RlTRbmDr/cpBYj5YJHR4FjeQrGl3CBnuG0IPjoItfZYZM4cpc/a11UW
         DdVRH9TsIcGjHmcRtiIWGnLrPrCE3N6on44aKXtGoINGBH9ccBqMZy1ZQKufbtFHU/HS
         6reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        fh=OsP6iuWIF5GDZR2ogKL7rgt84nvk8khNgHxEg1OeCC0=;
        b=SWfyhhfniep3oBFDlig/Pf+KbfQZL1hiaNGlbSSb7UQWkVxXC0CER/mTGpfOwPlx4w
         59kZcNIWiujgdoCjXzBt/sRwt1987SA2PNvmh6kzuZr8DDMAyXbA3ReY3igy4aNDLe2p
         5NGlT+3Bk85LvB5W5KubgQuw+B5+HmUcyTbIEXEgGsdcluqsgRJpmc//hiBNWBM1gTvi
         YYzGZe2vH6rgxKC/+le1+yRD0oRYIXJ01gQARdGH/O6pTEQzEq5ZNl3SHSaFVxy6i6Sv
         TBGMQCtI2Vx7/DI5ZjjX8disKq4NNo4X1ldiZ/CExMISc+QEC+GsrGER2El1ZKndbfTN
         fJLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776824354; x=1777429154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        b=sjZn0BUQljheTtpVl7ncqNF7+J9T11OG/6zfZHc9VdBEewdvtBX9uo0LZxv3sZ6QU7
         sJD5pmmU+ZjQt6AAl6Op4qvAK9geAUB7bkt8Z1UMbBXIciceeoZtIzKs7Nh1+g7xTUyC
         vIhjiOn5QpOYFmQpmVvgGOG/U2q03Z6JFLPe4k+42EvA/J7A3beQOoLAs7zEGneOuJlw
         iLo7wca2mXlH5m7Cn3vkzYQBisUnIlRtkz1DN+WcSs9Ixlg5U5Sd1uMaqncjtJH3YDQy
         zREFK03OAIaP2/4jpybYQOBi+FlXbWEDy7UzEpY3GYtPKi7VJxM0BJhW5dH2Qg6Q2hSm
         /Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776824354; x=1777429154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        b=mppt5GRa+n8ISZdBcFOiMl09sqRFCa5psiP8cN1WDjFptgKkwXrZYOofqqexbcPTio
         1UQUSccjaboEfM91aqwZBs2ZuLicrMPok5ONy/G8KGSWRHWDb0ibeMkV/dw1H/jAJrSP
         pC+fyOcO9e5eK93GSao8WxJHPHzPC2lldQNzouAY2aOGI7HU/1Vd2QxNkyDCRiGgKiC9
         fGMiZcMsuo+rfGPKuGjNPDnXhG14R8JpRklCrX4g/falVTzwBOO1yHMoICkK679HJB+o
         VgsaRnS6WcqBEfU9mnpWPlpvvA6UMUbEwf8hiY1Gr+HMadBJ5hGMXT6d3EiRy4Ezq0w7
         PFCw==
X-Forwarded-Encrypted: i=1; AFNElJ8VXQWWI1DEGDcD6QVimQABu/Vm2gqSSdMIe19qUDgk4UPrMgSBC/VlFail5lFxNpkzBE8kJB5UVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+T4zK6mc+N7uhmbYpuX28WuuwgRTPLII5I9yqR4c5q/dwwVMt
	bddBRFaJLaRdfjXNieltdflhJTAdozO2GZDdjfU4hRoOdmZm6I15vw4EuwHwxd3l99m+/hV+fWu
	25F4EHpTBtZmZx7vlltuRLN4o2jFz/9Q=
X-Gm-Gg: AeBDiesq8Has3GKJlbSnFeSrNZ2kcGJduMSJV/djlyDuDMgIoe4jQnz775lwYJRjOhx
	fOHqa0KgSqMnYN8CLhJzGg0h2lUV6chmVYAiXOcuLH0d2wRVb/tnMCjlddIV6N/SUIuRaaRgbbw
	nPpqlzblfbZ0fDZdrW2MoX2S0eYbMogl/JqJFKaZpMFp0ciCrlkKrDDwC016BuMDT0OlWI5YozO
	O0Wh2jW6Nku0Hdxj2ovZWFK9oNSFm5NFF5NY3Ao9Fb+0fU816xz7vA2UohzDpYnJZ0VtNd/v8v9
	kLgMZ+88xZaHmwzIl0MqxlO35f1s61bCt26Xcb2llPmIOZPzmiY=
X-Received: by 2002:a05:6402:26d6:b0:676:d863:ce29 with SMTP id
 4fb4d7f45d1cf-676d863cf85mr1407081a12.28.1776824353486; Tue, 21 Apr 2026
 19:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
In-Reply-To: <aegUoOiUbjUAH5aT@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Apr 2026 10:18:35 +0800
X-Gm-Features: AQROBzDy3s1eJBSM4ivRYyuVreJ6HWEvbaw8uJ7B00A6nArMH1jrA77MWD0vRmM
Message-ID: <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
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

On Wed, Apr 22, 2026 at 8:26=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> >
> > This patch series implements the virtual swap space idea, based on Yosr=
y's
> > proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> > inputs from Johannes Weiner. The same idea (with different
> > implementation details) has been floated by Rik van Riel since at least
> > 2011 (see [8]).
>
> Unfortuantely, I haven't been able to keep up with virtual swap and swap
> table development, as my time is mostly being spent elsewhere these
> days. I do have a question tho, which might have already been answered
> or is too naive/stupid -- so apologies in advance.

Hi Yosry,

Not a stupid question at all=E2=80=94it's actually spot on. :)

>
> Given the recent advancements in the swap table and that most metadata
> and the swap cache are already being pulled into it, is it possible to
> use the swap table in the virtual swap layer instead of the xarray?
>
> Basically pull the swap table one layer higher, and have it point to
> either a zswap entry or a physical swap slot (or others in the future)?
> If my understanding is correct, we kinda get the best of both worlds and
> reuse the integration already done by the swap table with the swap
> cache, as well as the lock paritioning.
>
> In this world, the clusters would be in the virtual swap space, and we'd
> create the clusters on-demand as needed.
>
> Does this even work or make the least amount of sense (I guess the
> question is for both Nhat and Kairui)?
>

Yes, this absolutely works. In fact, I previously posted a working RFC
based on this idea. In that series, clusters are dynamically
allocated, allowing the swap space to be dynamically sized
(essentially infinite) while reusing all the existing infrastructure:
https://lore.kernel.org/all/20260220-swap-table-p4-v1-0-104795d19815@tencen=
t.com/

The only missing pieces are a few helpers like folio_realloc_swap()
and folio_migrate_swap() for lower layer allocation and migration. I
prototyped this locally and it wasn't difficult to implement.
Furthermore, this approach works perfectly with YoungJun's tiering
work with zero conflicts, the dynamic layer can be runtime or
per-memcg optional.

To move this forward, I've stripped out the RFC features and memcg
behavior changes, and recently sent a V3 that focuses purely on the
infrastructure. It introduces no behavior changes or new features,
just optimizations.

It cleans up a lot of allocation and ordering, as well as memcg
swap lookups. Since some of these problems were also observed in the
vss discussion, I think this will make things easier for all of us:
https://lore.kernel.org/all/20260421-swap-table-p4-v3-0-2f23759a76bc@tencen=
t.com/
