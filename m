Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21F3D7D74
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220963; cv=pass; b=ImNXmavkoIxFaEleebe3UlmIanbMQFp4WikaD7n4/qqjvAYMFjDy7LW4SjFffCAC7F9F2dUnNuQNCDPk/fbM2QkKYPzsXkUiaHhNmpURGzuLUcF782lKRANCOvh16Cv5PXRAngnWIwMDS9taYEroMKocqRtFHt2KXiw/35gopyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220963; c=relaxed/simple;
	bh=zBx9gnNsB9NSi+9Ij72hy3OCPS2lsLev1LAk6e7qJ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjSyTkjV+A3nBpT59tpWxOfONfyxLjYEFmLwAqWc4rWkROLGS1YGizSrwEf1ZzqjBW+uV5x9ocOd8YywG3YDd1QUJbH2syNQg+ZtZTr1qcEvLTo9rvBTaIx1HDUEn/av4Ow6HrzUbtJCKycnUv39izpJQ8QhZ5AQt4psjKA/3jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=C6aa4ykV; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="C6aa4ykV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f9568e074so2270692766b.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773220958; cv=none;
        d=google.com; s=arc-20240605;
        b=iWxCVJ/Y68oX0DAvbTxz0quZJ+AbGlhazLha1gI2fIEtH99R7joRQOeMk4hWp1qS6j
         uVKzieq3nJ5GATiaPlR60H6/wcXAjB7oTSb2S9WnJT5wrzrpk60r/OWsjonA7M0jIMK+
         Ow2ncRQ7nWW+TptB5QQXeYBME3OO6r5Y+JoTzq0EADsewZyx+8KoVm9N5V/M8I2+bdxP
         Tq7XYkM/ay7+J4Ujy2jpCbPf2Bk4bAGpCyQsQd9jIa6CKe5TTQJNeq0q1VblITU9w3Qh
         1nigK33PycrjQopefREGUplvNZ8IrGv6uPG8r0w0wYeIOoZ8xuwMbabgfNeGpL8IOT7U
         cm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=klh9S7GuSCGDLDo0zlg3/zkjEOQHM6MtHgF3cZ88Urs=;
        fh=uGu26dEB6//Ig2+93QeDwVDLwPK5Px36f54yIycn2e0=;
        b=TWrqHbkHsm/kncmT6gY9l+7CoEKbEEMlFc3Ymz0oFP+mWeDheBKafoMU5GSZDItYA6
         tLLIuIqQYV4Xdwl9JwrF/cYQS0XelGuckxCLOgkeaD3W2K13BA2g0QEXz64plHB0LWh0
         hN5sHivnRj/cLidS3yEhavhLkNEQhFYAhaoy0AS4b6mNRDaKpI9JpDBXtcDKYNFCfM5L
         tDVbgVIj/dR8L+sff0+cV5DxZqIWsPUvtu1tOstBMz/d2N8X9rqdPRnm2c3jlknEPBIA
         qdixmkJd1l1DZX6RapgBZMV2lJtbXCTvfKW3Uw8usWMYFwu4F3ml+oOJiKKH6DAYIoWW
         surg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773220958; x=1773825758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klh9S7GuSCGDLDo0zlg3/zkjEOQHM6MtHgF3cZ88Urs=;
        b=C6aa4ykVBB6xrUlkPOYyxPz5ylZ9amf7QAsy934xq8GlkXoml8fXvFvc7FRDF6kl1N
         VrmAOhmYYNu7wIVWumwE2Zsj/nRajokIf/+Aai1M3pYWY0KM7aJu6iMiB3+ipq1jrqyq
         M+C6ySgYoo+nvFd/NrEelM3x05Y95ZY48fip192Thf1RsFSVkWBCjMoXFEMIraRZaz18
         yUFJuHIooQm+dd1HVcuBZIZl9sVtNsRMKKewsUtAom15GeKSMZDcNiuPxAvPH6gp2aJ1
         TMs3PCVU79UtBv8BIP3FdCoS4T7XlWmwPNO6OFIwdEDP/ST5sVFocg5PwPytlMnttRzR
         wcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220958; x=1773825758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=klh9S7GuSCGDLDo0zlg3/zkjEOQHM6MtHgF3cZ88Urs=;
        b=VZlOlo5JEWIJe9IN+oGrFXx6dPFE/k3A6wbj0lipXz9G7Qz61EJFs8mD2d8g88mXHo
         9IerIthbNJzp39srd/Hk0+y3KkP4AD+5j/oDpuhBvViuUL41pLDA3qfZKmWAvegInN7j
         gbNlgPaGwdcVlOnTHSON8HDveuRPJXNaJpGEx6cX6Q/wXwK6bnuLeZgrOFRd3BLVMckG
         gWwvFbg8lCDwO4PM7oAnv5ov/OekJkMp2ZIKo8LPwz1AgMpluKd7ty84/uNJZlPGOXnh
         0QIgfoPgG/T7xgFUKDUWdqaObRlIoaZoc81xiDYj/h+g9mfkXFBhO1fAB1uu8kkjG+bk
         OcRw==
