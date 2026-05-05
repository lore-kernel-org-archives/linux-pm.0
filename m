Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858A3C6A2B
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990709; cv=none; b=TxGKubQ7csHkbbGhWTSyhdqjkAWcQ8MBKaF6Ts9eo4a1Ig5PAv7cIa8d1zdr6BSt5GXQrGPdtJG5f75osjGQhQiymco4WFZfZW6tUMsqHm2MO24GoqPcZWdFRqGCh7HeCAASfAOFPvRTvMfZ8ZAHbK7s0yw4c5XB4jbrW1sOmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990709; c=relaxed/simple;
	bh=fs3WyS86P1cobei063vHZNvMniQJ2L/6DB9bU5unqVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfZ+wEaASpFfsLaMxi6Y1zWXOSv+NgouS0rRvw1D9PcGJdRKmjUuJdAB9B86dNJVa9EFdeju5UpzDQZOcUQ9+qdMJ1O6Tg7K2apzThV4T0qVG6BBpKgkymENDyzQkqJCyeSx6LFDUmUMgFNleHOSNkxa+7V/kTYE+6baDElbgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfHraLEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfHraLEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD96BC2BCB4
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777990708;
	bh=fs3WyS86P1cobei063vHZNvMniQJ2L/6DB9bU5unqVg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=MfHraLEMUeP5/DREGDITghSU061dKucJWDUFrnk8jCXYIKx5Dg4x54wkgQjgv4hBX
	 pvOqXXodq7LYNdorCxk5Tj2SMYbCtYOc6IKIOuLrarwJ2A3eAgbnbcila2Ttyz4hoY
	 IW7exvNyHOY0xwekMFjow46Fcr0jW4kcz4PRC9xMGbbdN7A5TCENuk4/uusLUtQN9k
	 Edm2gqrpAknf/RXi7ygvs7ctkZwVWdSfTtwY2fmtibC/aatUj9Z4I8ZaOOtvx3JoNT
	 KVe+1PIN/RstreoU/fA5oM/YVJMstXbeNSVmiHMfJBvOQfMdfPr+gSM/lTIvKoBzjp
	 6p4rFjdvMTTMg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e7d983f50so60956051fa.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:18:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8U4Omdpwp22Y7h4qv8HPn7xq78IrMtFbiu9kxQzlPlezxFh9ft6ZSf3vSgwwUsVgVA1hhXCwAwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMk1NKty50+0EZgG01bImXomi4W/SPzZbY6iimFKeZlNo1QXY
	R8I5i/JcEqHk//snwa7j41PAl1l1gkD0mDOdfcXNX38R9mHe+Wf+9Dax10YHTxIYlksp2gXT9TH
	LB9qb/L4GJIDjPS0iCd3uqpor6avEtg4=
X-Received: by 2002:a05:651c:550:b0:393:9cd4:ea5 with SMTP id
 38308e7fff4ca-3939cd4108bmr40207251fa.13.1777990707140; Tue, 05 May 2026
 07:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050245.646078-1-iuncuim@gmail.com> <20260504050245.646078-4-iuncuim@gmail.com>
In-Reply-To: <20260504050245.646078-4-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 May 2026 22:18:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v674Ash+eiN42EkiCCsjN1Y7+iRmZR+Bt37e+EtnfOE0tg@mail.gmail.com>
X-Gm-Features: AVHnY4Iw15ROowKdMFkqI-ON5u3aYZ0szmXhIXedM9DZoTYlirjw1ecxwjFWiYo
Message-ID: <CAGb2v674Ash+eiN42EkiCCsjN1Y7+iRmZR+Bt37e+EtnfOE0tg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] thermal/drivers/sun8i: get calibration data from
 two nvmem cells
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 1:03=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> The A523 processor has calibration data in two nvmem cell. To be able to
> add support, the ability to add data from two cells into one array must b=
e
> added.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 77 ++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index df0c26970..c4aaff8f7 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -301,43 +301,70 @@ static int sun50i_h6_ths_calibrate(struct ths_devic=
e *tmdev,
>
>  static int sun8i_ths_calibrate(struct ths_device *tmdev)
>  {
> -       struct nvmem_cell *calcell;
> +       struct nvmem_cell *calcell =3D NULL;
>         struct device *dev =3D tmdev->dev;
> -       u16 *caldata;
> -       size_t callen;
> +       struct device_node *np =3D dev_of_node(dev);
> +       struct property *prop;
> +       const char *cellname;
> +       u8 *caldata =3D NULL;
> +       size_t callen =3D 0;
>         int ret =3D 0;
>
> -       calcell =3D nvmem_cell_get(dev, "calibration");
> -       if (IS_ERR(calcell)) {
> -               if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -               /*
> -                * Even if the external calibration data stored in sid is
> -                * not accessible, the THS hardware can still work, altho=
ugh
> -                * the data won't be so accurate.
> -                *
> -                * The default value of calibration register is 0x800 for
> -                * every sensor, and the calibration value is usually 0x7=
xx
> -                * or 0x8xx, so they won't be away from the default value
> -                * for a lot.
> -                *
> -                * So here we do not return error if the calibration data=
 is
> -                * not available, except the probe needs deferring.
> -                */
> -               goto out;
> +       of_property_for_each_string(np, "nvmem-cell-names", prop, cellnam=
e) {
> +               size_t len;
> +               u8 *caldatapart;
> +
> +               calcell =3D of_nvmem_cell_get(np, cellname);
> +               if (IS_ERR(calcell)) {
> +                       if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +                       /*
> +                        * Even if the external calibration data stored i=
n sid is
> +                        * not accessible, the THS hardware can still wor=
k, although
> +                        * the data won't be so accurate.
> +                        *
> +                        * The default value of calibration register is 0=
x800 for
> +                        * every sensor, and the calibration value is usu=
ally 0x7xx
> +                        * or 0x8xx, so they won't be away from the defau=
lt value
> +                        * for a lot.
> +                        *
> +                        * So here we do not return error if the calibrat=
ion data is
> +                        * not available, except the probe needs deferrin=
g.
> +                        */
> +                       goto out;
> +               }
> +
> +               caldatapart =3D nvmem_cell_read(calcell, &len);
> +               nvmem_cell_put(calcell);
> +               calcell =3D NULL;
> +               if (IS_ERR(caldatapart)) {
> +                       ret =3D PTR_ERR(caldatapart);
> +                       goto out;
> +               }
> +
> +               caldata =3D devm_krealloc(dev, caldata, callen + len, GFP=
_KERNEL);
> +               if (!caldata) {
> +                       kfree(caldatapart);
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +
> +               memcpy(caldata + callen, caldatapart, len);
> +               callen +=3D len;
> +               kfree(caldatapart);
>         }
>
> -       caldata =3D nvmem_cell_read(calcell, &callen);

>         if (IS_ERR(caldata)) {
>                 ret =3D PTR_ERR(caldata);
>                 goto out;
>         }

This will never happen now.

>
> -       tmdev->chip->calibrate(tmdev, caldata, callen);
> +       tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
> -       kfree(caldata);
> +       devm_kfree(dev, caldata);
> +       caldata =3D NULL;
>  out:
> -       if (!IS_ERR(calcell))
> +       if (calcell && !IS_ERR(calcell))

          if (!IS_ERR_OR_NULL(calcell))

>                 nvmem_cell_put(calcell);
>         return ret;
>  }
> --
> 2.54.0
>
>
