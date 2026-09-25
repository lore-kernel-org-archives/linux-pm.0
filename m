Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924344604F
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366262; cv=none; b=WImix2bjOZL/Q6HmAXrknUkyFOwFvcQyiM6K2SUCd+0PrpBbDC2/C2F2wj0pmejqoPlTXxfWP83EfXf9PABKiKo/qUFfAO4XbCAzLIpDlksZq5YxB4DZuFjMhmI8QuH2NwkDYMVAKY56ZC8Qkir/+tFvPiA4n1Fk9WwMBp5pOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366262; c=relaxed/simple;
	bh=alSbXionUckrEqhLEMw5vN+DI64Z112+lA3G/L0wV4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1C7/bCiMLNLjM+LDvJbtJo/uZ3UMS2FcQLJnnwl00I7gtOMBcrCA4Ie+0HBdiYpL4qRuZ7T8AE4hE6wFlllDfkviwahSR1q/DwWT1N9V1fpdz74k4lHFxTOYOIbNorBERxprf6kzxz1ugnv+lwGDeTXeeayhVPl1+Bdgf2K920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKdSpdEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKdSpdEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423971F000FF
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366260;
	bh=KcHcrjFXmcheLPSGWXIZYIuPCnKoDK3uabc3scYktsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SKdSpdEG3R11l1/db7GmEzs57zA42aBCPZPgKbvs4wLqn2LBwp4z/w3oTue3v3fyr
	 cutNlvXevWgaAKMUZmmsqP1/g7Pro5glObYmHeMinEpFOP938EKF7dOuasd+BJeg0Y
	 VdIGKqg3NUMm3d5BywCD2gG+knm0gGrMJ4GVI+UbWWu10XNoG6hgZBsYhQt2YvIiH7
	 rFWYQ5jaAfknVVczjUerCWm8ygp8LPxMnXCAAL69o2vQIMThGHlM778q9r3L3mW7PB
	 v00EAf0rV/L+XyP73uoDODlqYYK0f7Kv7DSaJHr7poYWj9yU+BBhUAcFNBGJ29EBNe
	 CnbZY2eAY8rEg==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a65a351692so1352241fa.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:57:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzj8DE/v3q+9vy7K33c53Ex4hnUgZ+wn4tkyWTOAprNbiqxovngUC9/2psm65q/kuZk4TdVBD6KUA==@vger.kernel.org
X-Gm-Message-State: AFuF++n8KQi7OtlFtny/zvj5am4FJhKjvktPQZXyPwtzlPlrkOByppSn
	8NVqfMsR9xVlj/wQ/iJ7ToCD48W7ADtVEnGegtfbSVVOPhD0Ee8cNAzWGPwMcxP0BPCVIdSANzA
	NKrU8h2nJGxuIhBAV9Ci7N09vMfwnEg8=
X-Received: by 2002:a05:651c:154a:b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a63c30cb49mr18228641fa.18.1790366258695; Fri, 25 Sep 2026
 12:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921101446.1193565-1-trieu2.huynh@lge.com>
