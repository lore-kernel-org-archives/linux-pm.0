Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793783974;
	b=fwrXgMGS+gSf1dDvuAUycXaxEN2+MBchZDRhbCSV4VlQeZ5BIOHj1QFoPWXJrT+Jacuo
	 F/9V9qLv4fu2JXguwx02VYj/iqlQXc8XuQNPYZ+VNTgmsjNdpDkwqCRVzMBbj+17hLurQ
	 dWmatIXARgbNd459K6mntMWkyp6udDzIbghmhwq8QmoPVGqoekVW6cfuEPiMTmItxm/oK
	 Nmo03D89aEDSVr4rEu0Oyyj8HtZr28c0OVpd0/yV0lqgNEJytdiOqfw7Iud6WbPuw6fGt
	 QC8VNz0bdqJFJtysmpA9mbB3wGDgTXT0ZG14WXErf8/oXS4JRpU88uU7P7pj3kbLrsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YRz/K05YLArkwgmmoG2AbhmGzTf6qgCvL/rORwgm+WE=;
	b=WK2BSWkfkEbIK0Dowrn38lBT1+IgnW7ld518xljgrrXI4PhDHjfKwje/CPY6ANF3s3IK
	 lyLrLSizudqQn38iwS1HGJQlAe5T7LG0SPp5R5KLRgxpMizvK7cPs6p4B0Xa2AAY8PokE
	 pEc6VwFStrP2jCHBrSGZ4DOH7SWu0FP1Z+G5/MCm7Z/GG7B3xei9xeqvYlZ7Nk6CK9nCJ
	 pV/ShlFvpQxglRXaxRsAW6hSxAm88CDSJgtKwyLpdy2amsjv3h2wiCc4TkuIiP35ySzMO
	 XbNJbSIjxAVZOeKKRQ6jxRnnEodBpAwAP7Vf65ZgINLstQC4fc0lGIsTQ3iTI1yiovA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayb69Ya0;
	arc=fail smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E747606A338
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 09:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E747606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayb69Ya0
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so952578eec.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 01:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793783973; cv=none;
        d=google.com; s=arc-20260327;
        b=VFxIwR5DPww4GFjOeCHftCEXdnV4vmngfGJi05f6AefbBHpBORXdJ4SpmaZ8Yh0Lvz
         tlDwtx2DIimhLppRTmNPVxjSLPzNafV+/6mZz8GHu9sqR9xvkE/NzyAw07ogJ2XThYw3
         8Z8EDs7mh1kw/PHtjRITpkR3prHW4WlkRdYLRatTRLlNX/5QlC5W57pOKMR/xhXOThkf
         Xn6Ikaqq5DFplElgZmYMgWL6+MMAl+cIEtBnhugw8Sn6IZPSUDnxVsVcsg1so7QIrdMj
         3AVR8UlsA1AYL/PWzaOTLUTbU6buta01p96zt0KPthIwMYsv2HVSHmZC9Eun/APcGosK
         iIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YRz/K05YLArkwgmmoG2AbhmGzTf6qgCvL/rORwgm+WE=;
        fh=bKiVkR33OGckWgrBVtVbqGq5/+ZI8hA7bK/ckzteKqE=;
        b=TGAsGVzpAcM3CVyfErrmqFpoKK+8L9U1JRcdx1i5jcxfbPm0YDs1kBwnlwbPCVfQ/q
         sWbLHsoCcR+EXU9T1jkVfljac9jP0XZeLgcXHV98lKXu/tV8I0lml1CtHUJ9tbJiPcqO
         6y6jjoMMVZNYJI+pU5m7q2wBZRLfu2SCa5X6k6LyClKoEuZIMaQlIWTlZUrN7Aoyt8b8
         W/XAP2r8xh4Y31r4oW08uS5iBMN+yKGqZ6BE5YyHm2OlK+BNQWn+ThV2NzD5d2I/yN0/
         DZK7BjyBzUNkyxHyD4KUHCWhYl2vx0Lo/Juoj+v0R+Ob2xwqSzM9v2yKCmRUT5EIJ8ja
         L/ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783973; x=1794388773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YRz/K05YLArkwgmmoG2AbhmGzTf6qgCvL/rORwgm+WE=;
        b=ayb69Ya0o3ph0NsLKgZZUPiW2eL5NpQakbmSq8k43meo1an6qOsZDlEClqja0l9yiC
         qlQbarq40NXikJpoLVDStg73boddpAiquWgi05oXTgOeS73aRXuhGeLRIer0V/Ivz8uv
         v637Knpn6gaxU8Fl75XUkf1Wu/vGUJ1QLVL8ZTNuD2uH0y948IIEL388RcdxEcf7Ek2d
         L30ycVVgfTwDPZyeid/m0ce+ots4mOOfju4QjR/9qNipWjguXb1iOs/Ex1RT1tnDxZsQ
         ZNJ7NTpKzI5CCc5IqZTilho7RzIXUY/3DOkQNH3vTlh56SVIqAUrIileY/MPHaNE871h
         vetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783973; x=1794388773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRz/K05YLArkwgmmoG2AbhmGzTf6qgCvL/rORwgm+WE=;
        b=L4/f88Qng6yGbgQm8qdokl9WftVLXA2ldLCiYbkggSSr4Z0lEm+gYtyQF106TxdsRe
         2Mqf1y4RcMeDETy0JXJw4NCvGiRGt1ZtGv0WTUCSZlDY8JTIYH3Gobs6FzGG8EYXnuY6
         cl5DMX5Yc89Fb+DdRjaLXXCBpqVHpEaJjP3e04Zxi9R8aHertLFjY7ZSbwsxO131K6MK
         DsM7/cRbXBxmL6zNpDbghNQ+lLZ8gopJDZc/inqaXZOLzVqnmQCSWvYvBF8RxJ8Ppfrj
         DFUfwAk9R2TheGGpzdWEQNEKDTnnA6izUUQ47mBmRbUWw/NyDeIF5RRJ5ym1vvrVtJGJ
         k24Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1LSsq3sT6lUiI31nhpSs0ty/zuJN0kW2TyamlSkezdLNg/bM+a1nU2fdItdFhudOEW0UP6TGs2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8h+Nm8siiVG88rBqDbQxvavmSbwpyluwFHvpEp4QOBhMOk6ZF+
	vB7mszJ2Hj/18tD/Xp8xGajCqAwMS/RcCEiUH7sf6p+3n6Ntmf3+RxJFlBQ7V6d1Bs+P2Ya5DqC
	XBAHuIuuK761qu5vIrI/Zo8wBZCOr7KU=
