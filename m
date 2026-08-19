Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF373D3486
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128925; cv=none; b=PxROzd7/t1HLcSsmCNgN7fqrl39FrycwqMeQWE0XesVjKTE7G1LeGFqgJcOrRVdFNLmuWZaIFENGs1y0NOr826xeEjBW+WuSKPEf2KAKzi52Cjxtl5ObstgswKb/oq/idqkoUcn2YYqW5A++aEb/TSNGKoZ/GNrt3zPwhhPXiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128925; c=relaxed/simple;
	bh=+1jwVbFxW0XLlovd1xlFsqF4mv3a/J7TGbtos8pkWHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9LJWFdc9aKl1Bt4f8rKZsAJCj78NVARDaPK8P9/7j8l8z+X+Knir8XpXcTgbvi+rtefTD6txV4Hhu1IvcvDsn3XL4turJ/J3sudENxlV3AAfP/200EKi4H7u7UJwQ4fmm0ncM/MvzbUFUKf8VN+4bDJ3dQhiPJvjaKiV2g31iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-73b909fbb6bso485611137.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 01:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128922; x=1787733722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mkSyFl4tju91Z3EtUpcu+YMXfyGSyMxiBe3tnse0SDE=;
        b=TK2xxfTLvXXm5BAoQpD7fpdedoA/h84+w45aEjwApkLfgkHBKStC0p2r7zwrfcfavQ
         Y3Hs7r2f5MIg8w9/TYTK/zv6+TPH7RV3ioFFyVtVD+5AT0DRUjc3vth+UYXW8CAXPEnz
         o0wq9dgXj5QYvwXZ0AqktDx+okM2SBdrrgaXDidOLzvrPAXkHPwsA7xwYZsJVrsCIQHj
         muuZnzyBPd1BtT2sfpnf/5mP/UG388pvj/zb060GLo3lH3Bvo9XoXtF1IrM7WxGb3rsy
         XdwMGVryQ88nokWD6TBkoZV93urSIWJdylMclvOny81JfukVk+KgmI8vG12yIM6DR0xK
         qAFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFuBReCTk8R/EGr5qUVf+SOMsXGe4uJDu8W2tJ39QdD+mHkBGHh5xMkWUBE8Fk9t2LC94QQO4zgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpi58VoqjMh2wVpwWwYMut9klv8DnONMrAihOHJ27JSzanOSJe
	+mpUbHEYAvE6H/tOZmMKTTXEJ6CsmfC5I8mptjOUV96iT+8qJxw9Zxp44oUmudc/vIU=
X-Gm-Gg: AR+sD13WnbWLsHdHir2xJEITyRIok8OGKhP8j36qOjXPixO+Y2V6sJISiWwLQJp1gUj
	dQJVwMliaqxhrp0/se49zWCLkL2mmGScbJqGC6boqmD2ctgU9bhoeS/I6cbzYvVSRlSoKL0Hdnc
	/+HS5GnensJBRqDuTwbfFzePesli1uH/jqT7zmY4ySTF89Cx3Km0rUOtEhl3ycomkhn3rQFTFPk
	a6vdgOrwRpbv0aZrwKmBG9bLPGMJHY2dsQYXlwKny7LG8d7fdtLm7Ce7gcKyIhTHuARcw4sCnjs
	mGBA6XMmr+MXjTY0UrpAeX/MyKCdf+AAmzJN45HDVZGlG4bzpm5WmbekbuuKUqk4sC/acnhU9Ug
	8vRmw4cn/Hb7wKOzIOZoAv3JHfa8EGze/Sv1JuuCpCZZEqQhce+rjKHdal/uZX/My4ntbFgv3iV
	JHokEarrhLXLIsKDqfGc5r6hiclDHOC5fuNGtTr/1pHGEIHpPFlHRc1s0/buLUcuRJxfCMzXXPn
	08TSlPswXF6siA22kdsy8Uc7w==
