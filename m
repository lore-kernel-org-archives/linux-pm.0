Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E434B1A7
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579059; cv=none; b=T12XQxC6kplx6jCUMW5IRxJHG0p6YYtcgAej3ejC1CJDgpZNVAk9KTEFBsh/whF3HtHFtitw3BJJ41tc/J/BVfEBSVx+wRC3D92k77LDoyiY4vCT2vSwwkubc7N+mpVTmc2RxPPbmjH8B9UTuj9KF+rq+hfHfjDW0WVdA/QoLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579059; c=relaxed/simple;
	bh=K7UUnm7+0T1FluJsMAj98tyxebsG7OvNNIYLUVmk6U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ7B+mIqXyGjKYqOIOjltCiuDfEzITA3mvIOLDIrPl2gieuV0+f5n0pd4U9y0hTsn6VltKww4NQgRT3nbECOPqikrGL8Qgjm30tAiPaoB2Eha88ZrHJCzknrUz7PfySwRpcYmGprSkU13Cl2n6GwwPf7RpiApwg0jhCgHYsEDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNiqCZP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNiqCZP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6A2C2BCFA
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777579058;
	bh=K7UUnm7+0T1FluJsMAj98tyxebsG7OvNNIYLUVmk6U8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eNiqCZP6K15SUCDKxqrrC3nMc6dHqpDr47XJOS0ufEyfx8v8tevv3bRSba2yjtOp4
	 x1WsmBXBZNDYOa6Vhq2WjQKmjLV5+AvKl+pyr4j9tAVzDHVJOikbCIh+71fua8kue7
	 wA4R/3g1+anlirVmDbElfr4KIntS6bolFIMcfj/gcpaG4IpwN2m8B+i4zc1NjKRjhZ
	 BEhFNf/H1r/DjrxD8n6yBaVLusuMVhwaEqjpV5vLkHEBYq0hz0/VYwKVFNfG7urRkH
	 vonGMlTd5DF4MOAKxvEs+ouiqpc7CfPLOpe2W1lXh/T5x2qajJ33M9hyvNRXi4tG8V
	 8CJl7v5riswtA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so1216002e87.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 12:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9PFwzMwWuYAGNp2R2oaosCacf3583nz+/VjSljgInmI/4IBpSfRA3JDxWEiFGHMqJ2p5quJg7cMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9u7+F1YKbz7Fz3Z2Opzc5Se+m6/VQvch5JGxBKhd+BPrBb2MM
	AmXOXCcWqCNkqLa4PiliDMMLh9gacmHffLPblrEGM74I+UKA//Ogow3vwLJpsx16c7tG/8gZyYE
	W+tBLKJf1D3Np/QQMMpWR7kShhzbk5qA=
X-Received: by 2002:a05:6512:3d02:b0:5a4:7ec:145a with SMTP id
 2adb3069b0e04-5a85ae832fbmr37218e87.10.1777579056797; Thu, 30 Apr 2026
 12:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com> <20260429161430.3802970-2-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260429161430.3802970-2-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 21:57:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gYRuEBhdfeZ-kcwFPWxrRVFgA7+mBoTMnfeRk=8MBsBA@mail.gmail.com>
X-Gm-Features: AVHnY4Jed_Zripca-VuCTXVAOcFTR8TI5HZ5ISsU6Twu3YasOnvmA_Ii-p9O6sI
Message-ID: <CAJZ5v0gYRuEBhdfeZ-kcwFPWxrRVFgA7+mBoTMnfeRk=8MBsBA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] thermal/core: Use devm_add_action_or_reset()
 when registering a cooling device
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
> Use devm_add_action_or_reset() which does the replaced code. It
> results in a simpler and more concise code.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/thermal/thermal_core.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2f4e2dc46b8f..664a4cc95199 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1187,10 +1187,11 @@ thermal_of_cooling_device_register(struct device_=
node *np,
>  }
>  EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
>
> -static void thermal_cooling_device_release(struct device *dev, void *res=
)
> +static void thermal_cooling_device_release(void *data)
>  {
> -       thermal_cooling_device_unregister(
> -                               *(struct thermal_cooling_device **)res);
> +       struct thermal_cooling_device *cdev =3D data;
> +
> +       thermal_cooling_device_unregister(cdev);
>  }
>
>  /**
> @@ -1216,23 +1217,18 @@ devm_thermal_of_cooling_device_register(struct de=
vice *dev,
>                                 const char *type, void *devdata,
>                                 const struct thermal_cooling_device_ops *=
ops)
>  {
> -       struct thermal_cooling_device **ptr, *tcd;
> +       struct thermal_cooling_device *cdev;
> +       int ret;
>
> -       ptr =3D devres_alloc(thermal_cooling_device_release, sizeof(*ptr)=
,
> -                          GFP_KERNEL);
> -       if (!ptr)
> -               return ERR_PTR(-ENOMEM);
> +       cdev =3D __thermal_cooling_device_register(np, type, devdata, ops=
);
> +       if (IS_ERR(cdev))
> +               return cdev;
>
> -       tcd =3D __thermal_cooling_device_register(np, type, devdata, ops)=
;
> -       if (IS_ERR(tcd)) {
> -               devres_free(ptr);
> -               return tcd;
> -       }
> -
> -       *ptr =3D tcd;
> -       devres_add(dev, ptr);
> +       ret =3D devm_add_action_or_reset(dev, thermal_cooling_device_rele=
ase, cdev);
> +       if (ret)
> +               return ERR_PTR(ret);
>
> -       return tcd;
> +       return cdev;
>  }
>  EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
>
> --
> 2.43.0
>
