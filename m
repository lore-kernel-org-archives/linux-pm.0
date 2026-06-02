Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0653C0635
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387510; cv=none; b=U6FCuSMep/beuS7RgaoWRD9yTjmb5Cbt7jIT3BzVRrhUS/IQLwPtsvlOCjAbzamGt7nnpPwp0KbFf0foPyTFEdwEZvfD4H4L5ZALvLqkEdlVTVO8F3HAj4wQTIMwLNpvdyoXB576VjUJtkEgWe/Bb3IzuhjrAvpcAI3ANyO7rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387510; c=relaxed/simple;
	bh=TKjdp6yu3ZdkpEA8ZG/bzzihLWLkCA+4T48r6RtRetw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sChrh0p/tMoVLR/GcG8PecDuAYbxlR2TU9YmuzCU/EBeRbRWOgRa0FTIAfadOyPvtivFphu4lzRnxJHibBLaEzCRXXbcIIZw0az/N+Bl9pgn1zmgsiAIsmnK/973ovJUOt3kmOvhCPeEs55wPJY3BIF6Nu70Mevd03CpHpcM4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUPw37MG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUPw37MG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306631F0089A
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387506;
	bh=MI7oVMIq4E3ja+zz6eM2Qkbkhu1DKspabNPPMqOEciE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cUPw37MGfLsaFLvdAb10VmzsJg+r6/MHFUFMo8xeBuiIAOrMvp0F98qRzhSnb3CNc
	 hwceJxWOXJPjPmcx1zD8BYpnCDzefbgF1HjhER52b/o9PjOeVjb0hiadDmz4f8QtW0
	 ge18sZyG+Ivc/O1r0pC4qDPiKOcFpseDt9jYCWkup+swxuAeNElQB7G4/2bDXIcenw
	 CRoEiq6wbiG55N+7iQI6PsYyepkpt6WvpCqVyc2s4xzdqtcicp9ajpGzwnlODV07/K
	 43xkkywmibrCBS4e7X/AVjoM/ptDr8MwihWOt+zlqwlUk2mAXn+8www0swtHQP7nt+
	 GNL6NS4462fsg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so2242224e87.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 01:05:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9XdviiaPEeqRcTQT/MmcXU49RvTFFbPxaKFVUEtG3qYsQjgM4exROSrvF3FlDaElarnEhcCeFlJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PZ5RcCkcQr/7KEve9xBuWoyR8GBrfanC6IKRqJTfC4l6ZsWU
	rAM3KLgkMwI1qZepIbInjQJx/sbtn6j1o7Y9g3wvD2Zmgl3a0sn6SOleek+P+ddR7K6iAqbTKQG
	nggPbX/FK6Gk9JWi+JJo/E1AOA9ez4jU=
X-Received: by 2002:a05:6512:3da6:b0:5aa:7126:c63c with SMTP id
 2adb3069b0e04-5aa7126c7c3mr1888317e87.5.1780387504589; Tue, 02 Jun 2026
 01:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
 <CAJZ5v0iHezk28gWu+wNni01wi73bV7vkqmVKXD14Gtk+CKyGDg@mail.gmail.com> <c4176f8a63cd537a1ced7325079f5e7da30fb7fe.camel@collabora.com>
In-Reply-To: <c4176f8a63cd537a1ced7325079f5e7da30fb7fe.camel@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jun 2026 10:04:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMKKAuM0LxaTubjMLO1_XUs7V-o6FfYYF6cD=prKZOXA@mail.gmail.com>
X-Gm-Features: AVHnY4JGhaa2r4aPeP21MAmQyjo0ogu_7QaU_uxqJNpV7IDvoGzozeUSM2yHkik
Message-ID: <CAJZ5v0hMKKAuM0LxaTubjMLO1_XUs7V-o6FfYYF6cD=prKZOXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: hibernate: Allow disabling zero page check in copy_data_pages()
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:52=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, 2026-05-26 at 13:53 +0200, Rafael J. Wysocki wrote:
> > On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > The current implementation of copy_data_pages() has at its center
> > > do_copy_page(), which copies data of all saveable pages in a loop
> > > one
> > > long at a time, while checking whether the page is fully zero to
> > > allow
> > > it to not be saved in the hibernation image.
> > >
> > > As the comment above do_copy_page() mentions, this loop was used
> > > instead
> > > of the more optimized copy_page() and memcpy() due to them
> > > depending on
> > > fpu_begin()/fpu_end() (see [1] and commit 95018f7c94cb ("[PATCH]
> > > swsusp:
> > > do not use memcpy for snapshotting memory")). However, since commit
> > > c6dbd3e5e69c ("x86/mmx_32: Remove X86_USE_3DNOW"), this limitation
> > > no
> > > longer holds, and it only affected x86-32 in the first place.
> > >
> > > From testing it is clear that removing the zero page check and
> > > using
> > > copy_page() makes it almost 3 times quicker:
> > > - Current:
> > >     PM: hibernation: Copied 4940240 kbytes in 11.33 seconds (436.03
> > > MB/s)
> > > - With just the zero check removed:
> > >     PM: hibernation: Copied 4974664 kbytes in 9.03 seconds (550.90
> > > MB/s)
> > > - With the zero check removed and using copy_page() instead:
> > >     PM: hibernation: Copied 6275216 kbytes in 3.96 seconds (1584.65
> > > MB/s)
> > >
> > > Given that copy_data_pages() runs inside a critical section where
> > > only
> > > a single CPU is online and syscore is suspended, it should be kept
> > > as
> > > short as possible to keep the system responsive.
> >
> > I'm not sure if being responsive during hibernation is all that
> > important.
> >
> > Also, the change is about using copy_page() to reduce the time spent
> > in syscore_suspend(), so the subject is a bit confusing.
> >
> > > While switching from the loop to copy_page() brings big speed
> > > improvements, it also makes the zero page check much costlier since
> > > it
> > > can no longer be done in the middle of the copy. In fact upon
> > > testing
> > > adding the zero check alongside copy_page() made it slower than the
> > > current code.
> >
> > Guess what, CPUs have caches.
> >
> > > The following shows a rough comparison of a few more metrics
> > > between the
> > > current code and when both copy_page() is used and the zero page
> > > check
> > > is disabled:
> > > - Total time to hibernate:
> > >   - before: 13.77s
> > >   - after: 14.13s
> >
> > Score for the current code.
> >
> > > - Total time to resume:
> > >   - before: 5.85s
> > >   - after: 5.85s
> > > - Total time in syscore_suspend():
> > >   - before: 11.3s
> > >   - after: 4.08s
> >
> > Why does this matter?
>
> Reducing the time spent here means reduced time between
> pm_wakeup_pending() checks, which ultimately means the kernel is
> quicker to abort hibernation in reaction to a pending wakeup.

That could be spelled out more directly in the patch changelog.

I'm still unsure why it matters though.  Hibernation is slow pretty
much by definition, so why would anyone expect a fast response to a
wakeup event during hibernation?  If they have latency constraints,
shouldn't they use suspend instead?
