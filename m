Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF348C8AE
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716216; cv=none; b=d7cfvEy32tfN7ZcxIleiEMWBTI8gIV0x1Kwcp36eUZF6MNFu6z2XOrNqX9SRBxCVE1ccg4JUpohhmUoSOb73lOZGDTSmjYCYpFnMRQlOAhxY5Rp5hQrCtMFocUlOMkIY4MTCebZezT+aUV5tiJdqUII7ZhVX4RMG9arWi+Sj3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716216; c=relaxed/simple;
	bh=X28F3Hl05lwR6wgeMUHHK+ZBDLYoJUsWLiqcQ18Z8Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOPWv5YZ/Qon3EXVvwhbrnG94htZ2usWFP+ynRUy6UFmKdxa9Ixbyyd2P3hADmM+FqU4a4aXIIB8mjWcqyy+xYZGvX3jM0ZYkgtjpErtNEme82Qmbp2EHMA1SRnlkhX8lvevujAWLm0R7gFu9rDjlADxpm0v9QrwTulBb6rjRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej3QDQJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej3QDQJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F21F00A3E
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716212;
	bh=8y4MDUgvWdburveM+Qn/AQB/d71cSDhUUVHg/A13PSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ej3QDQJzjV39zigyDV3lCuF7gzBLoJN5rAa8mCs6x7mBDnV4sex6nc+0S/1G9JvgE
	 wSO31DZVqlIqWhC0xgOQGjto5BhcYqc4a09efLsi+/3qG0FFh5Hv26kbFhqij0gXnB
	 XOrQAYBEjkqVgGVhsNhipDMOqTpunLXkZ6K+rS/+YECxBE5I4zJ8BMvcuktGHfT6Yk
	 buFsXaNNZiH4tA3pmiI53mnUAuT88WtFXWgAvIE3Uk1U6hidB02HhdDqKtpwOjzdVw
	 n69JtYTs+BSrZt15ARks6Z69SKOayE+0QJoGW47ZWfWZBSWk7Yc9cPEMFf3HASeHYP
	 8+YGo5LER5Fwg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3996f80800bso8817741fa.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 10:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5zSxRCRQG3d9W4nlfQ0J1EACWaqwGG9qqiFG/dBMk3MppiRdLz0+ltLL6F77fZzM2bYnzN2jV8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyvv1lHQusFfjQSqLQwdG/pU6WisecA/AgfQhRLvXszAR9QTEq
	aBXUQkKLxsrTLIzgdXuvFWNoNtomfJiBvHABQtf2Jc9BH5NIaitrSAlzzXZcmNgKpdTcGdOhByy
	JX43xU2h0uaU9pC7XBSrdvF74RSw8LIQ=
X-Received: by 2002:a2e:ad13:0:b0:396:7f13:99f3 with SMTP id
 38308e7fff4ca-399775ac396mr1035011fa.12.1781716211159; Wed, 17 Jun 2026
 10:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3444162.aeNJFYEL58@rafael.j.wysocki> <bc20f2a1-66ad-4655-99e0-ad59e597f831@arm.com>
In-Reply-To: <bc20f2a1-66ad-4655-99e0-ad59e597f831@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Jun 2026 19:09:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtpcRMDo+U2-fa=SciQHPJwv-uqqzra__h7YzbS197DQ@mail.gmail.com>
X-Gm-Features: AVVi8Ccg-ucTWCnrREim74ba8QldIRKgrn3lzUzqD2Fk0af6qsz1VqvS44BCwgc
Message-ID: <CAJZ5v0gtpcRMDo+U2-fa=SciQHPJwv-uqqzra__h7YzbS197DQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Allow exit latency to exceed target residency
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 6/17/26 17:16, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 76934e495cdc ("cpuidle: Add sanity check for exit latency and
> > target residency") had added a check to prevent the exit latency of an
> > idle state from exceeding its target residency that later was limited t=
o
> > printing a warning message in that case in commit 4bf944f3fcb6 ("cpuidl=
e:
> > Warn instead of bailing out if target residency check fails").
> >
> > However, a thorough code inspection with that in mind leads to the
> > conclusion that actually there are no assumptions in cpuidle regarding
> > the relationship between the exit latency and target residency of a
> > given idle state.  It is generally assumed that the idle states table
> > provided by a cpuidle driver will be sorted by both the target residenc=
y
> > and exit latency in ascending order, but that's a different matter.
> >
> > Accordingly, drop the check in question along with the message printed
> > when it triggers and the inaccurate comment preceding it.
> >
> > Fixes: 4bf944f3fcb6 ("cpuidle: Warn instead of bailing out if target re=
sidency check fails")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/driver.c           |    8 --------
> >  drivers/cpuidle/governors/ladder.c |    2 ++
>
> ladder.c?

It looks like I forgot to refresh the patch.

> >  2 files changed, 2 insertions(+), 8 deletions(-)
> >
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -195,14 +195,6 @@ static void __cpuidle_driver_init(struct
> >                       s->exit_latency_ns =3D  0;
> >               else
> >                       s->exit_latency =3D div_u64(s->exit_latency_ns, N=
SEC_PER_USEC);
> > -
> > -             /*
> > -              * Warn if the exit latency of a CPU idle state exceeds i=
ts
> > -              * target residency which is assumed to never happen in c=
puidle
> > -              * in multiple places.
> > -              */
> > -             if (s->exit_latency_ns > s->target_residency_ns)
> > -                     pr_warn("Idle state %d target residency too low\n=
", i);
> >       }
> >  }
> >
> >
>
> Fine with me, but the title is cpufreq: instead of cpuidle.
> If you'll fix it when applying:

I will.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!
