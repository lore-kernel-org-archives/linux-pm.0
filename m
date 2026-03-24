Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15E397683
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344068; cv=pass; b=RrtLaM8oW3zQ4ZlyENLBsgUaGNcooklyHgRlrTMGDkcRKUTWSw2SqifnvzbgGl93SZ4N2nZgaCS4SUV2/Q+YgMvYZMAk8mWzx3HXFoYfmOTBPHjDIdYF6BewAmrciYWYPN/9z9k2vb/37ehEI4ArKCXjJqIiMq0wHy+0yqC2U5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344068; c=relaxed/simple;
	bh=EPyu5OqVknjVwgtna6B35VEkYvRH9HXMZoiklgUJgck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQmmOaX0IYHkQF27qHKFeRLfXG9yZgRfS14w3y6hZ2FTf0LgOrTHOGy/JBUtcMu+Y/eMKwb4WEhFYX6fDH/REre5ikQVij2DegByCbk9VCCkHoGanm2JAWsts0UB8aSNqbpYvuOyrJ21Jp3kgPQAaIryKs88Ha/AtlJ09/MlItY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=CGmpfkAw; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="CGmpfkAw"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-669efe709feso1865051a12.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774344058; cv=none;
        d=google.com; s=arc-20240605;
        b=Bb03dyfogEnouKQiCilEQ2gsm7piYXZNL8A3fNlzxY9Xxr8tYIdG/C/M8Zer9lKhUI
         LUPHF+TuAsKrrY8+KNbRdVDyvxRDuubxAH5uxeX7u3DXQ+SUyAibjoP9WQCM3K5OqikX
         xudoZATloCvBNvV+12JpLYaJZOkzv7hWG3BjN6x6dWyvfhoh45ywLav6s07PLr0lXGd7
         THA5+KW+2lORwECVNM0XjQZt1yMgsO/FZ5S2aMG2tmZrkieIz4HUv+3g84rC37KCQtaY
         Lj2QH/gJzxrdkcR1U0qrW/oiV2vhwcrfcKCYh/YsjIqFIHs5TkHTknb2wLTajxWbKG3V
         lQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+6q0TruHveP6U73BSJKA99LMCh6fuc9PfmktCKQOAiY=;
        fh=6LZeXxAFXeZr/gMeOsf1BZXzluYh7jTxirwIwPZdDVc=;
        b=AqccAARHMFvzQQWT3bgkvSWzBE7uJlw+79qU5UZ/AfSPTXBFRj0h1wZYzTgXAa3V9A
         jvm4It2DCN2gA27yCU+gnhAICLGoP4t8h20qslXcG+dsdDA+n5AtPNWip4rF9A3VC8d3
         n9C3N88mmY4SsTTzj3POFR3QaDBuTkRHk2jjLgiqxztItXXMuWWHz1NXfb9QvYfE8FCo
         6TrpcYXdNkVOrpUxsLyf97F3re14bL4JnC3NvyafJb0uB/4LM3pMxzy54jLogCLgL9ZC
         ZmsmIhRNq7ZkzXZ+XwiWgbzZHbH6JOqOuiyGITXObJ3W1740sfwtLi6a42AaoF0eb8zS
         EA3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774344058; x=1774948858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6q0TruHveP6U73BSJKA99LMCh6fuc9PfmktCKQOAiY=;
        b=CGmpfkAwY7iWvZxqmd8bMxWVhzTJ4uQggcBOZ1n2QaTcnefX0nhwO0Vzy7gNJ7sRJS
         eD1UaXi4I6jz/M2acIPATcJ/+OV6+qhJoQYa0fwnvkdojoXhNfB2ivf7uTVboNejLk/o
         0DuRi8i2rl5eC0XhPJzevQL6fUqVITMQDP3692+gY7G+eQFRAHbQ5CoAL50FK80gePUz
         1qtTOxbTK9io5UD5e4gx40POZuZQaja+F4VL6hk9te/jhT5NWvrTTAGPsX0GD/vRlo6Q
         VP9oFEYu6kd29O1igL8pMyuuJ8GpTQQJwTkhkvNHSlF/K8tdKF7vvXnYMEAScDnrg/4E
         9OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774344058; x=1774948858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6q0TruHveP6U73BSJKA99LMCh6fuc9PfmktCKQOAiY=;
        b=ZYIdFz3rXM+WQw+wPKaf40QN0lrnP7/Q0LC4zTcFqwNPZALcRRAsaYwZ888k9h1Q5L
         z6NEPNUsDnPc/HaThUJhQGYZtqPoYAEY8gCSDz6JRQUwhwLw9bvZhomAh3GPnQ4nfzxL
         dNVERkYf9usP9aEtzEYg91j+Nzh9tKjM/f7D60pgUB13joUoGGEafWMLVaQIvCxD3AWs
         3PQCTmelABimncoGiARYz8J4rSDvR8QJysVprvNDgvMgepRG2hBdAjLtoRHgPFkkE+XJ
         mhgzztWTvvf9+qLH70JnbgcnR8AIz5sC6ZHghn0QZra0QH9iBpKLuWnV2Zdcanned2pF
         phkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB7m+IyHIjHoD5PwlPrj5GzhPAYkihXB+a5+b1mw/EXjEeI0vVDk61LpAOKcn6AK0Qomsu8A0BBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGrgDOqlj+cGq+3Ik5KPDXb5DUkxPKyPA1ZGQ/D7bOdn2cYRU
	WRrh5whp5T4BrGK6Zq5VmHKf+d8YVd27vF3aEnGbEun4lOlQbmuww9r4Nc79aszc8ykPtaWa1/w
	P85wPGAoK23g3Nxq8IOQCiooV9646CtUow1aRiOQXeQ==
X-Gm-Gg: ATEYQzzaXHpco3gH1R/hclG9PSjzk43BrRCPvGI/5YVf/UY73iE+s48fLn8vUg4SUlV
	bl9W+Jd6t5r44umvdiN+TqzBNPlLejaxTajPNI8joid0+N07rjZLoW/SE8/RqzGJLE2+eOuz4tz
	YQ5GAU0kwoOZVek8ML/v0bTLCoBuSJwdDhEvMroDDaYZm4xSTWeSyMB2/pIrYASosuheBPjioHD
	d0f9Lnt+uJIdX3l8ZL+/bbrX/GatbrftO8B6OmlJ9iuWlW9ICdPQbBE6Ui0lfVogAXKYzXnGRlb
	yoKpuks=
X-Received: by 2002:a17:907:874c:b0:b98:29fb:f32 with SMTP id
 a640c23a62f3a-b982f20c0c8mr1131030766b.1.1774344058018; Tue, 24 Mar 2026
 02:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
 <20260311-bq25792-v4-9-7213415d9eec@flipper.net> <20260319170118.GP554736@google.com>
In-Reply-To: <20260319170118.GP554736@google.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 13:20:49 +0400
X-Gm-Features: AaiRm50WQIURynGokcQQcvDh658IApUyTNwD38EN9K90pAulfCo2gFqeEA5eF_4
Message-ID: <CAKTNdwFUuzemasuuKgnJXDofOrnkrdMoxOZCC-Fa6yLF+X5xTw@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] mfd: bq257xx: Add BQ25792 support
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:01=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 11 Mar 2026, Alexey Charkov wrote:
>
> > Add register definitions and a new 'type' enum to be passed via MFD
> > private data to support the BQ25792, which is a newer variant of the
> > BQ257xx family.
> >
> > BQ25792 shares similar logic of operation with the already supported
> > BQ25703A but has a completely different register map and different
> > electrical constraints.
> >
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/mfd/bq257xx.c       |  54 +++++-
> >  include/linux/mfd/bq257xx.h | 414 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 465 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > index e9d49dac0a16..4445ded5b2eb 100644
> > --- a/drivers/mfd/bq257xx.c
> > +++ b/drivers/mfd/bq257xx.c
> > @@ -39,13 +39,47 @@ static const struct regmap_config bq25703_regmap_co=
nfig =3D {
> >       .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> >  };
> >
> > -static const struct mfd_cell cells[] =3D {
> > +static const struct regmap_range bq25792_writeable_reg_ranges[] =3D {
> > +     regmap_reg_range(BQ25792_REG00_MIN_SYS_VOLTAGE,
> > +                      BQ25792_REG18_NTC_CONTROL_1),
> > +     regmap_reg_range(BQ25792_REG28_CHARGER_MASK_0,
> > +                      BQ25792_REG30_ADC_FUNCTION_DISABLE_1),
> > +};
> > +
> > +static const struct regmap_access_table bq25792_writeable_regs =3D {
> > +     .yes_ranges =3D bq25792_writeable_reg_ranges,
> > +     .n_yes_ranges =3D ARRAY_SIZE(bq25792_writeable_reg_ranges),
> > +};
> > +
> > +static const struct regmap_range bq25792_volatile_reg_ranges[] =3D {
> > +     regmap_reg_range(BQ25792_REG19_ICO_CURRENT_LIMIT,
> > +                      BQ25792_REG27_FAULT_FLAG_1),
> > +     regmap_reg_range(BQ25792_REG31_IBUS_ADC,
> > +                      BQ25792_REG47_DPDM_DRIVER),
> > +};
> > +
> > +static const struct regmap_access_table bq25792_volatile_regs =3D {
> > +     .yes_ranges =3D bq25792_volatile_reg_ranges,
> > +     .n_yes_ranges =3D ARRAY_SIZE(bq25792_volatile_reg_ranges),
> > +};
> > +
> > +static const struct regmap_config bq25792_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D BQ25792_REG48_PART_INFORMATION,
> > +     .cache_type =3D REGCACHE_MAPLE,
> > +     .wr_table =3D &bq25792_writeable_regs,
> > +     .volatile_table =3D &bq25792_volatile_regs,
> > +};
> > +
> > +static struct mfd_cell cells[] =3D {
>
> This was `static const` before. And I don't see any code in here making
> changes to it.  Was the `const` dropped intentionally?

Thanks for spotting this, Lee. It was removed in a prior version when
I was passing the type as platform data, which is no longer the case,
so the const can be reinstated. Will do.

> >       MFD_CELL_NAME("bq257xx-regulator"),
> >       MFD_CELL_NAME("bq257xx-charger"),
> >  };
> >
> >  static int bq257xx_probe(struct i2c_client *client)
> >  {
> > +     const struct regmap_config *rcfg;
> >       struct bq257xx_device *ddata;
> >       int ret;
> >
> > @@ -53,9 +87,21 @@ static int bq257xx_probe(struct i2c_client *client)
> >       if (!ddata)
> >               return -ENOMEM;
> >
> > +     ddata->type =3D (uintptr_t)device_get_match_data(&client->dev);
>
> This logic seems a bit fragile. For non-DeviceTree platforms,
> `device_get_match_data()` will return `NULL` since the `i2c_device_id`
> table doesn't provide any match data. Casting `NULL` to `uintptr_t` will
> result in `0`, which corresponds to `BQ25703A`. This means the new
> `bq25792` will be misidentified as a `bq25703a` when instantiated
> without a DeviceTree node.  Even with DeviceTree, if a compatible string
> is matched but has no `.data` property, the same misidentification will
> occur.
>
> Perhaps it would be safer to explicitly handle the `NULL` case and make t=
he
> identification logic more robust?  Or perhaps start your IDs from 1.

Guess I'll do both: add matches to the `i2c_device_id` to enable
non-OF use, and make IDs 1-based to avoid misinterpreting a failed
match as a valid BQ25703A match. Thanks for the pointers!

> >       ddata->client =3D client;
> >
> > -     ddata->regmap =3D devm_regmap_init_i2c(client, &bq25703_regmap_co=
nfig);
> > +     switch (ddata->type) {
> > +     case BQ25703A:
> > +             rcfg =3D &bq25703_regmap_config;
> > +             break;
> > +     case BQ25792:
> > +             rcfg =3D &bq25792_regmap_config;
> > +             break;
> > +     default:
> > +             return dev_err_probe(&client->dev, -EINVAL, "Unsupported =
device type\n");
>
> Given the potential for `device_get_match_data()` to return `NULL` (which
> becomes `0`), this `default` case might not be reachable for invalid or
> un-matchable devices. A more explicit check on the match data before this
> `switch` might be better.

I'll shift the enum values to start at 1, then an extra check on the
match data shouldn't be necessary, as NULL will fall through to the
error in `default`.

Thanks a lot,
Alexey
