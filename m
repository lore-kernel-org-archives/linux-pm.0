Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099273463
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960672; cv=pass; b=muvzP4ucN2sSFxuLGN72dvGmttHEy8dZ14KjqZ6IAS3uIGNZSJ2XyhWjphOAp5nD3Lk+/RXqRsIlaI9BbmFEdTdQsYLELKg9dOMGthCjprG0Z1xRIJVWnRDsF8duwLE3CZXe4yHYo/7vyuGOKVFMdnNb5ssxB8dbS/eJYqovooU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960672; c=relaxed/simple;
	bh=jPbNg7vnffslAngWLp1YXKpgROU2PnXJpaYVtorkLMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgWKa7oFf7c5bn+wNT4y2YWgNX+5RDU/PLQHjpB1um3COnLxhjMIloG1pVgu4Rt2KmYIrX6qQCsjEvgpiVj8inv8sw2WSPsSfIuXTHF1zZF3+lnEF0avYzKOVtW70UyIGbLR8QhvxxH4xx2gnjsLQf8PGIh+kbrjQmTucqLuFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=OHFU5U3j; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="OHFU5U3j"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b980b35534eso1032144066b.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 05:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774960668; cv=none;
        d=google.com; s=arc-20240605;
        b=TnjQFWGzaI06lJ2nAk5go7TuRTVbp3FL5hpInjTJP7JV+cK8SGv9YhTDqd5gNBPMzn
         +uy9nArZ72RjG1M8gDlArRXzmXOQk8raHVOEPM5eJoreuEgTJS0G+O5GT3Z1ha4UuExl
         VkCXK42yO2AD396XV6aLmDMMaq7KwlaMAtXkGPIioxbtgHd9cw2zrK72eRKAV+6OBE1G
         QqPStiwflfcdOpZHN8dqmJ8E3bXlYAVfIODcNGPo9zZ2p+BzMYN4tTFuEGXmzgV1PfXF
         7KUvMt+qvgYk0eTT+nbiEtbDUWIfcEFZZCBriw9TNwWqy1i4S96zfpxGNzSUlDPMIfOg
         Tdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APk6GhrrYthp1r3qG0lb9C4gKQqFk3Q9Fs1Ji6JZing=;
        fh=8gS4agLeOhGhRdgUGgYmZUvB8eBC8miWFYiMe5D1DZU=;
        b=Xcox9N0gLb5eo6O56NaK9OLfBjaC3d5SonCpusXrNHztgNU56swe54JMkL38MfNG6z
         Z9bL9rV+5+7rEKwtZq6YR5nYEQ0evubdpqdwyN4JBcSmSr3WLK+eo+kz/yg+2D6mr/5y
         wVaz6Nt102/UuG9pwxvC0YH52boxgH8Mzu8FCN/Z/az+duN4ZVcMgj1ObWB3QOe/nyUl
         oEHltRqAt7Oe4z6z1FGDGSpqgfj14qDenlUyTLHWadideh7hdeO7lw9T8SCd84QDpM/D
         kQLMVWXfPgMs9tYDYCSxRJk1j+ksVB51tBb/9tFAHZD+78qYBVf5Nqr+G1ZVWAFJgfmx
         CRCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774960668; x=1775565468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APk6GhrrYthp1r3qG0lb9C4gKQqFk3Q9Fs1Ji6JZing=;
        b=OHFU5U3j66PbvMavlSF+a6mpP45beTwgYQnPzHAdFNx0leuJLj5waAEmp4l9tkgnrT
         pNvR7PtQo85qheqJR39ZyW0Mups/YVBmIV2XTaoUazYWfzEeQHBYnaEMJGasa6b5fmNw
         jfa75bC3De8hZ7wju11xbrgk3XyItkeJNvutjovRhS4GL8LjXYWQSTk9+HlhC1j/BWFW
         12LsFxyxtdOQHd6kOVIfGvnXpYAFKn3e/5wOjuYCaBcKc1lm5ok8e5okhmlilT1iN0tu
         IB3gIQ6KASqksjWF5seja8ZdiGGYmjYScSFudcWC/0Jgoak+g48Ve5iMAnRwRej9WvWo
         uS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774960668; x=1775565468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APk6GhrrYthp1r3qG0lb9C4gKQqFk3Q9Fs1Ji6JZing=;
        b=XpzotYllblCXaf+Hj1UMjQuuV+XxuXsI6VNICNSxPqgqyW4P5cbtK4q0w2YpwzphVN
         KXxpkv1G2dRa3h4QKPumCeyuB5/YlCPDvsZ99G6R/dhDLcghZftZLdgLc54DtSn4H682
         YnLtirCa16IcCvrHaUaQFj+JKddv8R2lwHDDJ6vJUNVF0b4NqumwB24pdLscFoU/IW9I
         Vf0hcCLoVuA1jEgQ7eRPculaNsEiiL1dSe8kUg5g5MRkm41dbchEuRMofCC3Z9gwLOX3
         90FCxk9wbYE8fBOUsCyqIU7d1AndnTKD69clW6IFc2Nh0kHC1jdO4GT9S1XMn4+6+Xj4
         RFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVMG92nY/lBlzxZMrwBKgWpTo1avMNYtHtjQGLp3/u7lWW/1Aym6pCaLxlu/zG9bzQDoKsei73BAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jkkaL04STXZlX3/9oTwTauSbEv959zW0X3jR0ECGNQ+WdLjc
	SMvq4B6sXlAf0XI25/4QlCoY/i1clHikbTCqqBD2l/KycaAmKEeoDNHzPpapeOBuS8vFNlntlXs
	j+ysNTNZ6Pkg6MoVZEQsrwVp6aX1wg/H4dhsbZ64RGg==
