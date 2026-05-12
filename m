Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D112379C30
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569545; cv=pass; b=lGeZo9ZnyMLE5sIdSEyJM9UGQ6mnmG67gV2M8I2wOLQoIAbV8SjT5WRbfEIrXfXPnYMkgGJOgKf4aaMu4Gkda/NLFSAsRvWlgyXyUublUhO3+hpaAMiwL5FBc3XasNgYV69r+2Fz+Bi8HJErN1UgbIMa6kQBlRXHIzAXotQrgxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569545; c=relaxed/simple;
	bh=iUA4KanOx+PRFfzuu3dxsfCzyK7fuN7zilHuCkz4ENU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkQLRSu+GtBEEA0/IvG4hGh1aGuBi5dDscpzQiCinRdDknIWa7c+FHouDi2O7KkuSy5pbcobTobo6m236CNqOZjpv2rgu51088qQqIXh1HIJptHTBjjXEGRPq6x46CqfDU6QDgzxLfILQ+47PrdqVKZqM0yoddUz1IJ4qdcV4qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxYqZB+/; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxYqZB+/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso9834478a12.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 00:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778569534; cv=none;
        d=google.com; s=arc-20240605;
        b=NkBwqlFCTE/3wgq5XQOtWHSP7mMaw6qC7fpr2FF27Uz15uxnbiIv52ezrsmgqBCPVL
         Ebuw63HyBiOnG13hauU8N7CFa+ax5aNaCnrxVb6qaS5BdHCUFi/0Oiz9R+P+e1B5FIji
         dZsajIXE2bzxrKiwTvs1uqgA1YdC7lEw089A5wObzFAkDmKHQ9r9eXcDkjIoqOTtW7Zy
         4hjRbqvTjLUb/xbq61gWJn2+/TZS+xSgfH7/CiO4khITDwLuZbAltnYtJ+TyMfd+lJs7
         XbvpgnjwSTcxxTZuD8Ko0zgVf1TkN0IabmDRklrzQFA6AcR83hoa9Bcb1Lyqv6mBBnYt
         kQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        fh=MPhg6wC7AD7Of64eKLlDWFsnX/UC827I9tAKyzQHdIw=;
        b=js9Utzp4GQJLa4e40qz8k3BFqSfMdbupff3diSUHUxidkzmwMruty4sqFb1LfGZEn4
         4TBAPaWKJripDGEaqlrGJexwG2lM2E9uXdLr73XX8dPZnoBAFmbLnzL3ZHz2gRNI7UGb
         QAKo8zt//jsFncGZIDz5nQfKtMGwG2D49aT7bF9LVL8EKy6a0rYlnyVsLniRl0OBLDRk
         y7Rxsx2C0zAr5AE6+nCUDudEIjA6r3UqLWNxvKO6xQvMU97EufIa4AnUvBUR2JKfpVj9
         bhoywRdRgwEATqxdvABFc1x+tpLXO+F03sCXzW09EdcMTL9AraCYwxISp9n8hdPPNPhq
         ldrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569534; x=1779174334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        b=rxYqZB+/UHFvOKizRzFW+V6ETszlYvcxLmNJyeZiLpObexJbJF04PmilU8HL5ysClb
         P+bWv3h2BLwYiI0+XqjR6wCDWdJSO32OOH4hzcuYXcFyD7gtQYBmVINNd4EiqMVS/ern
         4utktMp9gVUDnsM8TOIf6dbKmPPyZySlhmbfyy7D5lxJsc4Y4CQ1o4PGAbnxJaDCCSyl
         sIYyHYjZ13Q0RJ+mfzVDtX3H+6RW7nInH5BpyTb6/Y/F1TIATduf7V54wT3mhq9hEQqX
         wm4s0g9PXWmGppFSCReIatjLiMQ0XsDThgBbJjPbgM5j/Xhx+EmIXwTDbI/p9hTTC2Jb
         9w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569534; x=1779174334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WKO48wCVFVY/Q3lQzIe4xzewKQpps/o90phN6WWe98=;
        b=YV4x6PMKpVh1EgSSR2hQjh7g44vox6o7KgGRRyffgSR71gg8QNHfEWjvwAD5CAZ17X
         mp5d/zjH2Ieo4AeMh0ksLq+0yX7N+szoDelgi++KM8GUeTzxuF0Gf+g6WljoC6/JQLm1
         uhiuJBWsPKwdkIxW9246p7zJ9oh63txH+ZT01HAWBv47gNGaepB9/ZCC2NWJUy+Ic72p
         xpLoiRfhR2oSvS5r7aLz7Jv8Q4SSL3tzOPj0LQ8RIM/UbprdLhb2zTUA8/mzort5SdVN
         +4zMk6lJDuAS0GM8Z6u2n/gUJNkfIEFCZX7D+u6lV24aEmwkVtuKuvbh3c072n+NrOK5
         +jxA==
