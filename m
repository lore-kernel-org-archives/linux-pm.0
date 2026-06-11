Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5B331EBF
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180198; cv=pass; b=MuxGEQLeKm/oyyKHGRj048rsVhIvSYc2JxnGrYFHDIcLtNdWvB24lK6Mh/2H5H2/uFgoj1KpS7XaZREsmnvRSd2IOB9rz/50Jhrj9X76UJIR2+CrhcUAbNU23Y/Q96hf9Jl5OVMuy5N+kKTV4EEY/fNyHWNnJIHlyqzUL/ZZ4TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180198; c=relaxed/simple;
	bh=m0ILiGQjjW37FZWVT+lHXwgZAIZlQlt6GwpdAP8++QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnXoeag3kAZOxmm8LZ/WDb8w6dhc49/sgY7gAShAPtjf0cfYFIM55f//Mw/BlIhMZ4IXczVmndmXpivhHP+37m+J5bsOr+uWxTjWQ799iPMddvaYe0/uk/PK2HOxp8mBbKEvTuk83+jesWGtIX+MZ9vjM1nVCkh/S0s3C++xbvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl3uG/3B; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl3uG/3B"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304f590dd91so8743088eec.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 05:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180196; cv=none;
        d=google.com; s=arc-20240605;
        b=iV7kjeYPk08vJtjG3ZuGvPgDtVQlmjKF+l3dHp/TJgbwE2eqevu4G0xkr0zPQJvq64
         RlQZNNG1i4vcNbtFNSHA60+7uQaV9WhDAscsAyPrITw8puWeA5l++yrPgi/Wuqr0d+2x
         jWBaigwENclJqEacRnMg6b2mPibkPYxR6kr3y8Kqjpo5o2hcFWI6SJNwmHnBO96GvO8s
         ubcxoaWlJYBr+nbzxi7kLWaf9pi0/TDZ9ixPXrSriwmp6lX5HxsFHGMeZvlVExRjijXX
         AYsD3Rp1vO/6zJsDDbEEEdJBLA7SyWccahliCrmBdN7TRICsjjcFQ8YUB4ut/L1CgiYA
         NI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+TegY9LxT3bCxYZ8LvM5tPIY+YnM7zuh5hgoesekgc=;
        fh=6iOXyO7OS9qjq7egZ3+ZKzzXAEyYvqzT54jcLo9G+aI=;
        b=QNb9vVzPQ6X6J6bhhiLoLka0b1gjTC/b2ERKH/TRg84ku+PKV6Xo3QPjX9q0VY+IEa
         tG2z2L2lFijQ2dmFSdKRz488JjyRDeqk3ZIMvQYSF8oDiz2r5ni3KPtuL+qimCPpFQ/s
         eo3c4tbtKI6NpNJBE6oAC6pAxKNbng6JHnmxmmHp8O+cYGFldobDKUK1S0z/U2Xt4sGz
         4vAXef/ZCEdWUK6HkiaElFCX5eoko7I0Xhi1j3KFJHX9NaisvHMpbElkDPhHccpGyyES
         v8Bw41mhjdVc+FQ9W2H4rOlNDPEhidml3qtvam1/wmkec7+kSa9qfIY1n9pICdAF45OI
         9FnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180196; x=1781784996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+TegY9LxT3bCxYZ8LvM5tPIY+YnM7zuh5hgoesekgc=;
        b=nl3uG/3BTU9PPdKwrAfWuSqxLGJTdEYt+igegxQdUDDFvkPESSHK1FRT7wUynCq9wE
         +Ny2yJI6XuATNpZR1hw1tifOSOPoUkQrQ8GylPr+/w/N4UomwOeSyoN5mMQJ/f+jnTnq
         G8ZNzLu8/uXoZg2B+G01rOzkSAs0YDwlXz4pGU1ubEgE+BMq1Y9vbdF9pqkthMyvG65g
         opcOTcVZCBTQPZZFioGg8MCTf+scciEhHQz38tgZjF9XHz4stVipmdIfzsylCdUPvYaR
         vTsf4ZvPuWS3unuIm3MLSq02ocuqoL1iijApf4IWYtmpgp8HwWG3bKEcbHQTWFu/zMGj
         4iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180196; x=1781784996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+TegY9LxT3bCxYZ8LvM5tPIY+YnM7zuh5hgoesekgc=;
        b=QMpHPbrdXq+QLYYf2SpzEwazxS+jtwsZSNzVARPsZTWKmImc69IEzvoCUt5ii8eVnS
         p93nxVfekU+B2xgNzs94BQsmjQ4WdfHd2UWtqVtVsh8CP+yCcG3+6KYpz74gzVZ1ZruZ
         Y0cnZVj5fBQbNhmulj1lnBEFtxvb+Ro6txCpV1MntqVrBlDf3/w670xjhuVpwGb6kuAf
         5wXMGoPQmpSGs79I0a/PO9vPWtcKReGc5gmHn+oHORQKoWOiJwUb7TEFBHkppAohQJqp
         71LyJAaJE53ZBACJ5qunWIwxlt9Zr4BVkVCAArbE9GDFUo8UoIHXJBFhtzRqc6VvHmO6
         py6g==
