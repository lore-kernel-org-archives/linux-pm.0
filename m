Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7ED384CDD
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568271; cv=pass; b=YGPlM3JkOAXqoCHWVxK0tDXAhwpCihUwMio5avFhJSSeifmpUDVDh/hIQVlAPfVvwuiE5aHv4g4OIBJXQ1hHBx5nlr2vica/q4tAPWl3PvH8/dYP0BkwbBVjc8duePgpNzRcJd1ceNqYrKKe/K+18keVwE1AeaOnePAzWhjd7s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568271; c=relaxed/simple;
	bh=FjgzfIcEzFg1b096kbJ3RIQzKX5tIHlT5F677cNirk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXwVxjW5g4d3Jwy+Sa833riu8uj0Vrk1j29OZkKNM3j8dF/3QWWB5tFSTRCoUZmZo2HSLA0yx/jQ3ZQvL+IWRIGIFtvbRtwbD1CgIlHYro5lxgATK+fwYhu4Y0hnhDqHGF8SPmpIxRBp9wjDhs/SmYzY50vGSo2wXsyRxuEjO0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZ8k1arB; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZ8k1arB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso682076766b.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 23:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568256; cv=none;
        d=google.com; s=arc-20240605;
        b=cTTrZf7iBWW30C+ZpnmraN9pz8DEn6EHKLzReTTEzYYIUG1AtrwjQV5omE1DTEvtsV
         q9U/HssmZSIl7fo5rXwjb4tFuFfrXwEGIqYppkp+7XCPuGYa5I6nZAuiDat19kWeibyb
         3hcxjU6nG0ShbOTzXoKC9wOM36R50njaxSR7OrrVrNdF4XwquhcWaoQoacGAxUtbhzde
         i4ObsVCckQq2h7fd+XzaMhBqEW+NfQAcNlaR9+Zt1zbNrDH5nTfQj81QX4Azaq/BMImY
         Rq3UGwi/o0kS1oikMTY+HFSUO82v845LfH4pI8leue1IB7mzx/S1uqyyIHWoIYp/0F1U
         70/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        fh=ymCBbri7CFyKdVdY2w/oVjV2Zm+v7H9nECkp7a5+3II=;
        b=l0UOvepbD6DwcT83j2o2OL73fpKznO5JMML2JFzPTvAPXNBcbkEil7aTBuEZNKO/cw
         zLiox7Q8OEL+cjBC/hkbRXxOtOB/mSH+/l5R4iZ6kevD0ygI47sHmENsB0rM+c2W3hKl
         LJLCn1IWD4H2iwXyBCcIUTtKMUTfhyJyn3m2PJr1nytHRJj1rQ5RZPDqbU4C0/Kw8VNE
         u7JzGhw8zJlFbgeyLrLJMPkC8Oo7eomiMjzGTlMsvhLwp67ZaqIRA808Rn8ylJkz2zrt
         Dz1DZucsyHemRlqRcgGKVGDQg3j/9rBuFLbi3wtBZmFBqSW2kLBmGzq/mosk0BMxOUQr
         LKTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568256; x=1779173056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        b=sZ8k1arBo/iltA0Zjf84h/5CURPNlBi/IQ10S32q1NesXxFDyIwF1txkWydnxMi1j1
         JtwnGLPQFB3sBFbZmkQgffqpzZ69/vklgxsF4by7Fu/h3SMsgM/FNkKBJRx2JcXbAyJt
         QcxHjT54H1WIf4CU1DDFVDRTX71KQMo29gOTkJwH0uhBZ2Nkr0StX8fOj7vY018pkNjd
         0LVy+gbJ9vOOZfcP09HIdeXsGxL/++qHn8h0ECVgQvtgroMag2bIzASLM6QJo7KD8n2V
         wd9ZpjCbfT/NXHweROqU0Y1ikwhKBEaq9LRpXZZFN2i5AF9h61R3zgbQCr3rG1yg5TUD
         5gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568256; x=1779173056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        b=eQGyLurZDd2oq96tVOQl50EntSV/3SyUqevBjX39JlF+EEkuiainqRfkPLyN5p9r+U
         1Gk/FFISfcM093nMFx+JcU2It8Iv8lmttxUr+jehqcWIh9H/CJ55xX0RE/bKILP8oSBT
         SrWz2SXetnal0pYsPHLBkDbLGZKElFjQWfCNC+0k0xYkQEBdQaNqbkSwALW/z/Xr63zi
         ntAUZk8oo5EC93QypqsSCgFd2pTSB2aYdmX8boKeNZAhqudSiQ8AOY1nu8eoF36WHk/6
         D1nPm74l1kVZi7zzjHmUiQD2M4NsTHzDjhPmnuJcnMqkEyYiOgadGW/CgQzvgJeLlT7W
         PfVA==