X-Forwarded-Encrypted: i=1; AFNElJ/jGfokz6wg8VkV1LFzu55/HEQtI8fN6eMM+i3sXjhd0mChKYQ5AhyWlNWxK17yi3h4uZsP7yqGYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqGvERvW9coH41X6fPPv6xcjNyeRdWO9hOc355C9VUEhoW6ya
	3W1x3ZyZ68rA0lWCTxqYysbqT3WW7umq79DiUqKkaY9sf481oDl3r0kFDhuauYnZc985ExQ/Wgq
	NGAFoePUHZ6jOnSBxCix+xL9VXESvqQg=
X-Gm-Gg: Acq92OHaA0tdqzb0w7NU7e0oeffGB3bd3zQl1yoovz7MXvohHvPhmIEeh/p8b58yM+s
	S6b3mq7mFTtbE6pnr+JlcRA0XZbtDxU0sMY20stEZJ0+xCq8QBadoVjrSqiDPjJPvHsQa25Z5AM
	aUChzK3eQ9eRl09OVZ/UKlQx8Ce9XGxOSJ0KWfn96kqtLGaIxcj1ZVff6OEmITICoJXuHjy+Rem
	VNcxlHBWS5+1bf8xIbTaG1kpR0zTHL85lIrU70CJuoHE6huyzu0+5XBWDZji0kPoH/NeSmWbXmn
	0dc9vWTsyzP4pgJzfnSmn7K6J2Wf1vm6WHRvfzKXFKk3AS7FJpZ7OM8uGLEtDNgJHCFxz6oFRZX
	iNXioNjU=
X-Received: by 2002:a17:907:8b87:b0:bcd:2dbd:8241 with SMTP id
 a640c23a62f3a-bcd2dbd8f82mr647649566b.5.1778569533677; Tue, 12 May 2026
 00:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-7-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 10:04:56 +0300
X-Gm-Features: AVHnY4Ir9Mq_UQabCQBoJYVIwG-u_PpfuUXY4u_xRVfJJhNKJhDnleR-UqRVa9w
Message-ID: <CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] thermal: mediatek: add PMIC thermal support
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
> Add a new driver to support thermal monitoring on MediaTek PMICs.
>
> The driver retrieves calibration data from EFUSE, calculates the
> temperature using a linear interpolation, and registers the device with
> the thermal framework.
>
> Initial support is added for the mt6323 PMIC.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
> +#include <linux/iio/consumer.h>

> +#include <linux/kernel.h>

No way the driver(s) nowadays use this header. Please, drop it and add
the ones that are really in use (there are missing ones).

> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

> +#include <linux/slab.h>

Is it used?

> +#include <linux/thermal.h>

Missing types.h

> +#include <linux/units.h>

...

> +#define MT6323_ADC_VOLTAGE_RANGE       1800
> +#define MT6323_ADC_RESOLUTION          32768

These two ring a bell with the first code patch. Are they the same?
Can they be deduplicated?

...

