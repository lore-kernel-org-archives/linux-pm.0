Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6425228C
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831943; cv=pass; b=SQUoLnxTGHvFTi/0M1Oa2QWhWE4Dnct/7+cne1b9lBkMo2QXFj3zZfB/CD/oKgu+sSwPdQir6Ei4RX0FLPTr0x84ZCr60Bv1/IutG5M6fXOVXJYJdBhJL8B/DbzAZWWtN1/EEhHKQb8mA+nvIQcfZSbleBKEvAcxMVPi0yuR8OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831943; c=relaxed/simple;
	bh=p4S6xst4Bc9Jb0rzUgQJsg1PJsJd3yHzoDKY6i0dENM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3v/WgXTMKYbRRycY4NsCqy14yGFkh4e4jymmqm52Sadpydo2xRt6iisZSOkKrtKaWx/1RSItodeQ+XTcKSUW85KpkXFUrRK3DjbiPQKZoFF97FmsFdAkCRfIbaVNKDDKiNgRAMVy2sYxUlw+9pM4DiTjdBv/CLvnieH61XYlsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnEj0ZxT; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnEj0ZxT"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-42fbf95cca8so2417418fac.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 11:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777831940; cv=none;
        d=google.com; s=arc-20240605;
        b=PL8P04j7N7j4342SJ061C+/Yl8PXZxSrMaqWPKXNdFyhPJ0BaLIsySyxkSXnvXmwr4
         GIyAMf8yqbuAtcFZWMAjR89wHuje43d+ruTfS54jtThNUDtqoYzttLXMSn2khEe2zfJd
         BEn0rD1ZIJ3KPKWNp20PuPlHxwHPmsT6ZWjCDMZuSiPG5lA+5QNXVTAnu16NawI84jRB
         4KF8AsZI1COnbAOpivVJmeOsB6Q9iyJIpxFTTFDEt8dYmhpchAWGAxyWka4jzjx3seu4
         g0uw4VwQV2mIqSvzjii3+sEoGM+dgfXzr4ztUe+UFlzU0usYG4fDcWhMUWBMTmEh4JpG
         L+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TuHk6gntEIJV0GgLUK1hPsy76HnphKiXZnnnJVyWRVI=;
        fh=dY5l1vsDoZA2ZAHfpL8oYQ/ITW+KpTnAFdNUfZ4BMPA=;
        b=BYW2QNHNT1xt/NVhw5+JHXnBE5kWhieTuhI1DTU9rdyRMVanZ058qflgWNZPyKQpAp
         mCiGEqQvg5VFe/GzashbnJdh/92juSbnrPdPf1H/HQwEA4MSfTxYHz7VcV+5+7uRkSoG
         TXYdaZv502r0W89CnZs8+VmX8DLzQlFHnVhSKbSjfohp1+jFQv0+QUIDamgBgvZ1/5hr
         uF91wLNFZecWRVQO6A5yE9XIOkEBMCiaG/Gubb0s+l1gMHQIINMIXA8UaciSI7Od8MrE
         C6/z4heZRDB5RkmlDBYtvIYKR1cFLK+bnPJ+zrgrb9mp2WjQFrysLmG7welOPlssO9sc
         o3oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777831940; x=1778436740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuHk6gntEIJV0GgLUK1hPsy76HnphKiXZnnnJVyWRVI=;
        b=EnEj0ZxTVq9MujK5El0Glr3hQOq6CeFCccnZBSzAWgjOfLFRFCX+HPwwqvAkCIJc5W
         sWBb4FCNU/4rvMQBUeAX+NFsw3L8GkG3S2A5kAGMEwoXGmtFM8/+K/bqEQTIvYbGDxgs
         TwRLxofLQM/QKHTe4EGAUcVFCOAuLku/bk/hX6YZa6FlqtaMExogtSkfmj5fPqS5f6+K
         gE7cSoPdWh9uDDzyIvCCWJYUres0DJdwTt7fEyoqemTUm2YNH8dzCN//goLiXFjwKKtO
         igoMBFjGVl/bUfEKYXSEyf0/TPaOaxlLNutrQlConvqrRtNGWybH/FjzNZp/SBALPpJ0
         eZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777831940; x=1778436740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuHk6gntEIJV0GgLUK1hPsy76HnphKiXZnnnJVyWRVI=;
        b=kUCu6zXqNnQkfSGMKCj73hj6eJiR3WoLsQN+zY2ON9NKOieJnxDWE2/A1lRkma70X/
         RB2hGVclrYzbg1EONFah+b9EfJfH6QrkwopnmiBOzh1XOqPwqngJx14tOAsKnw1l7SHR
         Ruf4R1NE8Avn9GXL84F8PcqHp+7wEoL7V/9IEhH0TXzebS/jKIGwjTdvXs4zYfztsNfy
         gsrkKuRJT2f1+CyXsZjQNOCRPtwpZmy4p0ihydY/9m048P1xmES185xmOf/E8gIFyS1S
         xVuLxeeg4rMUXw3ALMWLOl9vbCyORBJIPB9LRXQUqwOOS6BcDxnMxuxEyDMhyQ7UdxqV
         5/hA==
