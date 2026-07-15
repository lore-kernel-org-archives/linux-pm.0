Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEA3ED113
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106660; cv=none; b=fvWwrEeKG7E3mBBHNYChojuF00iQMdAWQRPzAsY6aoKyI2CtABqr/0uk7SfJ3lDP0P3NuLFoH/ZxiPeew79ApJXmfoXLMCkNfGAQDxPmcfNrjRzRU2x52TBN9Nf9iukArW22FqePg8NJTjF6wZXNWfT2hSm7lWkbtG0SR9BulYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106660; c=relaxed/simple;
	bh=b9PpOJcb8DxhkXY45jY4YE04g6Om+Wyc4fpqhjZ75nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZqrT7llmqQV5WOD6RQE7aAhplD3kvbt69utgUbdydxLIv1r8axiBQgU5nYLb2a2oMcuejaf0GFTuT3D0sIyfMHcczW7TnSYDUJm61AQbNtLtqmcXHJaS0WsSzGnO7dof7yYYHffJnGAVovp3Li1t9sVNIoonsZimvYtg5dlkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so4417852e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 02:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106658; x=1784711458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLTXQ+jfU88JSGv7Lh/A+xkjnHoYFHk+Tdqt/10T0QY=;
        b=nBwabc3jSjpirJvG/R5+BkF9P+uPCt1ohft4AsjIkJmDVh2Tr4tlUpUv6kCsO7VHCp
         /s3zsYVd0Y9YOcUa4FJiBBPKqRSgeAXESeQcS1kMqUWnV15XuMHE2WxqANR9KSkeuU42
         wlLGQpxqCTtDc2D3FOcsdHH5jVq7UIisunG2nYHUA3eZhWfnf4Cuql8e+2Y8Zs5hInUc
         EWUrEWCLr2VoVs7cuxYlG5yPGM4Yed/QTILB+83A/FfamL66zLwRWu3A+0pJGa5/R1u+
         clZ5N3Kdl7eD6R+FT1PVKfAj2sWQ+0TZi7yUgRA6lT99L3fb2b+hTq/BqsRZg/qXvrSc
         9Hhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7vXsx1Mg5vZ+C3BzQQuomnwQcmgzX6qUAtdXBT+WHq4IskHKT6XHVELGg01WitRHC4SdKHdpcIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZVHuN4Q6juWKVNcpn0eNbwLm1fMTs+7QWa35FK8NpUJ6FvEA
	IyN4886k+eFhvnSu8ncWJeXP1O4sn67JP5CTJ1Q2haKY0hjdkGSFHjp6ED3y4Y78Wfg=
X-Gm-Gg: AfdE7clR69aBRfga0K5VaVqURi6R+sLTtvvwsWEIcGbAaZI/Nwl4IZn0FMw1LpuQGQs
	29Y4+oEsSIBbgFsJS6Q0MAS3sdCSHVVOX9iYqS8Dxo6TtE05l92jQuxZsqwrU0yQr8KftnejmG/
	Sd5EW1M/AGaHbXXs9kiHm226Q2XSkU4ZlshXmTEZddPEAZiKt6p+0CHMi/0blR3/wpwIsOW6Vm/
	PigOn07ZUNcwggFmEdoxGuwK4cD9kA24OOmkKgV2hN1ykjBGSihWe4ug77r3Z8SHnAKLtcj1Lsz
	liv3y08SzRchHqCOA9hBPgK9ds3D24+axQjK+wsbP+dUQGxD+VuNjYb3IzVJGo1TuVGs21EZGws
	cCisbb5A4QmbzIz22ktscdpZtDRoimjiohuXRUjKbnTHXHm2cMf1XqQNykl+i4sruo+yvW8LdZC
	uETdkdzBrvInYuTNySSF7VdZsf0mWifjpSfkIcNahtln4bFZHGKw==
X-Received: by 2002:a05:6122:1d0c:b0:5bf:b497:87c3 with SMTP id 71dfb90a1353d-5c124d82d35mr1297562e0c.0.1784106658214;
        Wed, 15 Jul 2026 02:10:58 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf8bc8e082sm10062269e0c.1.2026.07.15.02.10.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:10:57 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-73791ee3612so3730924137.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 02:10:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpeGOWQ/ka31zWCuRZnNg2d+2zTSYszZVoJkWakFeS/V2AJLhqGU1yFg5qHC/31YWW+IJSBltx89g==@vger.kernel.org
X-Received: by 2002:a05:6102:4425:b0:738:2a8c:736b with SMTP id
 ada2fe7eead31-7459a045858mr1258510137.20.1784106657725; Wed, 15 Jul 2026
 02:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505142.git.geert+renesas@glider.be> <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
 <CAPx+jO-=LF9CvYDrC3O_GBtfHU6GYvq524OLmTG8R1-u27oyKw@mail.gmail.com>
In-Reply-To: <CAPx+jO-=LF9CvYDrC3O_GBtfHU6GYvq524OLmTG8R1-u27oyKw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 11:10:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAwxs50S7hwWRsSmtRagD7Gu4rodGund4k3r1x1+A5ug@mail.gmail.com>
X-Gm-Features: AUfX_myLu6xhapX4cEw1JPlcU_GnqjYP1lw1RxK8SjV_xKv0JfjeAPhzRG7BCHM
Message-ID: <CAMuHMdUAwxs50S7hwWRsSmtRagD7Gu4rodGund4k3r1x1+A5ug@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Tue, 14 Jul 2026 at 14:04, Ulf Hansson <ulf.hansson@oss.qualcomm.com> wr=
ote:
> On Wed, Jul 8, 2026 at 12:15=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > Add a minimal Module Controller driver for the R-Car X5H (R8A78000) SoC=
.
> > For now this just supports the always-on power domains, and dummy clock=
s
> > and resets for the serial console (which is enabled by the boot loader)=
.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c

