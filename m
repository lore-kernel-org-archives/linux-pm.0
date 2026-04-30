Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210F36215A
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579981; cv=none; b=QiM9F0Tl8rxKhE7T3P9FGw3VlYp7hHMvM+a/oA/aECV8D1PLNXEhaUqBzM0PVJKh08X4ajuAlW3lifDehiS5Wx2vCHDpMPOdjh5LfO6naKm6z9eHl3SCEoDnpRNPbl3s7xXLdH5e4vAcx8p/Jb7666OIZYmmRQCLv6XtR2QqMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579981; c=relaxed/simple;
	bh=s2Rjxi8LVUJPlEng92a+TWyQRzSjgHW68DZQFnTrL68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZatePknudGdVSpBeV2NAakTZeIlBxxGG1Zn9m45Wt+CuMI6r5C7shHM0erX1DdhXrGjn6UdXAng5+w1O4z38qjezAbO8W17qkH6UTSTyRBudZ1I+wMDy1IMJ1qzPXBzrnUQCYRGmcaNpN6jKg2ARHrqL9x317vVy4+o/hcBZ2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMIzFJwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMIzFJwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94895C2BCFF
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 20:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777579980;
	bh=s2Rjxi8LVUJPlEng92a+TWyQRzSjgHW68DZQFnTrL68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pMIzFJwZHgfKlrvscQmnxg0SV4dMnDjfIEBerbFVBe9InIHrnDFLVQIO8lud9GXVr
	 YF/wJIIsNi3g8cg3t0uWwPiQFLs8F6n0eTsR2eZyt9axRyuqckcOEReA1D2gx5k8pz
	 SRrZeEAwJVS1TOlGLjL0RpsKkFXUmUgURIU6AOBiTPJB8VCXMoQJSXMKYErnvLREUT
	 7mDQQVxuC5pSVinboGw4WJt76SE81xuzA2Vw/cfORzaboIC0VfSTm0MKeUtivBEqsO
	 K5wBFB9JEjU337PtoywfdRVTxX2EfdqFvjnvWnr7Yp/tVVIk+21bb0A7b5UA4SEs2U
	 U2M3A8XbLZXCg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c500750dso2365711e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 13:13:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9J7b0LvdH1rDiWGLAKIE4ctnSYF/dbeYmMEH1+wN2UyHBVaCwHLgeuYGcUsAqbuuQXnCs7r0wKFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5D9G81uaC7zJl7KBbwb5UlU/kOvlHT4ka1zK6pOOeSD2VnjH
	oOMGONUISXpqziFibsia2oQl68UcrIytOG55ePxmnE2KEAXG3LM9Q2Fg2un41ryTjipqfIMxYnP
	6dRaNJ/dRorAjA4U+8gNxSb3Q28RE7Kg=
X-Received: by 2002:a05:6512:401f:b0:5a3:ff48:f7f1 with SMTP id
 2adb3069b0e04-5a8522d5acbmr1558162e87.25.1777579978397; Thu, 30 Apr 2026
 13:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com> <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 22:12:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
X-Gm-Features: AVHnY4JGeLIzOdLhVQNMQSJloBEfwK1V6HTl-Ej2u7OCtGx5qNJDgAQIs24HFH8
Message-ID: <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in
 the OF code file
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, 
	gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 6:14=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> The node pointer being assigned to the cooling device structure is an
> action done by the thermal OF only and does not belong to the core
> framework code. Move the node pointer assignation in the thermal OF
> code. Consequently, the devm_thermal_of_cooling_device_register() can
> call its non-devm version resulting in a more intuitive design of the
> API.

I wouldn't make this change.

