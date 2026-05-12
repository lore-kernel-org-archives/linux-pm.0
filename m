Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34739DBDD
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576170; cv=none; b=WRSJhSpT5OjbuFCr/teGITMjbfcbnCTEmyzEnta6EPZ9Su04GPz7qTKVX4j08jyzwlOIEQ9s0lIR268DSZZEPn7FfJbYFY0S6gpOn3Pd5FV/GeGqlLQmlDjNmnagLqEcH3ozymKBjCe0H55XSF3CUsZ/lS4ZV+FBYHHvROIBKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576170; c=relaxed/simple;
	bh=ypEdE9S5W+el7BIfAW6PiDD5x4AkWrlByb2LeodoAac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLCbyzJlwuS6S79jSvpBW3h84CxTnBxeDLMdZvMeQcP3rbAIDsf1lXZaNFCBCSoYDjcCMTgDjXhkeW24TBoBt71VawUFmO15t5x/1LSz3oHaIWGXZ9tw2zsXkk3emzOXu4VP9ugBIQNWC49CF7ZlOPmPvSb03y1ygYSItMpt1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=u3/+/i0k; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="u3/+/i0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778576151; x=1778835351;
	bh=WkOaXzKPMuxC5YGc6fREz2IvVZ152n0pdW2k9zoo3oc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=u3/+/i0kg2rBQhVXxJemYSUcFAGCTQQ5eoCfvqgeXVzweKsu9dyDZqh1kHcAT5SEY
	 mQ+DTe+TrXX/uL/DZc3SyZ38hw2gO7HNpiFSj7TD7Ehq+pYyzxurFV0HjjLtu1eNTl
	 zrEeGMKk5pPvFwKkLtIVxUzMgdCgcNofjtO6D1gElCGO1lVHG7UNzUyJ+hAhDhYHfR
	 UpfJlX6JvTnkRYftUjyZpxc/eaBPdcFV9B6BmBDUbi0E7mx0pXKK+uZuOCkVYSWg6P
	 eS5OQmKBJPZMQrY0w+r996i5NkPtz0X/7ppBiM8aATXs99rfikyPazuN2FL/Jb3G/h
	 Eqn06hkG1gDlg==
Date: Tue, 12 May 2026 08:55:44 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 07/16] thermal: mediatek: add PMIC thermal support
Message-ID: <j2uhavC9edilBoD6VJnlz8cCmMPhE9rQavh1epqLk61zrlZ3k1rqlyj8fVYWnkddIY1fEfPk1DfcW09i39hd-Q7I9Y8Vxd0w8C2eCjVGLc4=@protonmail.com>
In-Reply-To: <CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-7-3efcba579e88@protonmail.com> <CAHp75VfgrbEDLavMKFp2maFCH08RBUxF2wYhh56GG1HCq4ogmA@mail.gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 981c736e97e4dbd1e20caa42f42d8805c8c23015
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 12th, 2026 at 10:05 AM, Andy Shevchenko <andy.shevchenko@gm=
ail.com> wrote:

> On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
> <devnull+rva333.protonmail.com@kernel.org> wrote:

...

> > +#include <linux/kernel.h>
>
> No way the driver(s) nowadays use this header. Please, drop it and add
> the ones that are really in use (there are missing ones).

Is there a tool or script that can check for IWYU? For example,
the u32 and s32 types are defined in the asm-generic/int-ll64.h, which
is not used by any device driver. Instead, types.h should be used.
It's difficult to guess which header to use for a given type/function.

I've tried include-what-you-use [1], but it gives bad results like
"add #include <asm-generic/int-ll64.h> // for u32".

> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
>
> > +#include <linux/slab.h>
>
> Is it used?

Yes, without slab.h the __free would complain about missing __free_kfree,
which is DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T)).

...

> > +#define MT6323_ADC_VOLTAGE_RANGE       1800
> > +#define MT6323_ADC_RESOLUTION          32768
>
> These two ring a bell with the first code patch. Are they the same?
> Can they be deduplicated?

They can, but I doubt it's worth creating a header just for 2 constants.
It would look too small compared to the other headers in the include/linux/=
iio/adc.

1: https://github.com/include-what-you-use/include-what-you-use

Best regards,
Roman
