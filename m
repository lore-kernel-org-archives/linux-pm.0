Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D935C190
	for <linux-pm@vger.kernel.org>; Sun,  3 May 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829092; cv=pass; b=BOZ7jQAx/HiXE8C/6ZADDyZX4gcbDpQ8O416YYLu2qEaU70y/fP3gHTu+1QXOoHAQ8sZPkvBQGB1HQmHa8+PHghHM/kl+8Pdu1nYYMP4/RXj4mFwc/+c4OZFZSVQn9ldVn1VTtUT7KNu5R8gkc9Y5sEmLikAFU8fL4a/LieJAoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829092; c=relaxed/simple;
	bh=5ba8SQXXIokBSshGu6q0GkevhT5YrZeycKsylTOnLg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUOxDx1UVObLkklvv4YGe9uhBYgoDp2R/laEvLYLMLNrJNaOrHwg135BisOcKAJabAkjuLpntsSOI42zUDBQE+xLw/SMarwYUkol5TJLFv31mUFW5GO04xLIdf3vkymECtx/F/SgtVrGWSTBuy/E7Pcz5zr8wSJmqDkWW0F+N/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbzI4U3/; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbzI4U3/"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6470d549e10so464603d50.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 10:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777829090; cv=none;
        d=google.com; s=arc-20240605;
        b=Zt/sHdXHz1TV0crYB5opABk5x58C7ZzfrQpXlmg3ryz+9wONmbFlGEa5HmZ7dMA3fV
         /xzdLQ/bdQAKKVf4WpOWpdLlK8Y9+ZfPDAuDwrXUEN5J3FrJNP4b1xC8jYpA8uMvxDbR
         73b6hXBMXhEN3Ct8+Jq1Qr8DsqoBUNMhAfZow4p9FqU7yBgBpvMO22Y56l1iUygZIfEc
         a1cvTiN5dYSUygtCqBE4a66JbUvPqBdmPpp6D2oPtrXwlUoq88U70UFhLkkLj4BKHePs
         6eLDA1zsOo/QUtJeQCx2Ykb4yepPIUC58f0MRdXq8dRkUpXpgC6WfDHIQdFWri7Nnn8x
         SqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JY5LSBoQoK2scNI9ks7oXEsa9hffwFwJ1QlfXrt/gD4=;
        fh=DBCIUKdiBO1Kc6ls2l4Q7BtqziMdJ/xAjCuM8OigbeA=;
        b=HEP6nwk/PztVNQpp7RWGEN20RauPJqxLD06ex4w1G9ei2FisNmqYvZ2ylg0RGLv6jw
         3xmlhX7Ek6lgELqtije9YMzwzgNLdbSklIIWELL/VdoWQCXz8GNCWn5B2FJOdKZCBx5f
         c0x9gI8JRcwhVBm2uIArHjETK1m9lUie54AhcZ0DcPyP+sQ2Xu2LUfMTunG/NcCeyG3c
         6j4UQ1qdeph9Hypnb0rgy3S+TZfLRYTjR/NB/iTfA+/fZr/r1TPDqTbdKnfMGGw7HZCH
         1zqrWT+h6i3DumAcB8OfxZj8a1wCa+oUYRxmNladEuYp8t51if9LxQdGCyYSCmRVEIND
         iYVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777829090; x=1778433890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY5LSBoQoK2scNI9ks7oXEsa9hffwFwJ1QlfXrt/gD4=;
        b=sbzI4U3/gyX9l658ya8IpgfsBGXtwuzOc8a/OWC99qjqxe7WZH+TNhAEQW1CnGTkCX
         ZuIiLHA3+9qpTooPoXXeZMxyZ5vMfTFVdyJIW/gVnZ1NHZ9P4pPzUEMVblxb6aYwok36
         enHpv+z/l1mZDsW6hBJTy6VIuZ4hRK1EcZCAPp9TNN8C+FjPJ4w10x8KCrPtrujY1L2b
         PAgCaFuYeT9cGmkqXxirhmMDBZgO0/P6nuRILf1IVm4OVDtaDopB12MTkn4MSdjzQsLC
         1BSKwABjvQWj6wwP2+HXPgXw0bDfYvW4x6GOHI5oJYf8WfkqyxhSRbW/J5vhh6etEfH7
         2J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777829090; x=1778433890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JY5LSBoQoK2scNI9ks7oXEsa9hffwFwJ1QlfXrt/gD4=;
        b=hlmhQq1qNjYuFcm2lLsb9LacHMR0lccPozUt5tt4MolMfCNYMvCU7PMJZxm/HmlxsZ
         02nKsl79C9MDktco5szVAhLQlJSgvr8Lb6hKZUzj8N0xjGY2v86wGoksvbYa2SjzuHPp
         BEt9NRl7nkUzt+Nfny62/qfd35oo8H7nJBBWvg003ppFi4cD4yfDktnBHkWIwjr4VTz4
         6+KKkBWW9kfq2PcGcHlhRFrehh7IvJHbwi+/zHD5aLkw83uf5ijxdBaat1NDcxqC0wmg
         cG1YXPT7OCtgHK0g3FvQoZFCZnIxgnWjrpbu2Kv3riS+agUZxd4jM0ng1obzSDh6zXk0
         q7NA==
