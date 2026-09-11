Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4A48595B
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135008; cv=none; b=MBkfz8tkPlmMghoakyU2U/aY62rff7SnobZbEyFn1IHwrFtCGbLqPmXECikY+dFyYu1O2SyrFE1fsfAUFOJl4KJAwZrmv1+eUlyuIANyC0ib/z/hc6ylrdR4In8fM3tFRr1+UXAdehyLO3zXgcCtXz/NctUbXoPmd3PyMwVxk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135008; c=relaxed/simple;
	bh=F8YOyMdfp95sQVvBaT3u+TAiVvhaPdHZRKtdPC/Qu9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5kDHQrQk3uW/+wSIOoMI/7cqwMzJBCF5N6fp+hyjPtxpxosNf8Csojxd6Do6UJ/QLkVUcDGxZbsRgz7U61jmvkPZYRwZVDLjtAIywWvKTL1giuir6/I3vmxng0+lLGoNUKLqFUwbUsvBCYjBhGGVvJDk8tcw5L6MV9cOHVn9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkywjBj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkywjBj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BC31F0089A
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135007;
	bh=b36sG5el4/5Hy8E9T+/E7xqNZnVB19OuoYAC/FxjORo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EkywjBj0u5q+muxzaU2rsWySGVINxEaXQCIj/BP/pzu0tW922og1viI1ROjUaFaPk
	 BmgTYz2HPjjfbMjXiqaePOQ+ZwN+aPCfnAloZspzZKwMLC7vwdl18MRQ03xU2Np9GK
	 Hdap62Khy6PKeqB3CE2cNCtxSFCmAOBoNauUdXVVf4vkYPXvlez1uOx5aXRUNV+fht
	 QIT5xDzCgWx8x4D7no/1lWjRd8fK32VzUTE7Qldr62/8fqwxLU6QzFt7N5cgJ8QSTe
	 zSHOznk+X6ks3AjwP36c6ZEo9LkrgfT3ED3NC/OKss46cHp1yf6NuMn7lLdxRVeQ2j
	 K21LqI8/2cxkg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f16so1007017e87.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 06:56:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz0cLRqaxgmgsV3kjIin0aqvNj5n0eRf2CKOdpYo+Xicl+3/aWp7jzC0MZlAGexpdBKkU2bot9bng==@vger.kernel.org
X-Gm-Message-State: AFuF++nG/7nb14AWzSEGGTmuwrOWwbmuRStcf3whH3XbQnsJ+iw4FX3K
	FEwRg+RRKLlUepd804/7dzdZBYG8ApSrzEBd5qY8bOW3sKWUCau01/mv488EAS9Imra1mdN60Fa
	2ZSdNbDMunX86l9KEfRN/4A2x/etfabA=
X-Received: by 2002:a05:6512:3f23:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b8a02dccabmr1900750e87.3.1789135005397; Fri, 11 Sep 2026
 06:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813074343.26460-1-include@grrlz.net> <20260813074343.26460-2-include@grrlz.net>
 <CAJZ5v0iLnyRzM2g-k5ky0ofgVOttYU5w5Agb0EE21ejS_vWJ0g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLnyRzM2g-k5ky0ofgVOttYU5w5Agb0EE21ejS_vWJ0g@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 15:55:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ji8c=6cOYkjfpFn67S-f1HnNrEA8BSGBy=3f_imfWY7g@mail.gmail.com>
X-Gm-Features: AcwNN1X0G_P-S1OhMzoDuD8NpLWCDSaHmGRtMxgK0cawd9QaBz92LM5db7aWHuY
Message-ID: <CAJZ5v0ji8c=6cOYkjfpFn67S-f1HnNrEA8BSGBy=3f_imfWY7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/timer-ti-dm: Unregister CPU PM
 notifier outside of the timer lock
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Bradley Morgan <include@grrlz.net>
Cc: Thierry Reding <treding@nvidia.com>, Daniel Leznan <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Rosen Penev <rosenp@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:17=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 13, 2026 at 9:43=E2=80=AFAM Bradley Morgan <include@grrlz.net=
> wrote:
> >
> > omap_dm_timer_remove() calls cpu_pm_unregister_notifier() with
> > dm_timer_lock held and interrupts disabled. Nothing sleeps in there
> > today, but it pins the helper into a context where it can never be
> > allowed to sleep, which is in the way of restoring the RCU grace
> > period on the cpu_pm notifier chain.
> >
> > Do the list lookup under the lock and move the unregister after the
> > unlock. Nothing can race it at that point: remove() owns the device,
> > and once the timer is off the list nobody can reach it anymore.
> >
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > ---
> >  drivers/clocksource/timer-ti-dm.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/ti=
mer-ti-dm.c
> > index bd06afb7d522..032e102bdd0a 100644
> > --- a/drivers/clocksource/timer-ti-dm.c
> > +++ b/drivers/clocksource/timer-ti-dm.c
> > @@ -1530,7 +1530,7 @@ static int omap_dm_timer_probe(struct platform_de=
vice *pdev)
> >   */
> >  static void omap_dm_timer_remove(struct platform_device *pdev)
> >  {
> > -       struct dmtimer *timer;
> > +       struct dmtimer *timer, *found =3D NULL;
> >         unsigned long flags;
> >         int ret =3D -EINVAL;
> >
> > @@ -1538,14 +1538,17 @@ static void omap_dm_timer_remove(struct platfor=
m_device *pdev)
> >         list_for_each_entry(timer, &omap_timer_list, node)
> >                 if (!strcmp(dev_name(&timer->pdev->dev),
> >                             dev_name(&pdev->dev))) {
> > -                       if (!(timer->capability & OMAP_TIMER_ALWON))
> > -                               cpu_pm_unregister_notifier(&timer->nb);
> >                         list_del(&timer->node);
> > +                       found =3D timer;
> >                         ret =3D 0;
> >                         break;
> >                 }
> >         spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > +       /* Unregister outside the lock: cpu_pm_unregister_notifier() ma=
y sleep. */
> > +       if (found && !(found->capability & OMAP_TIMER_ALWON))
> > +               cpu_pm_unregister_notifier(&found->nb);
> > +
> >         pm_runtime_disable(&pdev->dev);
> >
> >         if (ret)
> > --
>
> Nobody seems to be interested in this patch, but Sashiko only sees
> pre-existing issues related to it:
>
> https://sashiko.dev/#/patchset/20260813074343.26460-1-include%40grrlz.net
>
> and the second patch in the series depends on it, so in the absence of
> any objections or concerns, I'm going to apply them both.

And so applied as 7.4 material, thanks!
