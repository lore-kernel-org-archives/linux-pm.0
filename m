Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF184BC025
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813004; cv=none; b=aekkvHQxHuacXt+KOa+gOLJQ/+/PG43YOIIF4yC9hXuxoej3hIsbUMifuaapA1ivQJR+uv6AOY4Qk8DbRrOZsGtRuFsFBV5K11wQ7UqxlJpbJw/Id2mbYJ7lvxzqx1yj1Q+JBkkeWjM1vJxotntmF9mt2l4NDkJcUnI/zYj381M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813004; c=relaxed/simple;
	bh=e8JLRVnPWGOfpoHqffwWon1YJMfSZTfVAmOXuOfWf3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7aDpIN/yEou1y7GVMWqQKyvtmJgIxoVGN++lYK93r1gkkk+OK5fQWgWxC4mfVYSk5whRTRQBEbNn6aSBxO04PiEGR0VvWSH+HAGQ/3oS2MUvrceuAAR/J98i6n9iEVCOybKG1e9jXGFeB6Cju1oWteXWpEUupi6n2eEUyMfo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfTVbfq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfTVbfq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B951F000E9
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784812997;
	bh=h8q0fqPD3+xX4XNdlNPRamaXcHRHDrLo/nFUd+HpSP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bfTVbfq8RYbKCyWmE1xBdh3M3SLpTfhdeR9zArj75zLCDFtBtEEXZKpxasMZPZ4Dj
	 b3h8iOW0bc/WkENGUJgeCcnUdYs2qPriJYPrx119+fP73OTAhU2AS9tW+vlHNjDYbM
	 n6ZFghfumnUAyzPZ07GBP1ti3N/6hwKE/HnXgemo0qGkiAjB5h+4+0ptmEjwdGpN/+
	 vfaLFEmO8/385kZK5hMkLphnpHtJKDt3ILFCQ2HqAZ2FQeaJr0ra6Pl1lFwbcM/RhU
	 lt5PVH8eSx6lrNaPdJSIVEwDoDlrwpALIXNI2d7/CARHVQnuuGdROx/Dbj2g/K6cSu
	 3zz1fctVgXvSg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so588435e87.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:23:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwsGOuErHmmD1UrZAqawnEmUMK5d4XoD7UMRK7n1yZFdPjWiPEY
	0G6uT6bq2G2OD9cTdNk8U2pfNEv6XGK7GVuxt2PKigezDP4YXtLKQX/Lj/2WBUEala0ks9G762g
	Lc+v9uWYBvvLKyPQRjLJccGR8ZZlLa0s=
X-Received: by 2002:a05:6512:2507:b0:5b2:9599:b5c7 with SMTP id
 2adb3069b0e04-5b2b2f67c31mr698222e87.41.1784812992987; Thu, 23 Jul 2026
 06:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711145246.8625-1-malayarout91@gmail.com> <CADyq12wf2eyRndf5M01-SCE6a0NGOD12EBWpftLi4k2x8eOiEg@mail.gmail.com>
In-Reply-To: <CADyq12wf2eyRndf5M01-SCE6a0NGOD12EBWpftLi4k2x8eOiEg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:23:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7CJj-Ro6ZA-B1Mf5Xa5scBh9LD82WgenbQNkFBj70tg@mail.gmail.com>
X-Gm-Features: AUfX_mytdCcizvod0tKP4Ton47aHd5JaQJOSrziJtedXJjGS-GPKGLty-RXKyB0
Message-ID: <CAJZ5v0g7CJj-Ro6ZA-B1Mf5Xa5scBh9LD82WgenbQNkFBj70tg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix memory leak in snapshot_write_next()
 error path
To: Brian Geffon <bgeffon@google.com>, Malaya Kumar Rout <malayarout91@gmail.com>
Cc: linux-pm@vger.kernel.org, mrout@redhat.com, me@brighamcampbell.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:27=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> On Sat, Jul 11, 2026 at 10:53=E2=80=AFAM Malaya Kumar Rout
> <malayarout91@gmail.com> wrote:
> >
> > When memory_bm_create() succeeds for copy_bm but fails for zero_bm,
> > the function returns without freeing the resources allocated for
> > copy_bm. This results in a memory leak that includes radix tree nodes,
> > zone structures, and page lists.
> >
> > Fix this by calling memory_bm_free() to release copy_bm's resources
> > before returning the error code when zero_bm allocation fails.
> >
> > Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the imag=
e file")
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
>
> Acked-by: Brian Geffon <bgeffon@google.com>

Applied as 7.3 material, thanks!

> > ---
> >  kernel/power/snapshot.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index d933b5b2c05d..4a73927cc55b 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -2797,9 +2797,10 @@ int snapshot_write_next(struct snapshot_handle *=
handle)
> >                         return error;
> >
> >                 error =3D memory_bm_create(&zero_bm, GFP_ATOMIC, PG_ANY=
);
> > -               if (error)
> > +               if (error) {
> > +                       memory_bm_free(&copy_bm, PG_UNSAFE_CLEAR);
> >                         return error;
> > -
> > +               }
> >                 nr_zero_pages =3D 0;
> >
> >                 hibernate_restore_protection_begin();
> > --
> > 2.54.0
> >
