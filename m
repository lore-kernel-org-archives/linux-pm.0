Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584711;
	b=XvrUMLbeY96tGlyyR8t3dbiBtJUdmetZDzwhWcCAvnaPDC3J+Z6SjN4zxNmjccJ0aE3Z
	 lS1PIpnlhBTsNs9rGfy8kT2MY7k1w2mtYJf4FAFrQzOlDNgoXv5+o2bg8LrVSln4k7xUk
	 gdim7sCdm5HfmxhwUqrnWY48MTRN/7Mei6r26UDa+70pMfhYwK4NUV7iI7ktr6CezQflv
	 IqyJP6ZAszBTi5y1GakLVYiYPui0ObBnqhdolXkVEXrx6TeU0jFiV+1Dr+/DrLD2fQrb3
	 gkcJFJcq7OWWscNXyZ7Dbt0qUv3bkd7ag9wZVPodvgpQ1v8vevkfEHbJfDrx+ntTpGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584711;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n/wuHTb6nfiDadh4l5rcFTk7hc/gsK1EGHfxTyZXNAw=;
	b=11mrNF1oSFLn0obrpA6OqdTCYMnalX4ItIik6Tu03MTus05cK3sUUIJemDB+ylULMPs+
	 zcbCltgH9559nT9qjg2mYhrPW2VzSwjPh6FYBizK/kzC6UwPu1QY33/gHdNOpa3eSLEkq
	 4Nwe9B1iDGfoDspFUpHbGpQsIygCZUnoFik7snjaOTJiatXArcgCInrI+QOwTlofWWckN
	 WF/Gr5XZjJoUo1noEzSrjEPIeREMKDyMGyQR3/i+j4dfZpFDwBYub+24VmzAsla7cv17l
	 oBnwCnSZmB9PNaFJO0TRXBCGO3L1wYqn/0Ei1DhT78HPKQj+EKBmySu3x/aaUsyx2zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQCk+eon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1660A261B
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQCk+eon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715571F000CB
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584711;
	bh=n/wuHTb6nfiDadh4l5rcFTk7hc/gsK1EGHfxTyZXNAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OQCk+eoneq1ObkyPSD3pj/DjRJYbHvarbPA77fFjKNmXJIkbEEcRKg87D513n46ex
	 jvm7V+qHxe0zOAfGnxDxYj8fBauUgT4vYVJKCDL83fswF4CGq+HyE6/MJ5OEKdNVdr
	 pFQ/InBU2q7s0mfJYu8S1kSGIiFSR71mXi9cl3UN8GQw/Spt3JmKarrUk6w9Y40INN
	 x7/aSBWx0EfQQYIo3THahbaow4c4KHIaPFKZiOS/E/a9XIjqDFXPdi4M2vIBEG6OrI
	 FAFY9+3OYSjKoaTntbzVTNelSBLcdAZASIw8410nrI7EB8OTyxNWtCAi2iPnIuQeG8
	 Hyfu6TvVIMuOg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso16862631fa.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:45:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGZJXxZlo34ogzDFC9Ir+RxXLNsxIXEyIn+k71Qe6H4W1kKyVNEGUf9keM9zJDwF0zG1OiE7qJXdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z87Uf7MWRlEuLM3uz98zyDICsAws+yJvUaAXpngLB3vPh+tc+TK
	e3E6GD0A0QHz9tbAlOMVfQtEzy/kzYwaoesN0dXqxsw22k1xySCRwygrAgZFebgbAaUJnHOYQX7
	V+9H8PfFn09YUzYNsTNw/kMtUSHok+2Y=
X-Received: by 2002:a05:6512:2520:b0:5ba:41f0:5a45 with SMTP id
 2adb3069b0e04-5c17079a222mr1240864e87.21.1794584709797; Fri, 13 Nov 2026
 07:45:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001084115.2549761-1-trieu2.huynh@lge.com>