X-Forwarded-Encrypted: i=1; AFNElJ9OsZXYAwLqGz2ZKn3UZas1T3vdrSmZHBLPUbwI25bxblPtpU3lm9fb+WqKX/R+qu+AW+73uj3TJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOakOc9XGy+HqOFzQIhsKJ/7dwu9WVJLDi1xzHWJ6ewk8arQeg
	xN7+ll9mWnXSVUbr6xCvKPjnzhRjWtPrFx4+z2D+Ym02bST9n9yfMsY8TkM5NWXegUFkWLNny+N
	m1CiQuu8AudL5NrfZaRH81ljkkaT95yw=
X-Gm-Gg: Acq92OGI0MaEsBMe4x+k+LksaxPMYANbsH4LXfg6b0kEJ5QdU/jyyTM7TBBadOWAt6l
	y0WKiYLn3n2TBbgluD/iKwz+FW/G1Z1HtXTChnvYJcK9jfVf1sJn8MjleYY4nc7ZyY0yeXue871
	Rrr9ieUB/dwTQ4wCcYdET3VXns/70vdxDIPzPXRDl6TVPH3Oa4/vXUQp/vbqVP0O7zj6b4wR1DQ
	1FuBTQIkJSt3opkIV7LbV7P5jqpYPanoHgOocTh7y3D0scz0yXeu2egyjD0spfgfFDH/+xMGP0s
	ftoj4z8NyVLQU6KndrvFJbIFCjve3w==
X-Received: by 2002:a05:7300:6d20:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-30804cbf74bmr1952028eec.34.1781180195562; Thu, 11 Jun 2026
 05:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-3-clamor95@gmail.com>
 <20260611111732.GN4151951@google.com>
In-Reply-To: <20260611111732.GN4151951@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:16:23 +0300
X-Gm-Features: AVVi8Ce8ZrG9KhRHab2qXH0lL2_niB-_klT-O9ok2BFu5UDw3zgfPGeAc1cDiF4
Message-ID: <CAPVz0n0caBBt6A+AFeUpGdxvb3Qhoui7khLCt3747bPUKmMXhQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] mfd: Add driver for ASUS Transformer embedded controller
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