X-Forwarded-Encrypted: i=1; AJvYcCW/mOGMxSS/h7sTuPdfsCBdIj8uQhDmOJLS4Kt3wSVWI19l4gSnlLnbApHoHNMuv0lXSf2DVLS1Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhBf2SrRAIqDyALNZ0GlCKSf2lX/uxflBnu4r2QZXy5FGc+Ph
	GmwZPkiMhTv50hOrJPkoxdgzB9WhSmcxNIDYMHwd9EY0x+pS4DLP7jdFt1TmRElg87zKl7aH1iz
	tz8OKRpoXmoF0P/OxPtyl/YPMzuPpO79KaFSp+9SQPg==
X-Gm-Gg: ATEYQzyCi0ybhXwWXXiX2/eLskWCYNCmlWj2dNM/10k8REx//S2vlY/wTrdNbp60WFJ
	2a6j2PTQJvm4DZuyBv56kliME6c/+80BLdRsBict4Le2Z+OA/+3xFcWxJEcpSP+82ViyqBQmStT
	x9JKhVdxT0y/cTFTCthmuOLZqeC1zO7d31zlctT0rznbEbQUxK9JKjQgLBeetZzbxwlZH42/z3K
	NUEBqbqs17mU3rB7JoP/KPLZIMx4xMIRq2WNQpS2WOC2erXI038vp4Ke2G48fLq6hpv2BNQBL5E
	AVKVBjf7hFn4wu4XMg==
X-Received: by 2002:a17:907:1b28:b0:b96:eb7e:bc3b with SMTP id
 a640c23a62f3a-b972e530602mr92994266b.49.1773220957598; Wed, 11 Mar 2026
 02:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-11-02f8e232d63b@flipper.net> <abEpAs5O1a3HqFTJ@venus>
