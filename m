Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B370D54
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300044; cv=none; b=RIvFMCzoo6Dm+HXiOSp7U4cFuGNa4a5CCWoMibjOR0vZKdnAid5Fq5Pash1Ru9XFEHWvxJwvqZiIEFiQq3aDZmMiyMmW/COhbzl1738ta3F6eOeKrJ6fsjsJPcU3sWRZcCentnTXzc/RAgpBJQ6GXYDS00N9WMQ+gP7CbG+RmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300044; c=relaxed/simple;
	bh=94+xfr2B7jPGTEtMTeC3oXZF+BJtseXt+Vlioo7pr8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oldO3FeCe9hBLEKb44QLptT6R4j0NyHHRUKp8Fbp36En0+T40kEWwUQDg0TZsMx5/6gqbeRCpMDC4bNW15k8Wo2z7AP+T/80uowfPNJjDQsLqfY19fxQT74ZNcKRp3g4utvSEct+6wAHN01Ps5oIUDeZnW8XjdkN/m4ndsbi5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrKXOtcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrKXOtcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F621F00896
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779300043;
	bh=nPAhIQ9pHakytAl1BrJEqtQxrA/i67VnTRHdU+hmRUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IrKXOtcOjlNs3+bhl7/N5jBwN2eSCBBHMYlZm4m0iSV8JtH8F2MJR42/OB4S9MzWx
	 xX1xzPlcqECdXx+IGv69Q93Q5be42gUVKFfq7rijzB4v3KPCFiYesvNa+mV52jmy56
	 UVTvvS4nhTMG8zKqUvFMdg4OJ/IN7w9EPMNn/3PvJlrqzDiQdQQ8wRfdrqoSRcvrxE
	 mSXDka6MuM/T+nLSk4CpGplzbPmqKrLTcPmX3KevmclFqk4lJim3nGDVvVwMd0+ALd
	 uxLpmQslehePMqekHuzrosrh1vKeNe0vkh/hOiUrI9kJugFl/v3hh0upnB/uDvgvVx
	 vdgFd9D8bKwxQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a877510541so6152438e87.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Bt3ev4x5D+2CdWfQgTtaACTVH6tUK7XWbI9/fOlwqxtV1nhv2BwoEhgrNaI7Jg90dE2d6K1TjTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8WnwYuXopqlwUzRdFvj4UTyHG5XPTx+t7Dnz8WR0vCkHU6MI
	rHwm+BeS5kwT0KFOqPqy5l9Ok1oGJaD4vCHF3CuES3ATORBxDKLYXaBc82SHtklmasIpWBJyz60
	PzykXv0JK3DFlBL/1+4gyGTpSwC8u93A=
X-Received: by 2002:a05:6512:3095:b0:5a8:d7d4:4948 with SMTP id
 2adb3069b0e04-5aa0e7641e9mr8213643e87.33.1779300041485; Wed, 20 May 2026
 11:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520165835.90974-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260520165835.90974-1-ovidiu.panait.rb@renesas.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 20:00:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEREsmZWUzC-Zn1b4+DC+35AQ_D+pPdsAEK9UK54F_Zg@mail.gmail.com>
X-Gm-Features: AVHnY4KSLv82GJGq3DcljpdqkcHGa3frrhl3DC96Vj45gVsgvYAo_BG3TgcFY5s
Message-ID: <CAJZ5v0hEREsmZWUzC-Zn1b4+DC+35AQ_D+pPdsAEK9UK54F_Zg@mail.gmail.com>
Subject: Re: [PATCH mainline-linux] thermal/core: Populate max_state before
 setting up cooling dev sysfs
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 6:58=E2=80=AFPM Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
>
> Since commit 13f4e660a126 ("thermal/core:
> Split __thermal_cooling_device_register() into two functions"),
> thermal_cooling_device_setup_sysfs() is called before the
> ->get_max_state() callback in thermal_cooling_device_add().
> However, cooling_device_stats_setup() allocates space based on
> cdev->max_state, which is not initialized at that point.
>
> With CONFIG_THERMAL_STATISTICS=3Dy, an out of bounds access happens
> inside thermal_cooling_device_stats_update(), followed by a kernel
> crash:
>
> Unable to handle kernel paging request at virtual address ffff800081329e6=
0
> Call trace:
>  queued_spin_lock_slowpath+0x1cc/0x320 (P)
>  thermal_cooling_device_stats_update+0x28/0xa4
>  __thermal_cdev_update+0x74/0x88
>  thermal_cdev_update+0x44/0x58
>  step_wise_manage+0x1b8/0x300
>  __thermal_zone_device_update+0x270/0x414
>  thermal_zone_device_check+0x28/0x40
>  process_one_work+0x150/0x290
>  worker_thread+0x18c/0x300
>  kthread+0x114/0x120
>  ret_from_fork+0x10/0x20
>
> To fix this, restore the original ordering of ->get_max_state() and
> thermal_cooling_device_setup_sysfs(). Note that with this reordering,
> the dev_set_name() and ->get_max_state() error paths now reach
> thermal_cdev_release() without setup_sysfs() having run. This is safe
> because cdev->stats is NULL in that case and destroy_sysfs() is a no-op.
>
> Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_regist=
er() into two functions")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 4e2a17fdb6a7..9b9fa51067bd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1015,8 +1015,6 @@ static int thermal_cooling_device_add(struct therma=
l_cooling_device *cdev, void
>         device_initialize(&cdev->device);
>         cdev->devdata =3D devdata;
>
> -       thermal_cooling_device_setup_sysfs(cdev);
> -
>         ret =3D dev_set_name(&cdev->device, "cooling_device%d", cdev->id)=
;
>         if (ret)
>                 goto out_put_device;
> @@ -1037,6 +1035,8 @@ static int thermal_cooling_device_add(struct therma=
l_cooling_device *cdev, void
>         if (ret)
>                 current_state =3D ULONG_MAX;
>
> +       thermal_cooling_device_setup_sysfs(cdev);
> +
>         ret =3D device_add(&cdev->device);
>         if (ret)
>                 goto out_put_device;
> --

The fixed commit is in linux-next only ATM, not in the mainline, but
the problem addressed by the patch is genuine AFAICS.

Applied, thanks!
