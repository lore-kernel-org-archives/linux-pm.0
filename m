Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17424113D
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037799; cv=pass; b=phCOEufq76k3FNPD9cX12KdvUYOEEjDLuRED2Wup2cWtcbJC6efbK3VQRL9CAjHx0RhUtjrD5yA17OhfCi/qXMozFfCNSxi3yNA3FaoVwmuPLrABDMFfIvca9ztlIjZqaK7lWyL3c7D9/dkNo7LN3VfrZRAR9MX0XdM8/ppYW2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037799; c=relaxed/simple;
	bh=jcfCE/0TEkTsIVfXnYBhBH66bO22mTW43lzd2mIpj78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg2hKmDKv5xk/mEIsFnkD7jNNGfAHoVgNy4/mIhQse3BK74G2YcPeK+vOAH2A049dzN9P2VX8iS1QpnzJUIbWxREhdRjMJ16ej7Smk91TFY3K+WDAaFpDlVTknszVTt0mmQFjM4irp7r/ocIr7HqZ9uxuZxUt0/i7P8i4VbWZbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAK2SoBn; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAK2SoBn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so1162645a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 07:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037795; cv=none;
        d=google.com; s=arc-20260327;
        b=eZ/3JlQf4KEZGZCJLQpatFYc9ewiNYkkanSjSTqv2GYlo9doFzoM+Oz1Ez28hxPFy2
         fnHOj6nQPtF0tR1h4BWAEU4Q6BJ0+w4ROOvB0hZ41HZsRWs1Ff/zPk55ao0bodkLC1cn
         SMp8K0S3nzAS6a0F8pSEKCBSV32Ryarw8usiMivMF78KGgstiGCbtTrcGMH80dXjqXBf
         04cqziREgqSO4nnSyusP4aIkNkpIQUGirgCSS5E2oDrewz0i8IXR+0MH2TcROEDr3we4
         YLek8ZApjXoIs41/usbSkmpE64X7lMbegZNU4O1MFVUXZ34e1dmyW8modl2nsLTxJE82
         A9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        fh=Pe2gpsv47wgF3q3iva//fEB2UsJumsuAneCC/t296ao=;
        b=fD4gI+hyF08HREpQhnyQdPy1miMY2lANPoqfUQhzuPeACZ9pfzHrM5HFwsv4yboKgW
         H9TKmRRKfjYDQL6TZpK971Q26522RqDekABPr1EbXGAx5ULgfh+qmoSz7U4xjABz5RJg
         1Rdek06idb7BCFGn+B8oc8DEKe1zcT/4SYIRpJhuf63HNhndbNrwf90/dJk1H/y+AdVA
         uS2kUSVCmVJJ68HodmEEAZfrV/xwC+K1V45pxUfv+dKSQwHWzPRpuRTb9hAUT63rkZa5
         yatsKLCwCsCDmVCtG/XPenySdmlho36uc22YmkC5GnfRZkAovouS7JRPlIXKZtrNK+Sw
         JeHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784037795; x=1784642595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        b=lAK2SoBneg8a79IZxLlhDsoAc5s20dBKXYEmWxNqZbpTv1QYHuXFFTg+NoFNbGZt2D
         UEVjkRmdqrTUvXv7NUo+KyP47BDLcu4h6ndNAWy8SpgCyMfHyAHNG4l4y3KQQsVM+NfO
         y3AuDDKNqrG2ji6rSNU4GXaj318V6nIpTK5NE9HzDHEqubMliMFQ/6DYBUTv7cRfhVko
         3hLr+lBtOX3eNCTXc2oxsUbuLs3l5I4wzeDq7R6fv1ZZeVGJqY1ZEmMy5Km53CIK2+gt
         sR/h7Ue36rW6UZW3hnySs1O74EAPlLqb2jBd8DkABTJgXXntJDpmIPLfyks3ke+Fgy3h
         W7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037795; x=1784642595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myF6T21RyLYT6/CfTBKwlhYNyiiPbXPGvaRTBJcI6ZU=;
        b=D2mx2OwFjHaZxMwp0hp/mfoQiOoWQSn56CfCU46thE0or7VOX9qvTENbenDOWRxevL
         7i5FbGXzGrS4CmDd3rLWbUaG33Z6hLtr4Znav7FY0DQkRdbfNu0GZwJiTJBOt5f33E7F
         Ar/M1ecpLou11vfRUx8wSyC4mwMzyW8b+uw7nSNKpR1zUzZzDwkxDCQl4sSnlsqhhCLw
         AQTVnGXpiaHluF/LEdgQZSBehzL4I0BApuxtRW3WdI7Y8nUJvMKug4A4pmqUh+8cQv3h
         dkfmLk77P/x2C1cLVSgr9gBVuQ09ErBsBbJ+aps1EbCxukZkRAF9fvfgaYZJtv2hfm82
         3hRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrnd9tCtx/QcjYHb7QdFNHagCXIWTneoeIB9bSr44UQJqtMaY3UrNqFYMArNFK0AYDM9/1i680B5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKHYvRXBim2R8qbnHTf2iTWwCuv+89g6eXk2NTMqrH3d1Of18
	QfsidIxEWKatewPlZcvy4R6dOsllfVXjkoTlrXhtV/sV28LTOZpOntDyqRjzi2TtaPbvhGo0x85
	MhYFUIdS3bJJm9CObU8qIzkk99QTjWX0=