In-Reply-To: <abEpAs5O1a3HqFTJ@venus>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 13:22:29 +0400
X-Gm-Features: AaiRm51i3wtRA2Tj_AVQFWiCPVOfdWRpC8ahXTfenbFGXvMip4nTXSyf9FEPXiM
Message-ID: <CAKTNdwEJei8duZAJDK6w=bJemnDbnnWAh5v7ZmqtSzUQVfUSSg@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] power: supply: bq257xx: Add support for BQ25792
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:52=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hello Alexey,
>
> On Tue, Mar 10, 2026 at 01:28:35PM +0400, Alexey Charkov wrote:
> > Add support for TI BQ25792 integrated battery charger and buck-boost
> > converter.
> >
> > It shares high-level logic of operation with the already supported
> > BQ25703A, but has a different register map, bit definitions and some of
> > the lower-level hardware states.
> >
> > Tested-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/power/supply/bq257xx_charger.c | 492 +++++++++++++++++++++++++=
+++++++-
> >  include/linux/mfd/bq257xx.h            |   6 +-
> >  2 files changed, 493 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/sup=
ply/bq257xx_charger.c
> > index 951abd035fc5..0bbb0a8b5f55 100644
> > --- a/drivers/power/supply/bq257xx_charger.c
> > +++ b/drivers/power/supply/bq257xx_charger.c
> > @@ -5,6 +5,7 @@
> >   */
> >
> >  #include <linux/bitfield.h>
> > +#include <linux/byteorder/generic.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mfd/bq257xx.h>
> > @@ -18,12 +19,19 @@ struct bq257xx_chg;
> >
> >  /**
> >   * struct bq257xx_chip_info - chip specific routines
> > + * @default_iindpm_uA: default input current limit in microamps
> >   * @bq257xx_hw_init: init function for hw
> >   * @bq257xx_hw_shutdown: shutdown function for hw
> >   * @bq257xx_get_state: get and update state of hardware
> > + * @bq257xx_get_ichg: get maximum charge current (in uA)
> >   * @bq257xx_set_ichg: set maximum charge current (in uA)
> > + * @bq257xx_get_vbatreg: get maximum charge voltage (in uV)
> >   * @bq257xx_set_vbatreg: set maximum charge voltage (in uV)
> > + * @bq257xx_get_iindpm: get maximum input current (in uA)
> >   * @bq257xx_set_iindpm: set maximum input current (in uA)
> > + * @bq257xx_get_cur: get battery current from ADC (in uA)
> > + * @bq257xx_get_vbat: get battery voltage from ADC (in uV)
> > + * @bq257xx_get_min_vsys: get minimum system voltage (in uV)
> >   */
> >  struct bq257xx_chip_info {
> >       int default_iindpm_uA;
> > @@ -47,8 +55,10 @@ struct bq257xx_chip_info {
> >   * @bq: parent MFD device
> >   * @charger: power supply device
> >   * @online: charger input is present
> > + * @charging: charger is actively charging the battery
> >   * @fast_charge: charger is in fast charge mode
> >   * @pre_charge: charger is in pre-charge mode
> > + * @overvoltage: overvoltage fault detected
> >   * @ov_fault: charger reports over voltage fault
> >   * @batoc_fault: charger reports battery over current fault
> >   * @oc_fault: charger reports over current fault
> > @@ -79,6 +89,53 @@ struct bq257xx_chg {
> >       u32 vsys_min;
> >  };
>
> The above belong into the previous patches that actually added the
> fields to the structs :)

Fair enough, will move it there. Thanks for spotting!

> > + * bq25792_read16() - Read a 16-bit value from device register
> > + * @pdata: driver platform data
> > + * @reg: register address to read from
> > + * @val: pointer to store the register value
> > + *
> > + * Read a 16-bit big-endian value from the BQ25792 device via regmap
> > + * and convert to CPU byte order.
> > + *
> > + * Return: Returns 0 on success or error on failure to read.
> > + */
> > +static int bq25792_read16(struct bq257xx_chg *pdata, unsigned int reg,=
 u16 *val)
> > +{
> > +     __be16 regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_raw_read(pdata->bq->regmap, reg, &regval, sizeof(r=
egval));
> > +     if (ret)
> > +             return ret;
> > +
> > +     *val =3D be16_to_cpu(regval);
> > +     return 0;
> > +}
> > +
> > +/**
> > + * bq25792_write16() - Write a 16-bit value to device register
> > + * @pdata: driver platform data
> > + * @reg: register address to write to
> > + * @val: 16-bit value to write in CPU byte order
> > + *
> > + * Convert the value to big-endian and write a 16-bit value to the
> > + * BQ25792 device via regmap.
> > + *
> > + * Return: Returns 0 on success or error on failure to write.
> > + */
> > +static int bq25792_write16(struct bq257xx_chg *pdata, unsigned int reg=
, u16 val)
> > +{
> > +     __be16 regval =3D cpu_to_be16(val);
> > +     int ret;
> > +
> > +     ret =3D regmap_raw_write(pdata->bq->regmap, reg, &regval, sizeof(=
regval));
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
>
> Are there big _and_ little endian registers on the bq25792? Otherwise I
> would expect this to be done by properly configuring regmap.

Oh it's such a pain actually. Most of its registers are 8-bit, but
select few are 16-bit big endian. So if one tries to configure the
regmap for 16-bit big-endian, it incorrectly accesses the 8-bit ones,
as the least significant byte is then not at the right address (and it
also spoils unrelated registers at write). Setting big endian with
8-bit registers in the regmap doesn't make much sense as there is no
endianness with bytes. So I ended up setting the regmap to 8-bit
registers without any endianness flags, and dealing with the
big-endian 16-bit ones manually as above.

If there is a more elegant way to do that please let me know, because
I'm not a fan of that manual endianness trickery myself.

Thanks a lot,
Alexey
