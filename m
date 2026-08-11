Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BE434409
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449127; cv=none; b=oZPNy3CuReoo3nP7qmJbaIQe4FsXPeTwZASEP5dhHYniTRAxM9wh2nl3cKfedJgIIkxLKU3V/Y0adNG2z6ljei8wgq4lTo4xktx2CioierJpmHwRfPcLAngp49qu+IBcynBmH8UsbWlUB0vUuDXGUomt0ZWnP8L1RTyOnl1+KW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449127; c=relaxed/simple;
	bh=W8lxYDaSFvG2LENuVgumDI2Us0ijdNp1IfWuToF3Sc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pm8+/fc/lBlLkIjzA1FJgznfBSVAMj5g3qyQG+MQyTSlWlDTWZVgJV0F2fPdaCVy9hVe3jRUyl1li2kEwgxtiT0N0kNfLbXAzsAXpokfn/AfeFdJASrVV5Nx3PfchWIDMhKzFPY5hh938+mg+cZKEIFgThXA0uzxgj0wp7xVY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bf959b820cso1886568e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 04:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786449124; x=1787053924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gw6+OutRgMyTdQq2RnO8+b25hOPJIM1JAzCBiUaxv5A=;
        b=NUM7wvjlwyv2WJmCZlJA39fldcP70hFHa5Q4pJLeCRoU5wzNO5UxgK4AyVO00WcOw5
         pN7RYN0uPZ7Zyurszll1FhRxcrv6edB2oiinU0qr3v7CPI7z0DHHQLqqptNc2gJcGiqa
         iCxWodpc289UV/8GUrKPaU+/JRe2q7nY82Hfqt4sf6iDD0g8VF7eqjzFdfD0847PdnOB
         3NVmuZwJHPBv8m5vWBKGRtDO0T3Sd2Z2ThH3cpm4lxVcx0UNIoTyItBpUlLMfs0GGNus
         kn31RJxUXL+ys6/LaO3Jn8ye5DMRq6OCf1Jc+Su0/NeCdS3FMNenxwFCznduvloi+ROK
         5iyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQWAND8IrV6Kuk9IujG3YhzWQttRDCZiEkdlNNp0sChbxpFw7EkYKn5jlziwIX0pdjIAlZK67eLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmbwPtiO8obZXjPYfepjlrYaAcWbYMDHQ2RWAJa2r5WHU5zLi
	0QlcwGg0zKnSmnsYUTtXloISv+RnDjE+sYwjJZasBYT9T+Hg/QTA0oB9PEBlrm5A
X-Gm-Gg: AR+sD13eIpvljjY+hr6JeRUAHx2YcuBkgVBfrYnWZ58oa6YUZeCYGcfb2Hi5jQb9Kf7
	4PXgj8YtHTctUHhdrTUR0sqY/DW6xYMB+bZGSzPoQSuNAVMqtpQ6rUSgPoEKvNxrI1AlPeG9N5X
	FIhvonJ7y8kjl7Kx74/UtPj5CAJJ/N2Df1or/dC3cwZgo4rk8NVGq5yqoGYZ8gawxDdcikItAad
	rU72tahurGWg/bRteGY2wLjgDdFcDSFwsPMIo3Xy9IfkQTTzWfnlpK4H9fcu6o9haI8ckyVPxwJ
	EcA+YFia89AeX/HUaBcdnhSwWUijasGR8lLmT8KvJJAlRx4FVyxcO4ry0Up5oCZbzIwb1qSJ9PF
	66CFsRxnl+PlbE9lFLPowml5L8j/l9qkuKjDi3RHGR+ud1xWNHPBY4eBAjMYmLg3izCR/zKuZxB
	ut833FXOU+bINJsilFWIXkTunov3aYM25rF6glESkeFDiZyB7QNsFfMYnqWCxcOFJeDUpqTNyEn
	IEaSe+sU0n2SdiYxLXO4HEoC3062DdRK3Br
X-Received: by 2002:a05:6123:2e6:b0:5c2:acd2:5b44 with SMTP id 71dfb90a1353d-5c45037548dmr387604e0c.3.1786449123874;
        Tue, 11 Aug 2026 04:52:03 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c451e802absm282937e0c.17.2026.08.11.04.52.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 04:52:02 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-966d70b9e1cso1650795241.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 04:52:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpEAnq0G1ekvxsa6fJSY4asjbRa/fZ8rwwAmIr3or6D5ze1O1Zm4Cclz2X9b+rNN73CSxjDFpJ05w==@vger.kernel.org