=D1=87=D1=82, 11 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:1=
7 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 28 May 2026, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> > and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> > detection and common operations for EC's functions.
> >
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/mfd/Kconfig                     |  16 +
> >  drivers/mfd/Makefile                    |   1 +
> >  drivers/mfd/asus-transformer-ec.c       | 542 ++++++++++++++++++++++++
> >  include/linux/mfd/asus-transformer-ec.h |  92 ++++
> >  4 files changed, 651 insertions(+)
> >  create mode 100644 drivers/mfd/asus-transformer-ec.c
> >  create mode 100644 include/linux/mfd/asus-transformer-ec.h
> >
...
> > +
> > +     memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
> > +     ret =3D i2c_smbus_read_i2c_block_data(client, ASUSEC_DOCKRAM_CONT=
ROL,
> > +                                         ASUSEC_ENTRY_SIZE, buf);
> > +     if (ret < ASUSEC_ENTRY_SIZE) {
> > +             dev_err(&client->dev, "failed to access control buffer: %=
d\n",
> > +                     ret);
> > +             return ret;
>
> Should we return a negative error code here if the read is shorter than
> expected, rather than propagating the positive byte count?
>

Yes, I have adjusted it already locally for the next iteration. It
will return ret if negative and -EIO if ret is pos but less then
ASUSEC_ENTRY_SIZE (return ret < 0 ? ret : -EIO)

> > +     }
> > +
> > +     if (buf[0] !=3D ASUSEC_CTL_SIZE) {
> > +             dev_err(&client->dev, "buffer size exceeds %d: %d\n",
> > +                     ASUSEC_CTL_SIZE, buf[0]);
> > +             return -EPROTO;
> > +     }
> > +
> > +     val =3D get_unaligned_le64(buf + 1);
> > +
> > +     if (out)
> > +             *out =3D val;
> > +
> > +     if (mask || xor) {
> > +             put_unaligned_le64((val & ~mask) ^ xor, buf + 1);
> > +             ret =3D i2c_smbus_write_i2c_block_data(client,
> > +                                                  ASUSEC_DOCKRAM_CONTR=
OL,
> > +                                                  ASUSEC_ENTRY_SIZE, b=
uf);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(asus_dockram_access_ctl);
> > +
> > +static int asus_ec_signal_request(struct asus_ec_data *ddata)
> > +{
> > +     guard(mutex)(&ddata->ecreq_lock);
> > +
> > +     gpiod_set_value_cansleep(ddata->ecreq_gpio, 1);
> > +     msleep(50);
> > +
> > +     gpiod_set_value_cansleep(ddata->ecreq_gpio, 0);
> > +     msleep(200);
>
> Do these numbers come from the datasheet or were they arbitrarily chosen?
>

There is no datasheet. These delays come from downstream driver and
with lower values or removed delays request fails.

> > +
> > +     return 0;
> > +}
> > +
> > +static void asus_ec_clear_buffer(struct asus_ec_data *ddata)
> > +{
> > +     int ret, retry =3D ASUSEC_RSP_BUFFER_SIZE;
> > +
> > +     /*
> > +      * Read the buffer till we get valid data by checking ASUSEC_OBF_=
MASK
> > +      * of the status byte or till we reach end of the 256 byte buffer=
.
> > +      */
> > +     while (retry--) {
> > +             ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUS=
EC_READ_BUF,
> > +                                                 ASUSEC_ENTRY_SIZE,
> > +                                                 ddata->ec_buf);
> > +             if (ret < ASUSEC_ENTRY_SIZE)
> > +                     continue;
> > +
> > +             if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
> > +                     continue;
> > +
> > +             break;
> > +     }
> > +}
> > +
> > +static int asus_ec_log_info(struct asus_ec_data *ddata, unsigned int r=
eg,
> > +                         const char *name, const char **out)
> > +{
> > +     struct device *dev =3D &ddata->client->dev;
> > +     u8 buf[ASUSEC_ENTRY_BUFSIZE];
> > +     int ret;
> > +
> > +     memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
> > +     ret =3D i2c_smbus_read_i2c_block_data(ddata->ec.dockram, reg,
> > +                                         ASUSEC_ENTRY_SIZE, buf);
> > +     if (ret < ASUSEC_ENTRY_SIZE)
> > +             return ret;
>
> Same here.  These should be negative.
>

return ret < 0 ? ret : -EIO same as above

> > +
> > +     if (buf[0] > ASUSEC_ENTRY_SIZE) {
> > +             dev_err(dev, "bad data len; buffer: %*ph; ret: %d\n",
> > +                     ASUSEC_ENTRY_BUFSIZE, buf, ret);
> > +             return -EPROTO;
> > +     }
> > +
> > +     if (!ddata->logging_disabled) {
> > +             dev_info(dev, "%-14s: %.*s\n", name, buf[0], buf + 1);
> > +
> > +             if (out) {
> > +                     *out =3D devm_kasprintf(dev, GFP_KERNEL, "%.*s",
> > +                                           buf[0], buf + 1);
> > +                     if (!*out)
> > +                             return -ENOMEM;
> > +             }
> > +     }
>
> FWIW, I hate this!  What does it give you now that development is done?
>

We have already discussed this, and you agreed that EC and firmware
prints may stay! This prints EC model and firmware info as well as EC
firmware behavior. It allows identify possible new revisions of EC -
Firmware combo and address possible regressions (check if it is chip
malfunction or firmware needs a new programming model) without
rebuilding kernel and digging downstream kernel for needed bits of
code.

> > +     return 0;
> > +}
> > +
> > +static int asus_ec_reset(struct asus_ec_data *ddata)
> > +{
> > +     int retry, ret;
> > +
> > +     guard(mutex)(&ddata->ecreq_lock);
> > +
> > +     for (retry =3D 0; retry < ASUSEC_RETRY_MAX; retry++) {
>
> for (int return =3D ... is generally preferred for throwaway variables.
>

Not that I care too much, but I am defining ret anyway, why not add
retry too there?

>
> > +             ret =3D i2c_smbus_write_word_data(ddata->client, ASUSEC_W=
RITE_BUF,
> > +                                             ASUSEC_RESET);
> > +             if (!ret)
> > +                     return 0;
> > +
> > +             msleep(ASUSEC_ACCESS_TIMEOUT);
>
> I like that this is defined, can we do that with the others please?
>

I don't see any benefits of defining delays, they are all arbitrary
and derive from downstream kernel, removing or altering them caused
malfunction.

> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int asus_ec_susb_on_status(struct asus_ec_data *ddata)
> > +{
> > +     u64 flag;
> > +     int ret;
> > +
> > +     ret =3D asus_dockram_access_ctl(ddata->ec.dockram, &flag, 0, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     flag &=3D ASUSEC_CTL_SUSB_MODE;
> > +     dev_info(&ddata->client->dev, "EC FW behaviour: %s\n",
> > +              flag ? "susb on when receive ec_req" :
> > +              "susb on when system wakeup");
> > +
> > +     return 0;
> > +}
> > +
> > +static int asus_ec_set_factory_mode(struct asus_ec_data *ddata,
> > +                                 enum asusec_mode fmode)
> > +{
> > +     dev_info(&ddata->client->dev, "Entering %s mode.\n",
> > +              fmode =3D=3D ASUSEC_MODE_FACTORY ? "factory" : "normal")=
;
> > +
> > +     return asus_dockram_access_ctl(ddata->ec.dockram, NULL,
> > +                                    ASUSEC_CTL_FACTORY_MODE,
> > +                                    fmode =3D=3D ASUSEC_MODE_FACTORY ?
> > +                                    ASUSEC_CTL_FACTORY_MODE : 0);
>
> Why not create make:
>
> ASUSEC_MODE_FACTORY =3D=3D ASUSEC_CTL_FACTORY_MODE
>
> What happens to NORMAL?
>

ASUSEC_CTL_FACTORY_MODE is a bit in the ctl register. For NORMAL mode
bit is cleared,
for FACTORY bit it set, for NONE bit is ignored.

> > +}
> > +
> > +static int asus_ec_detect(struct asus_ec_data *ddata)
> > +{
> > +     int ret;
> > +
> > +     ret =3D asus_ec_reset(ddata);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     asus_ec_clear_buffer(ddata);
> > +
> > +     ret =3D asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_MODEL, "Model=
",
> > +                            &ddata->ec.model);
>
> You can use 100-chars and make the code look beautiful! :)
>

Not every subsystem permits 100 chars, some stick to 80 as a strict
rule, so it is better be safe.

> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_FW, "FW versi=
on",
> > +                            NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_CFGFMT, "Conf=
ig format",
> > +                            NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ret =3D asus_ec_log_info(ddata, ASUSEC_DOCKRAM_INFO_HW, "HW versi=
on",
> > +                            NULL);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     /* Disable logging on next EC request */
>
> Why, but why?
>

Cause EC requests are frequent (handshake/reset) and constant logging
same data is not acceptable.

> > +     ddata->logging_disabled =3D true;
> > +
> > +     /* Check and inform about EC firmware behavior */
> > +     ret =3D asus_ec_susb_on_status(ddata);
> > +     if (ret)
> > +             goto err_exit;
> > +
> > +     ddata->ec.name =3D ddata->info->name;
> > +
> > +     /* Some EC require factory mode to be set normal on each request =
*/
> > +     if (ddata->info->fmode)
> > +             ret =3D asus_ec_set_factory_mode(ddata, ddata->info->fmod=
e);
> > +
> > +err_exit:
> > +     if (ret)
> > +             dev_err(&ddata->client->dev, "failed to access EC: %d\n",=
 ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static void asus_ec_handle_smi(struct asus_ec_data *ddata, unsigned in=
t code)
> > +{
> > +     switch (code) {
> > +     case ASUSEC_SMI_HANDSHAKE:
> > +     case ASUSEC_SMI_RESET:
> > +             asus_ec_detect(ddata);
> > +             break;
> > +     }
> > +}
> > +
> > +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> > +{
> > +     struct asus_ec_data *ddata =3D dev_id;
> > +     unsigned long notify_action;
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_=
BUF,
> > +                                         ASUSEC_ENTRY_SIZE, ddata->ec_=
buf);
> > +     if (ret < ASUSEC_ENTRY_SIZE ||
> > +         !(ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK))
>
> Unwrap for readability.
>
> Also, I think a comment would be helpful.
>

if (ret < ASUSEC_ENTRY_SIZE)
    return IRQ_NONE;

ret =3D ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK;
if (!ret)
    return IRQ_NONE;

This would be acceptable? (I will add comments later on)

> > +             return IRQ_NONE;
> > +
> > +     notify_action =3D ddata->ec_buf[ASUSEC_IRQ_STATUS];
> > +     if (notify_action & ASUSEC_SMI_MASK) {
> > +             unsigned int code =3D ddata->ec_buf[ASUSEC_SMI_CODE];
> > +
> > +             asus_ec_handle_smi(ddata, code);
> > +
> > +             notify_action |=3D code << 8;
> > +     }
> > +
> > +     blocking_notifier_call_chain(&ddata->ec.notify_list,
> > +                                  notify_action, ddata->ec_buf);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void asus_ec_release_dockram_dev(void *client)
> > +{
> > +     i2c_unregister_device(client);
> > +}
> > +
> > +static struct i2c_client *devm_asus_dockram_get(struct device *dev)
> > +{
> > +     struct i2c_client *parent =3D to_i2c_client(dev);
> > +     struct i2c_client *dockram;
> > +     struct dockram_ec_data *ddata;
> > +     int ret;
> > +
> > +     dockram =3D i2c_new_ancillary_device(parent, "dockram",
> > +                                        parent->addr + 2);
>
> Could we define a macro for the address offset '2' here to avoid using a =
magic
> number?
>

It seems that you are excessively concerned with "magic numbers".

> > +     if (IS_ERR(dockram))
> > +             return dockram;
> > +
> > +     ret =3D devm_add_action_or_reset(dev, asus_ec_release_dockram_dev=
,
> > +                                    dockram);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     ddata =3D devm_kzalloc(&dockram->dev, sizeof(*ddata), GFP_KERNEL)=
;
> > +     if (!ddata)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     i2c_set_clientdata(dockram, ddata);
> > +     mutex_init(&ddata->ctl_lock);
> > +
> > +     return dockram;
> > +}
> > +
> > +static const struct mfd_cell asus_ec_sl101_dock_mfd_devices[] =3D {
> > +     MFD_CELL_NAME("asus-transformer-ec-kbc"),
> > +};
> > +
> > +static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] =3D {
> > +     MFD_CELL_BASIC("asus-transformer-ec-battery", NULL, NULL, 0, 1),
> > +     MFD_CELL_BASIC("asus-transformer-ec-charger", NULL, NULL, 0, 1),
> > +     MFD_CELL_BASIC("asus-transformer-ec-led", NULL, NULL, 0, 1),
> > +     MFD_CELL_NAME("asus-transformer-ec-keys"),
> > +     MFD_CELL_NAME("asus-transformer-ec-kbc"),
> > +};
> > +
> > +static const struct mfd_cell asus_ec_tf201_pad_mfd_devices[] =3D {
> > +     MFD_CELL_NAME("asus-transformer-ec-battery"),
> > +     MFD_CELL_NAME("asus-transformer-ec-led"),
> > +};
> > +
> > +static const struct mfd_cell asus_ec_tf600t_pad_mfd_devices[] =3D {
> > +     MFD_CELL_NAME("asus-transformer-ec-battery"),
> > +     MFD_CELL_NAME("asus-transformer-ec-charger"),
> > +     MFD_CELL_NAME("asus-transformer-ec-led"),
> > +};
> > +
> > +static int asus_ec_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct asus_ec_data *ddata;
> > +     const struct mfd_cell *cells;
> > +     unsigned int num_cells;
> > +     unsigned long irqflags;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_=
BLOCK))
> > +             return dev_err_probe(dev, -ENXIO,
> > +                     "I2C bus is missing required SMBus block mode sup=
port\n");
> > +
> > +     ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +     if (!ddata)
> > +             return -ENOMEM;
> > +
> > +     ddata->info =3D device_get_match_data(dev);
> > +     if (!ddata->info)
> > +             return -ENODEV;
> > +
> > +     switch (ddata->info->variant) {
> > +     case ASUSEC_SL101_DOCK:
> > +             cells =3D asus_ec_sl101_dock_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_sl101_dock_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF101_DOCK:
> > +             cells =3D asus_ec_tf101_dock_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf101_dock_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF201_PAD:
> > +             cells =3D asus_ec_tf201_pad_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf201_pad_mfd_devices);
> > +             break;
> > +     case ASUSEC_TF600T_PAD:
> > +             cells =3D asus_ec_tf600t_pad_mfd_devices;
> > +             num_cells =3D ARRAY_SIZE(asus_ec_tf600t_pad_mfd_devices);
> > +             break;
> > +     default:
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "unknown device variant %d\n",
> > +                                  ddata->info->variant);
> > +     }
> > +
> > +     i2c_set_clientdata(client, ddata);
> > +     ddata->client =3D client;
> > +
> > +     ddata->ec.dockram =3D devm_asus_dockram_get(dev);
> > +     if (IS_ERR(ddata->ec.dockram))
> > +             return dev_err_probe(dev, PTR_ERR(ddata->ec.dockram),
> > +                                  "failed to get dockram\n");
> > +
> > +     ddata->ecreq_gpio =3D devm_gpiod_get(dev, "request", GPIOD_OUT_LO=
W);
> > +     if (IS_ERR(ddata->ecreq_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(ddata->ecreq_gpio),
> > +                                  "failed to get EC request GPIO\n");
> > +
> > +     BLOCKING_INIT_NOTIFIER_HEAD(&ddata->ec.notify_list);
> > +     mutex_init(&ddata->ecreq_lock);
> > +
> > +     asus_ec_signal_request(ddata);
> > +
> > +     ret =3D asus_ec_detect(ddata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to detect EC versi=
on\n");
> > +
> > +     /*
> > +      * Systems using device tree should set up interrupt via DTS,
> > +      * the rest will use the default low interrupt.
> > +      */
> > +     irqflags =3D dev->of_node ? 0 : IRQF_TRIGGER_LOW;
> > +
> > +     ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +                                     &asus_ec_interrupt,
> > +                                     IRQF_ONESHOT | irqflags,
> > +                                     client->name, ddata);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to register IRQ\n"=
);
> > +
> > +     /* Parent I2C controller uses DMA, ASUS EC and child devices do n=
ot */
> > +     client->dev.coherent_dma_mask =3D 0;
> > +     client->dev.dma_mask =3D &client->dev.coherent_dma_mask;
> > +
> > +     return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NU=
LL);
> > +}
> > +
> > +static const struct asus_ec_chip_info asus_ec_sl101_dock_data =3D {
> > +     .name =3D "dock",
> > +     .variant =3D ASUSEC_SL101_DOCK,
> > +     .fmode =3D ASUSEC_MODE_NONE,
> > +};
> > +
> > +static const struct asus_ec_chip_info asus_ec_tf101_dock_data =3D {
> > +     .name =3D "dock",
> > +     .variant =3D ASUSEC_TF101_DOCK,
> > +     .fmode =3D ASUSEC_MODE_NONE,
> > +};
> > +
> > +static const struct asus_ec_chip_info asus_ec_tf201_pad_data =3D {
> > +     .name =3D "pad",
> > +     .variant =3D ASUSEC_TF201_PAD,
> > +     .fmode =3D ASUSEC_MODE_NORMAL,
> > +};
> > +
> > +static const struct asus_ec_chip_info asus_ec_tf600t_pad_data =3D {
> > +     .name =3D "pad",
> > +     .variant =3D ASUSEC_TF600T_PAD,
> > +     .fmode =3D ASUSEC_MODE_NORMAL,
> > +};
>
> Any reason not to just pass the identifier (variant) and add the name
> and fmode attribues to the switch() above?

