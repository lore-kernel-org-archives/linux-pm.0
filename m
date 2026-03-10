Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F23806C1
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150604; cv=pass; b=IvzHFLMOEvo4SWgEJOG5eW8FvxD5bETlxOJrvsHHZTH4bPXI+hOdRD777MF7rZDtwQqycb8M0/NPfYcMcWA1xwz4N9OyF9Myob1qNtwUIlIaN1uhB0u4gjaj3fOEH8IXHI4Gq+VxMnlkuueMrvIiUDXohvKvSOTrOzhVUFONsWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150604; c=relaxed/simple;
	bh=3EfJEhbNyYHp29tHC+BP/iev1/iEwlGeaA3ZtDrhSX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUqckOJqPsENqDB+ryKFiDfZYUQP4E7KOsmvnWws5z//nT2jPCaRR9muPSqHYOXIgLt9j6FQMhrZF7/VRAOT3BYxdFwKb8V01SZ4xtlz72r7RmOv5QO/KXMsj3f0IjBueGdhlx2OqFPMtje2U9vn/THJUOtCf+hkEie1qX0shIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Q7eq6Brm; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Q7eq6Brm"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b96f02b4329so394879266b.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 06:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150600; cv=none;
        d=google.com; s=arc-20240605;
        b=kfOEeOTD5ChcpZzfZwwSPu0Hlz5cIswAqeAdsaG8zJVZYx4we0y/apHwV3w4Pt7qyK
         Jp59eLeKPljttY6Q2NV09ygsGQHRKcybqPgJtZbFj4N2917875BDkOSYCr6tYicQcLht
         vrO/ul/c/C+qojXISs7QDe5r0CVXAIVXGxwMW69RS+7krnJwERAuYBgKVHswXweOI4ep
         KSTMnGDD0tQvK6tAd8A99SnEXHlkaKDy1ocAuKnM+fWujEawnLwOEU/7ds87J78GAvSE
         VwY4hzUsDVMSH1sfimgBWKDOZWMlfx7O9B+7JQH/35D7Kf8u2jygXlLcvn89Pg4lptXq
         SSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1mERfYSuSAiIwvbv/dJ/kgJKbE5+s2qwKMdl0EczUJI=;
        fh=Z015Ws477U9DUXzKwIbC+ZXiFcBs++pByArslk8H7LY=;
        b=MM+KALVuULRbRIrLq+1y3PvHsPPuZQBNhkNOte9TLMxG+sIutyNKXMVYhYc8VPWyL+
         b4Asu4TNdebn/pn9HDpHG2rFx6uqk0sNVZ8JKGQq1qt1lACRECXPub7m2xCKLYRVNslK
         jdAmCkhd3WKS2a3/iacxgrdoOp0FPAYriMAmz8L6/0fjzr839fperclhMaquVwBUwlXY
         VGtmChEHNz3PEVBevE5gBVtbYY8xJzl2uvifSpeFn2ZeW8ylJV6yWIcZVvkIcCsKYDfF
         QTnyOr6yUOTOGPuU92RX3gqhjejphRPvltnMrquluPFYUe9sXYLmBWefzWTPnl2xKW1J
         8zCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773150600; x=1773755400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mERfYSuSAiIwvbv/dJ/kgJKbE5+s2qwKMdl0EczUJI=;
        b=Q7eq6Brmwt6+CgXAV9a0FtZZz1DF0vx0Di77iehHfUX7KfZucviTEJejBlO3g3DSa0
         L1vUGJxQf5QLPsparGFHSH807aGPqe/RufQi6uKO8PoDXdXIA0KyR99c3ItMx64ZzWUD
         FcY+b1A99xqicvmepuNTfV2lf1sLBFHDxVOYcCKt60SniX/BwNW25oZO9OWQsgOvJxZq
         YiZKnKGD3J90PIo4GVjqKgELO0kIwiWNkXSMOIbHs7OPvbPDrdS+AlNAll3JCezIwHyX
         HBceP3X6u12q/45VJy7R7m+78jZJjrdtFhLQE02aT/M6gaRnUNTR8ic5KCht7eKems7l
         bYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150600; x=1773755400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mERfYSuSAiIwvbv/dJ/kgJKbE5+s2qwKMdl0EczUJI=;
        b=YzfW5+gZVr5iPc30wRLrkoBixNYKxva79UB+fmA8PhOzldwliJiugjtXAhxsqKAzxe
         /Do02BHyJHBgleEvjgNqz4w8kFkyakWOyzI6Kct7KjpISKnpTBwp1wOx9cDZV4iF8XfV
         xJOqYbDjLnIpjvHDP/Ar9HAKnPZyThOumZwSZQHEu2mK6HorTpPAdRdO1ftrLJMnnsiR
         04eGLazDWjoMLicSR8+e9aUViU2HZAb/c38T8zBcDMPN3FlTcHy+W+9cFTXz0QQi+MQW
         hSqZljjM2uFTAZHf7vC4fpSr2S7wAnmiImumVATptDzYGA0jFxS/75YRHUOM7mGHVvFu
         lKiA==
X-Forwarded-Encrypted: i=1; AJvYcCVXugnZZZgLyPskTbZPAjYvAtCvMdycmtxJfunuHHHiEvyipaQZ4vYR4Y911n0NceUsTPxkJCWLCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbtNEGI+0bD+3mqY/Ie9ECFRNu/w2u+UX0Q4KCTV06OAWvhjj/
	6eY+PKBWJQKUqP5PKQdCYC2WBcL2uuFVVv+f9TZSiYWT7CdQuiUEhwjFKn+Wj7BciylgErM858P
	sJGEwGdVZPTEJl1ykPwKkArpFWpt3o6r1CWE6T3Z04w==
X-Gm-Gg: ATEYQzzVt+WWZzILhHapYUk28odPRuSM3PN7SZQY5L0h7u6tnKxAKsJwapTCsnde9M0
	HEc9d/kNtreUuN8QdgC2uDavuafgNy+h2ii0HxO7QFbgoK7aNz1EaqENtEb00Ifpy/1k1IzcAbS
	ZPlokCABHS/vusGDKuTz6mKINiRJSGxYPVuNB28CByIRdBbadhvJtPXcRsyBFU/C89Otl8LJqpw
	O82Pyx8ElR+PwXSuHJujfxnSW4XHSZ7+mRzMWq463ZpsYNN/L0HvYUmDWqm4q8V2bTCc1rzK2R2
	0GgTq/o=
X-Received: by 2002:a17:906:9fce:b0:b88:587f:f594 with SMTP id
 a640c23a62f3a-b942dbb91dcmr825006866b.18.1773150599757; Tue, 10 Mar 2026
 06:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-9-02f8e232d63b@flipper.net> <20260310130315.GK183676@google.com>
