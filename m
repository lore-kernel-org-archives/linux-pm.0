Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04363E5ECF
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301158; cv=none; b=Av0KcLOc8QQpVTnCtO/cA0Df8sliRjZhOJxKfddoiOtMX1n2SadqbHBbBClXR47W7xEP4d3kO4IIDFJwFGB8pzHm1J4xm1F46IuMg3XaADMVHqH9svfuCJnOPOTEP8x+JTuccC8POR6jUWqg1+4hpyrn+yxUY/vVfSFwVxlF2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301158; c=relaxed/simple;
	bh=L07ugexr4g98X11wi78Q+tqNnY75+cQ4PfhLNNWqWBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r65+wP1E876+OL8AufTB7LCTSrSYl8PrGMSe1kQCXH/XrdpgivGuYiQ3BQc626nfQolmaCKJqf1XUSiXumfYCn+kODU90B4EYqp5hfhsJa/wCPUzHVFNG1vKHpwuwiLZu+CWaLXfU6S3kMVWAktOV0B8JWmDDxHvxaWxyTOrDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOpzEP6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOpzEP6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11961F00893
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301156;
	bh=r8k5uHCoRVBIv1c9oG1U/zO3ZMGj+nRan6mX7s9e7uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SOpzEP6XeuA3Q3JycuX1HpUG7nAfeozoZvhTBbRJuVxMY2Ise5Iob4+Wo4wr7I8PC
	 vx300lRHoLbEr8v7IiMJrtFD1ezl/jht122a5YzXzA71RbcgSu301QwSPLZmoQBnQU
	 1pzumfmXix892evdkafe343HNAhDb+QZ9lGPy+p8KaVhRYQr9ppVM5znFKx7szL8Rl
	 5cRq79mxg1klZ4CeNcbRWD7oV4QbrTHUvZGUxZRF8wx0UjtGBiF7yjE51jFqKB0fAs
	 6K2jOSaCzkm7RkkfoMY3x/+FN2Rbd3N6ZKywqfeLBGfGN73r+2/uS5M0o2QDHo0msk
	 E0fs5zekeTqGA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so5832229e87.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:19:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+4Emg8Q9jTv43ITrFNtZNRQ38blovLNFY3xmfkEFEj7+ZVXeIIF3NiToTfGxoL4lVxuusYfMByg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLv4Jk7/tFlBRUD8JCsXgKpRz1InLBUjuLMxconpeKQ594xc9D
	VyS61hmV84BE8zid0AiUmQb8A49AI0dEa3rt6XoVEtUbXAo8lAU4GL7wZ0OFChbLBT2lx9N0aQW
	QwG5ihadpeNkleRBZD/b3DNrnOUwtUFE=
X-Received: by 2002:a05:6512:3188:b0:5a8:a555:f57e with SMTP id
 2adb3069b0e04-5aa0e73da54mr9346298e87.30.1779301155154; Wed, 20 May 2026
 11:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520150018.2491267-1-riel@surriel.com> <20260520150018.2491267-34-riel@surriel.com>
In-Reply-To: <20260520150018.2491267-34-riel@surriel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 20:19:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtkPK7+a3pBgiZRSHp7842L8aaZGOPG+SrdnuNebN0aA@mail.gmail.com>
X-Gm-Features: AVHnY4K_PJZMu_LRCyJ1SsE4uQ8YoN1fMVm-ozSbCHY_r7CEJzG7JEw9O8vu1d8
Message-ID: <CAJZ5v0gtkPK7+a3pBgiZRSHp7842L8aaZGOPG+SrdnuNebN0aA@mail.gmail.com>
Subject: Re: [RFC PATCH 33/40] PM: hibernate: walk per-superpageblock free
 lists in mark_free_pages
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org, 
	david@kernel.org, willy@infradead.org, surenb@google.com, hannes@cmpxchg.org, 
	ljs@kernel.org, ziy@nvidia.com, usama.arif@linux.dev, fvdl@google.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:01=E2=80=AFPM Rik van Riel <riel@surriel.com> wro=