X-Gm-Gg: AfdE7cnkD9aPnf8yo84aQLQyTT5n9xLj5bCcmkh1pignCqlI7ECZKxBC4FwJYHTBCJW
	dv++VqCV4Fmib7C1Pbi1fEXIBsrezS8BKVUcZ3hxEc6lhaZ6HmIRwsd5kg6Jd6ss0499O+mlZ3b
	UxXa/i98EiKI+f1Rk79fwy0qCr3WRBu74nk4lcq2fy9G1Iurv8H6RO3Fl3Kvvwy7e9zvMBufLFP
	6Q5t7f/dbtr5gMyWqX5Fetj4SrHp8MMGPSnZwNxXrqT38rrQIVLRam6rJXz08YK5kmLjymAaTsE
	UV77CVpa3RrOstN1SSTGEs1BwhJamg==
X-Received: by 2002:a17:90b:5863:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-38dc73bcfdfmr12462942a91.1.1784037794156; Tue, 14 Jul 2026
 07:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625081529.22447-1-clamor95@gmail.com> <20260625081529.22447-5-clamor95@gmail.com>
 <CAPVz0n1o+2NRQrLfbCMT0JdeFhhD4PS4UzSt3L6-QQ2ywHL+mA@mail.gmail.com>
In-Reply-To: <CAPVz0n1o+2NRQrLfbCMT0JdeFhhD4PS4UzSt3L6-QQ2ywHL+mA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 17:03:02 +0300
X-Gm-Features: AUfX_myvMCwvq1yA3I4zoSr0hddrF32oflvRuyg70zCnHs7uf8DcWagE6S5UHa4
Message-ID: <CAPVz0n3FkzoXJBffsOJzd4Rq9HmA0n1oFCU-9Xt=URmpXhY2UA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 11:53 Svyat=
oslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D1=87=D1=82, 25 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11=
:16 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Only Dock keyboard input events are tracked for AltGr pressing.
> >
> > Co-developed-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/input/keyboard/Kconfig                |  10 +
> >  drivers/input/keyboard/Makefile               |   1 +
> >  .../input/keyboard/asus-transformer-ec-keys.c | 314 ++++++++++++++++++
> >  3 files changed, 325 insertions(+)
> >  create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
> >
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 9d1019ba0245..913cb4900565 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -89,6 +89,16 @@ config KEYBOARD_APPLESPI
> >           To compile this driver as a module, choose M here: the
> >           module will be called applespi.
> >
> > +config KEYBOARD_ASUS_TRANSFORMER_EC
> > +       tristate "Asus Transformer's Mobile Dock multimedia keys"
> > +       depends on MFD_ASUS_TRANSFORMER_EC
> > +       help
> > +         Say Y here if you want to use multimedia keys present on Asus
> > +         Transformer's Mobile Dock.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called asus-transformer-ec-keys.
> > +
> >  config KEYBOARD_ATARI
> >         tristate "Atari keyboard"
> >         depends on ATARI
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index 60bb7baf802f..0d81096887ad 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_ADP5585)                +=3D ad=
p5585-keys.o
> >  obj-$(CONFIG_KEYBOARD_ADP5588)         +=3D adp5588-keys.o
> >  obj-$(CONFIG_KEYBOARD_AMIGA)           +=3D amikbd.o
> >  obj-$(CONFIG_KEYBOARD_APPLESPI)                +=3D applespi.o
> > +obj-$(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC)     +=3D asus-transformer-e=
c-keys.o
> >  obj-$(CONFIG_KEYBOARD_ATARI)           +=3D atakbd.o
> >  obj-$(CONFIG_KEYBOARD_ATKBD)           +=3D atkbd.o
> >  obj-$(CONFIG_KEYBOARD_BCM)             +=3D bcm-keypad.o
> > diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/driver=
s/input/keyboard/asus-transformer-ec-keys.c
> > new file mode 100644
> > index 000000000000..53aff3ce7146
> > --- /dev/null
> > +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
> > @@ -0,0 +1,314 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/mfd/asus-transformer-ec.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define ASUSEC_EXT_KEY_CODES           0x20
> > +
> > +struct asus_ec_keys_data {
> > +       struct notifier_block nb;
> > +       struct asusec_core *ec;
> > +       struct input_dev *xidev;
> > +       struct input_handler input_handler;
> > +       unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
> > +       const char *kbc_phys;
> > +       bool special_key_pressed;
> > +       bool special_key_mode;
> > +};
> > +
> > +static void asus_ec_input_event(struct input_handle *handle,
> > +                               unsigned int event_type,
> > +                               unsigned int event_code, int value)
> > +{
> > +       struct asus_ec_keys_data *priv =3D handle->handler->private;
> > +
> > +       /* Store special key state */
> > +       if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> > +               priv->special_key_pressed =3D !!value;
> > +}
> > +
> > +static int asus_ec_input_connect(struct input_handler *handler,
> > +                                struct input_dev *dev,
> > +                                const struct input_device_id *id)
> > +{
> > +       struct asus_ec_keys_data *priv =3D handler->private;
> > +       struct input_handle *handle;
> > +       int error;
> > +
> > +       if (!dev->phys || !strstr(dev->phys, priv->kbc_phys))
> > +               return -ENODEV;
> > +
>
> Hello Dmitry!
>
> Would this approach be acceptable? Handler links strictly to asus-ec keyb=
oard.
>

Hello Dmitry! May you please take a look? ATM only ACK on input patches lef=
t.
