Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9B3E6385
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100083; cv=pass; b=Tyj90tkDuyXG/i/8d5qoXu/rm39FhuTWLP0vOQZXBC9C+0TKbxyDdJm2IHU/o/uG11SYTEf+VZ2NgwASc/BvxjUq2MraaYycdy7SMd3wD9ar2f1t2mNKh1RAh5EQK3rHaZMyELOOCVFjwHWJuW3cGdvKioYYliyAzlUepsamtX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100083; c=relaxed/simple;
	bh=de/RGNl8I6Jd7XzCUxqk4t5+7GUeTAKsKoZdeyJFxBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Szli4ElVuA2ElQAyENaYYl9WPa4ARLh1D8lMRsUnmvauHppH0eWv6FQiApEmrVX9untAgV/Mt+HoPVY9MGGqnvPF123r7crCjJfnmfhKzv4GG0p5dQACn+uNpde+Aq5kT1H0AK/tAxbzpSMVHBeEIaF/m4ysHJvboDbhdHIJBk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4VCjgKQ; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4VCjgKQ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso2469535eec.1
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 03:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779100074; cv=none;
        d=google.com; s=arc-20240605;
        b=S6M8/TJlHtSs/m26R4NfAcKAha0uMici+iAz6QG52YJfLJU4qMPaOt61vySCcvga5A
         mUbyhCLGyhRIv8ngl6hU9aHgpo+E36ZcBujW3ybuZpvNtL7UW62aX4XXIQuvyz625gou
         QYUtOu/vnZLnb9rGHCTUERy4n+CVhBcEys9oUJKjM90GNCIKO3yvbqT54HWjGJaZjOXz
         CcH+eDEvvzHRuWsMxVZIf5lhJEvpl4rC3pvFWeVV4EnZLOxLZT8fVQW9Zk43shu6kRtB
         cHhnv+PjY4xkPaXQZLqzLd6Ra3ptgybAcZ3ei3mm+H1JPOGH68+4ybbuhb1LmzPt56pm
         AdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDtWok6ghcbMOh+aRUPuJcRSWIrIOfWKuyRB73ATInw=;
        fh=tbYo5tw5wj8mL+Ih8rcdrhmHSXt1KrpkMUoPXv3awXQ=;
        b=gN5dMR/b0VhWHjKJEQZlDaAnOsQomwDkvmrbIbgIQFWf8f8kN26qoRgNvG6+WGGq7P
         D2rGCFZAhmacOWq2U+WeJVaoWAtAJsbhAJ6MslCsF4hcbeieGoeVEsAn9GQ1wS7+Q0/h
         OJ16k40qKC2//hzpl4IjT9kunSkCfAupbLev1U7sN8r0+bqHTEbsBw3hwvWOSFyqZvno
         lvpSROVe1lKxATtx2Tkt6BqZX13KZcoxzOmwNx1uqCGaskPY6lch+Q1haNm5hr3gF0eg
         fEWa1QJCxgFMNupO/K3ViEfq0oPXO20MX6yv8LXTG1e38NPPenWA51iUKXIPqwfKDxRJ
         UO2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100074; x=1779704874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDtWok6ghcbMOh+aRUPuJcRSWIrIOfWKuyRB73ATInw=;
        b=j4VCjgKQipWlMtiav+oRaPR0f0v1nvfzZapNCxenZbUZ3Mt3Rn7gmUEXq4oi7jkUIb
         4HgX5uvcMi0RszlVOneYbNm1DM+mJU/JrJR0h0GO8g4bukkzMC7zMlBHjCSOgPkhMpTV
         c4wzllyPVJm2XMA+DbO43unohFkJBR7zJC8kPgscsLXOrQoLc889x8CXLMCrjb7k7adz
         Gsbumo9YHGirJUU0vfb33Y11pt7G3APC6WK3KmfUzHGeFwpngQRJCoM4161ft4aApt6w
         Kt1L2d49HbFBUptVzh8i1FeIDgJkVcLkQkauv8bG7uF5x1ddFs4dXIs3THiHDz4MjsjJ
         8/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100074; x=1779704874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDtWok6ghcbMOh+aRUPuJcRSWIrIOfWKuyRB73ATInw=;
        b=LjTZhBr43bQEVUcY4RpDO1msl2Zf4FIIcn2JtTUt6bJqaPd2NvRP051h5aF0EGMrFu
         +/33LlsPiQOtBTP89SYmMQdoYnSJHs4jjsQMgZEzLDjvgtZgybthKyUmvAO7EghSld2s
         lMsAakjPvhieqgt7Ge5wT+GztGC93YFQOuB1nT0x5IRmmfOvMZaBvcZjN/2ng/Ds/sDX
         Y0YIabSAlSxuiBl8NbhOzz+zm8gH8V2MrJ2LEcL38Z0UdJCn2+0NNJx7GrTygg2lR1vi
         4ez+Kic7+mpSA1sY5jqlC72FtvGbRi2iZoACTOM82XdFgd8H1BCNLkH7HBSEru8v8JJ3
         dX2A==
