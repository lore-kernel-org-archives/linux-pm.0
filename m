Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717275;
	b=GZhHXV1NjQi9x8vJT7rmcCMesMHG+OtY4J4jI1cAZ1Ho3UaxHTa+MDjGj3hOvDGjvs5n
	 ko8WeGekK2DHjMUVFJAcHhXxJZpBLSpTw+1WWEMyE00khbDLPWCPbCLnaItrbn1oOkXfC
	 cqOHLTOqkxv1KommVV8FOQPYNlEwMkxr8uDcGdTVEVkGub3Pch0tDmaha9ki+Al+pnwSj
	 Py3LmlYkESK8O7m6mzSO8OcdDFoBnZAJ75Z4WG03p98bYaHI6Xx4jVdL1GBqK8E6I33Vg
	 M2d/DvtRPzdi5PJ8U0E4nW9PE1J2HJsZMIDC+1w3dG678PGM7/eCXK382y6T6mfc9zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EmwaoLyEu5PNjBx2vvNAolYKonR5/swVcE8YNHDBpts=;
	b=i8QELJsT6PHSDGoGPYvhytIoTgRG2FCY99t6OiuRKhKjCZ8L3EzgqjsieS+AdTTPevpg
	 7UaMDdpMUrDNdhItlw/Yw75v91xUi2gViMmrPHrjcgGRdecRa0fG1Aw1Z1sfgsdBh7KT0
	 VlhqHNPgcufI2sKrhjWWmkxVnplxB91qJIxNIE53jz8cQngwRtWUCPzTYPNnAS5Cz18Mh
	 H0k2jtrcZ1LftUqQOcTO3QtikpUdxwA/SRR4Z6JtqXYql0JYmHvBZdFTtP2cBA9hhm80o
	 1ukiQ8CfQEwlh2AyKn209/6h51YcX7iIN84GewtEmsruLn6pb7od3dJJ+OyxuMpAO/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkV3LUIS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD96083622
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 14:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABD96083622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkV3LUIS
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4189876c88.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 06:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717274; cv=none;
        d=google.com; s=arc-20260327;
        b=P78aowTWSoY8scFfcttd6wqiuyK90vIDYUrORxSIAW6SJpYXUPm4xZ0PflwcJr9297
         B8F9K511dmetMUQEYnnJ3DSObIxutKegARQ4LEaEDFKHSf9vUjeBR5u45Hj/B4gt5oPx
         WQjtevwmxuhrWFQXpf2eeQvFttsHBNOs+rUY3zjRqNXnoXg+OIvoVD5gdn8K58FtWsIt
         ngI9wsxZyVkSnU9OqY95yVKzRz+2SOvasGf0ottgjQFkWrk1WOf4wZwlzKWnFm1CmqrS
         IZSwPhCzKalYA+zfbE0J0VrX/PGuqHcFSKy94/U5vn4C+0eFPnYS9dB3F/Q+JBCINVY2
         ilYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmwaoLyEu5PNjBx2vvNAolYKonR5/swVcE8YNHDBpts=;
        fh=mua9fosV7+XwzvDqpLzpJXVZ5YHtus0QBHMZ+qQwsQk=;
        b=HtiIxLDQBbM/uuJRb7bqh096d59DDbuhYPp/qAkAasK/7VNrS4WZCCb25B8qqE/tNt
         IMmRC6HyO1tJw8V15PtLmCsqB04hlr0kSY5DhafFF91VCVp6mt03Kkm7ttsFRvY/GvdX
         qe1gcwmTcY1IucZ74P9970S3kUUAwx/GRnHh1dBGG46t/zbhWc1U9cMYCJzADWyisc9D
         kvTifd7sSpSZ+iZP5egIksbIFO7IfCHQjKWYV27MZacSmerUirTPX+2Kl4thCtJQcb2A
         CcLIgkjV3fkbgC/7lDO4UpaU+anBaPPwJSKy7nQoXkDYyTwhUrfI4s1pchq3RHWl1A9Y
         gcVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717274; x=1794322074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmwaoLyEu5PNjBx2vvNAolYKonR5/swVcE8YNHDBpts=;
        b=PkV3LUISEPLdJuG5ockFsbkWeTNCdGPjsM3OgX3ZKb8sPxZWknOWER6K3fjpWHeUPZ
         UqxyeuYGcGdvoACDHqtpxEIwQ+dVO2aQtNr3GtGNglUofucgd9J+mRTPlbEjqi0wfrN+
         DXX5amGEqAKJGdygbd58mxBZ/wvfoiuDFytn3OmnfwbROqB7IqRwi9GhT1+zUPCfjzB+
         gvFXWu6qmoHmrG/XvunGX8hSOaMurXUef4Oye7twOr8jw/CYxDMoxFcwklG+X1tpuU7Q
         3bluhmj8bVjGJKsi1chBKJXcreOXeWLzaSuzWvr2gU+3nIQXUuZPVNH/0HuWgARsZOR+
         jPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717274; x=1794322074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmwaoLyEu5PNjBx2vvNAolYKonR5/swVcE8YNHDBpts=;
        b=P/RemEhx0kVDKcPZYYSxxb9IemzVcupP/bwZ2Mbdqwxu4W+cwj1mvB+0rux/zJQj53
         cezSNT6P610eK9ktxEbUQENGL3U9eESx+tk7IfUGduFIxsAFcrDmc+2pd8/V+SejDa5V
         jUyjzjnBNdYPnElghggZqleUwDuJxf3nt5zlLkDnIOHItbb3vJT7lsee8usLZOzxL51q
         ogq7jGz2ik6mK+OOlpMi7WavaGmFNJI/0TjfHB9Yv/FtCQDbuuGtOm0cC6kg6bqGCEis
         GFwux08tHVfn7PnyI5PaD9q97UQ73JuNlrUMRjwfYxRc5HnJP+3C4Yv/FY83saY18Cdd
         z3Zw==
