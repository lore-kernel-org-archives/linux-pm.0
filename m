Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14E192B75;
	Thu,  4 Jun 2026 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535112; cv=pass; b=XXNbUyPSajODtRgY5qEnryYpSC3IzjHwlqKfH5MkkD4zXYsGiqh+IVeMW+BiRTx0f8XfIA2GRVhc4XbQzcm/4vmmq3F8dQk6DD2b5ifElSqWqIcD2f5s7qibOseh6s+T2EcIDPbGaZIouZcaOXjjPi/VFC/aA4jt3pj2p7qO9/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535112; c=relaxed/simple;
	bh=lKa+RtutWmljXsD0Ee84wr6eBHGct7VV6vBqziJ5e94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obg4V1mCjMgBqeeuVC3T53wP4LuWQyxrd4/b9MoiQeN6KML7sSRWqif6jE+e0Ce/01KK80e/EKaVxWQjd4WDN/19Dy69mGPpb+JV4/SBBmMiAtjVnlf0GIdyLcliDmURo3Bxk+S/oozV2TXafe0nA8sIK2p/8b5V57Wpo7wDnDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=kllZyIXG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="kllZyIXG"
ARC-Seal: i=1; a=rsa-sha256; t=1780535098; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nIvTQibm1LOG3T1r9HUnFGOW+pw99ciEWQ+eMqTxFPCzxmApxULfjIL4c1iKpMtjutLv0xegYhauZ3iYdX/QCDXtR3gocJ6c3flDoVPRUZEfX+TagaTH8uaqdC3KoLA39ipVQD58+Jn80UBlR4yWzHVCWnjNMxIlSAerULpoDkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780535098; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lKa+RtutWmljXsD0Ee84wr6eBHGct7VV6vBqziJ5e94=; 
	b=irzfAA7HBYTzgGXadke4wCQrOqHZ2kfOTl0a7z1NuTkxwR871ihccwl88M65DzDNUd3mAbmw6IWZXmgGY/IniJaf/1HqhYF3bIi7ATI+pNZ/Py12uieb5qM8iFesEXeohwKnGUx2+NIxQmkia1rtaVCUqbIxSyiCgjsIZIloKG8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780535098;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=lKa+RtutWmljXsD0Ee84wr6eBHGct7VV6vBqziJ5e94=;
	b=kllZyIXG8ZpdR+zbW+e5KS2Diosb55gD5OVYc+wRUuBKoeBS6goZtPJqQck5DLQt
	/W25IYy/HVnwi+zacVmrNbnuvevCkr716c2nwKszpXPB+8YEAvupaqMFT2QuyrbyzlE
	KcKWHnyD/j9OZTX4MNEly++WTshMJMkDSxJbV8Lg=
Received: by mx.zohomail.com with SMTPS id 1780535095790481.16791850006507;
	Wed, 3 Jun 2026 18:04:55 -0700 (PDT)
Message-ID: <a32ed33592cb3acd426dc69f819f64e443f4ea54.camel@collabora.com>
Subject: Re: [PATCH 3/3] PM: hibernate: Allow disabling zero page check in
 copy_data_pages()
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Brian
 Geffon	 <bgeffon@google.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 21:04:54 -0400
In-Reply-To: <CAJZ5v0hMKKAuM0LxaTubjMLO1_XUs7V-o6FfYYF6cD=prKZOXA@mail.gmail.com>
References: 
	<20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
	 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
	 <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com>
	 <c4176f8a63cd537a1ced7325079f5e7da30fb7fe.camel@collabora.com>
	 <CAJZ5v0hMKKAuM0LxaTubjMLO1_XUs7V-o6FfYYF6cD=prKZOXA@mail.gmail.com>
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

On Tue, 2026-06-02 at 10:04 +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 2, 2026 at 12:52=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >=20
> > On Tue, 2026-05-26 at 13:53 +0200, Rafael J. Wysocki wrote:
> > > On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >=20
> > > > The current implementation of copy_data_pages() has at its
> > > > center
> > > > do_copy_page(), which copies data of all saveable pages in a
> > > > loop
> > > > one
> > > > long at a time, while checking whether the page is fully zero
> > > > to
> > > > allow
> > > > it to not be saved in the hibernation image.
> > > >=20
> > > > As the comment above do_copy_page() mentions, this loop was
> > > > used
> > > > instead
> > > > of the more optimized copy_page() and memcpy() due to them
> > > > depending on
> > > > fpu_begin()/fpu_end() (see [1] and commit 95018f7c94cb
> > > > ("[PATCH]
> > > > swsusp:
> > > > do not use memcpy for snapshotting memory")). However, since
> > > > commit
> > > > c6dbd3e5e69c ("x86/mmx_32: Remove X86_USE_3DNOW"), this
> > > > limitation
> > > > no
> > > > longer holds, and it only affected x86-32 in the first place.
> > > >=20
> > > > From testing it is clear that removing the zero page check and
> > > > using
> > > > copy_page() makes it almost 3 times quicker:
> > > > - Current:
> > > > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 4940240 kbytes in 11.33 =
seconds
> > > > (436.03
> > > > MB/s)
> > > > - With just the zero check removed:
> > > > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 4974664 kbytes in 9.03 s=
econds
> > > > (550.90
> > > > MB/s)
> > > > - With the zero check removed and using copy_page() instead:
> > > > =C2=A0=C2=A0=C2=A0 PM: hibernation: Copied 6275216 kbytes in 3.96 s=
econds
> > > > (1584.65
> > > > MB/s)
> > > >=20
> > > > Given that copy_data_pages() runs inside a critical section
> > > > where
> > > > only
> > > > a single CPU is online and syscore is suspended, it should be
> > > > kept
> > > > as
> > > > short as possible to keep the system responsive.
> > >=20
> > > I'm not sure if being responsive during hibernation is all that
> > > important.
> > >=20
> > > Also, the change is about using copy_page() to reduce the time
> > > spent
> > > in syscore_suspend(), so the subject is a bit confusing.
> > >=20
> > > > While switching from the loop to copy_page() brings big speed
> > > > improvements, it also makes the zero page check much costlier
> > > > since
> > > > it
> > > > can no longer be done in the middle of the copy. In fact upon
> > > > testing
> > > > adding the zero check alongside copy_page() made it slower than
> > > > the
> > > > current code.
> > >=20
> > > Guess what, CPUs have caches.
> > >=20
> > > > The following shows a rough comparison of a few more metrics
> > > > between the
> > > > current code and when both copy_page() is used and the zero
> > > > page
> > > > check
> > > > is disabled:
> > > > - Total time to hibernate:
> > > > =C2=A0 - before: 13.77s
> > > > =C2=A0 - after: 14.13s
> > >=20
> > > Score for the current code.
> > >=20
> > > > - Total time to resume:
> > > > =C2=A0 - before: 5.85s
> > > > =C2=A0 - after: 5.85s
> > > > - Total time in syscore_suspend():
> > > > =C2=A0 - before: 11.3s
> > > > =C2=A0 - after: 4.08s
> > >=20
> > > Why does this matter?
> >=20
> > Reducing the time spent here means reduced time between
> > pm_wakeup_pending() checks, which ultimately means the kernel is
> > quicker to abort hibernation in reaction to a pending wakeup.
>=20
> That could be spelled out more directly in the patch changelog.
>=20
> I'm still unsure why it matters though.=C2=A0 Hibernation is slow pretty
> much by definition, so why would anyone expect a fast response to a
> wakeup event during hibernation?=C2=A0 If they have latency constraints,
> shouldn't they use suspend instead?

We can't just rely on suspend because battery life also matters.

Indeed hibernation is slow, but if it can be made faster, or at least
quicker to respond to wakeup events, then why not?

--=20
Thanks,

N=C3=ADcolas
