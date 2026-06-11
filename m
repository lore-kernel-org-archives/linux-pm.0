Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC4395AD2
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194459; cv=pass; b=Wj5aJMl4+6fOl3DBgmKZY6Da48S/wEXY4hn4BIZFwx3G8lhqBE0TsxmR1kOGooPo/8zH0Db5G6E3tlUt5Bdz/mVgKYaujeahiDJ7UVFhZlfJ/Pp2FYKhJg+vK878W4F7XgD6OU4HEgv8NJwSj92HEcwAxbhxBBSmZtJQLvP+U/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194459; c=relaxed/simple;
	bh=bM7fgF89Mfg55QAbv7Np1pn0Ifafuy7Q5O6SGbzZY7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTKHMRTg95EiiJ41ipo0g3b/tmtWJqzV2xCXTaT/EiTYs53dU4L6+c+xiGXiT59iAxHlusZvUjMNYcbFDKthw9Utc/IdprXDu6R/xmcutPHqXtuzjFycafgcYt3hnClIOv1YAcewJJO2dVyluz46rsmpWcawd9lV/BgCf2aW8rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csrYIUTU; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csrYIUTU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so30435a12.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 09:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194457; cv=none;
        d=google.com; s=arc-20240605;
        b=Gr0P45ZMzRU2sb9Zu/YazmxGQPjXGrrS9EZIQggyE99gkXx0V7bRq60euYzBFMyApO
         u0aYpnFKu5zwtTo4ukb441aieRRqSdXXhK3YBgHbyTH2lfMCZP/DjVGAqUrUxJq0vCgs
         32XvKpO4QbXBt20AePdd5hitV/ON04Ey9OrXJo5qWS8CawU1pYwE7HKdj7BPlLg0oD4r
         F4WgHSMW4No495oo7vmcsOaQhB9nT8IYWiUlQD2bAFfmGP+OaLe7K6eSsPy3joU2ZSxC
         PnzQYRJy95IFPvhVkNri7KDzVAqoNeogYvA/b2QS7ylKBiTauX5+tb13VinnF2aE1B2r
         th/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=As/pP/Wl9lgSZeirNEJQtG+sKd/tXccaEi6RDRuHzhA=;
        fh=R2h44j+bQGGwNKlM0y8QcuqlNJ+ffpgOJZqqLuDWG18=;
        b=C9UV+aG5Y6qZ8ZxfiwPVepV9a1/p8zNJ3JxBbN7pBljAUhuaoeP2qg6ZNkdiUzgC8x
         iCIv3Z43lcDmeNOeBwxb/YZ+iEPfkPFIwRMbvQbwYT1xBq2dP9bgkK9sqRnjhZYAXeJi
         pFcnE3AoS1JmOrluFOHgqtYkYKNUWI3I4SCg6NXPRvOPmVx5lOsA2TjONwhgXaS8COgK
         pq0BEjXg31V0MNHN99GszI15Xcg6WiDTvFLMlKf7mEJwQAC6rBEqZvRYaeu53dK1Uwwt
         RrdZBn9CRk39b7v8ybnPM3WpMNHGoqcVtXpqdjvt8zdyMS6IqnEs9ayrlXGG7Ab1FJ0w
         R0Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194457; x=1781799257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As/pP/Wl9lgSZeirNEJQtG+sKd/tXccaEi6RDRuHzhA=;
        b=csrYIUTUvioqqU96P6dT9j0vfOFShvwyMDC+4d/UT5vtTblncii8Pnd+OrFz617lUL
         2H5qgyj5WFcQhuoBi1Rag8qCrt6Vod0q+n4CLmgDgeiIrTwyFO2E55k01UdXcoKWnqJ3
         AMujSDl1L1dcxgekniYE5xBo9PeoHWfkaXP9ID0k5kSmS7MVV7NwpQr9tekf1zO1PPp1
         kD2Owyq5n+FP2mYSQ5LTeWl6aiebiu7hJKeSIT8b7eONVjvzCx084IaIwMYZuPWZ5JGJ
         /Qe2tB0EEohvzJAuKSCglU+H7xe9d+Bso4SJcEBz/xpRSN2LpaEVY88O0B4TyBLN8ys3
         lM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194457; x=1781799257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=As/pP/Wl9lgSZeirNEJQtG+sKd/tXccaEi6RDRuHzhA=;
        b=F4mLm97I/n43j51AMOrfG/5WkvLH7J/AFpFgHxhDRH1+uLEUQelD3LdARZIPkBdrzz
         cIZpRwRbuXL1CNr3PuSI5MsSZoYp3fY3Vt8OVml4BeeFAhhnalAAHU/9iAmahnWfs0rQ
         T9YEtjvrfkpuLAGrgWcqtAPiWQ3uuZN4bQ3OiJgVXPdX0pn7JIuA3OiFsscLA2lfNsz6
         ORgE78rhU9axgXJDjJVxeiVCaviTDizeZvKODB5bj6Nu+Tqn149HkQGoLZL3SmgBAahk
         wvMqrUC+ox8GNYXRZDXrMVTSpUNl1oweXjeS6lzJJ5HfvzvmR5j0Kh+h4L2EbzLDHqPV
         ed5g==