X-Gm-Gg: AYBFou1tHwpBltuPZ5pc+2qJhSDXEsX0mIiGl03JAp0vYoqOMe54WGX9yl0MFU/HVMx
	09NbZMBW8Or775IJ7sSkIQhl2uqReHIsFvJ8TS4q7tto8Ezl11sBsC4rKinhNu/Sx9unDLbNad2
	JlGm+rbCRh+x+0ybHFM7WtGWk7fUbyT+uYG63se2Od1nSOKTvCkWwb37JEoBlOi30GEaNgwzTAX
	MtK1Ub4laAOwixoJwVh4DnWkv2ppa6ma3rlTsCLCZEfItwXjdxLCyHNzUDQ3gafFEuRMkQVJHvq
	ifGauipQr/IICUlZkLyRyhtp+IhIIVXF3aBzRMgKQ7fY6oRfunTAftrF1QgwwJf9IJNJv+9GO+D
	7SsGLuM1oitYhwVuh4z2hZ9NlFK12R1DmR6uO/kdnwx+18W9J3JZwZxKdJTR/1XP9Y/gb+g==
X-Received: by 2002:a05:7300:cacb:b0:36a:3310:21a8 with SMTP id
 5a478bee46e88-36a4238da58mr22696876eec.17.1793783973140; Wed, 04 Nov 2026
 01:19:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-6-clamor95@gmail.com>
 <179249575817.1833288.1089755405582445022@kernel.org> <CAPVz0n0=6Z7E9iSc84xL6Jt=Xi=a=qmSwVsT5g-LMZ+mENFkzg@mail.gmail.com>
 <20261104082839.GD792264@google.com>