X-Received: by 2002:a05:6102:5128:b0:744:d1a6:b11d with SMTP id
 ada2fe7eead31-76b54f7c0ecmr827022137.3.1786449121269; Tue, 11 Aug 2026
 04:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4bd0cc7f26c1bcdc260edb994b4971cb5dd3a10.1786438424.git.geert+renesas@glider.be>
 <CAPx+jO-uXbNpFPzbAbDkBQh2-xf4r1NXk2PdQvOh9ZOfEQ71gQ@mail.gmail.com>
In-Reply-To: <CAPx+jO-uXbNpFPzbAbDkBQh2-xf4r1NXk2PdQvOh9ZOfEQ71gQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 13:51:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLsMfGEz5s9s3voZGbQL90hRYCxsfC==xsGs315XOHWA@mail.gmail.com>
X-Gm-Features: AUfX_mxYFb3a8-KjLfsf-hDUGSX7q2XivFMj5SQAYvLQGp9PIzS7OsTLrsDrS6c
Message-ID: <CAMuHMdXLsMfGEz5s9s3voZGbQL90hRYCxsfC==xsGs315XOHWA@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, 11 Aug 2026 at 12:16, Ulf Hansson <ulf.hansson@oss.qualcomm.com> wr=
ote:
> On Tue, Aug 11, 2026 at 10:58=E2=80=AFAM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC=
.
> > For now this just supports the always-on power domains, and dummy modul=
e
> > clocks and resets for the serial console (which is enabled by the boot
> > loader).
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I had a closer look at the attach part and there is few questions,
> please see below.

Thanks for your comments!

> > --- /dev/null
> > +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c

> > +static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
> > +                                   struct device *dev)
> > +{
> > +       struct device_node *np =3D dev->of_node;
> > +       struct r8a78000_mdlc_priv *priv;
> > +       struct of_phandle_args pd_spec;
> > +       const struct mod_map *map;
> > +       unsigned int id;
> > +       int ret;
> > +
> > +       ret =3D of_parse_phandle_with_args(np, "power-domains",
> > +                                        "#power-domain-cells", 0, &pd_=
spec);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (pd_spec.args_count !=3D 2) {
> > +               of_node_put(pd_spec.np);
> > +               return -EINVAL;
> > +       }
>
> Is the above check really needed?
>
> Assuming r8a78000_genpd_xlate() is used for attaching, then the
> args_count must always be 2, otherwise we return an error code when
> trying to attach the device to its genpd, right?

That is indeed true if power-domains contains a single entry pointing
to an MDLC domain.
This check also protects against the (currently unlikely) case where
there are multiple entries. But for that to work well, it should indeed
validate pd_spec.np, too.

Is this good enough for now, or do you want me to drop the check?

> > +
> > +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> > +               hlist_for_each_entry(priv, &r8a78000_mdlc_list, link) {
> > +                       if (priv->np =3D=3D pd_spec.np)
> > +                               break;
> > +               }
> > +       }
> > +
> > +       if (!priv) {
> > +               dev_err(dev, "%s: MDLC %pOF not found\n", __func__, pd_=
spec.np);
> > +               of_node_put(pd_spec.np);
> > +               return -ENODEV;
> > +       }
> > +
> > +       id =3D pd_spec.args[1];
> > +       of_node_put(pd_spec.np);
> > +
> > +       map =3D mod_map_find(priv->mod_map, id);
> > +       if (!map) {
> > +               dev_err(dev, "Unknown module 0x%x\n", id);
> > +               return -ENOENT;
> > +       }
>
> Would it not be better (if possible) to do the above verification as a
> part of the r8a78000_genpd_xlate() instead?

In the current minimal driver, the verification could indeed be done
in the .xlate() callback.
However, subsequent patches will add actual data to the retrieved map
entry.  As the .xlate() callback cannot pass data for later use by the
.attach_dev() callback, the latter has to call mod_map_find() anyway.

> > +
> > +       dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
> > +       return 0;
> > +}

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
