Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB694AF165
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531540; cv=none; b=M4eZCgOZGKzjhymexVH1iU5dpzWvXvWY978tYmq4kaPWjCX+yFJoqNm1Cblr0aokfa05xH9aczitELQTnbUBGvtgqJbeSuKbcHNK85BkzdU/hXBrKSraBiMO1X+TtDiGQo0uRMDSG5wPwLGWquNIIoxR5wBycBmAmD2qpqNsR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531540; c=relaxed/simple;
	bh=UJBU8k1RMH+XBzRAsgB5KhavFuLFtKYjU4INuhwwG9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8Vx+oBS6g8fIKfD7Btp0cADOjHSglMMLyIwMgcKpx/6WjeEMfOM0E30qtwdJE0Bofg3raVnS8cs2WLjUvdH/ppldAorUeKoutHKF6LWQvHvhlw2PqfvFau06tuftJ8m+GyTTZPs9J5UpaYSMWJK8MceiqC6SYPfadBAbI02eVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4fa3CeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4fa3CeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DD81F00ADE
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531538;
	bh=ICLwyXnJhK/KUoVOOKq3/igE2t9mXTmbqKfGWifADp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O4fa3CeLzYpv2jL0RP4fyJOoKerIp+meBe1007BdOWqpziKlIoDnNryJfTFccrhYC
	 lunl7ap0t9pH56+WHVxLfkemFpeaYRxX8Nz1ZcnmhiRiNt8pIa9o/z8vHzoNRR5NmL
	 QcqLAG8XKUxg/WQQeZQTQGq4wZ1JBHCqRt8WurxNXdJmczJTKB21rvDpFx7W2es/Ux
	 qBRFRhW0vHQubJ2NOiiPtPV+fE2ShAffNpYzTq54CPELqgdcKhm1LUPfWxlfb6dC8V
	 5RKhxM0iUvUFODWTAY/mg1QgeEjeZBymENgCJtuo7jo+Ox+LJs1OgDjEhPojy4By0F
	 BhBDeOpanX8RA==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c664b8c3f3so968256e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:18:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy4Ho/6epLnelaw42315Uwe88s4bNDegTpG7/JzXU0trURMV8HTbSSG/eh2PpUZjRMSOU9vIZDCHg==@vger.kernel.org
X-Gm-Message-State: AFuF++nL7sGwxMO5DhodjFjdO1GOhSHdUgmQDwOsASpjK3tmu/E8Cl3Q
	fXeVyPTUUyffukxA6OXWIH4qR8JOHIoWTjWYRwXcZABUjet5YzxgbTCVcAaoYGnRKLn2yxMueGs
	8Nj6JCXb64g8CbLyA720Tk4jFkS40yFU=
X-Received: by 2002:a05:6122:e189:b0:5bb:eebe:7ffd with SMTP id
 71dfb90a1353d-5c7ed846723mr3238643e0c.8.1788531537439; Fri, 04 Sep 2026
 07:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813074343.26460-1-include@grrlz.net> <20260813074343.26460-2-include@grrlz.net>
In-Reply-To: <20260813074343.26460-2-include@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:17:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLnyRzM2g-k5ky0ofgVOttYU5w5Agb0EE21ejS_vWJ0g@mail.gmail.com>
X-Gm-Features: AcwNN1V5_Z3AzL6KJtrb8pJhA3QM951bpSd51TUMOLpYUc1pwfDpNtYNmV0mmJI
Message-ID: <CAJZ5v0iLnyRzM2g-k5ky0ofgVOttYU5w5Agb0EE21ejS_vWJ0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/timer-ti-dm: Unregister CPU PM
 notifier outside of the timer lock
To: Bradley Morgan <include@grrlz.net>
Cc: Thierry Reding <treding@nvidia.com>, Daniel Leznan <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Rosen Penev <rosenp@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:43=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> omap_dm_timer_remove() calls cpu_pm_unregister_notifier() with
> dm_timer_lock held and interrupts disabled. Nothing sleeps in there
> today, but it pins the helper into a context where it can never be
> allowed to sleep, which is in the way of restoring the RCU grace
> period on the cpu_pm notifier chain.
>
> Do the list lookup under the lock and move the unregister after the
> unlock. Nothing can race it at that point: remove() owns the device,
> and once the timer is off the list nobody can reach it anymore.
>
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  drivers/clocksource/timer-ti-dm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/time=
r-ti-dm.c
> index bd06afb7d522..032e102bdd0a 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -1530,7 +1530,7 @@ static int omap_dm_timer_probe(struct platform_devi=
ce *pdev)
>   */
>  static void omap_dm_timer_remove(struct platform_device *pdev)
>  {
> -       struct dmtimer *timer;
> +       struct dmtimer *timer, *found =3D NULL;
>         unsigned long flags;
>         int ret =3D -EINVAL;
>
> @@ -1538,14 +1538,17 @@ static void omap_dm_timer_remove(struct platform_=
device *pdev)
>         list_for_each_entry(timer, &omap_timer_list, node)
>                 if (!strcmp(dev_name(&timer->pdev->dev),
>                             dev_name(&pdev->dev))) {
> -                       if (!(timer->capability & OMAP_TIMER_ALWON))
> -                               cpu_pm_unregister_notifier(&timer->nb);
>                         list_del(&timer->node);
> +                       found =3D timer;
>                         ret =3D 0;
>                         break;
>                 }
>         spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> +       /* Unregister outside the lock: cpu_pm_unregister_notifier() may =
sleep. */
> +       if (found && !(found->capability & OMAP_TIMER_ALWON))
> +               cpu_pm_unregister_notifier(&found->nb);
> +
>         pm_runtime_disable(&pdev->dev);
>
>         if (ret)
> --

Nobody seems to be interested in this patch, but Sashiko only sees
pre-existing issues related to it:

https://sashiko.dev/#/patchset/20260813074343.26460-1-include%40grrlz.net

and the second patch in the series depends on it, so in the absence of
any objections or concerns, I'm going to apply them both.

Thanks!