X-Forwarded-Encrypted: i=1; AFNElJ+fpMqFafLQQBqwssLQYI7uIflhSJtgK1xYqzG4QPuPyJwrONM8EwdLJlToulzXbb1Msh3IFnwrEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPsM/NtFX/pBqCKpdeP0CSTaBmxjQQwqDIadnp0vS4I8Qz9gm
	GOnH4+/P8v4Iz1RweC4qbV6lD2xVq3GijJ/jEWI0amr7m7JN6Tybo0zKmREIAqrERfceJKOWOTC
	SOIwshUj+QL8V2e/DRb6xFexXJZMfEL4=
X-Gm-Gg: AeBDieuE5ttJJFLPpgDrunSHhWGteTC+vlTlKddZpG6VLsLGgqohhyRxMOAKeQxTp87
	DhLAJbgnwfj1VkBr+ePGDvu6v2KXvjaSjCDIp53siQ9zk+rNWHdThPlCWvcyETOVWjDp97TGSr3
	qB3MXmW6puRMa4hPB8HrG9n07veqnt/Qy4juHn93Bh9uhVor+2hu8DKddu+GKP2xvO0UctmN5dK
	V5VRO5cCu+BPAvFjccHcG9sM7TBDiMbDlldpV0TN5HTkFDipp+kbGXMG5UExWodteVSQstErqaL
	DLf5cRRJoXxtW3+EkDw=
X-Received: by 2002:a05:690e:1509:b0:653:9e2:1059 with SMTP id
 956f58d0204a3-65c3d885405mr3910018d50.0.1777829089678; Sun, 03 May 2026
 10:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430195651.287659-1-devnexen@gmail.com> <afUih+XwGTHsR0HY@yjaykim-PowerEdge-T330>
In-Reply-To: <afUih+XwGTHsR0HY@yjaykim-PowerEdge-T330>
From: CharSyam <charsyam@gmail.com>
Date: Mon, 4 May 2026 02:24:38 +0900
X-Gm-Features: AVHnY4LrEw5_6VQukKkSO0GARd7hylbgWbog9Ju3xEhrnLElgO_VmcGdg9-i61s
Message-ID: <CAMrLSE71rs1TyoFwCjChY4bEMX-qz01_QKdkAUQmZOSrMMEzbg@mail.gmail.com>
Subject: Re: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation pin
To: YoungJun Park <youngjun.park@lge.com>
Cc: David Carlier <devnexen@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David, Youngjun,

Thanks for the discussion.