In-Reply-To: <20261001084115.2549761-1-trieu2.huynh@lge.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:44:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjqOHzF2-hZeRwhb9AWK2iWxex3iK_R2+tSEnXEitBnA@mail.gmail.com>
X-Gm-Features: AclHuK9hM78u-Ram9NQ3Jtz8EWsianym-xUcGoXELzxl848Mm5g6QgrpIsDJaso
Message-ID: <CAJZ5v0gjqOHzF2-hZeRwhb9AWK2iWxex3iK_R2+tSEnXEitBnA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: exclude unusable free pages from image preallocation
To: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:41=E2=80=AFAM Nhat-Trieu Huynh-Pham
<trieu2.huynh@lge.com> wrote:
>
> hibernate_preallocate_memory() derives the number of page frames to
> preallocate for the image from the per-zone NR_FREE_PAGES counters.  Thos=
e
> counters count every free pageblock regardless of its migratetype,
> including MIGRATE_HIGHATOMIC and MIGRATE_CMA pageblocks. Such pages are
> free from the buddy allocator's point of view, but they cannot be used by
> the order-0, non-movable, non-reserve GFP_KERNEL allocations with which t=
he
> image is preallocated (GFP_IMAGE =3D GFP_KERNEL|__GFP_NOWARN).
>
> (*) Reported free vs usable free:
>
> The mm subsystem already accounts for this in
> __zone_watermark_unusable_free() [1]. For order-0 GFP_KERNEL neither
> ALLOC_RESERVES nor ALLOC_CMA is set, so the allocator subtracts the free
> high-order atomic [2], and the free CMA pages from the free count before
> checking the watermarks. The hibernation preallocation, however, computes
> its target from the unadjusted NR_FREE_PAGES value, so it asks for about
> half of the unusable pages more than the allocator can deliver.  On arm64
> (no CONFIG_HIGHMEM) the highmem fallback in the failure path is a no-op,
> hence even a small shortfall aborts hibernation, see [4] for example.
>
> (*) Why those pages are not usable by GFP_KERNEL:
>
> (**) CMA is reserved for movable allocations, so GFP_KERNEL has no
> ALLOC_CMA, and MIGRATE_CMA is not in the unmovable fallback list. Free CM=
A
> pages are therefore never handed to these allocations.
>
> (**) The high-order atomic reserve is only handed out to atomic, order > =
0,
> __GFP_HIGH allocations (ALLOC_HIGHATOMIC), which GFP_KERNEL order-0 is no=
t.
> These pages can be unreserved under memory pressure [3], but only all but
> one pageblock per zone and only after an allocation has already failed, s=
o
> counting them as available still overestimates what the preallocation can
> obtain without failing first. Excluding them is conservative.
>
> (*) Consequence of not excluding the unusable pages:
>
> With M =3D managed, S =3D saveable, F =3D free, U =3D highatomic + CMA an=
d
> R =3D reclaimable, count =3D S + F - totalreserve and alloc is about coun=
t / 2,
> while the allocator can actually provide about (F - U) + R pages. The
> shortfall is therefore inflated by exactly U compared with the usable
> memory.
>
> From [4], with U =3D 11430 unusable free pages (5120 highatomic + 6310 CM=
A),
> the preallocation target is inflated by about U / 2 =3D 5715 pages, while=
 the
> allocator ends up 1247 pages short and hibernation is aborted even though
> the system is able to create the image.
>
> (*) What changes after excluding the unusable pages:
>
> Subtract U from the per-zone free accounting used to compute count and
> avail_normal. Then count' =3D count - U and, since max_size is roughly
> count / 2, max_size' =3D max_size - U / 2 and alloc' =3D alloc - U / 2.
> max_size' remains well above minimum_image_size() in practice, so the
> resulting image is effectively unchanged while hibernation no longer abor=
ts
> unnecessarily.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> (*) SA6155P running on AAOS with S2D feature
> (*) backport locally on GKI 6.1
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] commit f27ce0e14088 ("page_alloc: consider highatomic reserve in wate=
rmark fast")
> [2] commit c928807f6f6b ("mm/page_alloc: keep track of free highatomic")
> [3] commit ac3f3b0a5551 ("mm: page_alloc: unreserve highatomic page block=
s before oom")
> [4] Example of an abort:
>     Mem-Info:
>      free:344621 free_pcp:931 free_cma:6310
>     DMA32 free:973864kB reserved_highatomic:8192KB free_cma:25240kB
>     Normal free:404620kB reserved_highatomic:12288KB free_cma:0kB
>     PM: hibernation: Image allocation is 1247 pages short
>
> Signed-off-by: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
> ---
> Changes since v1:
> (*) Add a reference to commit c928807f6f6b, and correct the words and
> quotes in the description as well.
> (*) Switched from zone->nr_reserved_highatomic to
> READ_ONCE(zone->nr_free_highatomic) to accurately fetch the active free
> highatomic counter, reflecting c928807f6f6b (Reported by: Sashiko).
>
> Link to v1:
> (*) https://lore.kernel.org/lkml/20260921101446.1193565-1-trieu2.huynh@lg=
e.com/
>
>  kernel/power/snapshot.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index b209712cb2c3..195db45ce80f 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1867,11 +1867,32 @@ int hibernate_preallocate_memory(void)
>         highmem =3D save_highmem;
>         size =3D 0;
>         for_each_populated_zone(zone) {
> +               unsigned long free, unusable;
> +
>                 size +=3D snapshot_additional_pages(zone);
> +
> +               /*
> +                * Pages reserved for high-order atomic allocations
> +                * (MIGRATE_HIGHATOMIC) and free CMA pages cannot be used=
 by
> +                * the order-0 non-movable GFP_KERNEL allocations that
> +                * preallocate the image, so do not count them as availab=
le.
> +                * This mirrors __zone_watermark_unusable_free().
> +                */
> +               free =3D zone_page_state(zone, NR_FREE_PAGES);
> +               unusable =3D READ_ONCE(zone->nr_free_highatomic);
> +#ifdef CONFIG_CMA
> +               unusable +=3D zone_page_state(zone, NR_FREE_CMA_PAGES);
> +#endif
> +               /*
> +                * nr_reserved_highatomic counts whole reserved pageblock=
s,
> +                * so it can exceed the actual free pages.
> +                */
> +               unusable =3D min(unusable, free);
> +

Please address Sashiko's feedback regarding this change:

https://sashiko.dev/#/patchset/20261001084115.2549761-1-trieu2.huynh%40lge.=
com

>                 if (is_highmem(zone))
> -                       highmem +=3D zone_page_state(zone, NR_FREE_PAGES)=
;
> +                       highmem +=3D free - unusable;
>                 else
> -                       count +=3D zone_page_state(zone, NR_FREE_PAGES);
> +                       count +=3D free - unusable;
>         }
>         avail_normal =3D count;
>         count +=3D highmem;
> --
> 2.43.0
>
