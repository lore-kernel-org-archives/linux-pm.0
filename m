Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5113DFC82
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768343; cv=none; b=q631qK+oETTkGpRRfpLHYIkThEi3z5HVc7xRDHPh3k44LAXuGmY3rge9KPcWBQzXGYcZIdsHNq1DC0dDzjpMBjw0opxLoruVbbDQAKiSzJaFxGouUrZpR7IGvr230BHNqyFAC4sWYqF8tjxSX5K0cdgmuLHqm7ozNBIUqQ+EqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768343; c=relaxed/simple;
	bh=YsfAvkGwQIZXxv46FrMqFr9tsndpu/Yg83HLfP51i0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDNDRZczB8PKvv5PN0kDZInJ3Vw++AbBbUSdMybwwqQHwpPAVs/AB0JyT37KIIxpNGvAsNgM2uhyAF1FRECKj0GyDWesTtr6jM3W4DwRUaLXScn3QZIATqO8e3PCryO6R4ejiD0oX2glGOhJ5YHmtENN5rqVIVkZKgS/xusz57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/9rDvyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/9rDvyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47958C2BCB3
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768342;
	bh=YsfAvkGwQIZXxv46FrMqFr9tsndpu/Yg83HLfP51i0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S/9rDvyJapQRRvtOWuod54Wvrd2pH3RnGdWGLW4FMUdJEPi08s9iD0hmZxVdKr3jT
	 w3rgsibe9sUw6x+yLLU9ApF39R1F/ThaAnKrT3qdWx0P5MpZyh2hMbP9OyMefy03+/
	 s1vNWD6smph5yrxa+AWWMI6/xJKpa5dfM35bxbN0GyvMW5/ubeDyv6DjwFNdXDeV1v
	 GFrLNYj1nNCW7PIHaJvRFBc6jfXshn/2PDpJ53jgvf+/Sjsw74JIE8oHpLtIDfTb7O
	 Ra6O6c6kyrTIAN/kFFZipbYwMfks1vg/ouv8RQV+62+z7/iUqVcFCGPHLWLczEEkaJ
	 wvgPc6jT+9Msg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a858881ad2so9263710e87.3
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:19:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/zCx/WfFg0bwypb18ALPll+8YTLr+iwIS4LEBEv+isYti8ouIYpmUpt5n49gZBIa7BZFX6nY/w7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyzzV1v/glmh6zI+n+uPTfxRr/WV9TMTXbEqpBTkosuo8bsdJ
	66Sgeie5Myw/2/9rgOSo2aDd4MQHv4Y2im3DQhpp6RE7r5Duyt3lydyuNgyQ8DwXkqEFriTviVo
	kWKKCNej4Xoyp9Rv32yzG4oQQgZzm1Lw=
X-Received: by 2002:a05:6512:1087:b0:5a8:76c0:a7b7 with SMTP id
 2adb3069b0e04-5a8f37c346bmr2382551e87.7.1778768340665; Thu, 14 May 2026
 07:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514132901.275477-1-marco.crivellari@suse.com>
 <CAJZ5v0gGyceLJfNtiS+Asi2BRVP8SPjJDxKJrDK+gi9Bov3P5w@mail.gmail.com> <CAAofZF4UMwpFz8-CqvPJzGEze40x+r_uXx9vTLqQGc3396EgiQ@mail.gmail.com>
In-Reply-To: <CAAofZF4UMwpFz8-CqvPJzGEze40x+r_uXx9vTLqQGc3396EgiQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 May 2026 16:18:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hx=5Fp6Oc8v7fo=C2OaHLaL7ymfb5Epz2wX2TDh+x9pw@mail.gmail.com>
X-Gm-Features: AVHnY4Imulu2y812ySwtRV7-MaJ3KpRXofgExH4oIvvkXfTqO1RVj0hMbsfxS5c
Message-ID: <CAJZ5v0hx=5Fp6Oc8v7fo=C2OaHLaL7ymfb5Epz2wX2TDh+x9pw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:03=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> On Thu, May 14, 2026 at 3:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > [...]
> > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal=
_core.c
> > > index 2f4e2dc46b8f..691c5e749c3e 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
> > >         if (result)
> > >                 goto error;
> > >
> > > -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFF=
ICIENT, 0);
> > > +       thermal_wq =3D alloc_workqueue("thermal_events",
> > > +                                    WQ_POWER_EFFICIENT | WQ_PERCPU, =
0);
> >
> > No, we actually don't want that here.  See
> >
> > 26fd03effa94 thermal: core: Adjust thermal_wq allocation flags
> >
> > >         if (!thermal_wq) {
> > >                 result =3D -ENOMEM;
> > >                 goto unregister_netlink;
> > > --
>
> Thanks for sharing the commit, I didn't see it.
> Quoting from the commit log:
>
> > The thermal workqueue doesn't need to be freezable or per-CPU
> > [...]
>
> Currently, alloc_workqueue() without WQ_PERCPU is already per-cpu,
> so drop this flag it doesn't make the workqueue unbound.
>
> If you want it unbound WQ_UNBOUND must be used.
> If it's okay with you, I will send the v2 with WQ_UNBOUND.

Yes, please!