X-Forwarded-Encrypted: i=1; AFNElJ/41MpBnYZ6IwrlnZimoC44U2hMOUSu06pKucvBRwx30Ys9kA7N9nrKiRHXzDZ/RVClJL4LjvmjJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5WgCxdvJmvqdk/x0+f8Mj83Ypj7f/yLK6nFxFpbrtlxRFGAn+
	2MwNvKvuuhJlSdUlo2MhDV5wMzGYWNTx1S6qnEzGLFeKZsHppn+3bV/cLTerAS8qGOhPHrCeWym
	lC4pdAPBryriMKgy/awZcpiMEPZ5r7Ks=
X-Gm-Gg: AeBDieuvvSy1f5+ArHECjnZG6WB8B+jL+jwkI1SrwSwdcxNt3of+wkgvfycFj+67TwO
	0I1SU7C1SNAXond9cs3qGNxZmZMY9YGvVL4GDEa06L+pmkZyN2YYrPOYKRkAc1cT1F6qnXFzFY4
	IVrJX6yph6mlXSBlF2dqH+IH/2HNM8rvHt6sywVGK013zkuQIs7bIkBsBwXVWRu6bLisvt+XD9L
	Ibm9M+3OtxAoJGRHLajtc5j5M28d8bObO9bOkAvVUVIkQFrBuxRcVGUPxBBIVtbuSPlMXO5mcgR
	Ae7/A1vWKLHQ4KGyq5NULr4cy382gV8WzaGPvFLCIIxe9uAb
X-Received: by 2002:a05:6870:1b09:b0:42f:b782:104a with SMTP id
 586e51a60fabf-4347622a4aemr3405023fac.21.1777831940496; Sun, 03 May 2026
 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430195651.287659-1-devnexen@gmail.com> <afUih+XwGTHsR0HY@yjaykim-PowerEdge-T330>
 <CAMrLSE71rs1TyoFwCjChY4bEMX-qz01_QKdkAUQmZOSrMMEzbg@mail.gmail.com>
In-Reply-To: <CAMrLSE71rs1TyoFwCjChY4bEMX-qz01_QKdkAUQmZOSrMMEzbg@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 3 May 2026 19:12:06 +0100
X-Gm-Features: AVHnY4Kd5l8lopbbU-EGH9NBZKTL3CyVlD7bO4ZsqqXXa_d7sbYSemBz6lTn6Ns
Message-ID: <CA+XhMqys0rbcJd8ddAMRmUPi=6byXYA0MD5oahgdvPU4PTSFTA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation pin
To: CharSyam <charsyam@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi CharSyam it is literally the same code, I did not look in existing
propositions when running the AI agent ... Sorry !

Kind regards.