te:
>
> mark_free_pages() walks the buddy allocator's free lists and calls
> swsusp_set_page_free() on each free page so it is omitted from the
> hibernation image. After the SPB rework, free pages live on per-
> superpageblock free lists rather than the zone-level free list, so
> the existing list_for_each_entry() walk over zone->free_area[order]
> .free_list[t] found nothing. The hibernation snapshot then treated
> every free page as needing to be saved, wasting image space and risking
> OOM during the snapshot.
>
> Wrap the existing per-page walk in an SPB iteration loop. When the
> zone has no SPBs (e.g. an unpopulated hotplug zone), fall back to the
> zone-level free list. The whole function still runs under
> spin_lock_irqsave(&zone->lock) without drops, so there are no lock-
> order or hotplug concerns.
>
> Build-tested as part of the full mm series; kernel/power/snapshot.o
> compiles cleanly in that build.  An -Werror=3Dreturn-type warning in
> enough_free_mem() exists on some configurations but is unrelated to
> this change and predates the SPB series.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Pavel Machek <pavel@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Assisted-by: Claude:claude-opus-4.7 syzkaller
> ---
>  kernel/power/snapshot.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index a564650734dc..f96885bc46f8 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1270,17 +1270,32 @@ static void mark_free_pages(struct zone *zone)
>         }
>
>         for_each_migratetype_order(order, t) {
> -               list_for_each_entry(page,
> -                               &zone->free_area[order].free_list[t], bud=
dy_list) {
> -                       unsigned long i;
> -
> -                       pfn =3D page_to_pfn(page);
> -                       for (i =3D 0; i < (1UL << order); i++) {
> -                               if (!--page_count) {
> -                                       touch_nmi_watchdog();
> -                                       page_count =3D WD_PAGE_COUNT;
> +               unsigned long sb_idx;
> +               unsigned long nr_lists =3D zone->nr_superpageblocks ? : 1=
;
> +
> +               /*
> +                * After the SPB rework, free pages live on per-superpage=
block
> +                * free lists. Walk every SPB's list for this (order, mt)=
 cell.
> +                * If the zone has no SPBs (unpopulated zone), fall back =
to the
> +                * zone-level list head so that any pre-SPB pages are sti=
ll
> +                * marked.
> +                */
> +               for (sb_idx =3D 0; sb_idx < nr_lists; sb_idx++) {
> +                       struct list_head *list =3D zone->nr_superpagebloc=
ks ?
> +                               &zone->superpageblocks[sb_idx].free_area[=
order].free_list[t] :
> +                               &zone->free_area[order].free_list[t];
> +

Suppose the code below goes into a separate function returning the
current page_count value and taking list, buddy_list and page_cout as
arguments.  Say its name is do_mark_free_pages().

> +                       list_for_each_entry(page, list, buddy_list) {
> +                               unsigned long i;
> +
> +                               pfn =3D page_to_pfn(page);
> +                               for (i =3D 0; i < (1UL << order); i++) {
> +                                       if (!--page_count) {
> +                                               touch_nmi_watchdog();
> +                                               page_count =3D WD_PAGE_CO=
UNT;
> +                                       }
> +                                       swsusp_set_page_free(pfn_to_page(=
pfn + i));
>                                 }
> -                               swsusp_set_page_free(pfn_to_page(pfn + i)=
);
>                         }
>                 }
>         }
> --

Then, what you seem to be wanting to do is roughly

if (zone->nr_superpageblocks =3D=3D 0) {
        do_mark_free_pages(&zone->free_area[order].free_list[t],
buddy_list, page_count);
} else {
        for (sb_idx =3D 0; sb_idx < zone->nr_superpageblocks; sb_idx++) {
                page_count =3D
do_mark_free_pages(&zone->superpageblocks[sb_idx].free_area[order].free_lis=
t[t],

   buddy_list, page_count);
        }
}

which would be kind of easier to follow.