X-Forwarded-Encrypted: i=1; AFNElJ+3k7qzkfKTJfqjt2xjOfZlNPOXBBKVT6RnPKj1cxK/hr3vQpPG61t3SLFQdNqV71+Xc053Qo+erw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1m99Lu7kQqzc6Y+V8WQ1fjto2kG7mUPgqXSglM+dknEOxfgg
	dctYVy6v9qHEAPbxVPbosCU3Jy/fwDw4nISgie1/eKewYcvQ7JfLusHIvXoyJZdf6SOd5Mdn+tp
	Cn6NCE5qQg6+1FBeKM4oMX8vB8j2HwDQiIGjAGUge4g==
X-Gm-Gg: Acq92OEh/NyK2ltz6ddAxLKK8jBf2dqQow9BpzwbihgOx1/O7BrqzGCHAndW1lFA4ZQ
	J15iVijnaJbpNkOXJfJMlhnzEzK5vuZGbaarCLTUNHylmMgIg3FBGb/v/fLFK7Nj3OdmcjrUbda
	saG7N54xQrAXe+UzqG4XoCwSoCnbLIp5lPjEwslBCcGcJ1AdEJLHv+1VjRZusqTkuh08+TohPgy
	ZDMyfg86WFL4XnOxlWcKxMyvcSL29bIzM5dIZS25SaNh6yxVN9mGGly1s5k5tY+9sAqkcwR0Zw1
	0BD05xy3cXVtBKDp385qf/gWYnk8Te/IrdIuRhT6r3PscbuCWBcd8bk0XrNOSVqDBasGv3P38h3
	YZEp8QQM=
X-Received: by 2002:a17:907:728f:b0:bd1:d244:ca24 with SMTP id
 a640c23a62f3a-bd28e412eadmr84527766b.14.1778568255436; Mon, 11 May 2026
 23:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 09:43:38 +0300
X-Gm-Features: AVHnY4ISc11FAtQmtWdJlGYyo0XawWUZJbHlaYzrkD_vnuBBxzJNK6YMpmrGwVg
Message-ID: <CAHp75VdtORjmCCWy3-oiN-RQd+s7z=2G4s8hemv3xrq47vXu5g@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] iio: adc: mediatek: add mt6323 PMIC AUXADC driver
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
>
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/stringify.h>

+ time.h // USEC_PER_MSEC

> +#include <linux/types.h>

...

> +#define AUXADC_TRIM_CH2                (3 << 10)
> +#define AUXADC_TRIM_CH4                (3 << 8)
> +#define AUXADC_TRIM_CH5                (3 << 4)
> +#define AUXADC_TRIM_CH6                (3 << 2)

Without a comment it's hard to say if these are like masks or actual
values. Can you clarify that in the comment on top of these four?

> +#define VOLTAGE_FULL_RANGE     1800

Are there any units? Are they millivolts or is it just some scale?

...

> +#define MTK_PMIC_IIO_CHAN(_name, _idx, _ch_type)       \
> +{                                                      \
> +       .type =3D _ch_type,                              \
> +       .indexed =3D 1,                                  \
> +       .channel =3D _idx,                               \
> +       .address =3D _idx,                               \
> +       .datasheet_name =3D __stringify(_name),          \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +                             BIT(IIO_CHAN_INFO_SCALE) \

Keep the trailing comma as this is not a terminator.

> +}

