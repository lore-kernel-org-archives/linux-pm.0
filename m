Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED978346FA0
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180876; cv=pass; b=FJN73ygdXTfXkQg64+BU36UcthGz2BNplW5kcG8/LNsDk0SVP8JLQLg2uldCV7arhv0p484gHR8eJcp6tSWOyKROv+Ulb0erzkUV09P+9oqyuFWuNLgjPYgcyldG6kdOLVxORBe510vjSyPhpYk/ICGbCErO1WDR0updjyVGtQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180876; c=relaxed/simple;
	bh=DbatO3kAOT4OZzRTOJ/NG/Vi7OILBleIVrZsVOdwbf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q13IIC62QWx415ESgjD4ayqIRO5KFSuo6w+THhJ+sn+9UBNW4r1QjbYzC/U3iksuEMWdXEwHDzrR+t2zG8uR0IpIC2sc0iANTkE3yZI1efM22B0tn9gmRu/sgvBN4igWHMIn0pt0+maFJSIBHkFH3o9TnAxYAuUiCKlkA6i0wiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9AJ5LF9; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9AJ5LF9"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-306f36df4feso631604eec.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 05:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180873; cv=none;
        d=google.com; s=arc-20240605;
        b=KNWiNJFKvQFTYbrOMw4Eqk30C8EjI4gVzLiqXmz/S2vartxU8K3hmDj/+BEm0P9LM/
         No3essGCXTBpJs7Ol/nbld3FOtSPtogf7tMgRtBBUeA8WvGEpt0SEoLH7THHUPhRDG1/
         anjXojmIheIpQXuArs8PjVLncNrJGPya25ro/56Q6t9INO76Fa6tnls7aC9+HiHzg5TU
         BdUIM70uToOTl7EvMo1omo6Ebg7o28i35cQfCyc9BRvo1vcwf8NDACvWKPc/X1IyKxWX
         au0GnN7WlTmTN25ippySdf+Snsxs3iqnwbLSVzVig8y5zYBbfGLxv1Er0yPIkwJX1PlM
         9oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VYIWRtJIPzHv3oaDGDHQXtoN5dERb3wNaaEqhAk4Y7Q=;
        fh=a7j+PaJR4GiN+6W4Eu5Un3saL0UI+bTPuwz+Va2c93I=;
        b=GpM5YTPsdm1zK1MKykyXrUb4B4Huvruya2f6cRbqoBebj4EHInGuQpgkexRvRL97BD
         /xHpSvv0ycU1IdwLao/qQXE7OKTIYZqeNJoSanktePqHkfaqUKeMB4Fy6JoZib1RVmhC
         PKp87uCtqMtmBPNHwkxfhvLecqxZBRX6csk8jSQmxRlehpCt2UW5azUL0eidMIllDE0N
         01y9iSZp6FZx1nY96sVcPwpg8DouT/3Slq/LwWl332dkRXLG3Fk5h9kWsBOzCSTsEwDM
         CCyzjqH8fOkokyvJedRz51rdXHOG45Pei9JoQm/ZRQIqdtIserl8IHwq8+5NeMlWICQB
         j9fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180873; x=1781785673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYIWRtJIPzHv3oaDGDHQXtoN5dERb3wNaaEqhAk4Y7Q=;
        b=d9AJ5LF9EIdwT3BlrvbbKREeouKdaMRZaqkzAHsFKbQ2uklncxnjThQf+7pY2iTtvh
         1egL+FlKMTFAaFYqn1Q88drLa7gdtSw9LbRB9iI6YCzZ2IShW5jX2W++HN5juPYJOMH4
         ryd4SyMMAdfiFsLlhSPYC75qsKUAmcDUdbtbqJeGKWrLUQOoi6aVzqxuMPruf8UHVog5
         mecNXUvH5hj9Bk2g1RhQssloTizZbK21tMmHo5Ag9/071qwWt4aTLfulNVibf1qZW2lw
         RJVn05h9kX9ywZPZTi0MWZBxA2OWwllf9guYeOFWv6hfptp96YHEjtf544I73GQTdwVq
         D1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180873; x=1781785673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VYIWRtJIPzHv3oaDGDHQXtoN5dERb3wNaaEqhAk4Y7Q=;
        b=Pk7s5ExbfBZk/i5Ow//AtON8UtQ3GDDVxzLV8D4PgSAUbPdV4PiMb9ePy7W6/vkf8O
         susrm9bY7TorstlODmafRaW7MTTUO0KHXBBaVwfcYSvqhI3CebnEzG+uBMiJZ7+eltpr
         kOiHL4Um24jGFhGe0BVEpj+3gg5n6xa/WsE9cJwgMCtUNWy6RgOVzBCqxvATYPpb68oF
         gvJ1rc/ztu4SWbHvy5TB9TOxSsGpBRiNmTdIH1tkvN50wqJ/vK7TNAUlML2s6WjN+fcu
         n/qCONFIUtHN0p5lXk0XJvS9PJtPiYPbKvV2aHc4jLR+UX2hm3sNheWXUdUiUPWTT9o3
         JaBg==