> +       ret =3D iio_read_channel_processed(sensor->adc_channel, &raw);
> +       if (ret < 0) {

Do we need that ' < 0' part? What is the meaning of positive returned
value (if any) and why do we ignore that? Same question to all similar
checks in the whole series.

> +               dev_err(sensor->mt->dev, "failed to read iio channel: %d\=
n",
> +                       ret);
> +               return ret;
> +       }

...

> +       /*
> +        * Temperature coefficient. The o_slope is a trim value applied t=
o
> +        * the base calibration

Respect English grammar and punctuation. Here is the period missing.

> +        */

...

> +static int mtk_pmic_thermal_extract_efuse_mt6323(struct mtk_pmic_thermal=
 *mt,
> +                                                u16 *buf)
> +{
> +       u32 reg;
> +       s32 vts, degc_cali, o_slope, o_slope_sign, id;
> +       int ret;

Better to keep reversed xmas tree order.

> +       return 0;
> +}

...

> +static int mtk_pmic_thermal_get_calib_data(struct device *dev,
> +                                          struct mtk_pmic_thermal *mt)
> +{

> +       void *buf __free(kfree) =3D NULL;

This is a discouraged way of defining variables with __free(). See below.

> +       struct nvmem_cell *cell;
> +       size_t len;
> +       int ret;
> +
> +       cell =3D nvmem_cell_get(dev, NULL);
> +       if (IS_ERR(cell))
> +               return PTR_ERR(cell);

> +       buf =3D nvmem_cell_read(cell, &len);

Should be rather here

       void *buf __free(kfree) =3D nvmem_cell_read(cell, &len);

> +       nvmem_cell_put(cell);
> +
> +       if (IS_ERR(buf)) {
> +               ret =3D PTR_ERR(buf);
> +               buf =3D NULL;
> +               return ret;
> +       }
> +
> +       if (len < 2 * sizeof(u16)) {
> +               dev_err(dev, "invalid calibration data length\n");
> +               return -EINVAL;

return dev_err_probe(...);

> +       }
> +
> +       ret =3D mt->data->extract_efuse(mt, buf);
> +       if (ret) {
> +               dev_info(dev, "device not calibrated, using default value=
s\n");
> +               mt->data->precalc(mt, MT6323_DEFAULT_VTS,
> +                                 MT6323_DEFAULT_DEGC_CALI,
> +                                 MT6323_DEFAULT_SLOPE,
> +                                 MT6323_DEFAULT_SLOPE_SIGN);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mtk_pmic_thermal_init_sensor(struct mtk_pmic_thermal *mt, int=
 id)
> +{
> +       struct mtk_pmic_sensor *sensor =3D &mt->sensors[id];
> +       struct device *dev =3D mt->dev;
> +
> +       sensor->id =3D id;
> +       sensor->mt =3D mt;
> +
> +       if (mt->data->num_sensors > 1)
> +               sensor->adc_channel =3D devm_iio_channel_get(dev, mt->dat=
a->sensors[id]);
> +       else
> +               sensor->adc_channel =3D devm_iio_channel_get(dev, NULL);

> +

Unneeded blank line as the above and below are coupled semantically.

> +       if (IS_ERR(sensor->adc_channel))
> +               return dev_err_probe(dev, PTR_ERR(sensor->adc_channel),
> +                                    "failed to get channel %s\n",
> +                                    mt->data->sensors[id]);
> +
> +       sensor->tzdev =3D devm_thermal_of_zone_register(dev, id, sensor,
> +                                                     &mtk_pmic_thermal_o=
ps);
> +       if (IS_ERR(sensor->tzdev))
> +               return dev_err_probe(dev, PTR_ERR(sensor->tzdev),
> +                                    "failed to register thermal zone %d\=
n", id);
> +
> +       return 0;
> +}

...

> +static const struct of_device_id mtk_pmic_thermal_of_match[] =3D {
> +       { .compatible =3D "mediatek,mt6323-thermal",
> +         .data =3D &mt6323_thermal_data },
> +       { /* sentinel */ },

No comma for the terminator entry.

> +};

--=20
With Best Regards,
Andy Shevchenko
