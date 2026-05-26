Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D23F6C53
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796455; cv=none; b=qhHwCYWTh4yg1Q0qZxDP2Qgu0dz4JseP62EikoNG/i7qEEyN6oNxsFm6lXMfOLO+eiUU1ZeJqTy8UsknruG8bU6xTmn87ziabVN5vE7oxe9kNXQRSk7uEMuR5WB7e1eIwRbCGTrE3r2qZV/EuC9M+AcdChKsCVJlv+jL7o+d8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796455; c=relaxed/simple;
	bh=obiRXhqWYaoVh/7S/afYu0ZHOfGBcJ7ElhJCrN8PNjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8s15PFLEiefVE0Pz+kONFuTYutfq44EY/ajx2iKel2VbIAQSzzOUK4e25OUHicNxiq+JojyY/7g+p1BssdD4+PGMir+vL6NC4dYb2W0oPbOOFJacIQN8r5iBvgMNRJ2XSFqZHkzu07Ik0QVXFOOF9gMdLIrwi3Xdy4IS6asqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1rSyLen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1rSyLen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A134B1F000E9
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779796442;
	bh=Rqd4bc4WUQNfwkEdU9ul2rorhcX8UKt3xTOi+dY5lDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=b1rSyLenZXxaFIXmGxrphoihdxZOuV/jpDdWe1HwzCSubV7q8x4iWthDJVz709Vot
	 bSp2bYMFyKOZDNF4DjT8uGWuXsFjxivjYs8Cu7Zvr+UXvQZvVYp0NlBnHPbyWznfoT
	 0IPQNv1aWSA9J7MS5Sus5Ko4Fd+ibt6317Psxzi8dP6bfmmuvqITjq8vdrvY3EOMQd
	 HFR/v0n2BByiZ1exC0wZMU0XtWsjsaumjy1LsGwRhmML8MOwy/CV3DcbMMUG/ZHHIu
	 /LFki+BE01WgLugiKCwgbzATWOIEJZvcTX6ApWdiUtspAd4T79BeUZSfwuuKaQPV5Q
	 uGqQUJbxebHtg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-395317d8852so88633771fa.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8I+/ESv5z1/uWq3TYR9K1WVF6uM913ikD1W6YYp9WQ8xUqGfBQs+RpwEgsYDsB3iOnr04SPq1aMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDM+pBcyI0ox0SM2Zwjn20q151HDq5bxy7nVGVLRZoSk5Oiin
	OSd7t6Q4b8zueJxmMNlWnwLeBai4dXPgNnuFQf43jKVikGxEPotxs1IZ4rLG+UY4qzmhyYCMtBG
	OCpEH5xpttE6HtZkOU7QmFZajIAWMtgI=
X-Received: by 2002:a05:6512:2245:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa3237d6acmr5330442e87.6.1779796440969; Tue, 26 May 2026
 04:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:53:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com>