X-Forwarded-Encrypted: i=1; AFNElJ/q/YU8GPeojaIdULmRqghGdGXzPHRHZLhVs51rvSTjT3OsFWp27F03SMpAD0JMx5Lz+QIRKZZ12A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRYhCJ3BaiSqwBhe/dla5ynOoWOXLP9/i2kEfkSJ3+IhQirqSE
	bVnE7oANRUAgos8+F0fGLohbDJTSqd9xxK2I7V3X2spmUDDyVIo4V1FQpvPP24O2bwM4mz6cHu2
	grzZ8CtWRe4wRJw4cOeJlbIed3X0QjJs=
X-Gm-Gg: Acq92OHjvdQu+fLUIFaOAXwa88Ks2o7z8tPCSK3+n8HoBIF7hRhzqm9bsyYy4CKtlkO
	5OzqELoT5pSasCS/V5Mq0pzxcbjePinJ27PCrJnX4hWi61+tHhJYsufj7BgAwLtxrzGZx+oQN/R
	V59XpvYVNbLs4XPSLFDZYHXkBAx9wI7Xj1IBD8I1qbEvccsYGy6qbhr+4wkGCbguAp03WAROQJS
	SAIgli6cq/6He0mV/pO78Qgq0bWKbfEAN/lupNqMQ4mHEQ48R7u5NWHpEzkarbW5+awT+/HIv5L
	JYmsrHPSg0Lnxk3WOmKrZiixIahneA==
X-Received: by 2002:a05:7300:371e:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-30805e289c5mr1512358eec.10.1781180873014; Thu, 11 Jun 2026
 05:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-6-clamor95@gmail.com>
 <20260611113037.GO4151951@google.com>
