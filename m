Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72A3BF691
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284093; cv=pass; b=qiBpitJpWxgEgipXuQAKufRlj5EsKkWYCiPZjGN07fEJWVYMna075X82H5ZTY9HuT3C5GmOXC1S1LIXuL6Yr1DyHs6sPFsUqZA8SgA+18G3RHy52Kqn9X+mDlHeJEimKjX9QO6VVyrAxzpp6uP4XGoNYsVWeOptI2OFEeEPSb/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284093; c=relaxed/simple;
	bh=qfm+jxRDid/tXrKxPwqn57nuEjBnj1DDrZrU+wNae2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+aWDm9D1IPvXKN7wQSHY6JjTpn8NOVlIoLuydU6w4IU1z+SIPVbiKkkl45xJkdjoqS3hGklt1cHXatSNRDh7hP1tuDJDVWvV9h7PZW9tVR/WRn6Yzxtxpk3JtruljAUAH9O453FZKB6qbCUjKLZKln0Dl4xpaxsnVLR3dK5x5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQw/Tj+l; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQw/Tj+l"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so52912666b.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 09:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774284090; cv=none;
        d=google.com; s=arc-20240605;
        b=dpj+vFEV06AdDZLJksvcBKvasMogxl/AzgL0YqA3Pk4RsSLfcLo/n9i6zKOX3mqV7X
         S6NCUi1T5DmvfTMDKPYq5SKifj7lJvebGwFgOn5+e8Q1Rdk8v+e/ntPXE//9xM3SUhPY
         0enG0J4qsOnsa0srCau+cSnQ+HGFuIueLlScQb43iIYASAi2dNASdfgdR5ZA2ARkOS09
         hho/SvetZadMX+208kHG1u0kVWbXbYgA4MxDo1m/0o0TmC6SipCQiRAK5/ng/6UZI8ub
         0UgDSKKlsRxe3VTO2phxOwbqpbpXBP6buUvcfYxpo4ZZ8VJrczNDIVUMu9FISIMpT8EV
         7+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        fh=EhBl/g+lCM1wwvHvkEHQNGx0PC9y+shN9lxN/eqUO60=;
        b=Ta+s1FDn8BnlvVNIzIJT49Ng0IyJjQLjwZ5/ce7KsHYMDTRh2GRXD9JEtFDr1Q4vgs
         5IYxMdOPKya31wUqMQUcLwxAFELGj6fsqsThVkb0WQhu+L9ZkS1M737SI4kw8eJjljto
         dTY8MZyGM/U1uDefE3QR6z7cqvAqPS0D15dkVmnZ++bb5jsdhLLwdo6KHTKEBXIbNS1n
         dMENm+uzy3HS6EWfDBezEJPR7CLtZU9aOQL5fvgKA1T4RWqtezxquabYVNLbWJ7RSDtI
         4nIW6bpszDRHQuBJ5AzT2h2empexPYghKIGJpCUVrZrndMFWSnqAeWW4bw3ukcSD0iMb
         4uBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774284090; x=1774888890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        b=AQw/Tj+lI1htlIyduQK+LigMZe4ERziEeLn9lfuqmPjqbBpqoeZRLKp4k1oAAvbfwY
         vHjjcuo48HwT0/yCLIP/DM2xX8DfnBxfd24mR+HqP88YTe4n3uj9SkaHV2YKOejJz3Y5
         olgr6ZYJqiVHo9Y3fSwDb/cE9O60ZexePMb4qPWGnKphqQqnHUuchODbk5TEFJfugPJL
         OwboUfm0V38awswDw1iSbJZv+S4YeJJgiYXuhEH7E4M58WtUxYyWS9gI7ZDGWRgp0Wcl
         7uq9ChgUTp5SPI52gxLQxHooBcJj8toMw8+Yhtw07Mbl+xd5wfVzvj3fhhZicjXDUuSn
         ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284090; x=1774888890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        b=Q58VIUf35Cysb3zXgsDNmbNWzalpYMdPeZSUpipQTXEawY1++kNixSYQeZV8FkdF0H
         ZpWkfm+8Ndpa3q3A2N9yVJ8ckCxajCFCbAOJcN28Mwi+bV18qYMbjXuUCcn/nvK/mzYX
         2YKm+rim8CQKZuC/0vvfoefrk0bvpvjcqyGXkonsZSEHXwmQDtHCuhdOeLp5Dg5jNcD9
         wFfILNbIhmGdO2wudzN4jIGtsb+RQWX4s4+TUjthSOFhGsjtVD2rIDpK3C27jOpqEHs2
         ZjsZkG1rwC5l28mcxV+KCaUPE8DzkBmpseUov1xcXsrAsI9+STpMOzV5iw3x6RCttMHw
         vUdg==
X-Forwarded-Encrypted: i=1; AJvYcCVmewh3D8WhlybKvEvGGsGhIBgLhVLUcspNhPCqOdvIOH6GiNvzdSRhQruv1BHFKkh0OhIT7xRDtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiZpu4KzR72NGujL9rkOQ3sfR5QAGaOJtSr8hpb1JWXeylx5C
	XFs9/n2D2uFm7II48K/iQRomITzMN9ncU5F05s8O/LaUJHEUC7CCQqw4NBLaYQ2pDhR3ADATadM
	mt/ZFHKGgehFo5EnJrBXMACbclodQ7fs=