X-Forwarded-Encrypted: i=1; AKwUvBx/5nzwn/5fHdTKL8IqC4Mn7vO4FwtoAFSzFYFonPrYulxyI774diFR/YIEqiLqb1C3wy6mcT+h4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+iQCK1tCE06WPPgjL943VRaBriMsnibrPia6kcpSkVKD8hy2Dp
	qBwjlui8a/2yldUlfZplVPJyapme5K7WDlAgIrv7jn4eXQblUBPFN0ns5vWhnqYUiXRjZ/0LcVC
	r2W8o9jK2ETnhUNiz/fHulxB8Nhf2LKs=
X-Gm-Gg: AYBFou37YN8ubn4wBLv45FGidcqejq6OaprM1Vk4Psan2KbhPKO2t0t2ooS2ZNLr2Yz
	6M+gmxrPdGN44kNyjVx4ntyiQnLtNri9FgwIV0Ltx9TPgK9pxftaOkbI+hDhGDhimfCdPrpdE4N
	YYQS7otolEjXV49lhO42U+5jU7iJJVjypLOqlGMWNUcMt+wa4EeqRpClPEmCw7PVmee2VBqMp8n
	UoxZzfsR4XkvpMBo6CqydRkLHQXVGfbxTaZLce/fY8mZtcW/mCnyvFQhSeCtkXkIsNpVCP3/Ydg
	48/pRmhEb4JyTsB+CbYhM3zMkxz/wbkHI8T53GeUlJm+XJBLi9YMcv5kl6XW2pRr3BF6EkjYO9b
	Oyw+Yft04RYG6ugPUBWmunjOnjDcwnUZMIERQVvv2Qrb3Bp8CtLnYs1SJ1GOikpPS0fS64g==
X-Received: by 2002:a05:7023:90b:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-1ac5e6f5132mr25490470c88.24.1793717273733; Tue, 03 Nov 2026
 06:47:53 -0800 (PST)
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
 <179249575817.1833288.1089755405582445022@kernel.org>