In-Reply-To: <20260611113037.GO4151951@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:27:41 +0300
X-Gm-Features: AVVi8CdJMWQJsV5RMfNy0VFbQwyfBDL1gbx8-gP-GKQ2UQnPvXxuEkIVsCd47h4
Message-ID: <CAPVz0n3sn7pmw8S7=q3Tp3=UmMJqapKt_55Nu75xoUw21skU8w@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] leds: Add driver for ASUS Transformer LEDs
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 11 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:3=
0 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 28 May 2026, Svyatoslav Ryhel wrote:
>
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > ASUS Transformer tablets have a green and an amber LED on both the Pad
> > and the Dock. If both LEDs are enabled simultaneously, the emitted ligh=
t
> > will be yellow.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/leds/Kconfig                    |  11 +++
> >  drivers/leds/Makefile                   |   1 +
> >  drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++++++
> >  3 files changed, 137 insertions(+)
> >  create mode 100644 drivers/leds/leds-asus-transformer-ec.c
> >
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index f4a0a3c8c870..f637d23400a8 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
> >         To compile this driver as a module, choose M here: the module
> >         will be called leds-as3668.
> >
> > +config LEDS_ASUS_TRANSFORMER_EC
> > +     tristate "LED Support for Asus Transformer charging LED"
> > +     depends on LEDS_CLASS
> > +     depends on MFD_ASUS_TRANSFORMER_EC
> > +     help
> > +       This option enables support for charging indicator on
> > +       Asus Transformer's Pad and it's Dock.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called leds-asus-transformer-ec.
> > +
> >  config LEDS_AW200XX
> >       tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
> >       depends on LEDS_CLASS
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index 8fdb45d5b439..d5395c3f1124 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_AN30259A)         +=3D leds-an30259=
a.o
> >  obj-$(CONFIG_LEDS_APU)                       +=3D leds-apu.o
> >  obj-$(CONFIG_LEDS_ARIEL)             +=3D leds-ariel.o
> >  obj-$(CONFIG_LEDS_AS3668)            +=3D leds-as3668.o
> > +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)       +=3D leds-asus-transforme=
r-ec.o
> >  obj-$(CONFIG_LEDS_AW200XX)           +=3D leds-aw200xx.o
> >  obj-$(CONFIG_LEDS_AW2013)            +=3D leds-aw2013.o
> >  obj-$(CONFIG_LEDS_BCM6328)           +=3D leds-bcm6328.o
> > diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/led=
s-asus-transformer-ec.c
> > new file mode 100644
> > index 000000000000..09503e76331c
> > --- /dev/null
> > +++ b/drivers/leds/leds-asus-transformer-ec.c
> > @@ -0,0 +1,125 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/err.h>
> > +#include <linux/leds.h>
> > +#include <linux/mfd/asus-transformer-ec.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +enum {
> > +     ASUSEC_LED_AMBER,
> > +     ASUSEC_LED_GREEN,
> > +     ASUSEC_LED_MAX
> > +};
> > +
> > +struct asus_ec_led_config {
> > +     const char *name;
> > +     unsigned int color;
> > +     unsigned long long ctrl_bit;
>
> Should we use 'u64' here instead of 'unsigned long long' to align with st=
andard
> kernel integer types?
>

sure

> > +};
> > +
> > +struct asus_ec_led {
> > +     struct asus_ec_leds_data *ddata;
> > +     struct led_classdev cdev;
> > +     unsigned long long ctrl_bit;
>
> Should we use 'u64' here as well to keep it consistent?
>

sure

> > +};
> > +
> > +struct asus_ec_leds_data {
> > +     const struct asusec_core *ec;
> > +     struct asus_ec_led leds[ASUSEC_LED_MAX];
> > +};
> > +
> > +static const struct asus_ec_led_config asus_ec_leds[] =3D {
> > +     [ASUSEC_LED_AMBER] =3D {
> > +             .name =3D "amber",
> > +             .color =3D LED_COLOR_ID_AMBER,
> > +             .ctrl_bit =3D ASUSEC_CTL_LED_AMBER,
> > +     },
> > +     [ASUSEC_LED_GREEN] =3D {
> > +             .name =3D "green",
> > +             .color =3D LED_COLOR_ID_GREEN,
> > +             .ctrl_bit =3D ASUSEC_CTL_LED_GREEN,
> > +     },
> > +};
> > +
> > +static enum led_brightness asus_ec_led_get_brightness(struct led_class=
dev *cdev)
> > +{
> > +     struct asus_ec_led *led =3D container_of(cdev, struct asus_ec_led=
, cdev);
> > +     const struct asusec_core *ec =3D led->ddata->ec;
>
> I'm getting confused here.
>
> ddata is what I'd be calling the device data struct passed by the parent?
>
> In fact, ddata is a little known concept in Leds.  Any reason to go for
> this over the standard nomenclature?
>

How then it should be named? It holds each LED's control bit.

> > +     u64 ctl;
> > +     int ret;
> > +
> > +     ret =3D asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
>
> Did we discuss preferring regmap already?
>

Yes, you were fine with all and even said that you will merge
everything with Dmitry Ack for input

HERE https://lore.kernel.org/lkml/20260527144619.GA671544@google.com/

Yet now I get a new pile of complaints and nits.

> > +     if (ret)
> > +             return LED_OFF;
> > +
> > +     return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
> > +}
> > +
> > +static int asus_ec_led_set_brightness(struct led_classdev *cdev,
> > +                                   enum led_brightness brightness)
> > +{
> > +     struct asus_ec_led *led =3D container_of(cdev, struct asus_ec_led=
, cdev);
> > +     const struct asusec_core *ec =3D led->ddata->ec;
> > +
> > +     if (brightness)
> > +             return asus_dockram_access_ctl(ec->dockram, NULL,
> > +                                            led->ctrl_bit, led->ctrl_b=
it);
> > +
> > +     return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, =
0);
> > +}
> > +
> > +static int asus_ec_led_probe(struct platform_device *pdev)
> > +{
> > +     const struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent=
);
> > +     struct asus_ec_leds_data *ddata;
> > +     struct device *dev =3D &pdev->dev;
> > +     int i, ret;
>
> Could we declare the loop counter 'i' directly within the 'for' statement=
's
> scope to keep its scope limited? For example, 'for (int i =3D 0; ...)'.
>
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, ddata);
> > +     ddata->ec =3D ec;
> > +
> > +     for (i =3D 0; i < ASUSEC_LED_MAX; i++) {
>
> Nit: for (int i =3D ...
>
> > +             const struct asus_ec_led_config *cfg =3D &asus_ec_leds[i]=
;
> > +             struct asus_ec_led *led =3D &ddata->leds[i];
> > +
> > +             led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s::%=
s",
> > +                                             ddata->ec->name, cfg->nam=
e);
> > +             if (!led->cdev.name)
> > +                     return -ENOMEM;
> > +
> > +             led->cdev.max_brightness =3D 1;
> > +             led->cdev.color =3D cfg->color;
> > +             led->cdev.flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_A=
T_SHUTDOWN;
> > +             led->cdev.brightness_get =3D asus_ec_led_get_brightness;
> > +             led->cdev.brightness_set_blocking =3D asus_ec_led_set_bri=
ghtness;
> > +
> > +             led->ddata =3D ddata;
> > +             led->ctrl_bit =3D cfg->ctrl_bit;
> > +
> > +             ret =3D devm_led_classdev_register(dev, &led->cdev);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to register %s LED\n=
",
> > +                                          cfg->name);
>
> Should we capitalise the error message here to match our style guidelines
> (e.g. 'Failed to register...')?
>

dev messages end with ":" so it should continue with lower case. You
want cap, I don't mind

> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver asus_ec_led_driver =3D {
> > +     .driver.name =3D "asus-transformer-ec-led",
> > +     .probe =3D asus_ec_led_probe,
> > +};
> > +module_platform_driver(asus_ec_led_driver);
> > +
> > +MODULE_ALIAS("platform:asus-transformer-ec-led");
> > +MODULE_AUTHOR("Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>");
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.51.0
> >
> >
>
> --
> Lee Jones