In-Reply-To: <20260310130315.GK183676@google.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 17:49:48 +0400
X-Gm-Features: AaiRm53S8OEK5SaUZeck_O6hUJopad5cKLvL1AQpN-ACdcgvJYmqmjopGMDXWQI
Message-ID: <CAKTNdwHs=QJ=UFVcN1DyOm+r0rOVd6Uxhb1N=0CYahtEGaXqYw@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mfd: bq257xx: Add BQ25792 support
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:03=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 10 Mar 2026, Alexey Charkov wrote:
>
> > Add register definitions and a new 'type' enum to be passed in MFD
> > platform data to support the BQ25792, which is a newer variant of the
> > BQ257xx family.
> >
> > BQ25792 shares similar logic of operation with the already supported
> > BQ25703A but has a completely different register map and different
> > electrical constraints.
> >
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/mfd/bq257xx.c       |  64 ++++++-
> >  include/linux/mfd/bq257xx.h | 417 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 477 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > index e9d49dac0a16..7516e2ec00e6 100644
> > --- a/drivers/mfd/bq257xx.c
> > +++ b/drivers/mfd/bq257xx.c
> > @@ -10,6 +10,11 @@
> >  #include <linux/mfd/core.h>
> >  #include <linux/regmap.h>
> >
> > +struct bq257xx_match_data {
> > +     const struct bq257xx_plat plat;
> > +     const struct regmap_config *regmap_config;
> > +};
> > +
> >  static const struct regmap_range bq25703_readonly_reg_ranges[] =3D {
> >       regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID)=
,
> >  };
> > @@ -39,15 +44,64 @@ static const struct regmap_config bq25703_regmap_co=
nfig =3D {
> >       .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> >  };
> >
> > -static const struct mfd_cell cells[] =3D {
> > +static const struct bq257xx_match_data bq25703a_match_data =3D {
> > +     .plat =3D { .type =3D BQ25703A },
> > +     .regmap_config =3D &bq25703_regmap_config,
> > +};
> > +
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
> > +static const struct bq257xx_match_data bq25792_match_data =3D {
> > +     .plat =3D { .type =3D BQ25792 },
> > +     .regmap_config =3D &bq25792_regmap_config,
> > +};
> > +
> > +static struct mfd_cell cells[] =3D {
> >       MFD_CELL_NAME("bq257xx-regulator"),
> >       MFD_CELL_NAME("bq257xx-charger"),
> >  };
> >
> >  static int bq257xx_probe(struct i2c_client *client)
> >  {
> > +     const struct bq257xx_match_data *md =3D device_get_match_data(&cl=
ient->dev);
> >       struct bq257xx_device *ddata;
> > -     int ret;
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(cells); i++) {
> > +             cells[i].platform_data =3D &md->plat;
> > +             cells[i].pdata_size =3D sizeof(md->plat);
> > +     }
> >
> >       ddata =3D devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> >       if (!ddata)
> > @@ -55,7 +109,7 @@ static int bq257xx_probe(struct i2c_client *client)
> >
> >       ddata->client =3D client;
> >
> > -     ddata->regmap =3D devm_regmap_init_i2c(client, &bq25703_regmap_co=
nfig);
> > +     ddata->regmap =3D devm_regmap_init_i2c(client, md->regmap_config)=
;
> >       if (IS_ERR(ddata->regmap)) {
> >               return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap)=
,
> >                                    "Failed to allocate register map\n")=
;
> > @@ -74,12 +128,14 @@ static int bq257xx_probe(struct i2c_client *client=
)
> >
> >  static const struct i2c_device_id bq257xx_i2c_ids[] =3D {
> >       { "bq25703a" },
> > +     { "bq25792" },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
> >
> >  static const struct of_device_id bq257xx_of_match[] =3D {
> > -     { .compatible =3D "ti,bq25703a" },
> > +     { .compatible =3D "ti,bq25703a", .data =3D &bq25703a_match_data }=
,
> > +     { .compatible =3D "ti,bq25792", .data =3D &bq25792_match_data },
>
> Instead of passing through the data structure, pass an identifier to
> match on, like:
>
>          { .compatible =3D "ti,bq25703a", .data =3D (void *)BQ25703A },
>
> Then add the ID to ddata which is already obtainable from the child
> devices via i2c_set_clientdata().  This saves passing it as separate
> platform data.
>
>         ddata->type =3D device_get_match_data(&client->dev);
>
> Then use that to initialise a local 'struct regmap_config'.
>
>         switch(ddata->type) {
>         case BQ25703A:
>                 regmap_config =3D &bq25703_regmap_config
>                 break;
>         [...]
>
> By doing so, you save on a lot of additional complexity and mitigate the
> introduction of some unnecessary data structures.

Thanks for the suggestion Lee, it does indeed make the code leaner.
Will wait for any additional feedback and send v4.

Best regards,
Alexey