It adds overhead to the OF case that's not really necessary and
complicates the code just to avoid using struct device_node pointers
in the core and I'm not really convinced that passing a function
pointer to __thermal_cooling_device_register() is so much better.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/thermal/thermal_core.c | 51 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 5c954bcae4a4..7867e6bc0a6c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1040,26 +1040,11 @@ static void thermal_cooling_device_init_complete(=
struct thermal_cooling_device *
>                 thermal_zone_cdev_bind(tz, cdev);
>  }
>
> -/**
> - * __thermal_cooling_device_register() - register a new thermal cooling =
device
> - * @np:                a pointer to a device tree node.
> - * @type:      the thermal cooling device type.
> - * @devdata:   device private data.
> - * @ops:       standard thermal cooling devices callbacks.
> - *
> - * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> - * to all the thermal zone devices registered at the same time.
> - * It also gives the opportunity to link the cooling device to a device =
tree
> - * node, so that it can be bound to a thermal zone created out of device=
 tree.
> - *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> - */
>  static struct thermal_cooling_device *
> -__thermal_cooling_device_register(struct device_node *np,
> -                                 const char *type, void *devdata,
> -                                 const struct thermal_cooling_device_ops=
 *ops)
> +__thermal_cooling_device_register(const char *type, void *devdata,
> +                                 const struct thermal_cooling_device_ops=
 *ops,
> +                                 void (*initcb)(struct thermal_cooling_d=
evice *,
> +                                                void *), void *data)
>  {
>         struct thermal_cooling_device *cdev;
>         unsigned long current_state;
> @@ -1089,7 +1074,6 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>
>         mutex_init(&cdev->lock);
>         INIT_LIST_HEAD(&cdev->thermal_instances);
> -       cdev->np =3D np;
>         cdev->ops =3D ops;
>         cdev->updated =3D false;
>         cdev->device.class =3D &thermal_class;
> @@ -1127,6 +1111,9 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>         if (current_state <=3D cdev->max_state)
>                 thermal_debug_cdev_add(cdev, current_state);
>
> +       if (initcb)
> +               initcb(cdev, data);
> +
>         thermal_cooling_device_init_complete(cdev);
>
>         return cdev;
> @@ -1146,7 +1133,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
>   * thermal_cooling_device_register() - register a new thermal cooling de=
vice
>   * @type:      the thermal cooling device type.
>   * @devdata:   device private data.
> - * @ops:               standard thermal cooling devices callbacks.
> + * @ops:       standard thermal cooling devices callbacks.
>   *
>   * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
>   * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> @@ -1159,10 +1146,17 @@ struct thermal_cooling_device *
>  thermal_cooling_device_register(const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *=
ops)
>  {
> -       return __thermal_cooling_device_register(NULL, type, devdata, ops=
);
> +       return __thermal_cooling_device_register(type, devdata, ops, NULL=
, NULL);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>
> +static void thermal_of_cooling_device_init(struct thermal_cooling_device=
 *cdev, void *data)
> +{
> +       struct device_node *np =3D data;
> +
> +       cdev->np =3D np;
> +}
> +
>  /**
>   * thermal_of_cooling_device_register() - register an OF thermal cooling=
 device
>   * @np:                a pointer to a device tree node.
> @@ -1183,7 +1177,14 @@ thermal_of_cooling_device_register(struct device_n=
ode *np,
>                                    const char *type, void *devdata,
>                                    const struct thermal_cooling_device_op=
s *ops)
>  {
> -       return __thermal_cooling_device_register(np, type, devdata, ops);
> +       struct thermal_cooling_device *cdev;
> +
> +       cdev =3D __thermal_cooling_device_register(type, devdata, ops,
> +                                                thermal_of_cooling_devic=
e_init, np);
> +       if (IS_ERR(cdev))
> +               return cdev;
> +
> +       return cdev;
>  }
>  EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>
> @@ -1217,7 +1218,7 @@ devm_thermal_cooling_device_register(struct device =
*dev,
>         struct thermal_cooling_device *cdev;
>         int ret;
>
> -       cdev =3D __thermal_cooling_device_register(NULL, type, devdata, o=
ps);
> +       cdev =3D thermal_cooling_device_register(type, devdata, ops);
>         if (IS_ERR(cdev))
>                 return cdev;
>
> @@ -1255,7 +1256,7 @@ devm_thermal_of_cooling_device_register(struct devi=
ce *dev,
>         struct thermal_cooling_device *cdev;
>         int ret;
>
> -       cdev =3D __thermal_cooling_device_register(np, type, devdata, ops=
);
> +       cdev =3D thermal_of_cooling_device_register(np, type, devdata, op=
s);
>         if (IS_ERR(cdev))
>                 return cdev;
>
> --
> 2.43.0
>