X-Gm-Features: AVHnY4J_zG8pMYc4mhhT64ozM1b1ptv471pQd2Uu_3vYPvAaEuvnzM2qka_jwd8
Message-ID: <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: hibernate: Allow disabling zero page check in copy_data_pages()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The current implementation of copy_data_pages() has at its center
> do_copy_page(), which copies data of all saveable pages in a loop one
> long at a time, while checking whether the page is fully zero to allow
> it to not be saved in the hibernation image.
>
> As the comment above do_copy_page() mentions, this loop was used instead
> of the more optimized copy_page() and memcpy() due to them depending on
> fpu_begin()/fpu_end() (see [1] and commit 95018f7c94cb ("[PATCH] swsusp:
> do not use memcpy for snapshotting memory")). However, since commit
> c6dbd3e5e69c ("x86/mmx_32: Remove X86_USE_3DNOW"), this limitation no
> longer holds, and it only affected x86-32 in the first place.
>
> From testing it is clear that removing the zero page check and using
> copy_page() makes it almost 3 times quicker:
> - Current:
>     PM: hibernation: Copied 4940240 kbytes in 11.33 seconds (436.03 MB/s)
> - With just the zero check removed:
>     PM: hibernation: Copied 4974664 kbytes in 9.03 seconds (550.90 MB/s)
> - With the zero check removed and using copy_page() instead:
>     PM: hibernation: Copied 6275216 kbytes in 3.96 seconds (1584.65 MB/s)
>
> Given that copy_data_pages() runs inside a critical section where only
> a single CPU is online and syscore is suspended, it should be kept as
> short as possible to keep the system responsive.

I'm not sure if being responsive during hibernation is all that important.

Also, the change is about using copy_page() to reduce the time spent
in syscore_suspend(), so the subject is a bit confusing.

> While switching from the loop to copy_page() brings big speed
> improvements, it also makes the zero page check much costlier since it
> can no longer be done in the middle of the copy. In fact upon testing
> adding the zero check alongside copy_page() made it slower than the
> current code.

Guess what, CPUs have caches.

> The following shows a rough comparison of a few more metrics between the
> current code and when both copy_page() is used and the zero page check
> is disabled:
> - Total time to hibernate:
>   - before: 13.77s
>   - after: 14.13s

Score for the current code.

> - Total time to resume:
>   - before: 5.85s
>   - after: 5.85s
> - Total time in syscore_suspend():
>   - before: 11.3s
>   - after: 4.08s

Why does this matter?

> - Total image size written to disk:
>   - before: 4956296kB =3D> 2606402kB compressed =3D 2.60MB
>   - after: 6274608 =3D> 2616624kB compressed =3D 2.61MB

"kB" seems to be missing in the bottom row.

Which means that this is a score for the current code again because it
needs to copy and compress fewer pages which means that less energy
needs to be used (which may be kind of relevant in low-battery
situations).

> As can be seen the total time to hibernate is roughly the same,
> suggesting that the time saved with the more efficient copy_page() is
> payed by having to compress more data (the zero pages). The time to
> resume remains the same. And the hibernation image size is basically the
> same, as the zero pages compress well (the case would be quite different
> if compression is disabled). The big win here is that the time between
> syscore_suspend() and syscore_resume() is much lower, meaning the system
> will be more responsive throughout hibernation.
>
> Expose a 'nozerocheck' module parameter

I'd rather not.

Either the switch-over is compelling enough to do it unconditionally,
or it is not, in which case the existing code can be used just fine.

As it stands, I'm not convinced.

> to allow the zero page check to
> be disabled and the faster copy_page() to be used, giving the option for
> userspace to choose between a more responsive system and reducing the
> disk usage particularly when compression is disabled.
>
> Testing was done on the SteamDeck OLED.
>
> [1] https://lore.kernel.org/all/1096877559.9064.45.camel@desktop.cunningh=
ams/
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  kernel/power/snapshot.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 4f452baf31dc..00feac18faae 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -40,6 +40,9 @@
>
>  #include "power.h"
>
> +static bool nozerocheck;
> +module_param(nozerocheck, bool, 0644);
> +
>  #if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_ARCH_HAS_SET_MEM=
ORY)
>  static bool hibernate_restore_protection;
>  static bool hibernate_restore_protection_active;
> @@ -1425,11 +1428,9 @@ static unsigned int count_data_pages(void)
>  }
>
>  /*
> - * This is needed, because copy_page and memcpy are not usable for copyi=
ng
> - * task structs. Returns true if the page was filled with only zeros,
> - * otherwise false.
> + * Returns true if the page was filled with only zeros, otherwise false.
>   */
> -static inline bool do_copy_page(long *dst, long *src)
> +static inline bool do_copy_page_zerocheck(long *dst, long *src)
>  {
>         long z =3D 0;
>         int n;
> @@ -1441,6 +1442,12 @@ static inline bool do_copy_page(long *dst, long *s=
rc)
>         return !z;
>  }
>
> +static inline bool do_copy_page_nozerocheck(long *dst, long *src)
> +{
> +       copy_page(dst, src);
> +       return false;
> +}
> +
>  /**
>   * safe_copy_page - Copy a page in a safe way.
>   *
> @@ -1450,7 +1457,8 @@ static inline bool do_copy_page(long *dst, long *sr=
c)
>   * always returns 'true'. Returns true if the page was entirely composed=
 of
>   * zeros, otherwise it will return false.
>   */
> -static bool safe_copy_page(void *dst, struct page *s_page)
> +static bool safe_copy_page(void *dst, struct page *s_page,
> +                          bool (*do_copy_page)(long *dst, long *src))
>  {
>         bool zeros_only;
>
> @@ -1471,7 +1479,8 @@ static inline struct page *page_is_saveable(struct =
zone *zone, unsigned long pfn
>                 saveable_highmem_page(zone, pfn) : saveable_page(zone, pf=
n);
>  }
>
> -static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
> +static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
> +                          bool (*do_copy_page)(long *dst, long *src))
>  {
>         struct page *s_page, *d_page;
>         void *src, *dst;
> @@ -1491,12 +1500,13 @@ static bool copy_data_page(unsigned long dst_pfn,=
 unsigned long src_pfn)
>                          * The page pointed to by src may contain some ke=
rnel
>                          * data modified by kmap_atomic()
>                          */
> -                       zeros_only =3D safe_copy_page(buffer, s_page);
> +                       zeros_only =3D safe_copy_page(buffer, s_page, do_=
copy_page);
>                         dst =3D kmap_local_page(d_page);
>                         copy_page(dst, buffer);
>                         kunmap_local(dst);
>                 } else {
> -                       zeros_only =3D safe_copy_page(page_address(d_page=
), s_page);
> +                       zeros_only =3D safe_copy_page(page_address(d_page=
),
> +                                                   s_page, do_copy_page)=
;
>                 }
>         }
>         return zeros_only;
> @@ -1504,10 +1514,12 @@ static bool copy_data_page(unsigned long dst_pfn,=
 unsigned long src_pfn)
>  #else
>  #define page_is_saveable(zone, pfn)    saveable_page(zone, pfn)
>
> -static inline int copy_data_page(unsigned long dst_pfn, unsigned long sr=
c_pfn)
> +static inline int
> +copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
> +              bool (*do_copy_page)(long *dst, long *src))
>  {
>         return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
> -                               pfn_to_page(src_pfn));
> +                               pfn_to_page(src_pfn), do_copy_page);
>  }
>  #endif /* CONFIG_HIGHMEM */
>
> @@ -1524,6 +1536,9 @@ static unsigned long copy_data_pages(struct memory_=
bitmap *copy_bm,
>         unsigned long copied_pages =3D 0;
>         struct zone *zone;
>         unsigned long pfn, copy_pfn;
> +       bool (*do_copy_page)(long *dst, long *src);
> +
> +       do_copy_page =3D nozerocheck ? do_copy_page_nozerocheck : do_copy=
_page_zerocheck;
>
>         for_each_populated_zone(zone) {
>                 unsigned long max_zone_pfn;
> @@ -1541,7 +1556,7 @@ static unsigned long copy_data_pages(struct memory_=
bitmap *copy_bm,
>                 pfn =3D memory_bm_next_pfn(orig_bm);
>                 if (unlikely(pfn =3D=3D BM_END_OF_MAP))
>                         break;
> -               if (copy_data_page(copy_pfn, pfn)) {
> +               if (copy_data_page(copy_pfn, pfn, do_copy_page)) {
>                         memory_bm_set_bit(zero_bm, pfn);
>                         /* Use this copy_pfn for a page that is not full =
of zeros */
>                         continue;
>
> --
> 2.53.0
>