X-Gm-Gg: ATEYQzxwN1gSwhIxSbtOy0r4+Q9ZuXlEVsGKReAV0H26Bzhll61baP6HybDNVRjBJqO
	bQmzygSnROnk/WiO8rlJ0Nxd62A1C5JXCLQs3QGSHBV2Tzq4fqqSCjimvWFLf21Ncd354bF2Tct
	TDehZIgUQHvW8FVuOqGlPvH+5ijRjKeduA+htPkK4iQund8RZjkcQUSj5MVS/wKm4JyFyaTQtsK
	hP27XP7Mab76+2bh6hqdMRT5Q2+cPdwE0jBiYPdOMFxQaymd8/FUq4YuGF/rnP7zWaMRaSa/bDS
	Laqk6HE=
X-Received: by 2002:a17:907:7245:b0:b90:4838:46ff with SMTP id
 a640c23a62f3a-b9be855a7cfmr188103066b.21.1774960668061; Tue, 31 Mar 2026
 05:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
 <20260324-bq25792-v5-9-0a2eb58cf11d@flipper.net> <20260331102710.GB3795166@google.com>
In-Reply-To: <20260331102710.GB3795166@google.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 16:37:38 +0400
X-Gm-Features: AQROBzBsOkDwD-_sfwvUc3QMEB-ceAPpDa8MP94cdzSz0KL5-FxEUULnB7SLa5s
Message-ID: <CAKTNdwE4omfEkd6FNdj=hZUY2ZwLprXzUu1L4juFhWCxbWEjpQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] mfd: bq257xx: Add BQ25792 support
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:27=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 24 Mar 2026, Alexey Charkov wrote:
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
> >  include/linux/mfd/bq257xx.h | 412 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 463 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > index e9d49dac0a16..31654925afa5 100644
> > --- a/drivers/mfd/bq257xx.c
> > +++ b/drivers/mfd/bq257xx.c
> > @@ -39,6 +39,39 @@ static const struct regmap_config bq25703_regmap_con=
fig =3D {
> >       .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> >  };
> >
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
> >  static const struct mfd_cell cells[] =3D {
> >       MFD_CELL_NAME("bq257xx-regulator"),
> >       MFD_CELL_NAME("bq257xx-charger"),
> > @@ -46,6 +79,7 @@ static const struct mfd_cell cells[] =3D {
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
> > +     ddata->type =3D (uintptr_t)i2c_get_match_data(client);
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
> Nit: Shouldn't we be returning '-ENODEV' here for an unsupported device?

Hi Lee,

Indeed, I've had a quick look and other drivers seem to return -ENODEV
in similar situations. Shall I respin a new version with that change?

Thanks a lot,
Alexey