On Sun, 3 May 2026 at 18:24, CharSyam <charsyam@gmail.com> wrote:
>
> Hi David, Youngjun,
>
> Thanks for the discussion.
>
> This is essentially the same direction as my v1, where I introduced a
> repin-style helper to transfer the SWP_HIBERNATION pin under a single
> swap_lock critical section.
>
> After Youngjun's review, I reworked it in v2 to avoid adding a new
> single-call-site helper and instead reused the existing
> find/pin/unpin helpers. The current v2 approach keeps the existing
> pin on failure and avoids introducing a new API.
>
> Given that this is more of a hardening improvement than a strict bug
> fix, I think the v2 approach is a simpler fit without adding extra API
> surface.
>
> Happy to adjust if there are specific concerns.
>
> Thanks,
> DaeMyung
>
>
> 2026=EB=85=84 5=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 7:00, =
YoungJun Park <youngjun.park@lge.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Thu, Apr 30, 2026 at 08:56:51PM +0100, David Carlier wrote:
> > > snapshot_set_swap_area() unpins the previously selected swap device
> > > and pins the new one in two separate swap_lock critical sections.
> > > In the gap between them, swapoff() observes SWP_HIBERNATION cleared,
> > > bypasses the guard, and tears down the device, reopening the race
> > > the SWP_HIBERNATION pin was meant to close. The window is reachable
> > > on any SNAPSHOT_SET_SWAP_AREA call after the snapshot device is
> > > opened for hibernation, and on any retry after the resume path's
> > > first selection.
> > >
> > > Add repin_hibernation_swap_type(), which looks up the new device,
> > > clears the old SWP_HIBERNATION flag and sets the new one under a
> > > single swap_lock acquisition. The same-device case is short-
> > > circuited so userspace can re-select the same swap area without
> > > tripping WARN_ON_ONCE and -EBUSY. Switch snapshot_set_swap_area()
> > > to the new helper.
> > >
> > > A failed lookup now preserves the previous pin instead of dropping
> > > it, so a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection
> > > intact. The open and release paths keep using
> > > pin_hibernation_swap_type() and unpin_hibernation_swap_type().
> > >
> > > The race was identified during AI-assisted review of the
> > > SWP_HIBERNATION pinning series.
> > >
> > > Fixes: 8e6e0d845823 ("mm/swap, PM: hibernate: fix swapoff race in usw=
susp by pinning swap device")
> > > Assisted-by: Codex (gpt-5-codex)
> > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > ---
> > >  include/linux/swap.h |  2 ++
> > >  kernel/power/user.c  | 17 ++++--------
> > >  mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 68 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 1930f81e6be4..213ecb627a39 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -436,6 +436,8 @@ static inline long get_nr_swap_pages(void)
> > >  extern void si_swapinfo(struct sysinfo *);
> > >  extern int pin_hibernation_swap_type(dev_t device, sector_t offset);
> > >  extern void unpin_hibernation_swap_type(int type);
> > > +extern int repin_hibernation_swap_type(int old_type, dev_t device,
> > > +                                       sector_t offset);
> > >  extern int find_hibernation_swap_type(dev_t device, sector_t offset)=
;
> > >  int find_first_swap(dev_t *device);
> > >  extern unsigned int count_swap_pages(int, int);
> > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > index d0fcfba7ac23..6e4f40e49319 100644
> > > --- a/kernel/power/user.c
> > > +++ b/kernel/power/user.c
> > > @@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot=
_data *data,
> > >  {
> > >       sector_t offset;
> > >       dev_t swdev;
> > > +     int new_type;
> > >
> > >       if (swsusp_swap_in_use())
> > >               return -EPERM;
> > > @@ -238,19 +239,11 @@ static int snapshot_set_swap_area(struct snapsh=
ot_data *data,
> > >               offset =3D swap_area.offset;
> > >       }
> > >
> > > -     /*
> > > -      * Unpin the swap device if a swap area was already
> > > -      * set by SNAPSHOT_SET_SWAP_AREA.
> > > -      */
> > > -     unpin_hibernation_swap_type(data->swap);
> > > +     new_type =3D repin_hibernation_swap_type(data->swap, swdev, off=
set);
> > > +     if (new_type < 0)
> > > +             return new_type;
> > >
> > > -     /*
> > > -      * User space encodes device types as two-byte values,
> > > -      * so we need to recode them
> > > -      */
> > > -     data->swap =3D pin_hibernation_swap_type(swdev, offset);
> > > -     if (data->swap < 0)
> > > -             return swdev ? -ENODEV : -EINVAL;
> > > +     data->swap =3D new_type;
> > >       data->dev =3D swdev;
> > >       return 0;
> > >  }
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index c7e173b93e11..4840fd40f36f 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -2219,6 +2219,67 @@ int pin_hibernation_swap_type(dev_t device, se=
ctor_t offset)
> > >       return type;
> > >  }
> > >
> > > +/**
> > > + * repin_hibernation_swap_type - Atomically replace the hibernation =
pin
> > > + * @old_type: Swap type currently pinned (or < 0 if none).
> > > + * @device:   Block device of the new resume image.
> > > + * @offset:   Offset identifying the new swap area.
> > > + *
> > > + * Look up the swap device for @device/@offset and atomically transf=
er
> > > + * the SWP_HIBERNATION pin from @old_type (if valid) to the new devi=
ce,
> > > + * all under a single swap_lock critical section. This closes the
> > > + * swapoff() window that exists when callers unpin and re-pin in two
> > > + * separate operations.
> > > + *
> > > + * If the new device cannot be located, the existing pin on @old_typ=
e
> > > + * is preserved and an error is returned. If @old_type already refer=
s
> > > + * to the same swap_info_struct as the new lookup, no flag changes a=
re
> > > + * made and @old_type is returned.
> > > + *
> > > + * Return:
> > > + * >=3D 0 on success (new swap type).
> > > + * -EINVAL if @device is invalid.
> > > + * -ENODEV if the swap device is not found.
> > > + * -EBUSY  if the new device is already pinned by another context.
> > > + */
> > > +int repin_hibernation_swap_type(int old_type, dev_t device, sector_t=
 offset)
