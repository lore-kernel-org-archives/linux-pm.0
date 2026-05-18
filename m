Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9C378833
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111881; cv=none; b=KlRx/qu/qfNPwHkcpjy8cRHilB3Y4uQR2uDrH4fVLtWbVhBDYbudUnRxLiuB5AxC7uwxpJ+vC6Xh5CkJrtdWxn61iuhi/rhMsTp2HNfOvGa8L+KIKqzrPer6f8KBbhl8yEE4+jLQj27z02a4OoQxrOQfzUhr2lVYUNg9IjbJq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111881; c=relaxed/simple;
	bh=hT9TcuhBnabI1WbkWsrZMVjm2UssLaE9pEVxVhKu8XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZJoEGAUAdrQu04oWcFdDYo04yaeEjr5sTLiT2dNBm9WRNkTd4yHdc4gZ5g4yrgYHHhIGxQKpziqBWkXuSfRZtzzRXLqFWGY5tf6ctD8cWoomH1xcqrW97fyZEwJtPIXE8LLcCg0TiM92apt9oUvvNfTBCdqd0u4Lk8JDTD8p9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Ll5q0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Ll5q0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B9C4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111881;
	bh=hT9TcuhBnabI1WbkWsrZMVjm2UssLaE9pEVxVhKu8XM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2Ll5q0PfcTWhGHm/BRxRrTj0azBKSXOF+Fy7mF8ImqmxsdZXU9nHW2sAgEXmEUbz
	 kibqXJ8guWLQ+miOnGMEcLqs8rPW6irPisHnuhsocO1pLBD7ZIUThOWP7i9sZxc/aX
	 Yn2HOFDP67M6dx3bI2aAoKezIt204bXn4tc8EOkvGC2G8ihw9GG2frFjvQBhgbIAmU
	 Uh1weo1aGWLU1libdutZsf4xQhrGC6TkiwGKxel7ZxpcP3rMET0y0B13WEIr347b20
	 DFyttdrZl1TlM2uJnafa6FV0mCA959/BLLTDmgAm2NoGMYwSKkHtfhwnRZ/GgbTH5j
	 4/AbWD6ww+Alg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so2232973e87.2
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 06:44:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Orrh3Pr1UsSGU+KZlAVAvfyyVtIPD+sLIkOWC1w2wX9MS2b2LRgZL9DJXt+0tHft2OH2Khct7KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3W0rR/XT9V1ZwpfTL31PPb/3yvAuiPX15aqE2WQXg66f6n0I
	86/e4DPdE1P1pmAEuct2hPB7Uaq1/LSMf8BPIq3sxBLsCf/2jBsL8lEl2pL2P2Abe7XaKuUc3SN
	pTZQwNXV+WRSr1uwXwrQ16Lh8i+5v44c=
X-Received: by 2002:a05:6512:2315:b0:5aa:b6b:a3f0 with SMTP id
 2adb3069b0e04-5aa0e74ae09mr4837717e87.44.1779111879684; Mon, 18 May 2026
 06:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-hibernation-fixes-v3-1-31bc9fa3ba2d@collabora.com>
 <CAJZ5v0j7fqyL2GtWzwpWP8ATj=WnuQGC5z8Zhz7VO-jixrYnpA@mail.gmail.com>
 <87mrz78brw.fsf@collabora.com> <877bp0q1ob.fsf@collabora.com>
In-Reply-To: <877bp0q1ob.fsf@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 May 2026 15:44:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_ox4Qe9_LBk+SHLKzo0NG+bjKH7DL7fG-zmGL=KRGYg@mail.gmail.com>
X-Gm-Features: AVHnY4J0aMYYdkqMq6TZ0zd00EuFNLc38nx1mtcGN9pSFC0q5eOpXsQFwWybDQ8
Message-ID: <CAJZ5v0j_ox4Qe9_LBk+SHLKzo0NG+bjKH7DL7fG-zmGL=KRGYg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: call preallocate_image after freeze prepare
To: Matthew Leach <matthew.leach@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, YoungJun Park <youngjun.park@lge.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:37=E2=80=AFPM Matthew Leach
<matthew.leach@collabora.com> wrote:
>
> Hi Rafael,
>
> Matthew Leach <matthew.leach@collabora.com> writes:
>
> > Hi Rafael,
> >
> > "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >
> >> On Fri, Apr 3, 2026 at 9:36=E2=80=AFAM Matthew Leach
> >> <matthew.leach@collabora.com> wrote:
> >>>
> >
> > [...]
> >
> >> Can you please have a look at
> >>
> >> https://sashiko.dev/#/patchset/20260403-hibernation-fixes-v3-1-31bc9fa=
3ba2d%40collabora.com
> >
> > [pasting comment in-line here for comment]
> >
> >
> >> Does this relocation introduce a deadlock during memory reclaim?
> >>
> >> hibernate_preallocate_memory() allocates a large amount of memory and
> >> triggers direct reclaim. Direct reclaim needs to write back dirty file
> >> pages and swap out anonymous pages.
> >>
> >> Since freeze_kernel_threads() just ran, threads required for I/O
> >> completion (like kswapd, jbd2 for Ext4, or WQ_FREEZABLE workqueues) ar=
e
> >> currently frozen. Will the I/O for page reclaim block indefinitely
> >> waiting on these frozen threads?
> >
> > The existing code already performs a memory reclaim after
> > freeze_kernel_threads(). The old shrink_shmem_memory() called
> > shrink_all_memory() in the same position, after both
> > freeze_kernel_threads() and dpm_prepare(). This isn't a new pattern
> > being introduced by this patch.
> >
> > Nevertheless, the call chain looks like:
> >
> > shrink_all_memory()
> >   -> do_try_to_free_pages()
> >     -> shrink_zones()
> >       -> shrink_node()
> >         -> shrink_folio_list()
> >           -> pageout()
> >
> > pageout() only writes back shmem and anonymous folios to swap; so jdb2
> > and other FS threads being frozen isn't a concern. For the swap write
> > out, the I/O submission path is via submit_bio() which is also
> > synchronous.
> >
> >> Additionally, because the OOM killer is already disabled by
> >> freeze_processes() earlier in the hibernation path, can the reclaim pa=
th
> >> get stuck permanently without being able to fall back to killing
> >> processes?
> >
> > There's nothing new here regarding the OOM killer. freeze_processes()
> > disables it in hibernate() prior to calling hibernation_snapshot().
> > Since this patch is entirely contained within hibernation_snapshot()
> > that pattern hasn't changed.
> >
>
> Quick ping on this. Any throughts on the responses, or anything else
> you'd like me to dig into?

Sorry for the delay, let me have a look at this again.