X-Received: by 2002:a05:6102:8099:b0:764:ff65:fe5b with SMTP id ada2fe7eead31-777f8f8f722mr1019475137.5.1787128921774;
        Wed, 19 Aug 2026 01:42:01 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e76271asm1456705241.1.2026.08.19.01.42.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 01:42:01 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7542a2ee156so463791137.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 01:42:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqEGikTSzzx88UU5MCg6IbT8HLCLafESv7g22WkB80RMjkAfrORHa+5M8HUxb1IF/qAhDedAmx8bA==@vger.kernel.org
X-Received: by 2002:a05:6102:5cc2:b0:775:3925:9d21 with SMTP id
 ada2fe7eead31-777faba5e6dmr972550137.9.1787128921299; Wed, 19 Aug 2026
 01:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812115010.108322-1-biju.das.jz@bp.renesas.com>
 <20260812115010.108322-3-biju.das.jz@bp.renesas.com> <CAMuHMdU+asd-YNYx_supbAvYWcEJYQrFKqBVv-emeN0Jy8ME8g@mail.gmail.com>
 <TY3PR01MB113464399E7C6C5D6B72A423B86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113464399E7C6C5D6B72A423B86A52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 10:41:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2tP-V9H0QthQ8=orDMxXSsLmzv=krkpn7YgYXCR7+Tw@mail.gmail.com>
X-Gm-Features: AcwNN1WfYoDYq5jMyxRuvnD2LhmVxHJ_oTDz65LLltJ8ov67AVHcAz3vnT9l3BA
Message-ID: <CAMuHMdU2tP-V9H0QthQ8=orDMxXSsLmzv=krkpn7YgYXCR7+Tw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 19 Aug 2026 at 10:18, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Wed, 12 Aug 2026 at 13:50, Biju <biju.das.au@gmail.com> wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
> > > which signals power readiness for various IPs (USB, DSI, CSI etc.) on
> > > the SoC. The driver binds as an auxiliary device to the parent SYSC
> > > driver, using its regmap to toggle the SYS_PWRRDY_N register bits, and
> > > exposes {usb,dsi,csi}-pwrrdy pwrseq targets.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > > --- a/drivers/power/sequencing/Kconfig
> > > +++ b/drivers/power/sequencing/Kconfig
> > > @@ -27,6 +27,15 @@ config POWER_SEQUENCING_QCOM_WCN
> > >           this driver is needed for correct power control or else we'd risk not
> > >           respecting the required delays between enabling Bluetooth and WLAN.
> > >
> > > +config POWER_SEQUENCING_RENESAS_PWRRDY
> > > +       tristate "Renesas Power Ready sequencing driver"
> > > +       depends on SYSC_RZ || COMPILE_TEST
> > > +       select AUXILIARY_BUS
> >
> > Could this cause circular dependency problems with ...
>
> You mean this to be fixed as??
>
> depends on SYSC_RZ || (COMPILE_TEST && AUXILIARY_BUS)
>
> So that there won't be any build issue with COMPILE_TEST for
> Auxiliary bus API's

Sorry for being unclear: probably the three exisiting "depends on
AUXILIARY_BUS" should be changed to "select AUXILIARY_BUS".

> > > +       help
> > > +         Say Y here to enable the power sequencing driver for the Renesas
> > > +         Power Ready signals. This driver handles the power ready signals
> > > +         required to power on the various IP's on RZ/G3L platform.
> > > +
> > >  config POWER_SEQUENCING_TH1520_GPU
> > >         tristate "T-HEAD TH1520 GPU power sequencing driver"
> > >         depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
> >
> > ... e.g. this, due to a mix of (a lot of) selects and (only three) depends?
>
> I believe this should give build error if COMPILE_TEST enabled for this driver
> Without AUXILIARY_BUS enabled??

Possibly, as the auxiliary bus doesn't seem to define dummies in case
AUXILIARY_BUS is not enabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