X-Forwarded-Encrypted: i=1; AFNElJ/XekyddccBySgS6BOFDmV2mmg0yEWCvlNWtzR09jCC2Lo+db7w0wEv2DXyA9DKJ5ztQcM4pdBO3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzut1UXBhbnVq36ZgZ6d7MJ0U9jxslzx4JYqqv9j7Cldu3yMvLY
	2lsxLOtvhY7r+CLiOKm2Y0/EovO1kizPODeAIPEIXoyExN4+S4T7fLc/+OQnR0hezPhShgLIJW0
	reb9Wqdp6ZNTcCAoz5eXx7MNW3HJul0g=
X-Gm-Gg: Acq92OHzSwIdrp7dLswqKK0bWtBGEpi6ldv9N6y4hZgwijdHBCXvf0J1zuFYtCxlAQk
	ZQrBRzHI6NoWrl9tzPLyz62fpVKjWJ18VGwOXI2HmQGCtsKKlTs3Bhs0ojw5Vz0EV+61+A8QJ4H
	Fzv84U5kD6L8GNf/fTDdypLalugzXkratmV7844Rhv9RQcJrTZMDmBCgHWkOU+71j8WKOgGFhOg
	9qdmB1xWq5b4IuXVD5iqGo5gFi0JmZ3YXlLLZ2/QJu2Ups/lkWa6QRKIJ0MHIc66uuPSdxqFhe9
	aF5kxFBJ8bonGKsoZPOjGJ6FiMIc0SoCynT/mY+/fte5j40D63ShRUijQWIm65+l3HNkEYSGi6i
	Nkla7+TPJaJlTaDJIxrJJ5HU+rTDcHUldfGtYt9vKfX+9Ru0Co967/coQwDNRZ1Me3UJdg4a0+/
	T9qVc=
X-Received: by 2002:a17:907:7ba7:b0:bef:1e83:8228 with SMTP id
 a640c23a62f3a-bfc87c0f243mr220203466b.39.1781194456320; Thu, 11 Jun 2026
 09:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com> <20260611-mt6323-nvmem-v1-2-b5e1b9ce51f2@protonmail.com>
In-Reply-To: <20260611-mt6323-nvmem-v1-2-b5e1b9ce51f2@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Jun 2026 19:13:38 +0300
X-Gm-Features: AVVi8Ces8T60xoHtEoplh69CdNS4vvYPyDhO6krvEnoKRWh_ilPPLEaS_PgToaY
Message-ID: <CAHp75Ve-+-xaWoktFO_qG1Xkyzh7D9JsBFw_qH9zcUXWhk_qNQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] nvmem: add mt6323 PMIC EFUSE driver
To: rva333@protonmail.com
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:21=E2=80=AFPM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
> The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
> thermal sensor calibration values.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +static int mt6323_efuse_read(void *context, unsigned int offset, void *v=
al,
> +                            size_t bytes)
> +{
> +       struct regmap *map =3D context;
> +       u32 tmp;
> +       u16 *buf =3D val;
> +       int ret;

Perhaps reversed xmas tree order? And it's actually better to see
assignments first.

> +       /*
> +        * A manual loop using regmap_read is required because PWRAP is n=
ot
> +        * a continuous MMIO space, but rather a FSM that doesn't impleme=
nt the
> +        * necessary read callback for the regmap_read_raw and regmap_rea=
d_bulk
> +        * functions.
> +        */
> +       for (size_t i =3D 0; i < bytes; i +=3D sizeof(*buf)) {
> +               ret =3D regmap_read(map, MT6323_EFUSE_DOUT_BASE + offset =
+ i, &tmp);
> +               if (ret)
> +                       return ret;
> +
> +               *buf++ =3D tmp;
> +       }
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko
