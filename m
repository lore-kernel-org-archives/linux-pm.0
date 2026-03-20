Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA712305047
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032911; cv=none; b=mcG3fx8ka5z3ouAGvVU0c2/N8aHg7jvIem6J2iz7cgqqqZnbrMX+ht+ANWd7g0a+fKYgThI/wnhgXPgxhMk2+uRCIjcNgn2utqMIBqEUwMCK226GQSAhMO7jS0F5ePoBuu0MRvWaW6Ay0nzaIRKP0iWX3eG/8Zic5PsJqwni+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032911; c=relaxed/simple;
	bh=rlxuh+g//SWfYZMPKZr79wt1FKZVKm66s2xpgenF3VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W23ZNc4ZsoEEoAGSwpKrGdGrb/3zsMg/mrCywln4UPrFMor7UxdvyRlNWtENBKPKAdnAYkXDHRHHHmoxDX30e7zt//N+mRjibPZHObHSslbSnRAkYjO/DccJ+ODgFFxwDb+pz1YHXKU10Ch/E9vXC3jC7Yb8k50EUUiQJKio48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USwJr39F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USwJr39F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CADC2BC9E
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774032911;
	bh=rlxuh+g//SWfYZMPKZr79wt1FKZVKm66s2xpgenF3VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=USwJr39FMepzwcaeiuoCIcAgjQDk7ERfSQVCovCPK4VOduuZvVst36iMQOsFzs2R2
	 UvFTGLAPWUU/vkOWihhIKwuyxhpiqmZHYI+VdSBF+j0ruqsx36sP4wyAV/XgcqneuD
	 sRLXGUn5plNwlnDoJ2e3zLnW+SZrdda+KvTEmgCAIER6P4h1Exb7JeK6QxL5CqiayG
	 xwUihHsV2HEUxiU9BzZud0Y3jgSGqDsPV//9XdkRF4GYBrqLl+PZvNVlhWJa6M3aeu
	 ZPIqooswhRVh5+EOG7sckEjgoJZgRjNdmAjUzBNLhNZ53gkJ1NEbY2wAEQhCT0CXA1
	 Ep+E4ejzTF+tw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40438e0cba6so1603406fac.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr4KZ6qFjD4C24AeBcttkEEQtxozwRM87297ncj/xR+ZfUJ9nQ6Gf/GLqbUukLpnGlGWhXsfEt4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZlIHi8zAyG/yrbqLoha8eRxzoYo1qPHTwXxXZTu95EhU3ccd
	jWkUDefA9WJQJ3GeUrefP9r7w54WmkRlUgoGNPCP89/OZJwd6tqLQMvZQz6c1mS3lYZ0UEmDkyA
	MqzpDau4adzun/vNSITnxfpNhnTnAk4o=
X-Received: by 2002:a05:6870:219c:b0:417:565d:e3e with SMTP id
 586e51a60fabf-41c10ee8758mr2515864fac.1.1774032910409; Fri, 20 Mar 2026
 11:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773075892.git.berto@igalia.com> <ef5a7c5e3e3dbd17dcb20efaa0c53a47a23498bb.1773075892.git.berto@igalia.com>
 <CADyq12xmsk8DoW328dV8GZkcnSu7q4ZqeC21xauMbsN=txDi8w@mail.gmail.com>
In-Reply-To: <CADyq12xmsk8DoW328dV8GZkcnSu7q4ZqeC21xauMbsN=txDi8w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 19:54:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iNea=Z2qtfQsJZxVVNMsaxeUNvnnDObwUnwp-0Y26eew@mail.gmail.com>
X-Gm-Features: AaiRm50NDiXsJUtGIhBarzE3XSSZeXubSZokGG-RbG0Wyj6_6ZXYezbaQq8oyZM
Message-ID: <CAJZ5v0iNea=Z2qtfQsJZxVVNMsaxeUNvnnDObwUnwp-0Y26eew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: hibernate: Drain trailing zero pages on
 userspace restore
To: Brian Geffon <bgeffon@google.com>, Alberto Garcia <berto@igalia.com>
Cc: Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:45=E2=80=AFPM Brian Geffon <bgeffon@google.com> wr=
ote:
>
> On Mon, Mar 9, 2026 at 1:40=E2=80=AFPM Alberto Garcia <berto@igalia.com> =
wrote:
> >
> > Commit 005e8dddd497 ("PM: hibernate: don't store zero pages in the
> > image file") added an optimization to skip zero-filled pages in the
> > hibernation image. On restore, zero pages are handled internally by
> > snapshot_write_next() in a loop that processes them without returning
> > to the caller.
> >
> > With the userspace restore interface, writing the last non-zero page
> > to /dev/snapshot is followed by the SNAPSHOT_ATOMIC_RESTORE ioctl. At
> > this point there are no more calls to snapshot_write_next() so any
> > trailing zero pages are not processed, snapshot_image_loaded() fails
> > because handle->cur is smaller than expected, the ioctl returns -EPERM
> > and the image is not restored.
> >
> > The in-kernel restore path is not affected by this because the loop in
> > load_image() in swap.c calls snapshot_write_next() until it returns 0.
> > It is this final call that drains any trailing zero pages.
> >
> > Fixed by calling snapshot_write_next() in snapshot_write_finalize(),
> > giving the kernel the chance to drain any trailing zero pages.
> >
> > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the imag=
e file")
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Acked-by: Brian Geffon <bgeffon@google.com>

Applied as 7.0-rc material, thanks!

> > ---
> >  kernel/power/snapshot.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 6e1321837c66..a564650734dc 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -2855,6 +2855,17 @@ int snapshot_write_finalize(struct snapshot_hand=
le *handle)
> >  {
> >         int error;
> >
> > +       /*
> > +        * Call snapshot_write_next() to drain any trailing zero pages,
> > +        * but make sure we're in the data page region first.
> > +        * This function can return PAGE_SIZE if the kernel was expecti=
ng
> > +        * another copy page. Return -ENODATA in that situation.
> > +        */
> > +       if (handle->cur > nr_meta_pages + 1) {
> > +               error =3D snapshot_write_next(handle);
> > +               if (error)
> > +                       return error > 0 ? -ENODATA : error;
> > +       }
> >         copy_last_highmem_page();
> >         error =3D hibernate_restore_protect_page(handle->buffer);
> >         /* Do that only if we have loaded the image entirely */
> > --
> > 2.47.3
> >