> > +static struct generic_pm_domain *r8a78000_genpd_xlate(
> > +                       const struct of_phandle_args *spec, void *data)
> > +{
> > +       struct r8a78000_mdlc_priv *priv =3D container_of(data,
> > +                                       struct r8a78000_mdlc_priv, genp=
d_data);
> > +       struct device *dev =3D priv->dev;
> > +       u32 id;
> > +
> > +       if (spec->args_count !=3D 2)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       id =3D spec->args[0];
> > +
> > +       if (id >=3D R8A78000_MDLC_PD_AON) {
> > +               dev_dbg(dev,
> > +                       "Mapping HW power domain 0x%x to always-on doma=
in\n",
> > +                       id);
> > +               return r8a78000_genpd_always_on;
>
> This looks odd, but perhaps it's just a temporary mapping that you
> intend to change later, no?

The hardware has multiple always-on domains, but on the software side,
using only one is sufficient.  When needed, it can be changed later.
Other domains will be added later, in the else branch.

> > +       }
> > +
> > +       dev_err(dev, "Unknown power domain 0x%x\n", id);
> > +       return ERR_PTR(-ENOENT);
> > +}

> > +static int r8a78000_genpd_always_on_singleton(struct device *dev)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +       int ret;
> > +
> > +       guard(mutex)(&r8a78000_mdlc_lock);
> > +
> > +       if (r8a78000_genpd_always_on)
> > +               return 0;
> > +
>
> I guess the mutex is used to protect the global
> r8a78000_genpd_always_on, but it looks like that isn't really needed
> based upon how things are being called during the probe.

Why would it not be needed? There are multiple instances of the MDLC
device, but only one instance of the always-on domain.

> > +       genpd =3D kzalloc_obj(*genpd);
> > +       if (!genpd)
> > +               return -ENOMEM;
> > +
> > +       genpd->name =3D "always-on";
> > +       genpd->attach_dev =3D r8a78000_mdlc_attach_dev;
> > +
> > +       ret =3D pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
> > +       if (ret) {
> > +               kfree(genpd);
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to create always-on domain=
\n");
> > +       }
> > +
> > +       r8a78000_genpd_always_on =3D genpd;
> > +       return 0;
> > +}
> > +
> > +static int r8a78000_mdlc_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct device_node *np =3D dev->of_node;
> > +       struct r8a78000_mdlc_priv *priv;
> > +       const struct mdlc_info *info;
> > +       struct resource *res;
> > +       int ret;
> > +
> > +       ret =3D r8a78000_genpd_always_on_singleton(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       info =3D of_device_get_match_data(dev);
> > +       if (!info)
> > +               return -ENODEV;
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->dev =3D dev;
> > +       priv->np =3D np;
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -ENODEV;
> > +
> > +       for (; info->base; info++) {
> > +               if (info->base =3D=3D res->start)
> > +                       break;
> > +       }
> > +
> > +       if (!info->base) {
> > +               dev_dbg(dev, "Unsupported MDLC instance 0x%pa\n", &res-=
>start);
> > +               return -ENODEV;
> > +       }
> > +
> > +       priv->mod_map =3D info->mod_map;
> > +
> > +       scoped_guard(mutex, &r8a78000_mdlc_lock) {
> > +               hlist_add_head(&priv->link, &r8a78000_mdlc_list);
> > +       }
> > +
> > +       ret =3D devm_add_action_or_reset(dev, r8a78000_mdlc_unlink, pri=
v);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "failed to add action\n"=
);
> > +
> > +       /* Note that no actual domains are registered, just need transl=
ation */
> > +       priv->genpd_data.xlate =3D r8a78000_genpd_xlate;
> > +       ret =3D of_genpd_add_provider_onecell(np, &priv->genpd_data);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to register genpd provider=
\n");
> > +
> > +       ret =3D devm_add_action_or_reset(dev, r8a78000_genpd_del_provid=
er, np);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "failed to add unregister action\n=
");
> > +
> > +       priv->rcdev.ops =3D &r8a78000_mdlc_reset_ops;
> > +       priv->rcdev.of_node =3D np;
> > +       priv->rcdev.of_reset_n_cells =3D 1;
> > +       priv->rcdev.of_xlate =3D r8a78000_mdlc_reset_xlate;
> > +
> > +       ret =3D devm_reset_controller_register(dev, &priv->rcdev);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to register reset controll=
er\n");
> > +
>
> In some of the error paths above it looks like we end up leaking the
> data allocated for r8a78000_genpd_always_on. Perhaps clean up that
> somewhere here.

That is intentional: the always-on domain is shared by all MDLC
instances.  If one MDLC fails to probe, the MDLC instances that did
succeed still need the always-on domain.

>
> > +       return 0;
> > +}
>
> [...]
>
> In regards to the merge strategy, I intend to pick patch 2 (shared via
> the immutable dt branch) and $subject patch. Please let me know if
> there are any issues with that.

That is fine, thanks!

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