X-Forwarded-Encrypted: i=1; AFNElJ+nDN1aQkILH5fjKe+D0XPPqAitZ12kav9/Lt6CW8Cgwj4sDnN3OXd+WPorofa6oVfh2vmItGqfgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI56k4UOBA6CjCCRHcjlXtMPadR2AO/CX8m4ZmKgAPIZHYETbf
	kbXqDq5H2yE9ymXoVArlRGGXu/Duo1RdJXASF9cpIzvBtcER/epm+hKgOI9i+8bz4JtmhUJyOW2
	/YVcXB+ueY468UeBq/0nh+R8Vb+zIaO0=
X-Gm-Gg: Acq92OGaDKu+2iiTk9LR0bmyHg2s1QCIZLdUTEevCQergjW4P7QmOGnWrNiT9wH7Lka
	rzNwtpZkWwtZnOER1b1uEeJZ1xX5ny8qllUFkK4PRAV7VOrkvT9B0RSkZuii/4LSs9wqexOu6MQ
	IWGCOWqw3UbdrKSdx+G1YsNnT97hgBrFUvoOkQ14LPcvTpAdoza1CwwjhV9WPoY631ElVdDgfnh
	MBFKFv1N6lpnuSbXScvfwbLExA6b6q60OJvyoNTlMimYWRLoevYLrviYSrbupbCzvwoHa/+tau8
	u+xWcFMA
X-Received: by 2002:a05:7300:8b95:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-3039813cab5mr6740822eec.5.1779100073932; Mon, 18 May 2026
 03:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502124055.22475-1-clamor95@gmail.com> <20260502124055.22475-3-clamor95@gmail.com>
 <20260514100205.GG305027@google.com> <CAPVz0n07EKiF=Gi=Po0zFVSuU=g4pbhJam7VHgiQsPTwtT2wQg@mail.gmail.com>
 <20260514155004.GO305027@google.com> <CAPVz0n1drWV6zMzOx93gHNaw+Tt0M9oAF2RyKW6tZcC2gF_HAQ@mail.gmail.com>
 <20260518101328.GS305027@google.com>
In-Reply-To: <20260518101328.GS305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 18 May 2026 13:27:42 +0300
X-Gm-Features: AVHnY4Kz1QJoA09br8muwyHJF2ZDsix5B0qlI6Cm2ua-EB9O61W3wDAYlVInIYQ
Message-ID: <CAPVz0n0imF_ESoGMJSrEX7NOnBShFj8wehDtQKXZV_DMcGqq=A@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] mfd: Add driver for ASUS Transformer embedded controller
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

