Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF413321AA;
	Mon,  1 Jun 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780354366; cv=pass; b=bZF02pAr0fWhMPexdhtPpctjp5tKLD8SwDw9N/X/ht5A4FPAMoJJTJ9qD4CLhJ+V8mRc4C8QEF3FkjZSxXQ/yNYeY8YGXZyZrYcobSGw5/LKmA5cTFsePRSR9rY+4HpJqhWyHQU61LUeLNfIMsDkp0wi4UKhyUhh5e3/RQM8zzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780354366; c=relaxed/simple;
	bh=N8oiakBE5TQSwTjLBYqmGuaqRwSKixUDp84qM53iclU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qx0p4Z37u3kVzt57vcOiVRi9x8Si9FDMmupziN441CJBdwJzORaUiAFREWGJmUR2fy7qiSh1RzVrg/A2XqNgIQCruO51agmSzrJUMRz0wZZQesqC4eJ/D5LY1jj6zcDSo7NTU2C0KlkUNaRK4oIn889V5L0eL9syDRnBeUVUlyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=VXv5kbC+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="VXv5kbC+"
ARC-Seal: i=1; a=rsa-sha256; t=1780354353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H1y9uQtBteR5JbneUgc8EZEONx3r8fYoa7l7onuPAAgifsAhQT6cyCw2/cGxoogw+q9pmHayWe8ETWYyJOCLwZ9RVk5wUgo/WGgTq7z79JqvJ6eyeW4S1PUq0sWpEOeESig3dwGb//XdVAkCV4WgnGZ/ToLXVsYDe0t/odSiio4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780354353; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N8oiakBE5TQSwTjLBYqmGuaqRwSKixUDp84qM53iclU=; 
	b=LX+uhI3iOKBa02MFRuf3f8VU3n1M6ra0aEjaHzL9fQf/81is/oAPueIQgdxYUfcY9yKuy/ZgS1uKcup3ja8+4vbrIhVnQLJaZ5C/7qKJWnW+rOrm74XMdhvZwTq6otLTPDpw77em0mNwBMsU7ETpIxNeV9ZVd+D0gTC1iB5zXto=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780354353;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=N8oiakBE5TQSwTjLBYqmGuaqRwSKixUDp84qM53iclU=;
	b=VXv5kbC+MKZwE6oICnksNSanyv/bO18IAsoqmFwroX/3XeBF7iAXf7/GurKZRMqF
	nJTG9x4X3gwnHx9ArOX9cTJ55kFzzIVoDg5wWhg1ElDZsqLf5fdngwusVPEYTkuwiFd
	aD4XfEor9U/Fj1j7LPj2+IAFEk9DIpXra9WNJ70A=
Received: by mx.zohomail.com with SMTPS id 1780354351038792.5227726591933;
	Mon, 1 Jun 2026 15:52:31 -0700 (PDT)
Message-ID: <c4176f8a63cd537a1ced7325079f5e7da30fb7fe.camel@collabora.com>
Subject: Re: [PATCH 3/3] PM: hibernate: Allow disabling zero page check in
 copy_data_pages()
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Brian
 Geffon	 <bgeffon@google.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 18:52:29 -0400
In-Reply-To: <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com>
References: 
	<20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
	 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
	 <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2026-05-26 at 13:53 +0200, Rafael J. Wysocki wrote:
> On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >=20
> > The current implementation of copy_data_pages() has at its center
> > do_copy_page(), which copies data of all saveable pages in a loop
> > one
> > long at a time, while checking whether the page is fully zero to
> > allow
> > it to not be saved in the hibernation image.
> >=20
> > As the comment above do_copy_page() mentions, this loop was used
> > instead
> > of the more optimized copy_page() and memcpy() due to them
> > depending on
> > fpu_begin()/fpu_end() (see [1] and commit 95018f7c94cb ("[PATCH]
> > swsusp:
> > do not use memcpy for snapshotting memory")). However, since commit
> > c6dbd3e5e69c ("x86/mmx_32: Remove X86_USE_3DNOW"), this limitation
> > no
> > longer holds, and it only affected x86-32 in the first place.
> >=20
> > From testing it is clear that removing the zero page check and
> > using
> > copy_page() makes it almost 3 times quicker:
> > - Current:
> > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 4940240 kbytes in 11.33 seco=
nds (436.03
> > MB/s)
> > - With just the zero check removed:
> > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 4974664 kbytes in 9.03 secon=
ds (550.90
> > MB/s)
> > - With the zero check removed and using copy_page() instead:
> > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 6275216 kbytes in 3.96 secon=
ds (1584.65
> > MB/s)
> >=20
> > Given that copy_data_pages() runs inside a critical section where
> > only
> > a single CPU is online and syscore is suspended, it should be kept
> > as
> > short as possible to keep the system responsive.
>=20
> I'm not sure if being responsive during hibernation is all that
> important.
>=20
> Also, the change is about using copy_page() to reduce the time spent
> in syscore_suspend(), so the subject is a bit confusing.
>=20
> > While switching from the loop to copy_page() brings big speed
> > improvements, it also makes the zero page check much costlier since
> > it
> > can no longer be done in the middle of the copy. In fact upon
> > testing
> > adding the zero check alongside copy_page() made it slower than the
> > current code.
>=20
> Guess what, CPUs have caches.
>=20
> > The following shows a rough comparison of a few more metrics
> > between the
> > current code and when both copy_page() is used and the zero page
> > check
> > is disabled:
> > - Total time to hibernate:
> > =C2=A0 - before: 13.77s
> > =C2=A0 - after: 14.13s
>=20
> Score for the current code.
>=20
> > - Total time to resume:
> > =C2=A0 - before: 5.85s
> > =C2=A0 - after: 5.85s
> > - Total time in syscore_suspend():
> > =C2=A0 - before: 11.3s
> > =C2=A0 - after: 4.08s
>=20
> Why does this matter?

Reducing the time spent here means reduced time between
pm_wakeup_pending() checks, which ultimately means the kernel is
quicker to abort hibernation in reaction to a pending wakeup.

Thanks,
N=C3=ADcolas

>=20
> > - Total image size written to disk:
> > =C2=A0 - before: 4956296kB =3D> 2606402kB compressed =3D 2.60MB
> > =C2=A0 - after: 6274608 =3D> 2616624kB compressed =3D 2.61MB
>=20
> "kB" seems to be missing in the bottom row.
>=20
> Which means that this is a score for the current code again because
> it
> needs to copy and compress fewer pages which means that less energy
> needs to be used (which may be kind of relevant in low-battery
> situations).
>=20
> > As can be seen the total time to hibernate is roughly the same,
> > suggesting that the time saved with the more efficient copy_page()
> > is
> > payed by having to compress more data (the zero pages). The time to
> > resume remains the same. And the hibernation image size is
> > basically the
> > same, as the zero pages compress well (the case would be quite
> > different
> > if compression is disabled). The big win here is that the time
> > between
> > syscore_suspend() and syscore_resume() is much lower, meaning the
> > system
> > will be more responsive throughout hibernation.
> >=20
> > Expose a 'nozerocheck' module parameter
>=20
> I'd rather not.
>=20
> Either the switch-over is compelling enough to do it unconditionally,
> or it is not, in which case the existing code can be used just fine.
>=20
> As it stands, I'm not convinced.
>=20
> > to allow the zero page check to
> > be disabled and the faster copy_page() to be used, giving the
> > option for
> > userspace to choose between a more responsive system and reducing
> > the
> > disk usage particularly when compression is disabled.
> >=20
> > Testing was done on the SteamDeck OLED.
> >=20
> > [1]
> > https://lore.kernel.org/all/1096877559.9064.45.camel@desktop.cunningham=
s/
> >=20
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > =C2=A0kernel/power/snapshot.c | 37 ++++++++++++++++++++++++++----------=
-
> > =C2=A01 file changed, 26 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 4f452baf31dc..00feac18faae 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -40,6 +40,9 @@
> >=20
> > =C2=A0#include "power.h"
> >=20
> > +static bool nozerocheck;
> > +module_param(nozerocheck, bool, 0644);
> > +
> > =C2=A0#if defined(CONFIG_STRICT_KERNEL_RWX) &&
> > defined(CONFIG_ARCH_HAS_SET_MEMORY)
> > =C2=A0static bool hibernate_restore_protection;
> > =C2=A0static bool hibernate_restore_protection_active;
> > @@ -1425,11 +1428,9 @@ static unsigned int count_data_pages(void)
> > =C2=A0}
> >=20
> > =C2=A0/*
> > - * This is needed, because copy_page and memcpy are not usable for
> > copying
> > - * task structs. Returns true if the page was filled with only
> > zeros,
> > - * otherwise false.
> > + * Returns true if the page was filled with only zeros, otherwise
> > false.
> > =C2=A0 */
> > -static inline bool do_copy_page(long *dst, long *src)
> > +static inline bool do_copy_page_zerocheck(long *dst, long *src)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long z =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int n;
> > @@ -1441,6 +1442,12 @@ static inline bool do_copy_page(long *dst,
> > long *src)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !z;
> > =C2=A0}
> >=20
> > +static inline bool do_copy_page_nozerocheck(long *dst, long *src)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_page(dst, src);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * safe_copy_page - Copy a page in a safe way.
> > =C2=A0 *
> > @@ -1450,7 +1457,8 @@ static inline bool do_copy_page(long *dst,
> > long *src)
> > =C2=A0 * always returns 'true'. Returns true if the page was entirely
> > composed of
> > =C2=A0 * zeros, otherwise it will return false.
> > =C2=A0 */
> > -static bool safe_copy_page(void *dst, struct page *s_page)
> > +static bool safe_copy_page(void *dst, struct page *s_page,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bool (*do_copy_page)(long *dst, long
> > *src))
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool zeros_only;
> >=20
> > @@ -1471,7 +1479,8 @@ static inline struct page
> > *page_is_saveable(struct zone *zone, unsigned long pfn
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 saveable_highmem_page(zone, pfn) :
> > saveable_page(zone, pfn);
> > =C2=A0}
> >=20
> > -static bool copy_data_page(unsigned long dst_pfn, unsigned long
> > src_pfn)
> > +static bool copy_data_page(unsigned long dst_pfn, unsigned long
> > src_pfn,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bool (*do_copy_page)(long *dst, long
> > *src))
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *s_page, *d_page=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *src, *dst;
> > @@ -1491,12 +1500,13 @@ static bool copy_data_page(unsigned long
> > dst_pfn, unsigned long src_pfn)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * The page pointed to by src may contain
> > some kernel
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * data modified by kmap_atomic()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zeros_only =
=3D safe_copy_page(buffer,
> > s_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zeros_only =
=3D safe_copy_page(buffer, s_page,
> > do_copy_page);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst =
=3D kmap_local_page(d_page);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_=
page(dst, buffer);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunma=
p_local(dst);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zeros_only =
=3D
> > safe_copy_page(page_address(d_page), s_page);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zeros_only =
=3D
> > safe_copy_page(page_address(d_page),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s_page,
> > do_copy_page);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return zeros_only;
> > @@ -1504,10 +1514,12 @@ static bool copy_data_page(unsigned long
> > dst_pfn, unsigned long src_pfn)
> > =C2=A0#else
> > =C2=A0#define page_is_saveable(zone, pfn)=C2=A0=C2=A0=C2=A0 saveable_pa=
ge(zone, pfn)
> >=20
> > -static inline int copy_data_page(unsigned long dst_pfn, unsigned
> > long src_pfn)
> > +static inline int
> > +copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bool (*do_copy_page)(long *dst, long *src))
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return safe_copy_page(page_a=
ddress(pfn_to_page(dst_pfn)),
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pfn_to_page(src_pfn));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pfn_to_page(src_pfn),
> > do_copy_page);
> > =C2=A0}
> > =C2=A0#endif /* CONFIG_HIGHMEM */
> >=20
> > @@ -1524,6 +1536,9 @@ static unsigned long copy_data_pages(struct
> > memory_bitmap *copy_bm,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long copied_pages =
=3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct zone *zone;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long pfn, copy_pfn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*do_copy_page)(long *dst, l=
ong *src);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_copy_page =3D nozerocheck ? do=
_copy_page_nozerocheck :
> > do_copy_page_zerocheck;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_populated_zone(zone=
) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsigned long max_zone_pfn;
> > @@ -1541,7 +1556,7 @@ static unsigned long copy_data_pages(struct
> > memory_bitmap *copy_bm,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pfn =3D memory_bm_next_pfn(orig_bm);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (unlikely(pfn =3D=3D BM_END_OF_MAP))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (copy_data_page(copy_pfn, pfn)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (copy_data_page(copy_pfn, pfn, do_copy_page)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memor=
y_bm_set_bit(zero_bm, pfn);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Us=
e this copy_pfn for a page that is not
> > full of zeros */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> >=20
> > --
> > 2.53.0
> >=20
