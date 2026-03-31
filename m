Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906E3E639F;
	Tue, 31 Mar 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963032; cv=none; b=hrdAgoE+8k6K7sGoebf1pxHEV+H9KjzYSEQANeLFwz4Tskl3qSuT2rDvpnhOuZfvFZZa8UAO/6zOHvrdnvWoEQTS5TaEovk9+UMZAhGMGZpcBbEzQA8cUC8KIv0uR/zUtZ8H6JQWxUFkHnkPDbp1ggWbuYT+hzPdPpIke7zlcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963032; c=relaxed/simple;
	bh=wfkM9H8lnswPA5KiysJl/MsElmwbu8d/sHC6jNfO0GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpDUnMx0DRN/Vl8cr3+Z8Nkhl8lsxp52yUaQ0j4CCTbcQ7eGbLUrMSRJ3cPE94kdpo78UBie4GZXW58I3Ync+SrBZsOq+e2VQTnESxIMwJpi+KBRMCfa46JxwXI/B3LXFkeYE6t50K9BLWchfdKJRPLmoUYu3sdl3oEXge7i4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEbxPOAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEbxPOAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71271C2BC9E;
	Tue, 31 Mar 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963032;
	bh=wfkM9H8lnswPA5KiysJl/MsElmwbu8d/sHC6jNfO0GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEbxPOAoA8ORT2e5y9YYLZ2GnEwvS8UvLz+e1VcDBd2PTP9ZMnwxYAEaUO6oAEepb
	 2cPyk6GBPA+n0TVDDzmJQ62Gv/sYMGd8VbwwARmKTVjvzFxB1dpbqvPa7p+6kA0j60
	 3MAtIV/WYa3pUwKZpuiCd9Y3Ddun9kE3PRBvTZaozBxSvd6qvj7Ai50Xq1966JPazL
	 Qpiw0hiMGyGGetKxS3W0DIcH1cCoYmTADApbdFzAK7HojH2RW0nqy47C7fkjMmtwjI
	 X6u5hOw+K8JNWjjJqmn17Q/JiVqMMvO1JfDxhBTfNhk4XJe+3Ju/FmmRiA2ofnRUli
	 02m13PZB0Wlbw==
Date: Tue, 31 Mar 2026 14:17:06 +0100
From: Lee Jones <lee@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 09/11] mfd: bq257xx: Add BQ25792 support
Message-ID: <20260331131706.GH3795166@google.com>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
 <20260324-bq25792-v5-9-0a2eb58cf11d@flipper.net>
 <20260331102710.GB3795166@google.com>
 <CAKTNdwE4omfEkd6FNdj=hZUY2ZwLprXzUu1L4juFhWCxbWEjpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKTNdwE4omfEkd6FNdj=hZUY2ZwLprXzUu1L4juFhWCxbWEjpQ@mail.gmail.com>

On Tue, 31 Mar 2026, Alexey Charkov wrote:

> On Tue, Mar 31, 2026 at 2:27 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 24 Mar 2026, Alexey Charkov wrote:
> >
> > > Add register definitions and a new 'type' enum to be passed via MFD
> > > private data to support the BQ25792, which is a newer variant of the
> > > BQ257xx family.
> > >
> > > BQ25792 shares similar logic of operation with the already supported
> > > BQ25703A but has a completely different register map and different
> > > electrical constraints.
> > >
> > > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > >  drivers/mfd/bq257xx.c       |  54 +++++-
> > >  include/linux/mfd/bq257xx.h | 412 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 463 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > > index e9d49dac0a16..31654925afa5 100644
> > > --- a/drivers/mfd/bq257xx.c
> > > +++ b/drivers/mfd/bq257xx.c
> > > @@ -39,6 +39,39 @@ static const struct regmap_config bq25703_regmap_config = {
> > >       .val_format_endian = REGMAP_ENDIAN_LITTLE,
> > >  };
> > >
> > > +static const struct regmap_range bq25792_writeable_reg_ranges[] = {
> > > +     regmap_reg_range(BQ25792_REG00_MIN_SYS_VOLTAGE,
> > > +                      BQ25792_REG18_NTC_CONTROL_1),
> > > +     regmap_reg_range(BQ25792_REG28_CHARGER_MASK_0,
> > > +                      BQ25792_REG30_ADC_FUNCTION_DISABLE_1),
> > > +};
> > > +
> > > +static const struct regmap_access_table bq25792_writeable_regs = {
> > > +     .yes_ranges = bq25792_writeable_reg_ranges,
> > > +     .n_yes_ranges = ARRAY_SIZE(bq25792_writeable_reg_ranges),
> > > +};
> > > +
> > > +static const struct regmap_range bq25792_volatile_reg_ranges[] = {
> > > +     regmap_reg_range(BQ25792_REG19_ICO_CURRENT_LIMIT,
> > > +                      BQ25792_REG27_FAULT_FLAG_1),
> > > +     regmap_reg_range(BQ25792_REG31_IBUS_ADC,
> > > +                      BQ25792_REG47_DPDM_DRIVER),
> > > +};
> > > +
> > > +static const struct regmap_access_table bq25792_volatile_regs = {
> > > +     .yes_ranges = bq25792_volatile_reg_ranges,
> > > +     .n_yes_ranges = ARRAY_SIZE(bq25792_volatile_reg_ranges),
> > > +};
> > > +
> > > +static const struct regmap_config bq25792_regmap_config = {
> > > +     .reg_bits = 8,
> > > +     .val_bits = 8,
> > > +     .max_register = BQ25792_REG48_PART_INFORMATION,
> > > +     .cache_type = REGCACHE_MAPLE,
> > > +     .wr_table = &bq25792_writeable_regs,
> > > +     .volatile_table = &bq25792_volatile_regs,
> > > +};
> > > +
> > >  static const struct mfd_cell cells[] = {
> > >       MFD_CELL_NAME("bq257xx-regulator"),
> > >       MFD_CELL_NAME("bq257xx-charger"),
> > > @@ -46,6 +79,7 @@ static const struct mfd_cell cells[] = {
> > >
> > >  static int bq257xx_probe(struct i2c_client *client)
> > >  {
> > > +     const struct regmap_config *rcfg;
> > >       struct bq257xx_device *ddata;
> > >       int ret;
> > >
> > > @@ -53,9 +87,21 @@ static int bq257xx_probe(struct i2c_client *client)
> > >       if (!ddata)
> > >               return -ENOMEM;
> > >
> > > +     ddata->type = (uintptr_t)i2c_get_match_data(client);
> > >       ddata->client = client;
> > >
> > > -     ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
> > > +     switch (ddata->type) {
> > > +     case BQ25703A:
> > > +             rcfg = &bq25703_regmap_config;
> > > +             break;
> > > +     case BQ25792:
> > > +             rcfg = &bq25792_regmap_config;
> > > +             break;
> > > +     default:
> > > +             return dev_err_probe(&client->dev, -EINVAL, "Unsupported device type\n");
> >
> > Nit: Shouldn't we be returning '-ENODEV' here for an unsupported device?
> 
> Hi Lee,
> 
> Indeed, I've had a quick look and other drivers seem to return -ENODEV
> in similar situations. Shall I respin a new version with that change?

Yes please.  And add a change log so I am reminded of it.

-- 
Lee Jones [李琼斯]
