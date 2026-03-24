Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB93A3E6A
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376802; cv=none; b=ZiBgSWOol0HvpgNdik/cU+l65GwGK3fj3GIihToQLVfEfPvH4rgLHxMUeAvWiAxUYrqGeifdMFsPFvlX0Bb1Fk4Thd+Yc1z6IJTQy0j783Ca8+1CGYTUZmPE0RuKZt3RbnkxibOVOzYwFOM3PRHERPgr1RSHj1mlQSvgYIAkEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376802; c=relaxed/simple;
	bh=GGfOKD68lU4mO+i2u+k2K6Xe8E5Qh/5WTgVtHzuV028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paixSK5u6WZCfv++JL8mUAOHe54CjpS9wr1J/LU9QErRRwwEhOgNwxx6fPYkm6pU1hYqWP6dVS/2ZzEP0dEik2NEng0XeCdyj6yteKF3qPD2GwXY589eR5HShklb4ZIbdzyMaAP+sdAT9yIAWTiJc20VEQyZ6Tqx0uuWlQrR6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfg+JLpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfg+JLpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE2C2BCB6
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774376801;
	bh=GGfOKD68lU4mO+i2u+k2K6Xe8E5Qh/5WTgVtHzuV028=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cfg+JLpxEk+H5ramG9hxsn7Th0tre4XE69ltgh+19ghxUgDdIZmwGjYxmQYG2PBw0
	 +uEnpme9thyY+NIart74eLizikE9pbj0uDlJWd42xEcQQ2Ev+1xuC40Fnb7JekiaDV
	 /3XFrA/5t8yFZ9120TifIZJ3WdiJ9lfz1ngZc4RNX0XSDqYV5aXyAT2s54ZalGsl5B
	 gRwY1m1ubG3UID+70z+zKsLINJcB4s+jkJe3Oo9DfiVbQKp6iNHMYluejnu3HEn0Vs
	 s6LP5H0atFBrASMWgKZQeBe52iqTRdabzodbipyk0yENYVqYR/hpimTqalqyI8JlSi
	 wMJLVzarG8lew==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-409de4132b5so2434555fac.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:26:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCOfxdK2ol7BVdZI8wKek+K8eQJNgm4EMPUM2cDii9LrP/KpiTanHscNOS6y5HtuzA5fX6KSqhxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUr0uOakdqtFUP5Tn5c+qUz7FBxw/Mxo9vRYAvCk9/i0hyQa/
	kZZc2OMp9N7XsUEogsMSThXHi8Nysp01E9QQoly8LOMzoAtAiYeEyG8Do8/CbDet2myKqVU8b2w
	UoO0gpm9ufslKocLL7tngRZdLybLK39E=
X-Received: by 2002:a05:6820:4dc2:b0:67d:eeb3:a2dc with SMTP id
 006d021491bc7-67dff46c33cmr473357eaf.30.1774376800859; Tue, 24 Mar 2026
 11:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324172346.3317145-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260324172346.3317145-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 19:26:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h7HJqyQeahBv2eyMnhgbKk2X4zvwjpkrGdUhGBwVPueQ@mail.gmail.com>
X-Gm-Features: AaiRm51AofyFCtfcyMJYXZx_-MoCwlvouvVBHdEPvFPgfbuTn6HsAYLZFEFBHdM
Message-ID: <CAJZ5v0h7HJqyQeahBv2eyMnhgbKk2X4zvwjpkrGdUhGBwVPueQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Power Slider: Set offset only
 for balanced mode
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Erin Park <erin.park@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:23=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The slider offset can be set via debugfs for balanced mode. The offset
> should be only applicable in balanced mode. For other modes, it should
> be set 0 when writing to MMIO offset,
>
> Fixes: 8306bcaba06d ("thermal: intel: int340x: Add module parameter to ch=
ange slider offset")
> Tested-by: Erin Park <erin.park@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org # v6.18+
> ---
>  .../intel/int340x_thermal/processor_thermal_soc_slider.c  | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 49ff3bae7271..91f291627132 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -176,15 +176,21 @@ static inline void write_soc_slider(struct proc_the=
rmal_device *proc_priv, u64 v
>
>  static void set_soc_power_profile(struct proc_thermal_device *proc_priv,=
 int slider)
>  {
> +       u8 offset;
>         u64 val;
>
>         val =3D read_soc_slider(proc_priv);
>         val &=3D ~SLIDER_MASK;
>         val |=3D FIELD_PREP(SLIDER_MASK, slider) | BIT(SLIDER_ENABLE_BIT)=
;
>
> +       if (slider =3D=3D SOC_SLIDER_VALUE_MINIMUM || slider =3D=3D SOC_S=
LIDER_VALUE_MAXIMUM)
> +               offset =3D 0;
> +       else
> +               offset =3D slider_offset;
> +
>         /* Set the slider offset from module params */
>         val &=3D ~SLIDER_OFFSET_MASK;
> -       val |=3D FIELD_PREP(SLIDER_OFFSET_MASK, slider_offset);
> +       val |=3D FIELD_PREP(SLIDER_OFFSET_MASK, offset);
>
>         write_soc_slider(proc_priv, val);
>  }
> --

Applied as 7.0-rc material, thanks!