> > > +{
> > > +     struct swap_info_struct *old_si, *new_si;
> > > +     int new_type;
> > > +
> > > +     spin_lock(&swap_lock);
> > > +
> > > +     new_type =3D __find_hibernation_swap_type(device, offset);
> > > +     if (new_type < 0) {
> > > +             spin_unlock(&swap_lock);
> > > +             return new_type;
> > > +     }
> > > +
> > > +     new_si =3D swap_type_to_info(new_type);
> > > +     if (WARN_ON_ONCE(!new_si)) {
> > > +             spin_unlock(&swap_lock);
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     old_si =3D swap_type_to_info(old_type);
> > > +     if (new_si =3D=3D old_si) {
> > > +             spin_unlock(&swap_lock);
> > > +             return new_type;
> > > +     }
> > > +
> > > +     if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
> > > +             spin_unlock(&swap_lock);
> > > +             return -EBUSY;
> > > +     }
> > > +
> > > +     if (old_si)
> > > +             old_si->flags &=3D ~SWP_HIBERNATION;
> > > +     new_si->flags |=3D SWP_HIBERNATION;
> > > +
> > > +     spin_unlock(&swap_lock);
> > > +     return new_type;
> > > +}
> > > +
> > >  /**
> > >   * unpin_hibernation_swap_type - Unpin the swap device for hibernati=
on
> > >   * @type: Swap type previously returned by pin_hibernation_swap_type=
()
> > > --
> > > 2.53.0
> >
> > I also caught up on this thread late due to travel.
> > Sorry.
> >
> > Hello David Carlier,
> >
> > It looks like the same issue and approach was raised previously:
> > https://lore.kernel.org/all/20260414143200.1267932-1-charsyam@gmail.com=
/#t
> > (+CC DaeMyung)
> >
> > I had suggested improving the fix by reusing the existing APIs
> > rather than adding a new one. v2 was posted along those lines:
> > https://lore.kernel.org/all/20260414164937.1363887-1-charsyam@gmail.com=
/
> >
> > To restate the points from that earlier review.
> >
> > 1. I think it is acceptable to release the existing pin when the
> >    new set operation fails. there is no significant side effect
> >    (see the earlier review for details).
> >
> > 2. If we still want to fix it, reusing the existing APIs seems
> >    preferable to adding a new one.
> >
> > Chris, Andrew - please take the prior thread into account during review=
.
> >
> > Thanks,
> > Youngjun Park
> >
