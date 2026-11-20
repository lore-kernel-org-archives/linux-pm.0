Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196965;
	b=NXAlKls5luPb0yr+qaaZI2e+2fcZ7F4aVrcnN5oYt/80B2fl3UOurIF1IET8XAmh/WHu
	 cQKtt/hJq/VT7H0ee6VA1vZKVi9hCCDaP/Y9LM98BZtR8K09LyE8/mM3lKwhZNq7i+5bQ
	 uxEfYg9gJalzE77BMjm+fpYnm4aA1YCZaDkghIR8xcxb0IcGGBGhdn/+TwtpTWVETwMjX
	 Zswk8TfX2yzhVBB4fA1khgAUpmo2E5kPVnLkeAUBJa9Xtf4rJT38+TVb5yZ5qh1+1AP4v
	 /klOXVnPjLrRNrF+IIYJ9dW93FUHD4QDFNfQynwNFxLB10HSMrrIpzpJ3u9JLN+kUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196965;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y/XrfF1iafL1OhzM7cC6hZHkTDa8Jg8Ue2qP5IV6kV0=;
	b=pgaqBXqjisQCcbgQk8pVUzlT7ZWqHr2z4aZIABCZ8FHtCrw0T1fnvpvTb5bQUj9muSIh
	 ZV7dGrYbMjH+pOWCndeFSiaZwpuD41iSP1F0+se+4AsizATFJIdKYHmSnkokmMVobOKqh
	 37TL+dL8yfQdpxcig648M/zLMjVDPucr5QLmhVD5Nw0sibWMT+I14rivCfdGaKZ57+7GD
	 tuMRWd/idPMhux5BZI6jI2nMFAJr+Z/iGs+0ShmhPsQ/Ddq41wryJhRIGyDFGMdOvt+NH
	 KMcE10U2zaadUJpD9lgir8S+5j9msN34Ydx8VthkNiQwW4ehveU+Qcpd9DBrpB/ItcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Moupq8tR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758B60A2606
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Moupq8tR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD51F000EB
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196964;
	bh=Y/XrfF1iafL1OhzM7cC6hZHkTDa8Jg8Ue2qP5IV6kV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Moupq8tRf/frKBhqrnzxKlNCRWttNTqfFdpVhQCv75R856KR50zl8vdkuLpbECtsA
	 RQA0q/g1PqRUTc9fkIr1/WisCwSC0a7VLPHN5qxdRXUQbEws2fgeNVxEd7PZXDKtPh
	 LUJhpFD4K6qoKlh0kjc1RpVYi10CMNwZAOFqCwytkIbH8rvpZZqLX+iHkbgkQCoW8U
	 B0rq+XWXX+d8momjovjVRFyWrZEFQtKRUSw8lpNyuYG5BRO4EtC6FJ/LeIw4xQMriM
	 17Zh9C+A0MMZVg9BavsrMJwwBR9Dh/2MkhIhMf71szlC6qFHUI+oQR2aHcOUOpt9+v
	 2TT2PeYi3sDfg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so22464981fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:49:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFjefAqyatWBiyotcPlYgQcVcDfS9CFWuCgcUd/H3NtDRDBCMri975xFfnQ1GZ6wrBqAKnYgC40qA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q4aO7S/AqVW1JTfqL4HMuFCAFgeqGeehSXPvhwe4URhn8xIXC
	Y9ohzg2B7MxCCYRX+V+ED6UkZKe/bCZ8Oqz26YOq/aL8mojTixJX4Ox8HTq8vM1djTpFYEVFmz/
	Lq5C2bCf3TfYKqg4KaMqyKeMozeZ1tGY=
X-Received: by 2002:a05:651c:883:b0:3ae:796:8143 with SMTP id
 38308e7fff4ca-3ae7b7ce452mr12303131fa.10.1795196963149; Fri, 20 Nov 2026
 09:49:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116084201.30092-1-trieu2.huynh@lge.com>
In-Reply-To: <20261116084201.30092-1-trieu2.huynh@lge.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:49:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gDyN8hmjUTKgjvKGimH9==0sgT-ZUQyy3tW5420Ekg1Q@mail.gmail.com>
X-Gm-Features: Aa3M54rY6oa4RhJemsGCZ_SCoTo-jhNt4IbKx7tcOrnPWEnAJ5PlvZcoH9pNCxs
Message-ID: <CAJZ5v0gDyN8hmjUTKgjvKGimH9==0sgT-ZUQyy3tW5420Ekg1Q@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: exclude unusable free pages from image preallocation
To: Nhat-Trieu Huynh-Pham <trieu2.huynh@lge.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:42=E2=80=AFAM Nhat-Trieu Huynh-Pham
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
> Changes since v2:
> (*) Rebased on v7.4-rc3
> (*) Updated the stale comment above the min() clamp: it still referred to
> nr_reserved_highatomic, but the code reads nr_free_highatomic, and the
> clamp is needed because the counters are sampled separately (Reported by:
> Sashiko).
>
> Changes since v1:
> (*) Added a reference to commit c928807f6f6b, and correct the words and
> quotes in the description as well.
> (*) Switched from zone->nr_reserved_highatomic to
> READ_ONCE(zone->nr_free_highatomic) to accurately fetch the active free
> highatomic counter, reflecting c928807f6f6b (Reported by: Sashiko).
>
> Link to v1:
> (*) https://lore.kernel.org/lkml/20260921101446.1193565-1-trieu2.huynh@lg=
e.com/
> Link to v2:
> (*) https://lore.kernel.org/lkml/20261001084115.2549761-1-trieu2.huynh@lg=
e.com/
>
>  kernel/power/snapshot.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index d5dba0e50b2e..24ba09db7fe6 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1867,11 +1867,33 @@ int hibernate_preallocate_memory(void)
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
> +                * free is a per-CPU vmstat approximation and is not
> +                * sampled atomically with unusable, so free - unusable
> +                * can transiently underflow.  Clamp unusable to free.
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

Applied as 7.5 material, thanks!
