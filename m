Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302923F23BB
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897859; cv=none; b=aVXXXfQKQlOXiqB51sGEW6bNG/hzmDz9Hirzig9kASe+A7zgweAdF0rHeU+qY3U8q5jD0tGMRXYbF/jNZebXRCLuJHSz/GYSo2M4zR1BS+RlJ+MFcA6+MfnKt9ohL7y7dwf9dS25JjRieWLr3M4CHFDwe17y5bnQsw+DSZsYjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897859; c=relaxed/simple;
	bh=fSQDFoD2QDiHdD9sozjPUbTo2K0Q/Jp9hC3TXlCvVoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On3AsJiNAH9VAiidi7o5LMvd0e/qYpK2NmqtpP+2JOgMD3VbXPsSNY0bY3yx8aAZ5zJEDj+d9Je910uf6zg/8pNrHLvXiRBlqQYXa6soJ+4UugwesZxRpzp8cAv0OtytZ0hiRkDDtWFqhR5D66IoRvKivuqdDocPYb+XkFgFQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq2xHSG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq2xHSG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58781F00898
	for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 09:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897855;
	bh=SjYJbPqlOSw/5GKAWiHuamoPBcbEI2Y/L8HWn+XiZW0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=jq2xHSG6KxF751GPakxt7ulzGYJ+uhk6NuIEjm3nqg9F+qqcxgZCxxlZW/8DHYSNc
	 xq5DMDZuf2CmPKJyiV4NZd4UVZZBaUI1uTbJe0asfGSvLdr454bEctYE7yguxNGh5u
	 H4MT1PqX3yi0nrvtq7P/L6bnlJFQZwzfGkAaXxTaKcKnWs1dpx0d41H8Ruc1J3u6V2
	 GhH1Z+LkTg/ZJBYIz+HQHf4tb4xWs43jOf+TuE/xMtytSUa1qllafst6r5o1JRSn/b
	 MW8uv7+X6LMiI6+iMqvI+0MoWF7FLag46rR2Be77sUp2J5KhBATQ4p7D3KSFMp/DVn
	 FdBYWcgGGWpyw==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49a10ee5aso15949641fa.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 02:50:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByt5tGgACOHLYCfsRHAhkZ1ce/v+d/wm6tWAgBvh7qNLWgHAeZv4KceMUTKPanMoFFeuZathi4mYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kQLfQxoVjOMvEWtJYS3HchqLunf8ok607TjZ/SREoUHDjuahYF
	iBOYVKcOLsfCJHKkiXCIbp6/WuVBQkspKKZwxykwNxHaT42gmnDUPU0gr1ltpMrT2VfuLalnfGU
	14CrZfyWXbGxYEFSM5+KsOsgtcZJbmsA=
X-Received: by 2002:a05:651c:1543:b0:3a3:7741:b43c with SMTP id
 38308e7fff4ca-3a5fbf06931mr15872001fa.7.1789897854214; Sun, 20 Sep 2026
 02:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145527.18148-1-iuncuim@gmail.com> <20260913145527.18148-4-iuncuim@gmail.com>
In-Reply-To: <20260913145527.18148-4-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 20 Sep 2026 17:50:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67jmSPeKD-kr2MsASJy7v5Mqw+FBOvX9ziE__-35W6EJA@mail.gmail.com>
X-Gm-Features: AcwNN1XesilYUDb2NviAIFfSkaFxFlN66gg2pfogUxTJxiboh6rzWf-zN1gPLSI
Message-ID: <CAGb2v67jmSPeKD-kr2MsASJy7v5Mqw+FBOvX9ziE__-35W6EJA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] thermal/drivers/sun8i: get calibration data from
 two nvmem cells
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	=?UTF-8?Q?Juan_Manuel_L=C3=B3pez_Carrillo?= <juanmanuellopezcarrillo@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:56=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail=
.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The A523 processor has calibration data in two nvmem cells. To be able to
> add support, the ability to add data from two cells into one array must b=
e
> added.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

I'd say that Sashiko's comment on "leaking" memory until the device is
removed is not too much of a concern. Sure it could be released sooner
since it's not used, but it's not a lot of memory.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/thermal/sun8i_thermal.c | 81 +++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 1412bce63..360654880 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -300,43 +300,68 @@ static int sun50i_h6_ths_calibrate(struct ths_devic=
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
> -       if (IS_ERR(caldata)) {
> -               ret =3D PTR_ERR(caldata);
> +       if (!caldata)
>                 goto out;
> -       }
>
> -       tmdev->chip->calibrate(tmdev, caldata, callen);
> +       tmdev->chip->calibrate(tmdev, (u16 *)caldata, callen);
>
> -       kfree(caldata);
> +       devm_kfree(dev, caldata);
> +       caldata =3D NULL;
>  out:
> -       if (!IS_ERR(calcell))
> +       if (!IS_ERR_OR_NULL(calcell))
>                 nvmem_cell_put(calcell);
>         return ret;
>  }
> --
> 2.55.0
>