X-Gm-Gg: ATEYQzwIE/vP/y9CjZJWgqEwfeJPVJkfbA7Q13IecbTNBOtzCID7MX+pR8J0jX1LzIp
	Y3HFxEjJU2lJO1Jb3ftdj1Ucy3frMmmwe9OU/pKqoWRG/yfDt5Xr5LFch/aGL/3X9SmhkL7V0Nk
	kRlPQM4audIgr2hISXd60UXTQxcM1yU7YjUDqz/IsASp6nDp92T1fsD3u3ae+PZu7iJ8LbJsL79
	ViRqeRI/zU+Z7Q1UHsawn9cHBXifSJdbVOO85eR7FS3l/a0mK2z/7WyBNueumwFznd5eUritWEh
	Dk8qRlkK0+6FpsrbjBa4IIimO2XA4ai/tqNWbaJO
X-Received: by 2002:a17:906:c398:b0:b97:1009:7536 with SMTP id
 a640c23a62f3a-b982f286a8fmr671723566b.15.1774284089391; Mon, 23 Mar 2026
 09:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Mar 2026 00:40:52 +0800
X-Gm-Features: AQROBzD1kpskNn11W5HqnEfFhEQur5XfLuCkDmtbLopJRo-HyQHAInVqxx1Q2Xw
Message-ID: <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
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
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, Mar 23, 2026 at 6:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > > This patch series is based on 6.19. There are a couple more
> > > swap-related changes in mainline that I would need to coordinate
> > > with, but I still want to send this out as an update for the
> > > regressions reported by Kairui Song in [15]. It's probably easier
> > > to just build this thing rather than dig through that series of
> > > emails to get the fix patch :)
> > >
> > > Changelog:
> > > * v4 -> v5:
> > >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> > >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(=
),
> > >       and use guard(rcu) in vswap_cpu_dead
> > >       (reported by Peter Zijlstra [17]).
> > > * v3 -> v4:
> > >     * Fix poor swap free batching behavior to alleviate a regression
> > >       (reported by Kairui Song).
> >
>
> Hi Kairui! Thanks a lot for the testing big boss :) I will focus on
> the regression in this patch series - we can talk more about
> directions in another thread :)

Hi Nhat,

> Interesting. Normally "lots of zero-filled page" is a very beneficial
> case for vswap. You don't need a swapfile, or any zram/zswap metadata
> overhead - it's a native swap backend. If production workload has this
> many zero-filled pages, I think the numbers of vswap would be much
> less alarming - perhaps even matching memory overhead because you
> don't need to maintain a zram entry metadata (it's at least 2 words
> per zram entry right?), while there's no reverse map overhead induced
> (so it's 24 bytes on both side), and no need to do zram-side locking
> :)
>
> So I was surprised to see that it's not working out very well here. I
> checked the implementation of memhog - let me know if this is wrong
> place to look:
>
> https://man7.org/linux/man-pages/man8/memhog.8.html
> https://github.com/numactl/numactl/blob/master/memhog.c#L52
>
> I think this is what happened here: memhog was populating the memory
> 0xff, which triggers the full overhead of a swapfile-backed swap entry
> because even though it's "same-filled" it's not zero-filled! I was
> following Usama's observation - "less than 1% of the same-filled pages
> were non-zero" - and so I only handled the zero-filled case here:
>
> https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.co=
m/
>
> This sounds a bit artificial IMHO - as Usama pointed out above, I
> think most samefilled pages are zero pages, in real production
> workloads. However, if you think there are real use cases with a lot

I vaguely remember some workloads like Java or some JS engine
initialize their heap with fixed value, same fill might not be that
common but not a rare thing, it strongly depends on the workload.

> of non-zero samefilled pages, please let me know I can fix this real
> quick. We can support this in vswap with zero extra metadata overhead
> - change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
> the backend field to store that value. I can send you a patch if
> you're interested.

Actually I don't think that's the main problem. For example, I just
wrote a few lines C bench program to zerofill ~50G of memory
and swapout sequentially:

Before:
Swapout: 4415467us
Swapin: 49573297us

After:
Swapout: 4955874us
Swapin: 56223658us

And vmstat:
cat /proc/vmstat | grep zero
thp_zero_page_alloc 0
thp_zero_page_alloc_failed 0
swpin_zero 12239329
swpout_zero 21516634

There are all zero filled pages, but still slower. And what's more, a
more critical issue, I just found the cgroup and global swap usage
accounting are both somehow broken for zero page swap,
maybe because you skipped some allocation? Users can
no longer see how many pages are swapped out. I don't think you can
break that, that's one major reason why we use a zero entry instead of
mapping to a zero readonly page. If that is acceptable, we can have
a very nice optimization right away with current swap.

That's still just an example. bypassing the accounting and still
slower is not a good sign. We should focus on the generic
performance and design.

Yet this is just another new found issue, there are many other parts
like the folio swap allocation may still occur even if a lower device
can no longer accept more whole folios, which I'm currently
unsure how it will affect swap.

> 1. Regarding pmem backend - I'm not sure if I can get my hands on one
> of these, but if you think SSD has the same characteristics maybe I
> can give that a try? The problem with SSD is for some reason variance
> tends to be pretty high, between iterations yes, but especially across
> reboots. Or maybe zram?

Yeah, ZRAM has a very similar number for some cases, but storage is
getting faster and faster and swap occurs through high speed networks
too. We definitely shouldn't ignore that.

> 2. What about the other numbers below? Are they also on pmem? FTR I
> was running most of my benchmarks on zswap, except for one kernel
> build benchmark on SSD.
>
> 3. Any other backends and setup you're interested in?
>
> BTW, sounds like you have a great benchmark suite - is it open source
> somewhere? If not, can you share it with us :) Vswap aside, I think
> this would be a good suite to run all swap related changes for every
> swap contributor.

I can try to post that somewhere, really nothing fancy just some
wrapper to make use of systemd for reboot and auto test. But all test
steps I mentioned before are already posted and publically available.