...

> +/**
> + * struct mt6323_auxadc - Main driver structure
> + * @regmap:        Regmap from PWRAP
> + * @lock:          Mutex to serialize AUXADC reading vs configuration
> + *
> + * The MediaTek MT6323 (as well as lot of other PMICs) have the followin=
g hierarchy:
> + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> + *
> + * Therefore, PWRAP regmap should be get using dev->parent->parent.

get --> obtained

> + */

...

> +static int mt6323_auxadc_prepare_channel(struct mt6323_auxadc *auxadc)
> +{
> +       struct regmap *map =3D auxadc->regmap;
> +       u32 val;
> +       int ret;
> +
> +       ret =3D regmap_read(map, MT6323_AUXADC_CON19, &val);
> +       if (ret)
> +               return ret;
> +
> +       /* The ADC is idle */
> +       if (!(val & AUXADC_DECI_GDLY_MASK))
> +               return 0;
> +
> +       ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19, val,
> +                                      !(val & AUXADC_ADC19_BUSY_MASK), 1=
0, 500);

It's better to have a logical split

       ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19,
                                      val, !(val & AUXADC_ADC19_BUSY_MASK),
                                      10, 500);

> +       if (ret)
> +               return ret;
> +
> +       return regmap_clear_bits(map, MT6323_AUXADC_CON19,
> +                                AUXADC_DECI_GDLY_MASK);
> +}

...

> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +                             const struct iio_chan_spec *chan, int *out)
> +{
> +       struct regmap *map =3D auxadc->regmap;
> +       u32 val, reg =3D mt6323_auxadc_channel_to_reg(chan->address);
> +       int ret;
> +
> +       ret =3D regmap_read_poll_timeout(map, reg, val, (val & AUXADC_RDY=
_MASK),

Parentheses are not needed in this case. But I'm fine with it here as
it probably makes it easier to get the idea.

> +                                      1 * USEC_PER_MSEC, 100 * USEC_PER_=
MSEC);
> +       if (ret)
> +               return ret;
> +
> +       *out =3D FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +       return 0;
> +}
> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan, int *=
val,
> +                                 int *val2, long mask)

Logical split

static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
                                 const struct iio_chan_spec *chan,
                                 int *val, int *val2, long mask)

> +{
> +       struct mt6323_auxadc *auxadc =3D iio_priv(indio_dev);
> +       int ret, mult =3D 1;

Decouple assignment and definition. These types of assignments are
hard to maintain and might lead to subtle mistakes in the future.

> +       if (mask =3D=3D IIO_CHAN_INFO_RAW) {
> +               guard(mutex)(&auxadc->lock);
> +               ret =3D mt6323_auxadc_prepare_channel(auxadc);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D mt6323_auxadc_request(auxadc, chan->address);
> +               if (ret)
> +                       return ret;

Please, add a comment with the reference to a datasheet (ideally)
explaining this sleep.

> +               fsleep(300);
> +
> +               ret =3D mt6323_auxadc_read(auxadc, chan, val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       } else if (mask =3D=3D IIO_CHAN_INFO_SCALE) {

Redundant 'else'

> +               if (chan->channel =3D=3D MT6323_AUXADC_ISENSE ||
> +                   chan->channel =3D=3D MT6323_AUXADC_BATSNS)
> +                       mult =3D 4;
> +
> +               *val =3D mult * VOLTAGE_FULL_RANGE;
> +               *val2 =3D AUXADC_PRECISE;
> +
> +               return IIO_VAL_FRACTIONAL;

> +       } else

Ditto, and it's the wrong style. Read the Coding Style documentation
to clarify this.

> +               return -EINVAL;
> +}

...

> +       ret =3D devm_mutex_init(dev, &auxadc->lock);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize mute=
x\n");

Unneeded error message. Most likely it's -ENOMEM, which will be
ignored by dev_err_probe() anyway.

...

> +       ret =3D devm_iio_device_register(dev, iio);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to register iio de=
vice\n");

If you don't see the device, it's failed to register, do we need this messa=
ge?

--=20
With Best Regards,
Andy Shevchenko
