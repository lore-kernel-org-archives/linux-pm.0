Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F533491D0
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344691; cv=pass; b=MFUufsfjoQqg0lIByNI50x9DvFquc1fxp2fUiDHApCDjR/ZtvV+TfrdhMvjAyeUOUHsptZA1FBcmtq+T33FUrh3sGNcOCX2M9ItyZS9uwiD5wZSv7gNVJu16u0d7hoPGPvnebCDkRxsfDygg5p9/Dzr8uOJ7VE3lmYZzoB7ZW7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344691; c=relaxed/simple;
	bh=6HDV9w6rUHdoh6/AommnBFvsyzCig67fdj4T+Ra/Nn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCFIVZ+8FFv2VUEIP1gWJXTozreYxrlCklckBKwYgE0/rsA1H0BMOO+aEXp+d4PAVB7adOP97Q8B2VjUKWRt0AXDKwO9LAgtEPFKYf1VDxDqs6pVLwfOc9IQM9WnE5R62qA0Sa7O36NOJnh6NDmZh4RFMIG5OuYn/laEsxLDoY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd1wEAYd; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd1wEAYd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aae4816912so53292085ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 06:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776344689; cv=none;
        d=google.com; s=arc-20240605;
        b=MLJobXqR1a6Fa5w+v5QIV9Ua8e0c+SZlucpdlXaWB94ah4hJ8V01DnBwFD6rbjM+W0
         u4d5uZuG+4u7XVb0MgPzfDHxowaVRe546PCMpPPIwk0bB+o9FJJM1+NmbeisC3VAtnuB
         gaE6noodEpPx8s0wPHRy4YdeG6ZD2QmM6Me7U7DcXAU5RNLm7GkW0U31KJQ+6Z/ij7Iy
         GsK6kxdw2si0BLGPhFL61CRDDvox/7lCQWrNy9A6SYt3wyrQ4O5wcxbOWK3dCwYa35WJ
         iu7zCo40ksSUq0d8OVIHdTp1vb+m1fDP4vSB8CqqDGDvxqrB6gorexGHQOtF9CrX95vQ
         1gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9keKW5p4++WsVuxHmBqHxADE1ZcTw3Q0sJGd/F983YY=;
        fh=bRK8AD9pYICKRlfyOSNTEkWKVTrDIy++f4Rn+GRDfGw=;
        b=ZsdvDdDvPKSErDwXBey2VXz6O/ttE42Z6sxlfycUWyFKBtZZZKmnFcZZNlGe8j3sUg
         Oz23K1q5aAB5g9ohCmFMixsAfsUPnuVK7xSwuZ2KyqAgPDDcHWpzWwd4QscRbau/hRXN
         gBDKnCAlBjsu0MXg5K/ptM1mDe/jmn+I6KbEdQqhl611OuOoId8Rk2+hCQfO+3SLxUN8
         klwAa/UBrqvvuIA9+nW0OI3bkDT0ZKqKSKiEyjC8hpem6qu4Wt2aJoes1tHRbQn43OiU
         Sv9WRyqvB2mjUomEgfdQgkeZFLoLJMmW+3Wf31cFZ3bByr+x+utorabFSRRkblPfj9/e
         2GVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776344689; x=1776949489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9keKW5p4++WsVuxHmBqHxADE1ZcTw3Q0sJGd/F983YY=;
        b=bd1wEAYdd9QW4IgkzGYbN5RK4s76QaDo/HSxQesz76995FuTZGGT8SN1FaAwb2RtAF
         8ly/nVhI5MNgKD4EkCWR1y9eBhhzb7SszO3qHQQZIGJzE2SI23NRayrZ/TrASyisw+WP
         kjBDDv5+EEc9M+H/aua78mSNxqfY8s17jAxxrH5uiDXjLBxeTg4FtPs99PZhTA3rHs+i
         E9D8No2RatbfUl0YOty5KQY8wlQYP52d0nIq93Ol2iyYcKHkQy/vpnJ9MagOy8POJnEv
         Rupv3lmvKzqVh25ouoBYBhWDtKfuSZ89oadSgGVjdcLaY3idAbgUjNy6P2tERXnfs5L8
         pNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344689; x=1776949489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9keKW5p4++WsVuxHmBqHxADE1ZcTw3Q0sJGd/F983YY=;
        b=Q9n/iLk+Q/awwZg2AfNABdZoXk5kZC4Yci5KF9SVHceJGcNJiboKJSiWHH3sa1+Gj+
         /suaajnIyQ6ivbRLCBfcp+qpYudHhmBwFa6l+n1qP9FomFkIVbLghHt1NjbKc4gkMY0h
         uGjM3QcVb2f8SEbiymJxUtxhh/6seM8iLgs0gQQX/jubJePmfQJqbx7K4ghRksM5SaYE
         +JGIJ4cFhZa302tGKAOIMu+Nc8IUIv3/E+0hs0LBnIIDDRBppVWKMNPWGkNxaw2l3Daz
         dlNPu1cQ6bcpD45H1vF87BGK4dTDVFLR/KzgWsuzDPFBig2xHOeTimIjDAsJECrtyRx2
         IaEQ==
X-Gm-Message-State: AOJu0YyInzXHSIfQrIrCmjhBCg6HXgORYA+vB8fLNqrLkGtpLRXf+dX4
	d7E0f8W03h4GoOfc/qEvlUK1Tqtq2kmE2kvNSmsjKnaLJXQlazfSTZkPGhE9pZki9LwCPfnnIpH
	Elww/kynFSYm4gJfG6jur5P9wSh5yzGA=
X-Gm-Gg: AeBDietUtR+7rZ2b/7xCZS8YtobxWmtIzHIIb79XiQXCtmlO+NrqAJuNz3RLjC78w4b
	ISgC9mKH7zJW1o8JqAZwOO1rhGXgsQAPn8wG1JIeTUYPPJN0DHjOnYbLmwgdBM6Dwu+ihqoW102
	bEeYMa/FmDaLEXp5WTWhrpoIOm2qmqcHdnKxNkfnbzJhob6KTJAz0r//SYkr8xZUDDtWoX1ay2i
	uyKKeCXu8neSatPfZYnlVD/a1+wFFp4jKdg4b98JJEeDUynQU3y8oTqjDU7t3NXuFrpHv0ONXFK
	rl+pM99cM6IxLMizsvf04QYnS1eXxkykQa2aSxsxqQGe57q5CGwFphtB34P43jMBOtf4oCw7xTg
	=
X-Received: by 2002:a17:902:d507:b0:2b4:5cd0:b6c3 with SMTP id
 d9443c01a7336-2b45cd0bb63mr212259795ad.29.1776344688850; Thu, 16 Apr 2026
 06:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-imx-v2-0-aeacff9e72b2@gmail.com> <20260415-imx-v2-1-aeacff9e72b2@gmail.com>
In-Reply-To: <20260415-imx-v2-1-aeacff9e72b2@gmail.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 21:04:38 +0800
X-Gm-Features: AQROBzAHfswAILDPJrZ03lSCXQzT-HPAwyhO5aKUzw0OdIQTV7XQ9Ww0qLogIkk
Message-ID: <CAN4SLj3rH1q-jd6ccdo2qVNuNUoqfpsiS0KXJ3b=b7m_bh2QBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx: Fix thermal zone leak on
 probe error path
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 9:10=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wrote:
>
> If pm_runtime_resume_and_get() fails after the thermal zone has been
> registered, the probe error path cleans up runtime PM but skips
> thermal_zone_device_unregister(), leaking the thermal zone device.
>
> Switch to use devm_thermal_of_zone_register() to fix the problem.
>
> Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/thermal/imx_thermal.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.=
c
> index 38c993d1bcb3..3729c3eac748 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -216,6 +216,20 @@ struct imx_thermal_data {
>         const char *temp_grade;
>  };
>
> +static int imx_thermal_sync_zone_trip(struct thermal_trip *trip, void *a=
rg)
> +{
> +       struct imx_thermal_data *data =3D arg;
> +       int temp;
> +
> +       if (trip->type !=3D THERMAL_TRIP_PASSIVE && trip->type !=3D THERM=
AL_TRIP_CRITICAL)
> +               return 0;
> +
> +       temp =3D trips[trip->type].temperature;
> +       thermal_zone_set_trip_temp(data->tz, trip, temp);
> +
> +       return 0;
> +}
> +
>  static void imx_set_panic_temp(struct imx_thermal_data *data,
>                                int panic_temp)
>  {
> @@ -679,13 +693,8 @@ static int imx_thermal_probe(struct platform_device =
*pdev)
>                 goto legacy_cleanup;
>         }
>
> -       data->tz =3D thermal_zone_device_register_with_trips("imx_thermal=
_zone",
> -                                                          trips,
> -                                                          ARRAY_SIZE(tri=
ps),
> -                                                          data,
> -                                                          &imx_tz_ops, N=
ULL,
> -                                                          IMX_PASSIVE_DE=
LAY,
> -                                                          IMX_POLLING_DE=
LAY);
> +       data->irq_enabled =3D true;
> +       data->tz =3D devm_thermal_of_zone_register(dev, 0, data, &imx_tz_=
ops);
>         if (IS_ERR(data->tz)) {
>                 ret =3D PTR_ERR(data->tz);
>                 dev_err(dev, "failed to register thermal zone device %d\n=
",
> @@ -693,6 +702,8 @@ static int imx_thermal_probe(struct platform_device *=
pdev)
>                 goto clk_disable;
>         }
>
> +       thermal_zone_for_each_trip(data->tz, imx_thermal_sync_zone_trip, =
data);
> +
>         dev_info(dev, "%s CPU temperature grade - max:%dC"
>                  " critical:%dC passive:%dC\n", data->temp_grade,
>                  data->temp_max / 1000, trips[IMX_TRIP_CRITICAL].temperat=
ure / 1000,
> @@ -724,25 +735,18 @@ static int imx_thermal_probe(struct platform_device=
 *pdev)
>         if (ret < 0)
>                 goto disable_runtime_pm;
>
> -       data->irq_enabled =3D true;
> -       ret =3D thermal_zone_device_enable(data->tz);
> -       if (ret)
> -               goto thermal_zone_unregister;
> -
>         ret =3D devm_request_threaded_irq(dev, data->irq,
>                         imx_thermal_alarm_irq, imx_thermal_alarm_irq_thre=
ad,
>                         0, "imx_thermal", data);
>         if (ret < 0) {
>                 dev_err(dev, "failed to request alarm irq: %d\n", ret);
> -               goto thermal_zone_unregister;
> +               goto disable_runtime_pm;
>         }
>
>         pm_runtime_put(data->dev);
>
>         return 0;
>
> -thermal_zone_unregister:
> -       thermal_zone_device_unregister(data->tz);
>  disable_runtime_pm:
>         pm_runtime_put_noidle(data->dev);
>         pm_runtime_disable(data->dev);
> @@ -761,7 +765,6 @@ static void imx_thermal_remove(struct platform_device=
 *pdev)
>         pm_runtime_put_noidle(data->dev);
>         pm_runtime_disable(data->dev);
>
> -       thermal_zone_device_unregister(data->tz);
>         imx_thermal_unregister_legacy_cooling(data);
>  }
>
>
> --
> 2.43.0
>

Hi all,
This patch has a problem, I will fix it and send v3.

Best regards,
Felix