Why not set it here, I am not passing any mfd or any other API via of data.

> > +
> > +static const struct of_device_id asus_ec_match[] =3D {
> > +     {
> > +             .compatible =3D "asus,sl101-ec-dock",
> > +             .data =3D &asus_ec_sl101_dock_data
> > +     }, {
> > +             .compatible =3D "asus,tf101-ec-dock",
> > +             .data =3D &asus_ec_tf101_dock_data
> > +     }, {
> > +             .compatible =3D "asus,tf201-ec-pad",
> > +             .data =3D &asus_ec_tf201_pad_data
> > +     }, {
> > +             .compatible =3D "asus,tf600t-ec-pad",
> > +             .data =3D &asus_ec_tf600t_pad_data
> > +     },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, asus_ec_match);
> > +
> > +static struct i2c_driver asus_ec_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "asus-transformer-ec",
> > +             .of_match_table =3D asus_ec_match,
> > +     },
> > +     .probe =3D asus_ec_probe,
> > +};
> > +module_i2c_driver(asus_ec_driver);
> > +
> > +MODULE_AUTHOR("Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>");
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("ASUS Transformer's EC driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mf=
d/asus-transformer-ec.h
> > new file mode 100644
> > index 000000000000..f085eea2193e
> > --- /dev/null
> > +++ b/include/linux/mfd/asus-transformer-ec.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __MFD_ASUS_TRANSFORMER_EC_H
> > +#define __MFD_ASUS_TRANSFORMER_EC_H
> > +
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +
> > +struct i2c_client;
> > +
> > +/**
> > + * struct asusec_core - public part shared with all cells
> > + *
> > + * @model: firmware version running on the EC
> > + * @name: prefix associated with the EC
> > + * @dockram: pointer to Dockram's i2c_client
> > + * @notify_list: notify list used by cells
> > + */
> > +struct asusec_core {
> > +     const char *model;
> > +     const char *name;
> > +     struct i2c_client *dockram;
> > +     struct blocking_notifier_head notify_list;
> > +};
> > +
> > +#define ASUSEC_ENTRIES                       0x100
> > +#define ASUSEC_ENTRY_SIZE            32
> > +#define ASUSEC_ENTRY_BUFSIZE         (ASUSEC_ENTRY_SIZE + 1)
> > +
> > +/* interrupt sources */
> > +#define ASUSEC_IRQ_STATUS            1
> > +#define ASUSEC_OBF_MASK                      BIT(0)
> > +#define ASUSEC_KEY_MASK                      BIT(2)
> > +#define ASUSEC_KBC_MASK                      BIT(3)
> > +#define ASUSEC_AUX_MASK                      BIT(5)
> > +#define ASUSEC_SCI_MASK                      BIT(6)
> > +#define ASUSEC_SMI_MASK                      BIT(7)
> > +
> > +/* SMI notification codes */
> > +#define ASUSEC_SMI_CODE                      2
> > +#define ASUSEC_SMI_POWER_NOTIFY              0x31    /* USB cable plug=
 event */
> > +#define ASUSEC_SMI_HANDSHAKE         0x50    /* response to ec_req edg=
e */
> > +#define ASUSEC_SMI_WAKE                      0x53
> > +#define ASUSEC_SMI_RESET             0x5f
> > +#define ASUSEC_SMI_ADAPTER_EVENT     0x60    /* charger to dock plug e=
vent */
> > +#define ASUSEC_SMI_BACKLIGHT_ON              0x63
> > +#define ASUSEC_SMI_AUDIO_DOCK_IN     0x70
> > +
> > +#define ASUSEC_SMI_ACTION(code)              (ASUSEC_SMI_MASK | ASUSEC=
_OBF_MASK | \
> > +                                     (ASUSEC_SMI_##code << 8))
> > +
> > +/* control register [0x0a] layout */
> > +#define ASUSEC_CTL_SIZE                      8
> > +
> > +/*
> > + * EC reports power from 40-pin connector in the LSB of the control
> > + * register.  The following values have been observed (xor 0x02):
> > + *
> > + * PAD-ec no-plug  0x40 / PAD-ec DOCK     0x20 / DOCK-ec no-plug 0x40
> > + * PAD-ec AC       0x25 / PAD-ec DOCK+AC  0x24 / DOCK-ec AC      0x25
> > + * PAD-ec USB      0x45 / PAD-ec DOCK+USB 0x24 / DOCK-ec USB     0x41
> > + */
> > +
> > +#define ASUSEC_CTL_DIRECT_POWER_SOURCE       BIT_ULL(0)
> > +#define ASUSEC_STAT_CHARGING         BIT_ULL(2)
> > +#define ASUSEC_CTL_FULL_POWER_SOURCE BIT_ULL(5)
> > +#define ASUSEC_CTL_SUSB_MODE         BIT_ULL(9)
> > +#define ASUSEC_CMD_SUSPEND_S3                BIT_ULL(33)
> > +#define ASUSEC_CTL_TEST_DISCHARGE    BIT_ULL(35)
> > +#define ASUSEC_CMD_SUSPEND_INHIBIT   BIT_ULL(37)
> > +#define ASUSEC_CTL_FACTORY_MODE              BIT_ULL(38)
> > +#define ASUSEC_CTL_KEEP_AWAKE                BIT_ULL(39)
> > +#define ASUSEC_CTL_USB_CHARGE                BIT_ULL(40)
> > +#define ASUSEC_CTL_LED_BLINK         BIT_ULL(40)
> > +#define ASUSEC_CTL_LED_AMBER         BIT_ULL(41)
> > +#define ASUSEC_CTL_LED_GREEN         BIT_ULL(42)
> > +#define ASUSEC_CMD_SWITCH_HDMI               BIT_ULL(56)
> > +#define ASUSEC_CMD_WIN_SHUTDOWN              BIT_ULL(62)
> > +
> > +#define ASUSEC_DOCKRAM_INFO_MODEL    0x01
> > +#define ASUSEC_DOCKRAM_INFO_FW               0x02
> > +#define ASUSEC_DOCKRAM_INFO_CFGFMT   0x03
> > +#define ASUSEC_DOCKRAM_INFO_HW               0x04
> > +#define ASUSEC_DOCKRAM_CONTROL               0x0a
> > +#define ASUSEC_DOCKRAM_BATT_CTL              0x14
> > +
> > +#define ASUSEC_WRITE_BUF             0x64
> > +#define ASUSEC_READ_BUF                      0x6a
> > +
> > +int asus_dockram_access_ctl(struct i2c_client *client,
> > +                         u64 *out, u64 mask, u64 xor);
> > +
> > +#endif /* __MFD_ASUS_TRANSFORMER_EC_H */
> > --
> > 2.51.0
> >
>
> --
> Lee Jones