In-Reply-To: <179249575817.1833288.1089755405582445022@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Nov 2026 16:47:40 +0200
X-Gm-Features: AclHuK9ZpOIriaiTNLrTV18kT4HaNtHT339MXb6YEPw-7495gnOAW9awk73Le-M
Message-ID: <CAPVz0n0=6Z7E9iSc84xL6Jt=Xi=a=qmSwVsT5g-LMZ+mENFkzg@mail.gmail.com>
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

=D0=B2=D1=82, 3 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:03=
 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 19 Oct 2026, Svyatoslav Ryhel wrote:
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
> > index 7ec2c8d785426..788e689fe875c 100644
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
> > +       Asus Transformer's Pad and its Dock.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called leds-asus-transformer-ec.
> > +
> >  config LEDS_AW200XX
> >       tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
> >       depends on LEDS_CLASS
> > diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> > index 4d4b089156e24..3da746279bb81 100644
> > --- a/drivers/leds/Makefile
> > +++ b/drivers/leds/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)          +=3D leds-adp5520=
.o
> >  obj-$(CONFIG_LEDS_AN30259A)          +=3D leds-an30259a.o
> >  obj-$(CONFIG_LEDS_APU)                       +=3D leds-apu.o
> >  obj-$(CONFIG_LEDS_ARIEL)             +=3D leds-ariel.o
> > +obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)       +=3D leds-asus-transforme=
r-ec.o
> >  obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)  +=3D leds-as3668.o
> >  obj-$(CONFIG_LEDS_AW200XX)           +=3D leds-aw200xx.o
> >  obj-$(CONFIG_LEDS_AW2013)            +=3D leds-aw2013.o
> > diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/led=
s-asus-transformer-ec.c
> > new file mode 100644
> > index 0000000000000..1b129247ea6c6
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
> > +     u64 ctrl_bit;
> > +};
> > +
> > +struct asus_ec_led {
> > +     struct asus_ec_leds_data *ddata;
>
>
> Why do we need 'struct ' at all?
>
> If we put 'const struct asusec_core *ec;' directly into 'struct
> asus_ec_led', we can drop the outer wrapper struct and the back-pointer
> completely.
>

You propose to allocate asus_ec_led for each led in a loop? I have not
seen this done by other leds. The asus_ec_leds_data is driver ddata,
asus_ec_led is each led individual structure.

> > +     struct led_classdev cdev;
> > +     u64 ctrl_bit;
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
> > +     u64 ctl;
> > +     int ret;
> > +
> > +     ret =3D asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
>
> As requested on v6 and v8, why are we still using this bespoke accessor i=
nstead
> of Regmap?
>

https://lore.kernel.org/lkml/CAPVz0n0imF_ESoGMJSrEX7NOnBShFj8wehDtQKXZV_DMc=
Gqq=3DA@mail.gmail.com/

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
>
> Use 100-chars throughout to prevent early wrapping.
>
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
> > +     int ret;
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, ddata);
>
> What consumes this?
>

Seems to be an overlook, must have forgotten to remove it during 12
iterations over last 10 month

> > +     ddata->ec =3D ec;
> > +
> > +     for (int i =3D 0; i < ASUSEC_LED_MAX; i++) {
>
> `i` isn't just a random iterator here - maybe call it `led`?
>

This is just a disposable iterator.

> > +             const struct asus_ec_led_config *cfg =3D &asus_ec_leds[i]=
;
> > +             struct asus_ec_led *led =3D &ddata->leds[i];
> > +
> > +             led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s=
",
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
> > +                                          "Failed to register %s LED\n=
",
> > +                                          cfg->name);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver asus_ec_led_driver =3D {
> > +     .driver.name =3D "asus-transformer-ec-led",
>
> Clever!  But, I'd prefer we still to the usual format to be honest.
>
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
> > 2.53.0
> >
>
> --
> Lee Jones

v7 seem fine https://lore.kernel.org/lkml/20260702162425.GD2108533@google.c=
om/
v9 as well https://lore.kernel.org/lkml/20260702162425.GD2108533@google.com=
/

Yet again complains and nits
