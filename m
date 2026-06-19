Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D7331EA5
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781892618; cv=none; b=qUP3A5X2V20YSMaAxUIRn6QKDUqBqhHsdr1GUALpUBH0arUzwp4l8r8+BB7+Dtxpkf0kD1+maZNol7hc3fQch02lfuUCdcrIO7ydz+uUF67Cdb6SE+8Ux2Y9ZTepeVPU0hKNS+IDMnI+OrwCNTdSkjw6JXE+pUqABN58DL/b3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781892618; c=relaxed/simple;
	bh=00tN0zVmjadBqpVCHFjhfKcoZAlVfMRL2mQa/8bjZAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyrXjLfHYyPePh9VeOIKVVepfq5HO0W+wPFUrIXimQP03BoxF1cyj7r+EemvJfbemON8jOx9B2wCLQY1jEGPOeae+6t34S/j/zMjzU4S67YGH56nbsdbmq8LZz1KCbdODAU3VEcHCw6/0f+pSzM1pMzPsKcAsjIeOI8HCJ1lk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUz5T1IH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUz5T1IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE61F00A3A
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781892615;
	bh=cbkDA4Dshds+sjaf3MIg2K3nG10/+FZp3WmqgX3Usiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MUz5T1IHUsRytzfbh7mrO5lg3fkXgtW26Nk8Hu7oMEcWLufFMZMw4YXUGvHVMBucE
	 yZXuMgbCvOMtDOUgZdyQbttuiGDlXyyG9sY+c+pEVZm+Ku0kQvBs9npkuBYdtQVna5
	 60Q5wjrPeARTxzlk1xcTKtfwGv10NJDyW9d5Akd2UTfMaLhRs+E6M6nuGmoVMm9qKZ
	 YPa+GzEwUiH3NvGsu5HxuOkFl3UCxhCIt5pepQ9myEvTXX32mQ2Vas5dYTAsWZUz1u
	 oLRVRo2nnuJz5fuPbeofSmTB/KUFJS4fKX4v4zLTImtQjOZkRBOEiew/qOfguCqn/W
	 myW3AV0HbKczg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3995e22ef81so34521771fa.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 11:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9bal9YGtIRUcYPBeaAgPGx1tO8zvZuuNB/NY9q0IzjXOheJciUCPGD7+HaP68Lwo6wlnAGR7dOPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVTxXwTFqkm6y7thPDKREl9E0BeVagWpn4QwK08ryV1PPlH97
	1fohfe0S5iva3ADLcGEITTbyNng9qnrZJLXKLuKHpJiUlzjNktj25N4jeZNfguiJFfxfMfIf30j
	LKZeHU/EHmJxDSnk2eqmUXKb+xmaH0Go=
X-Received: by 2002:a05:651c:160e:b0:394:5b8:48a1 with SMTP id
 38308e7fff4ca-3998b7b3970mr12429711fa.7.1781892614179; Fri, 19 Jun 2026
 11:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
 <20260613-rneri-directed-therm-intr-v3-1-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-1-3a26d1e47fc8@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jun 2026 20:10:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jM2XhJZCg4BLPyKTdWVx79UL6cR9_oEYg9ezo5D8zL5w@mail.gmail.com>
X-Gm-Features: AVVi8Cd5fpI6omCM_pJmX54_JU2SQ7qDtzpBd3hU5grEKbwP5gbcarMvaV_9U0Y
Message-ID: <CAJZ5v0jM2XhJZCg4BLPyKTdWVx79UL6cR9_oEYg9ezo5D8zL5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] thermal: intel: Fix dangling resources on
 thermal_throttle_online() failure
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 12:07=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The function thermal_throttle_add_dev() may fail and abort a CPU hotplug
> online operation. Since the failure occurs within the online callback,
> thermal_throttle_online(), the CPU hotplug framework does not invoke the
> corresponding offline callback. As a result, the hardware and software
> resources set up during the failed operation are not torn down.
>
> Since only thermal_throttle_add_dev() can fail, call it before setting up
> the rest of the resources.
>
> Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of ther=
mal throttle")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes in v3:
>  * None
>
> Changes in v2:
>  * Introduced this patch.
> ---
>  drivers/thermal/intel/therm_throt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/=
therm_throt.c
> index 44fa4dd15dd1..45a8ef4a608b 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -529,8 +529,13 @@ static int thermal_throttle_online(unsigned int cpu)
>  {
>         struct thermal_state *state =3D &per_cpu(thermal_state, cpu);
>         struct device *dev =3D get_cpu_device(cpu);
> +       int err;
>         u32 l;
>
> +       err =3D thermal_throttle_add_dev(dev, cpu);
> +       if (err)
> +               return err;
> +
>         state->package_throttle.level =3D PACKAGE_LEVEL;
>         state->core_throttle.level =3D CORE_LEVEL;
>
> @@ -548,7 +553,7 @@ static int thermal_throttle_online(unsigned int cpu)
>         l =3D apic_read(APIC_LVTTHMR);
>         apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
>
> -       return thermal_throttle_add_dev(dev, cpu);
> +       return err;
>  }
>
>  static int thermal_throttle_offline(unsigned int cpu)
>
> --

Applied as a fix for 7.2-rc.

The rest of the series will be picked up as 7.3 material after 7.2-rc1 is o=
ut.

Thanks!