In-Reply-To: <20260921101446.1193565-1-trieu2.huynh@lge.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:56:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iViUTTPBpfi10uHptoc98DbC_H2GP9BBuqNHA2d9vQkw@mail.gmail.com>
X-Gm-Features: AclHuK_cpa-ScBOU6nvCY5Ag22ciTDDvKM4errJxfZktIpEUcjFizzpktCC2igU
Message-ID: <CAJZ5v0iViUTTPBpfi10uHptoc98DbC_H2GP9BBuqNHA2d9vQkw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: exclude unusable free pages from image preallocation
To: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 12:14=E2=80=AFPM Nhat-Trieu Huynh-Pham
<trieu2.huynh@lge.com> wrote:
>
> hibernate_preallocate_memory() derives the number of page frames to
> preallocate for the image from the per-zone NR_FREE_PAGES counters.
> Those counters count every free pageblock regardless of its migratetype,
> including MIGRATE_HIGHATOMIC and MIGRATE_CMA pageblocks. Such pages are
> free from the buddy allocator's point of view, but they cannot be used
> by the order-0, non-movable, non-reserve GFP_KERNEL allocations with
> which the image is preallocated (GFP_IMAGE =3D GFP_KERNEL|__GFP_NOWARN).
>
> (*) Reported free vs usable free:
>
> The mm subsystem already accounts for this in
> __zone_watermark_unusable_free(). For order-0 GFP_KERNEL neither
> ALLOC_RESERVES nor ALLOC_CMA is set, so the allocator subtracts the
> high-order atomic reserve and the free CMA pages from the free count befo=
re
> checking the watermarks. The hibernation preallocation, however, computes
> its target from the unadjusted NR_FREE_PAGES value, so it asks for about
> half of the unusable pages more than the allocator can deliver. On arm64
> (no CONFIG_HIGHMEM) the highmem fallback in the failure path is a no-op,
> hence even a small shortfall aborts hibernation, see [3] for example.
>
> (*) Why those pages are not usable by GFP_KERNEL:
>
> (**) CMA is reserved for movable allocations, so GFP_KERNEL has no
> ALLOC_CMA, and MIGRATE_CMA is not in the unmovable fallback list. Free
> CMA pages are therefore never handed to these allocations.
>
> (**) The high-order atomic reserve is only handed out to atomic, order > =
0,
> __GFP_HIGH allocations (ALLOC_HIGHATOMIC), which GFP_KERNEL order-0 is no=
t.
> These pages can be unreserved under memory pressure, but only all but one
> pageblock per zone and only after an allocation has already failed,
> so counting them as available still overestimates what the preallocation
> can obtain without failing first. Excluding them is conservative.
>
> (*) Consequence of not excluding the unusable pages:
>
> With M =3D managed, S =3D saveable, F =3D free, U =3D highatomic + CMA an=
d
> R =3D reclaimable, count =3D S + F - totalreserve and alloc is about
> count / 2, while the allocator can actually provide about (F - U) + R
> pages. The shortfall is therefore inflated by exactly U compared with
> the usable memory.
>
> From, with U =3D 11430 unusable free pages (5120 highatomic + 6310
> CMA), the preallocation target is inflated by about U / 2 =3D 5715 pages,
> while the allocator ends up 1247 pages short and hibernation is aborted
> even though the system is able to create the image.
>
> (*) What changes after excluding the unusable pages:
>
> Subtract U from the per-zone free accounting used to compute count and
> avail_normal. Then count' =3D count - U and, since max_size is roughly
> count / 2, max_size' =3D max_size - U / 2 and alloc' =3D alloc - U / 2.
> max_size' remains well above minimum_image_size() in practice, so the
> resulting image is effectively unchanged while hibernation no longer
> aborts unnecessarily.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> (*) SA6155P running on AAOS with S2D feature
> (*) backport locally on GKI 6.1
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1]
> commit f27ce0e14088 ("page_alloc: consider highatomic reserve in watermar=
k fast")
> [2]
> commit ac3f3b0a5551 ("mm: page_alloc: unreserve highatomic page blocks be=
fore oom")
> [3] Example of an abort:
>     Mem-Info:
>      free:344621 free_pcp:931 free_cma:6310
>     DMA32 free:973864kB reserved_highatomic:8192KB free_cma:25240kB
>     Normal free:404620kB reserved_highatomic:12288KB free_cma:0kB
>     PM: hibernation: Image allocation is 1247 pages short
>
> Signed-off-by: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>

Please see Sashiko's feedback on this:

https://sashiko.dev/#/patchset/20260921101446.1193565-1-trieu2.huynh%40lge.=
com

and let me know what you think.

Thanks!

> ---
>  kernel/power/snapshot.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index b209712cb2c3..fd6164aea272 100644
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
> +               unusable =3D zone->nr_reserved_highatomic;
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
