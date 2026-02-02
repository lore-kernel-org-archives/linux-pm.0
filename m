Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0E3033E8
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064855; cv=none; b=fR30p5WCuA882r9egppCLKcgWlvCzLdENMQ4SdR0djqkd+m8tGHF8Qmv8MDm8eC/BDyKO9uX+HAWiY9bBWJYf+tvV2nymz2tTDd/9zOZ5SnwOGtzXcyNzbxN+ZRqor2Bc0BJS4T0FOfhRcUPNnFYejMEey+vcFu37pbENvUnobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064855; c=relaxed/simple;
	bh=LXxQqB4KAsGidoo9+6NNFlatKk5Irngdf6tU9OiZvOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqslwPo04Mr+rGZdPbyFakkMJMEmPyawIJedMaDWmYl5dsXrK/qnX9O5S7+pNjqU6Z7IO1i1R742/vgbEyZjeee9QB1FIzyjIQHB6F2UZoRExbx51pr0/k2PwKXfHm9ZVZjguEA1IvjkYckx/cHX9zM7tx901NYhc63B7FE2080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA29DaiA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA29DaiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70442C19425
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770064855;
	bh=LXxQqB4KAsGidoo9+6NNFlatKk5Irngdf6tU9OiZvOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NA29DaiA5CcARdxe58q3QpOo7rJvwTzCX8iS26/nwNP84AklLpwr4Gf+MG2e3pNyt
	 b1kXx02iBKqHGL7h8nU1CRaoVXZrjMd7ToimWnIy7ZrmEH7jrfGjB4aMn6H2Ugw6Dp
	 92kXA6XvW5xp8+kUquYHrtdNBlZxGSk8uiL8uWbFFPhbOhQhvwBrRaJXO9d2hfvf8C
	 vSDZIySyK4n6SYSYsUWy8TyOiGIaKiL+exOOvpA1zeYzBlYUhd6iLVGuhjTSMnTsTa
	 GqLTptfmgEQWDDjvIO5yLmHaUKu+2sNSNgSclo4Ulx+ni/SKixPCuhql08dQYobesv
	 pHsWPIVQWzbSg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-404254ffe8aso127003fac.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr/bwfhfH4vt3ZZXOfDCHtfkM80W17fYrCoUcJX3HrSwlX4hDSTMkTnV6g4vE+X7D1eyCrtP5Xvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlgh1ld2CkyMmOO+ZfSx3zDc0qgvPAvnmD+wG2SHypVLDfWzvv
	s5RjUagA9KPFntPdtZXQSJT6XvJquL7c3VsXytcuHdP+OqTlddbjeug28nll264zlSv8+vUO5at
	bdxQ3QNtV+HsafV3aEA7qwPAp+mRufig=
X-Received: by 2002:a05:6870:61d4:b0:3e8:97ab:d06e with SMTP id
 586e51a60fabf-40a3185f66fmr396884fac.9.1770064854548; Mon, 02 Feb 2026
 12:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com> <20260124012133.2451708-2-wusamuel@google.com>
 <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com> <CAG2KctqqZ_12AWiJ89OhCfqDfNqxBH3UrzssycxrXbcbj-82VQ@mail.gmail.com>
In-Reply-To: <CAG2KctqqZ_12AWiJ89OhCfqDfNqxBH3UrzssycxrXbcbj-82VQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Feb 2026 21:40:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=RiFM3Uq2_rwuMt9Vut9dmZxvE6tL3DAGLGvjYG8sFA@mail.gmail.com>
X-Gm-Features: AZwV_Qj-XhrIK5uBfxnL6lLjWm2xQ_I7kSYSt4RSOr2DcRazIpzT2Y5wJDlu5oA
Message-ID: <CAJZ5v0g=RiFM3Uq2_rwuMt9Vut9dmZxvE6tL3DAGLGvjYG8sFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 9:23=E2=80=AFPM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Tue, Jan 27, 2026 at 8:15=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Sat, Jan 24, 2026 at 2:22=E2=80=AFAM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > In the case of an empty wakeup_sources list, wakeup_sources_walk_star=
t()
> > > will return an invalid but non-NULL address. This also affects wrappe=
rs
> > > of the aforementioned function, like for_each_wakeup_source().
> > >
> > > This patch updates wakeup_sources_walk_start() to return NULL in case=
 of
> > > an empty list.
> > >
> > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > ---
> > >  drivers/base/power/wakeup.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.=
c
> > > index 1e1a0e7eeac5..e69033d16fba 100644
> > > --- a/drivers/base/power/wakeup.c
> > > +++ b/drivers/base/power/wakeup.c
> > > @@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
> > >   */
> > >  struct wakeup_source *wakeup_sources_walk_start(void)
> > >  {
> > > -       struct list_head *ws_head =3D &wakeup_sources;
> > > -
> > > -       return list_entry_rcu(ws_head->next, struct wakeup_source, en=
try);
> > > +       return list_first_or_null_rcu(&wakeup_sources, struct wakeup_=
source, entry);
> > >  }
> > >  EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
> > >
> > > --
> >
> > This looks like a fix for the for_each_wakeup_source() users.
> >
> > I can apply it without the next two patches.
>
> Yes please. Feel free to apply this patch independently, as it can
> exist as a standalone fix independent of the subsequent two patches in
> the series.

OK, applied as 6.20/7.0 material, thanks!
