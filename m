Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDA305678
	for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985807; cv=pass; b=uqF60hrTOn2g/7GqxDcM8ujGh2umsSW7k+/ooDlfyd/jXksqapaxP4f9himMnhGFBnnBTMHKr+8RJ+waDiOIlVV8WrKwGOoXoErT1g60rpciMu96TJco9ViRlJ5vQMa2RQF7UpUU9iu1Xl/2GGC7ipgzuPV//SEcGo/stYI0uBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985807; c=relaxed/simple;
	bh=iyfAphcrJGor91FmD7IGYNutyAxV9/ncvttL25PE830=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7ixAMCrfpY+SDbUaSBmEoNCjWEV4pLr0yLDblIVOFqzr/l68mZCiEWN2s9ElMxyZVMDyIM8wKdyWHTzNdPXj4V4ADwDe7ci1SmHjsbP/B0HKGHhcJfYlHVJz96Gi1XUKoVn7TZSmaQNVvh7YgHaOTRhzSBXt3rH6LMFK3i/DGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwr4tQOP; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwr4tQOP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1405094b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 06:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784985805; cv=none;
        d=google.com; s=arc-20260327;
        b=rM8mHc2zn1mtr9aK71RzQOlCm5rHWvh2HrFcMW2jZlL7KOBIAKR7SHogCcvyl5aw+j
         H2djTiNT1naVa/weB/j0d1lhi69p2u7ZL3DE7nW2w6xGZO8/4HKGJAGRwc0mWhYngCAE
         LTCny9LaRG7efuG7XFKGPB1isOUtE169EqkgFua46o1c79qJkW6pBCNvWSkJabx5tnA0
         /AOg1CZqEO21tWY0t5r+3I+gHgWZ4HmaEpuwIaPSHlBj9MJS8sY/gMoKB5f2xw0Cjv/5
         qKIFgqmkTpbu0todKkFctvyLR5+/nAE0L8iE6n/RtMQhjMnYZCl5a0t/0IvKhNiTdUTQ
         uUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        fh=pwOgB68hTaHeJF5dSX017MLBfbfnQIn8qj/bu8s+75Q=;
        b=gOYrnMkw/nw4SsujdFXBw4agIP+iuGvekS0tMbzHSAj7vSQ6nm0cSbkerwF4qd8ffd
         VvRAPL60QjrbwZZH7F4io1Q5PK662eFhhfeuc1ets4zxI1D+KAeIVVfk5RDzUco89Ngg
         a7f8gLxqNV3z45dEAebBdzDwEfgyRbIoTJPlCuOzRAdWWeLJQZsl2R+7DbagzjmAACYW
         mPElvrh9SV5GUewouvK28IXvPBBGgktgcdyXHU8kgNJ26OituuwRMr9WRJFPvn9PMztn
         z08w4RJOC7JpfKl6LtlaSFeLXV1pfNkbe4gRBIdlmAT7HlhIggW5eUtqnVPeHbL10J5j
         ibJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784985805; x=1785590605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        b=rwr4tQOP/NDuSVNy6MSTjghqfhqv/9wiglejRt1ULV6Th9ZpXSsgm5REam0H9lKkzk
         o896/WR/6nNlL7/9jA0Dl7db0LpDOtVkkqJbmMGG5Q0A0dFsSwRlAiOSpOnLQa59vwZQ
         lb/qby2aAFMubawZFbk9pH6OTbCd0xQI+VV+MlfrNEwwdY1foEztzk19SFDoBOaau+qJ
         Jn0Q6WM26eRMQ3YfafZw8yfEJlCgHzxzGgR5GU9ilx4q+RTu0q23b6DyfWS62TSshZQ5
         fD+eQZrNToPFKs2IYJ8/NHhI2AwCIH1QuaYVO5NtVzyqFuWeYNmvSCIB9Wn9qcqau3Kq
         BckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784985805; x=1785590605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw44hJDz7rSvpH5qvEi2DXJBQouyq2n4xZUL150B+WY=;
        b=nIjWEycPzXksf7+uu/Ek3Dqj5CNklcmYwGglg5GSvX4t2ldhNJWD+SiZqROiRfA1YJ
         B+6NCq0zMlbwHmAuzVU06Sa7+BGaohk3umdTTG4PxCtX5QT2ne+jpzW26vJmNwWXFXCL
         nKN5iV5O60oK+ZCiQpx9rzV3dSp3YWgCZzaUWVtkGahkA+8gwQ7INDg10aFBjVnXly7n
         g1yY1h2Q8cGWH4ktsqFd6h08hdy7aast0OdPu4fclSUzuquwmFqXqRKPFhMMLW3kPFMP
         hgKewtE2zZvLa75XmkBTzs+lelC9Rou+qmQuyP5X1zsN7ZqIrmV7lELeaH8evd3UJps+
         MqXA==