In-Reply-To: <20261104082839.GD792264@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 4 Nov 2026 11:19:21 +0200
X-Gm-Features: AclHuK-nwA8nmcK4-hyChgffnjaf-dRrb8bQSBvVXY32g8YXDAt5lwFBxCDKvVg
Message-ID: <CAPVz0n2aCy9Kx5kK1EZD3qxN=KCSf=cB7ZnP1SedrrJc13sh2g@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] leds: Add driver for ASUS Transformer LEDs
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 4 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:28=
 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 03 Nov 2026, Svyatoslav Ryhel wrote:
>
> > =D0=B2=D1=82, 3 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
6:03 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
> > > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > >
> > > > ASUS Transformer tablets have a green and an amber LED on both the =
Pad
> > > > and the Dock. If both LEDs are enabled simultaneously, the emitted =
light
> > > > will be yellow.
> > > >
> > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > > ---
> > > >  drivers/leds/Kconfig                    |  11 +++
> > > >  drivers/leds/Makefile                   |   1 +
> > > >  drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++=
++++
> > > >  3 files changed, 137 insertions(+)
> > > >  create mode 100644 drivers/leds/leds-asus-transformer-ec.c
> > > >
> > > > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > > > index 7ec2c8d785426..788e689fe875c 100644
> > > > --- a/drivers/leds/Kconfig
> > > > +++ b/drivers/leds/Kconfig
> > > > @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
> > > >         To compile this driver as a module, choose M here: the modu=
le
> > > >         will be called leds-as3668.
> > > >
> > > > +config LEDS_ASUS_TRANSFORMER_EC
> > > > +     tristate "LED Support for Asus Transformer charging LED"
> > > > +     depends on LEDS_CLASS
> > > > +     depends on MFD_ASUS_TRANSFORMER_EC
> > > > +     help
> > > > +       This option enables support for charging indicator on
> > > > +       Asus Transformer's Pad and its Dock.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the modu=
le
> > > > +       will be called leds-asus-transformer-ec.
> > > > +
> > > >  config LEDS_AW200XX
> > > >       tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20=
108"
> > > >       depends on LEDS_CLASS
> > > > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > > > index 4d4b089156e24..3da746279bb81 100644
> > > > --- a/drivers/leds/Makefile
> > > > +++ b/drivers/leds/Makefile
> > > > @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)          +=3D leds-adp=
5520.o
> > > >  obj-$(CONFIG_LEDS_AN30259A)          +=3D leds-an30259a.o
> > > >  obj-$(CONFIG_LEDS_APU)                       +=3D leds-apu.o
> > > >  obj-$(CONFIG_LEDS_ARIEL)             +=3D leds-ariel.o
> > > > +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)       +=3D leds-asus-transf=
ormer-ec.o
> > > >  obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)  +=3D leds-as3668.o
> > > >  obj-$(CONFIG_LEDS_AW200XX)           +=3D leds-aw200xx.o
> > > >  obj-$(CONFIG_LEDS_AW2013)            +=3D leds-aw2013.o
> > > > diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds=
/leds-asus-transformer-ec.c
> > > > new file mode 100644
> > > > index 0000000000000..1b129247ea6c6
> > > > --- /dev/null
> > > > +++ b/drivers/leds/leds-asus-transformer-ec.c
> > > > @@ -0,0 +1,125 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/leds.h>
> > > > +#include <linux/mfd/asus-transformer-ec.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +enum {
> > > > +     ASUSEC_LED_AMBER,
> > > > +     ASUSEC_LED_GREEN,
> > > > +     ASUSEC_LED_MAX
> > > > +};
> > > > +
> > > > +struct asus_ec_led_config {
> > > > +     const char *name;
> > > > +     unsigned int color;
> > > > +     u64 ctrl_bit;
> > > > +};
> > > > +
> > > > +struct asus_ec_led {
> > > > +     struct asus_ec_leds_data *ddata;
> > >
> > >
> > > Why do we need 'struct ' at all?
> > >
> > > If we put 'const struct asusec_core *ec;' directly into 'struct
> > > asus_ec_led', we can drop the outer wrapper struct and the back-point=
er
> > > completely.
> > >
> >
> > You propose to allocate asus_ec_led for each led in a loop? I have not
> > seen this done by other leds. The asus_ec_leds_data is driver ddata,
> > asus_ec_led is each led individual structure.
>
> For your whole 2 LEDs, yes, I think that will be better.
>
> > > > +     struct led_classdev cdev;
> > > > +     u64 ctrl_bit;
> > > > +};
> > > > +
> > > > +struct asus_ec_leds_data {
> > > > +     const struct asusec_core *ec;
> > > > +     struct asus_ec_led leds[ASUSEC_LED_MAX];
> > > > +};
> > > > +
> > > > +static const struct asus_ec_led_config asus_ec_leds[] =3D {
> > > > +     [ASUSEC_LED_AMBER] =3D {
> > > > +             .name =3D "amber",
> > > > +             .color =3D LED_COLOR_ID_AMBER,
> > > > +             .ctrl_bit =3D ASUSEC_CTL_LED_AMBER,
> > > > +     },
> > > > +     [ASUSEC_LED_GREEN] =3D {
> > > > +             .name =3D "green",
> > > > +             .color =3D LED_COLOR_ID_GREEN,
> > > > +             .ctrl_bit =3D ASUSEC_CTL_LED_GREEN,
> > > > +     },
> > > > +};
> > > > +
> > > > +static enum led_brightness asus_ec_led_get_brightness(struct led_c=
lassdev *cdev)
> > > > +{
> > > > +     struct asus_ec_led *led =3D container_of(cdev, struct asus_ec=
_led, cdev);
> > > > +     const struct asusec_core *ec =3D led->ddata->ec;
> > > > +     u64 ctl;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
> > >
> > > As requested on v6 and v8, why are we still using this bespoke access=
or instead
> > > of Regmap?
> >
> > https://lore.kernel.org/lkml/CAPVz0n0imF_ESoGMJSrEX7NOnBShFj8wehDtQKXZV=
_DMcGqq=3DA@mail.gmail.com/
>
> Sorry, I've slept since then, and subsequently forgotten this
> conversation.  You can drop this request.
>
> > > > +     if (ret)
> > > > +             return LED_OFF;
> > > > +
> > > > +     return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> > > > +}
> > > > +
> > > > +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> > > > +                                   enum led_brightness brightness)
> > > > +{
> > > > +     struct asus_ec_led *led =3D container_of(cdev, struct asus_ec=
_led, cdev);
> > > > +     const struct asusec_core *ec =3D led->ddata->ec;
> > > > +
> > > > +     if (brightness)
> > > > +             return asus_dockram_access_ctl(ec->dockram, NULL,
> > > > +                                            led->ctrl_bit, led->ct=
rl_bit);
> > >
> > > Use 100-chars throughout to prevent early wrapping.
> > >
> > > > +     return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_b=
it, 0);
> > > > +}
> > > > +
> > > > +static int asus_ec_led_probe(struct platform_device *pdev)
> > > > +{
> > > > +     const struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.pa=
rent);
> > > > +     struct asus_ec_leds_data *ddata;
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     int ret;
> > > > +
> > > > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > > > +     if (!ddata)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     platform_set_drvdata(pdev, ddata);
> > >
> > > What consumes this?
> >
> > Seems to be an overlook, must have forgotten to remove it during 12
> > iterations over last 10 month
>
> No problem, it happens.
>
> > > > +     ddata->ec =3D ec;
> > > > +
> > > > +     for (int i =3D 0; i < ASUSEC_LED_MAX; i++) {
> > >
> > > `i` isn't just a random iterator here - maybe call it `led`?
> > >
> >
> > This is just a disposable iterator.
>
> It's a disposable iterator that is clearly a `led`.
>
> Thus my request for and improvement in the nomenclature remains valid.
>
> > v7 seem fine https://lore.kernel.org/lkml/20260702162425.GD2108533@goog=
le.com/
> > v9 as well https://lore.kernel.org/lkml/20260702162425.GD2108533@google=
.com/
>
> These are the same link.
>

Ooops, v7 https://lore.kernel.org/lkml/20260527144619.GA671544@google.com/

> > Yet again complains and nits
>
> That my job.  You're welcome.  =3D;-)
>
> Sometimes new things are found on re-review.
>
> Apologies for the disappointment.
>

I will incorporate all your requests, but please, may you apply/check
v13 a bit quicker. That would be awesome.

> --
> Lee Jones
