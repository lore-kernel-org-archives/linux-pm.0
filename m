Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC136B05C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308879; cv=none; b=pT+PK2wMKiKeEG9GCigKbggMoYF8o+1HnjBX/N4YtSbyIDkxgMkCWyKePhkZFOH/PgMc4j8jA81igIAsG0h/ChjQTEoTCit4liJZ5TbgFONxGngad5Px9uDnU3DPnCIf0j+Ce9MTrhq6vvCnzpfZwAQ/47ocEHa6G9rx7gI7Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308879; c=relaxed/simple;
	bh=gi6UtRTlbuAi9RQucnX6uaeP86tJKgsxLBI7G7zOkRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otGv5fUyxdD99E0/Qmn5BVzmvjnPQqYqnZ/USCaT7i6RhQqbamAhk2BamxiAOmTs+N1Zr9UAtRpHuYiDmFr5wKohDrk1VAVSN+7bdVkOCwWYes9vulzryPQSau4rOi6IUpfS1u+FCpO4kqNBHBZ31ct9Q93EUZSlGLcyJTYwrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqYiho87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqYiho87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FA31F00A39
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308877;
	bh=OUx6n8rVxotdniCFeqmbw7mrguld1SfwzgI1DlFukoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bqYiho87UcFjTl3Rxpb3jN/i8Ttt1pS7uH5HrKM3xAB8zrXKKfN3tekltTT+IdFEN
	 Z+RMsbdieSsi2nuNad4glFkt7Wvgk/YZRMYsDLSxPs9JzIokmQHuneeZeTaj23IBSE
	 Gbd6zducFM1Di+AUTXRHVxttZECNgy2yR3WfnOuvbNUP/0NwWFy+oUk5Mw9+hdvDfo
	 rU+KhxOEmx4gCN8tOyTedj4CIOYlyAR8VonXQBnQ6/t6j8kiDFdDUapZYsSCqjWAei
	 nwo1LRTTCRZ1sDGbT4lpifZW94ZOpo4OcWaS9eDXjitizq2/j2+so1WKAQo8NGXTyP
	 WdSfRSEkxgZfA==
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-57512a429d1so4459226e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 13:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/MyU2pQ0iSxdjzrpSBBxrOwoEgrIWPtPSgcP9ObC1wlwaE61+Ite8bfgOkJCQMZ5rWtEkw3JUNgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvvr+DS+pW/5bntqIUa5ZMZHs0dubOyCGwSs1cJxgVBZph5B5M
	ZoBPYZe/fTV6Wvy4rYO76MO236h4zaFxV8hYplw/u9IIqXZflqUGxdByJEwUPeEnNoatwMgaVZ8
	T0ABdtn+10rgo+66o/xikdrj3XcuBKdc=
X-Received: by 2002:a05:6122:e44b:b0:575:e5d7:6f1c with SMTP id
 71dfb90a1353d-5760be3bc83mr15943086e0c.1.1779308877026; Wed, 20 May 2026
 13:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
 <CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
 <87mrz78brw.fsf@collabora.com> <877bp0q1ob.fsf@collabora.com> <CAJZ5v0j_ox4Qe9_LBk+SHLKzo0NG+bjKH7DL7fG-zmGL=KRGYg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j_ox4Qe9_LBk+SHLKzo0NG+bjKH7DL7fG-zmGL=KRGYg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 22:27:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvrmEbEqitFVvVft7Y_EGGLTMyygmJBVysGCMTPyj3Sw@mail.gmail.com>
X-Gm-Features: AVHnY4KcVtDrTWAttvsszEklGll2M9_ELUwKfvEMA6c18zBw8MhsrS9SsHaQLoE
Message-ID: <CAJZ5v0hvrmEbEqitFVvVft7Y_EGGLTMyygmJBVysGCMTPyj3Sw@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: call preallocate_image after freeze prepare
To: Matthew Leach <matthew.leach@collabora.com>
Cc: Pavel Machek <pavel@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, May 18, 2026 at 3:37=E2=80=AFPM Matthew Leach
> <matthew.leach@collabora.com> wrote:
> >
> > Hi Rafael,
> >
> > Matthew Leach <matthew.leach@collabora.com> writes:
> >
> > > Hi Rafael,
> > >
> > > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> > >
> > >> On Fri, Apr 3, 2026 at 9:36=E2=80=AFAM Matthew Leach
> > >> <matthew.leach@collabora.com> wrote:
> > >>>
> > >
> > > [...]
> > >
> > >> Can you please have a look at
> > >>
> > >> https://sashiko.dev/#/patchset/20260403-hibernation-fixes-v3-1-31bc9=
fa3ba2d%40collabora.com
> > >
> > > [pasting comment in-line here for comment]
> > >
> > >
> > >> Does this relocation introduce a deadlock during memory reclaim?
> > >>
> > >> hibernate_preallocate_memory() allocates a large amount of memory an=
d
> > >> triggers direct reclaim. Direct reclaim needs to write back dirty fi=
le
> > >> pages and swap out anonymous pages.
> > >>
> > >> Since freeze_kernel_threads() just ran, threads required for I/O
> > >> completion (like kswapd, jbd2 for Ext4, or WQ_FREEZABLE workqueues) =
are
> > >> currently frozen. Will the I/O for page reclaim block indefinitely
> > >> waiting on these frozen threads?
> > >
> > > The existing code already performs a memory reclaim after
> > > freeze_kernel_threads(). The old shrink_shmem_memory() called
> > > shrink_all_memory() in the same position, after both
> > > freeze_kernel_threads() and dpm_prepare(). This isn't a new pattern
> > > being introduced by this patch.
> > >
> > > Nevertheless, the call chain looks like:
> > >
> > > shrink_all_memory()
> > >   -> do_try_to_free_pages()
> > >     -> shrink_zones()
> > >       -> shrink_node()
> > >         -> shrink_folio_list()
> > >           -> pageout()
> > >
> > > pageout() only writes back shmem and anonymous folios to swap; so jdb=
2
> > > and other FS threads being frozen isn't a concern. For the swap write
> > > out, the I/O submission path is via submit_bio() which is also
> > > synchronous.
> > >
> > >> Additionally, because the OOM killer is already disabled by
> > >> freeze_processes() earlier in the hibernation path, can the reclaim =
path
> > >> get stuck permanently without being able to fall back to killing
> > >> processes?
> > >
> > > There's nothing new here regarding the OOM killer. freeze_processes()
> > > disables it in hibernate() prior to calling hibernation_snapshot().
> > > Since this patch is entirely contained within hibernation_snapshot()
> > > that pattern hasn't changed.
> > >
> >
> > Quick ping on this. Any throughts on the responses, or anything else
> > you'd like me to dig into?
>
> Sorry for the delay, let me have a look at this again.

Applied as 7.2 material, thanks!