X-Forwarded-Encrypted: i=1; AHgh+RpRoBhza9dkybbbqw8UF04QBiwhbK+G//gsQuDl7+h49OKTwC3lzUq4/C7dxjsvNxpFvMo0VxZH2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwObwU9BfHEewFunvAcnVuRdLAjaB6gkfsA6MPnrFA2ULBxJGLY
	zx+u28pPaRT9ntwfbNpxx8Kzfs6k7TE56cmOZ60d/+rGPz3YoQeMUW/OjauTyZRDRAFtWY5cz26
	BfV1AFhYuaA1M33LPgvJJW1pjAXFjM2Y=
X-Gm-Gg: AR+sD113PcPpYjft7Jca8LO6nE1AYMC13tTG8Strh1Tjrzj44H4qHWkpfHUUDn2WiSS
	ZPuFIr2C3BAL5oGqrVCDX725DurwkPYFVupoqtTUEID+ycUt/NvCpVsY7a2QL5xoI0Y6A3q8Acp
	5SPIVaZzLv/UifuaXCjvJuBdkf3chJq6JV5ZypXRephH55In5+zIfGwN9KEA03ODy6lOth+F76O
	u4XPD0NRlB9LUNrrgm+yuUvI9I3IKCXbk7+vuhuMuvSvRdkcX/4CGS8JuGt2ZLZLg4rSzFfmtim
	+DZoEutc+sNGf8EJ1xY=
X-Received: by 2002:a05:6a20:c5aa:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c67e026f9dmr2180177637.62.1784985805156; Sat, 25 Jul 2026
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095233.420823-1-clamor95@gmail.com> <20260721095233.420823-3-clamor95@gmail.com>
 <amGx2fJCUB4_XW1M@monoceros>
In-Reply-To: <amGx2fJCUB4_XW1M@monoceros>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 25 Jul 2026 16:23:13 +0300
X-Gm-Features: AUfX_mx8PDd_aHDdNKfdxjyqn_bGAG_YlQFuZHOTbUPdXQnkuKB3mJ4_MrnWIhc
Message-ID: <CAPVz0n2yWtTOgruRc+MAYTZ9=rd6qf6sEnX9v8THvJkN_opvbA@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded controller
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 23 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 09:25 Uwe =
Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> On Tue, Jul 21, 2026 at 12:52:28PM +0300, Svyatoslav Ryhel wrote:
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
>
> Documentation/process/submitting-patches.rst has:
>
>         [...] the ordering of Signed-off-by: tags should reflect the
>         chronological history of the patch insofar as possible [...]
>
> So your S-o-b should be last when you submit a patch.
>
> > +#include <linux/i2c.h>
> > [...]
> > +#include <linux/mod_devicetable.h>
>
> <linux/mod_devicetable.h> will go away soon. Please rely on
> <linux/i2c.h> to provide a definition of struct of_device_id and drop
> the #include of mod_devicetable.h.
>
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
>
> Trailing comma after the assignments to .data please.
>

Sure, but out of curiosity, why in this case you ask for trailing
comma and if entries are in one line, you don't.

> Best regards
> Uwe
