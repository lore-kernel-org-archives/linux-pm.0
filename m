Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE896463B74
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261129; cv=none; b=Nstb9ys96Dsm/za0s8uMlPMorfYfhwbQnfkTih0chPv3uqaSbQB7etX7I4wuOpGNn9tWI1QkzOdze+UbLKdz7m2AmIvL+yoXB2OOZos5ndejGYZWD33hGskOjrypVU1hOv4cR2uBzxMk1CuuDs7yktuJiNnkqZkvpPbVhsSDxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261129; c=relaxed/simple;
	bh=05tPweJpKxZlfib6ScGDFFPa80FzhmuvfHUxK8GZbNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul+y9tairSuQKj9/st6Uws92OTeOT9Nk37oCaOaVWpdneVnHF5hpdO5cc69JdNVLrEYue41L30R4GjPzDh4dwbhspdaMZLsNPMIGIaiKfSJTv++cTfxsIJAzNOCrux548uhaniIVUxuuE+hFmgbJ94JWoc3yL7wk8uyVwQUoUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CclNan51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CclNan51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31101F00AC4
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261127;
	bh=nWmi+nhbhCn5zSb0MvohBc8v02isfuIoIc/5EjMxVcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CclNan51wncgTnWC9G+im5D0Vy/W0caG33V1Yp83E/0BVb6r/n2iMx01c3Qv7iHLv
	 ba/1Ovq6Rslnirt19N3U7ib8s4zPXwp1Hr7aWmvZxTRRjQ4li64QuWY0JyIMptRgOe
	 8zwl3uKbE8tymorH12+L0dJC5OJC+vo5+mx00lZWxLwGENqBtWykIHhVDqirV3FdZ6
	 I6ZtgIau0fgeCZG0EOinV2z+awQ4MRgiUm/HtyrrUjX3yy4tiIVvvswXln78Vgpw/s
	 v7EfOb9EGPbWxPC9w9eBAW33yvTF+4tSTrngjRUDRaSR6Yh8m5SnRDyLtrPwfnWQeu
	 e7Hf7F8jIZOkA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b01910b499so227803e87.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 14:25:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8LCLLb0uzki7poIzpiYz+gKVHLUNl2v1L+ASgtovupQcc9NBgD6t+JipZCyoV7pUU52mJ5D102Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kdAi2WRmerNQeozBXHH4bowRxo/tasaoAlQICJvYJ7EjuTgDJU
	LUDK7b0ZcAaKxbUrKin0pR6VhxJzf7DFjoAq6Rp1Yi4ioHDZuOd5qvGFrgh3F1j1umsffQ5mtaG
	bX3qYAhu5yPXJq0+mj6FoUpVJ4eLgP3M=
X-Received: by 2002:a05:6512:b82:b0:5ae:b9b4:227d with SMTP id
 2adb3069b0e04-5b4847807f4mr157901e87.1.1787261126256; Thu, 20 Aug 2026
 14:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813074343.26460-1-include@grrlz.net> <20260813074343.26460-3-include@grrlz.net>
In-Reply-To: <20260813074343.26460-3-include@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 23:24:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJDUZ6HH44GK6sGdVKNAY+i7EMsqdFPNcGvoW4d7W4kg@mail.gmail.com>
X-Gm-Features: AcwNN1X1quSo1QsxIz3gCO_HDgbh8PN8nYOYmVGV5LAOkI8pEPnW3NlgR-TRiis
Message-ID: <CAJZ5v0jJDUZ6HH44GK6sGdVKNAY+i7EMsqdFPNcGvoW4d7W4kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: cpu: Restore synchronize_rcu() to cpu_pm_unregister_notifier()
To: Bradley Morgan <include@grrlz.net>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Daniel Leznan <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Rosen Penev <rosenp@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:43=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> cpu_pm_notify() walks the notifier chain lockless under only
> rcu_read_lock(). That only works if a removed notifier block is not
> freed until every concurrent walker is done with it.
>
> The chain used to be an atomic_notifier, whose unregister ends in
> synchronize_rcu(). Commit b2f6662ac08d ("PM: cpu: Make notifier chain
> use a raw_spinlock_t") switched it over to a raw_notifier, and in
> doing so replaced that with raw_notifier_chain_unregister(), which
> does not synchronize. The grace period quietly went away, so a driver
> that frees the memory holding its notifier block right after
> cpu_pm_unregister_notifier() returns can race with a concurrent
> walker:
>
>   cpu1 (idle exit)                  cpu2 (driver remove)
>   ----------------                  --------------------
>   cpu_pm_notify(CPU_PM_EXIT)
>     rcu_read_lock()
>     nb =3D rcu_dereference_raw(*nl)
>                                     cpu_pm_unregister_notifier(&od->nb)
>                                       unlink, no grace period
>                                       remove() frees od (devm)
>     nb->notifier_call(nb, ...)
>       /* use after free */
>
> The rcu_read_lock() on cpu1 does not stop cpu2 from freeing the
> block, and nothing else does. The read side is the idle exit path,
> so this can hit on any system where a driver with a cpu_pm notifier
> gets unbound.
>
> Add the grace period back. It is only needed when a notifier was
> actually removed, so wait on success and return -ENOENT without
> waiting otherwise. The kerneldoc gets back the "may sleep" note that
> the same commit dropped.
>
> Fixes: b2f6662ac08d ("PM: cpu: Make notifier chain use a raw_spinlock_t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

or if you want me to pick up this series, I need an ACK on the first patch.

> ---
>  kernel/cpu_pm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 7481fbb947d3..a2a598ad6e6d 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -10,6 +10,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> +#include <linux/rcupdate.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>
> @@ -76,7 +77,8 @@ EXPORT_SYMBOL_GPL(cpu_pm_register_notifier);
>   *
>   * Remove a driver from the CPU PM notifier list.
>   *
> - * This function has the same return conditions as raw_notifier_chain_un=
register.
> + * This function may sleep, and has the same return conditions as
> + * raw_notifier_chain_unregister.
>   */
>  int cpu_pm_unregister_notifier(struct notifier_block *nb)
>  {
> @@ -86,6 +88,11 @@ int cpu_pm_unregister_notifier(struct notifier_block *=
nb)
>         raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
>         ret =3D raw_notifier_chain_unregister(&cpu_pm_notifier.chain, nb)=
;
>         raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
> +
> +       /* Wait for the rcu_read_lock() walkers in cpu_pm_notify(). */
> +       if (!ret)
> +               synchronize_rcu();
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
> --
> 2.47.3
>