This is essentially the same direction as my v1, where I introduced a
repin-style helper to transfer the SWP_HIBERNATION pin under a single
swap_lock critical section.

After Youngjun's review, I reworked it in v2 to avoid adding a new
single-call-site helper and instead reused the existing
find/pin/unpin helpers. The current v2 approach keeps the existing
pin on failure and avoids introducing a new API.

Given that this is more of a hardening improvement than a strict bug
fix, I think the v2 approach is a simpler fit without adding extra API
surface.

Happy to adjust if there are specific concerns.

Thanks,
DaeMyung


2026=EB=85=84 5=EC=9B=94 2=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 7:00, Yo=
ungJun Park <youngjun.park@lge.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Apr 30, 2026 at 08:56:51PM +0100, David Carlier wrote:
> > snapshot_set_swap_area() unpins the previously selected swap device
> > and pins the new one in two separate swap_lock critical sections.
> > In the gap between them, swapoff() observes SWP_HIBERNATION cleared,
> > bypasses the guard, and tears down the device, reopening the race
> > the SWP_HIBERNATION pin was meant to close. The window is reachable
> > on any SNAPSHOT_SET_SWAP_AREA call after the snapshot device is
> > opened for hibernation, and on any retry after the resume path's
> > first selection.
> >
> > Add repin_hibernation_swap_type(), which looks up the new device,
> > clears the old SWP_HIBERNATION flag and sets the new one under a
> > single swap_lock acquisition. The same-device case is short-
> > circuited so userspace can re-select the same swap area without
> > tripping WARN_ON_ONCE and -EBUSY. Switch snapshot_set_swap_area()
> > to the new helper.
> >
> > A failed lookup now preserves the previous pin instead of dropping
> > it, so a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection
> > intact. The open and release paths keep using
> > pin_hibernation_swap_type() and unpin_hibernation_swap_type().
> >
> > The race was identified during AI-assisted review of the
> > SWP_HIBERNATION pinning series.
> >
> > Fixes: 8e6e0d845823 ("mm/swap, PM: hibernate: fix swapoff race in uswsu=
sp by pinning swap device")
> > Assisted-by: Codex (gpt-5-codex)
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  include/linux/swap.h |  2 ++
> >  kernel/power/user.c  | 17 ++++--------
> >  mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 68 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 1930f81e6be4..213ecb627a39 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -436,6 +436,8 @@ static inline long get_nr_swap_pages(void)
> >  extern void si_swapinfo(struct sysinfo *);
> >  extern int pin_hibernation_swap_type(dev_t device, sector_t offset);
> >  extern void unpin_hibernation_swap_type(int type);
> > +extern int repin_hibernation_swap_type(int old_type, dev_t device,
> > +                                       sector_t offset);
> >  extern int find_hibernation_swap_type(dev_t device, sector_t offset);
> >  int find_first_swap(dev_t *device);
> >  extern unsigned int count_swap_pages(int, int);
> > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > index d0fcfba7ac23..6e4f40e49319 100644
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot_d=
ata *data,
> >  {
> >       sector_t offset;
> >       dev_t swdev;
> > +     int new_type;
> >
> >       if (swsusp_swap_in_use())
> >               return -EPERM;
> > @@ -238,19 +239,11 @@ static int snapshot_set_swap_area(struct snapshot=
_data *data,
> >               offset =3D swap_area.offset;
> >       }
> >
> > -     /*
> > -      * Unpin the swap device if a swap area was already
> > -      * set by SNAPSHOT_SET_SWAP_AREA.
> > -      */
> > -     unpin_hibernation_swap_type(data->swap);
> > +     new_type =3D repin_hibernation_swap_type(data->swap, swdev, offse=
t);
> > +     if (new_type < 0)
> > +             return new_type;
> >
> > -     /*
> > -      * User space encodes device types as two-byte values,
> > -      * so we need to recode them
> > -      */
> > -     data->swap =3D pin_hibernation_swap_type(swdev, offset);
> > -     if (data->swap < 0)
> > -             return swdev ? -ENODEV : -EINVAL;
> > +     data->swap =3D new_type;
> >       data->dev =3D swdev;
> >       return 0;
> >  }
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index c7e173b93e11..4840fd40f36f 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2219,6 +2219,67 @@ int pin_hibernation_swap_type(dev_t device, sect=
or_t offset)
> >       return type;
> >  }
> >
> > +/**
> > + * repin_hibernation_swap_type - Atomically replace the hibernation pi=
n
> > + * @old_type: Swap type currently pinned (or < 0 if none).
> > + * @device:   Block device of the new resume image.
> > + * @offset:   Offset identifying the new swap area.
> > + *
> > + * Look up the swap device for @device/@offset and atomically transfer
> > + * the SWP_HIBERNATION pin from @old_type (if valid) to the new device=
,
> > + * all under a single swap_lock critical section. This closes the
> > + * swapoff() window that exists when callers unpin and re-pin in two
> > + * separate operations.
> > + *
> > + * If the new device cannot be located, the existing pin on @old_type
> > + * is preserved and an error is returned. If @old_type already refers
> > + * to the same swap_info_struct as the new lookup, no flag changes are
> > + * made and @old_type is returned.
> > + *
> > + * Return:
> > + * >=3D 0 on success (new swap type).
> > + * -EINVAL if @device is invalid.
> > + * -ENODEV if the swap device is not found.
> > + * -EBUSY  if the new device is already pinned by another context.
> > + */
> > +int repin_hibernation_swap_type(int old_type, dev_t device, sector_t o=
ffset)
> > +{
> > +     struct swap_info_struct *old_si, *new_si;
> > +     int new_type;
> > +
> > +     spin_lock(&swap_lock);
> > +
> > +     new_type =3D __find_hibernation_swap_type(device, offset);
> > +     if (new_type < 0) {
> > +             spin_unlock(&swap_lock);
> > +             return new_type;
> > +     }
> > +
> > +     new_si =3D swap_type_to_info(new_type);
> > +     if (WARN_ON_ONCE(!new_si)) {
> > +             spin_unlock(&swap_lock);
> > +             return -ENODEV;
> > +     }
> > +
> > +     old_si =3D swap_type_to_info(old_type);
> > +     if (new_si =3D=3D old_si) {
> > +             spin_unlock(&swap_lock);
> > +             return new_type;
> > +     }
> > +
> > +     if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
> > +             spin_unlock(&swap_lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     if (old_si)
> > +             old_si->flags &=3D ~SWP_HIBERNATION;
> > +     new_si->flags |=3D SWP_HIBERNATION;
> > +
> > +     spin_unlock(&swap_lock);
> > +     return new_type;
> > +}
> > +
> >  /**
> >   * unpin_hibernation_swap_type - Unpin the swap device for hibernation
> >   * @type: Swap type previously returned by pin_hibernation_swap_type()
> > --
> > 2.53.0
>
> I also caught up on this thread late due to travel.
> Sorry.
>
> Hello David Carlier,
>
> It looks like the same issue and approach was raised previously:
> https://lore.kernel.org/all/20260414143200.1267932-1-charsyam@gmail.com/#=
t
> (+CC DaeMyung)
>
> I had suggested improving the fix by reusing the existing APIs
> rather than adding a new one. v2 was posted along those lines:
> https://lore.kernel.org/all/20260414164937.1363887-1-charsyam@gmail.com/
>
> To restate the points from that earlier review.
>
> 1. I think it is acceptable to release the existing pin when the
>    new set operation fails. there is no significant side effect
>    (see the earlier review for details).
>
> 2. If we still want to fix it, reusing the existing APIs seems
>    preferable to adding a new one.
>
> Chris, Andrew - please take the prior thread into account during review.
>
> Thanks,
> Youngjun Park
>