=D0=BF=D0=BD, 18 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 13:1=
3 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, 14 May 2026, Svyatoslav Ryhel wrote:
>
> > =D1=87=D1=82, 14 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
18:50 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, 14 May 2026, Svyatoslav Ryhel wrote:
> > >
> > > > =D1=87=D1=82, 14 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=
=BE 13:02 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Sat, 02 May 2026, Svyatoslav Ryhel wrote:
> > > > >
> > > > > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > > > >
> > > > > > Support Nuvoton NPCE795-based ECs as used in Asus Transformer T=
F201,
> > > > > > TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF=
101 dock
> > > > > > and TF600T, P1801-T and TF701T pad. This is a glue driver handl=
ing
> > > > > > detection and common operations for EC's functions.
> > > > > >
> > > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.=
pl>
> > > > > > ---
> > > > > >  drivers/mfd/Kconfig                     |  14 +
> > > > > >  drivers/mfd/Makefile                    |   1 +
> > > > > >  drivers/mfd/asus-transformer-ec.c       | 762 ++++++++++++++++=
++++++++
> > > > > >  include/linux/mfd/asus-transformer-ec.h | 162 +++++
> > > > > >  4 files changed, 939 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/asus-transformer-ec.c
> > > > > >  create mode 100644 include/linux/mfd/asus-transformer-ec.h
> > >
> > > [...]
> > >
> > > > > > +     unsigned int num_devices;
> > > > > > +     bool clr_fmode; /* clear Factory Mode bit in EC control r=
egister */
> > > > > > +};
> > > > > > +
> > > > > > +struct asus_ec_data {
> > > > > > +     struct asusec_info info;
> > > > >
> > > > > You have 'data' and 'info' which a) using non-forthcoming nomencl=
ature
> > > > > and doesn't tell me anything and then you b) put 'info' in the de=
vice's
> > > > > driver_data attribute which is very confusing.  driver_data shoul=
d be
> > > > > for what we call ddata which I assume is expressed as 'data' here=
.
> > > > >
> > > >
> > > > asusec_info is shared among all child devices and is exposed while
> > > > remaining elements of this struct are for internal use only.
> > >
> > > Our terminology for that is usually ddata, that gets stored in
> > > 'struct devices' device_data attribute.
> > >
> > > > > > +     struct mutex ecreq_lock; /* prevent simultaneous access *=
/
> > > > > > +     struct gpio_desc *ecreq;
> > > > >
> > > > > If I hadn't seen the declaration, I'd have no idea this was a GPI=
O
> > > > > descriptor.  Please improve the nomenclature throughout.
> > > > >
> > > > > > +     struct i2c_client *self;
> > > > >
> > > > > Again, please use standard naming conventions:
> > > > >
> > > > > % git grep "struct i2c_client" | grep "\*self" | wc -l
> > > > > 0
> > > > >
> > > > > % git grep "struct i2c_client" | grep "\*client" | wc -l
> > > > > 6304
> > > > >
> > > > > % git grep "struct i2c_client" | grep "\*i2c" | wc -l
> > > > > 903
> > > > >
> > > >
> > > > ok, noted.
> > > >
> > > > > > +     const struct asus_ec_chip_data *data;
> > > > >
> > > > > 'data', 'priv' and 'info' should be improved.
> > > > >
> > > > > > +     char ec_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > >
> > > > > An array of chars called 'data'.  This could be anything.
> > > > >
> > > >
> > > > Do you have a comprehensive list of name conventions you find suita=
ble?
> > >
> > > Anything descriptive that alludes to the type of data being held ther=
e.
> > >
> > > There are 100's of good examples, but a handful of generic / bad ones=
.
> > >
> > > > > > +     bool logging_disabled;
> > > > >
> > > > > This debugging tool is probably never going to be used again.
> > > > >
> > > > > Keep it local.
> > > > >
> > > > > > +};
> > > > > > +
> > > > > > +struct dockram_ec_data {
> > > > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > > > +};
> > > > > > +
> > > > > > +#define to_ec_data(ec) \
> > > > > > +     container_of(ec, struct asus_ec_data, info)
> > > > > > +
> > > > > > +/**
> > > > > > + * asus_dockram_read - Read a register from the DockRAM device=
.
> > > > > > + * @client: Handle to the DockRAM device.
> > > > > > + * @reg: Register to read.
> > > > > > + * @buf: Byte array into which data will be read; must be larg=
e enough to
> > > > > > + *    hold the data returned by the DockRAM.
> > > > > > + *
> > > > > > + * This executes the DockRAM read based on the SMBus "block re=
ad" protocol
> > > > > > + * or its emulation. It extracts DOCKRAM_ENTRY_SIZE bytes from=
 the set
> > > > > > + * register address.
> > > > > > + *
> > > > > > + * Returns a negative errno code else zero on success.
> > > > > > + */
> > > > > > +int asus_dockram_read(struct i2c_client *client, int reg, char=
 *buf)
> > > > > > +{
> > > > >
> > > > > Have you considered using Regmap for register access instead of
> > > > > implementing custom functions?  Remaps already deals with caching=
 and
> > > > > locking mechanisms that you'd get for free.
> > > > >
> > > > > This looks like it would be replaced with devm_regmap_init_i2c().
> > > > >
> > > >
> > > > I will consider this, thank you.
> > > >
> >
> > It seems that regmap does not fit for this purpose, but I might switch
> > to plain i2c_smbus_read_i2c_block_data
>
> Can you explain why Regmap doesn't work for you?
>
> Regmap is just a wrapper about i2c_smbus_read_i2c_block_data() and friend=
s.
>

Honestly, it seems that this will cause more hassle. Regmap has max
bit size of reg 64 which will require use of regmap_read/write_raw and
obviously no regmap bit update operations will be possible. If this
chip was a plain 8 bit register i2c device, obviously I would use
regmap.

I have removed most of custom functions in favor for i2c smbus block
helpers and left only asus_dockram_access_ctl since it is used in many
places.

> > > > > > +     struct device *dev =3D &client->dev;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > > > +     ret =3D i2c_smbus_read_i2c_block_data(client, reg,
> > > > > > +                                         DOCKRAM_ENTRY_BUFSIZE=
, buf);
> > > > > > +     if (ret < 0)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > > > +             dev_err(dev, "bad data len; buffer: %*ph; ret: %d=
\n",
> > > > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, ret);
> > > > > > +             return -EPROTO;
> > > > > > +     }
> > > > > > +
> > > > > > +     dev_dbg(dev, "got data; buffer: %*ph; ret: %d\n",
> > > > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, ret);
> > > > >
> > > > > Please remove all of these debug messages.
> > > > >
> > > >
> > > > Why debug messages cannot be preserved? They are specifically marke=
d as dev_dbg
> > >
> > > It's a general convention.
> > >
> > > After initial development, they tend to just litter the code-base.
> > >
> > > Debug prints can be useful higher up the stack though.
> > >
> >
> > I am fine with removing all debugs and logging but I strongly would
> > like to keep EC model and firmware version along with susb and factory
> > status. That may be quite useful in identifying EC used and its
> > behavior without need in rebuilding the kernel and digging huge piles
> > of downstream code in order to find how to dump these values.
>
> Yes, you can keep this sort of thing as INFO.
>

Noted. I have send v7 with your suggestions applied. Change log is in
the cover commit.

> --
> Lee Jones
