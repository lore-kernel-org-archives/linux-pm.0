Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953299;
	b=2W++yHftDpcSyxGp6h1MN3biTesse3JWyJAM1AdHRhTg53xpgUT7y0qq3BaVZ0D5/ZrF
	 NzhautJfUFi3ZPHHGbIqIlwug8ZM69WQaDK2pdsfxwqWMkaDUQDePcl4FlYoky/YkvXz7
	 JjOhGYRyDSlhGTY0qvXfA2PVf2PPW2wSlT3y5Zf0d8DyooKsa//u+hJl1gPZ7cOLDRH9y
	 R/HKIsyC5F58oQeE3vYglzkqd8+xT2SJ6BPGY6bgDUf2JTDLT82/ZRVtV+Ve9zKVJ93sB
	 zRrjN/QKPT2eqLPbb6cXEi6C6kjMv82ZuSXJDjo6EyYgShGjPzqJcraBoP8cOVR7SsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953299;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=B5U6R28eASu1V9FcblqPPOgTL19VFOQ1nMFsFJSdCXU=;
	b=VbnMzNwbslUEW7mK2r/g10+wivCTdJe58HAdfk5xzNCqnoAjzq3A2OBsZYRaMA91KoaF
	 atWeAYKqsjFsuEujyR/eyzwj/b+zjwme3kJnA81/Ux3NWG4eT+El7ESCbyQgGRQ/+qN7R
	 a29vTwee+qN2/sP9fNjhIdjLtgzdfLCg6HlF2BbC1TwSdDeWCo0Mij/FVZkSclCkFSWA/
	 zgNYuk9kWEm82FUHtR1AO9MExJv4cyubVwyOAZ5W8Fv32u7FYcKNfcN6Zks657fgi3TIT
	 RgvsaoBb0RvpaG8JuRVk9BHRXYoVeEnxRKxntpnM9thxzOaWuj4udnU5lkaNp+5nr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B4606A328
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 201B4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so281617137.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 00:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953298; x=1794558098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B5U6R28eASu1V9FcblqPPOgTL19VFOQ1nMFsFJSdCXU=;
        b=ui4r6nhehiKRBVlnE484fBFkOb/OnrgdXsOEnhN+qBs8mHoNuAjYJjUWz0iK4jTG1G
         ipiJ91zRIkmIOp74Q4Sq/E1ATyH6EHCtjADMWGKqiKZFDuordEGyZNGmsL7yHhTsYRhQ
         7XUicbx2wY+rDQ+e3fOIxU/R7BCVay/VeO5tpIkGNyHeCksJF7Eska85rryty0GuBQY2
         bHSdM3ZnrJVRusb68O4WZWXs+PLki6pNkXcJGX3uO3nq/Y9WYTeYEU7SIz+1O//1AitS
         P4sd1e75hGCxU7YH+mfVYhm3dSshVQgEZ77+r18SEiIlekNL293m1XCXx6167N3I1/Qx
         L6CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt2PmstqWM3KSV8hMFOzRMBAxOR8AcNPDH5N5XJ+2E5PhOzBkEilgw2lqg2L9dtNI/aKTEsQkSzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9g4xwSHEKYpr1CmIaMH7+PDzZpeTtVmqLb+69jxlpv/tipvoOB
	gSCpewTyqc4OkixM1EJHKRtNPVG40ELWvtjUmb2T4cAGuZoLuefcD0lUdAq1KsGpVV8=
X-Gm-Gg: AYBFou2+jMuh2m8dNW18z9f+chGk0MVB6su8oFNLm+5vC3JA+1BFb3L3bmjvq9oqw05
	C5movEjoyiAwHXMbWmrsruEuIlMvpLn7NuhclCgwVZHD2RmuLdtZXLAvOlet30C6sH/uvbSbqeM
	lCva1/JmwbEPUm751oP7+yWwfd76OozfHhiSILMXewfu+jTtJ9HNVf6GaNSFV6WPuPibbKvOkGq
	Er8QVW5ncyWpu+B5gHRLofmRdEYFeJK8x/PD8SuWdNraIJkvswRjav1IMdttoizCGDgpE8Rc/5X
	ca3iVF3Of9FCxkwa3wlTkapgmzNP1WCZNoUdP4329KOsEzIv6wIXY0yOZVCcuH59jnTDGnJr1We
	c8qZ7a3Ubl7Zi4QmWZdePA+LS3Lg5mALKGj8InqJaa4MXjyxTWdxS4QjcCLC0Lx+ffy5ywV81Pb
	CNX4SztDasTmoe+DfMzbCRCObpnOYuOZtDXrIl4pDZHEf2L/+Au9+O0hYnoxhUV0DuoJ9mA1EhY
	lrpXXZrm+wEnekx5UyYhWMBg4G7NxMcGcClqCEtOErmfnU30zNV5ygsRV4DEDFK0fYjlr6WZBlG
	8HyF217p5Vv5EZ3lhoPFaJplCsyG2vv11fKHXaqxyyd79F3gCpZOdJhdUKFz6hsCJQ==
X-Received: by 2002:a05:6102:5121:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7d2a15f9d96mr1290107137.23.1793953298091;
        Fri, 06 Nov 2026 00:21:38 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a89abee6sm792721137.6.2026.11.06.00.21.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:21:37 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso258516137.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 00:21:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzNDPjArlTj+/1cUAHUXqibih2gnZ1MCespYkoYVcTIDtjNQx+WjQ9E7h8I407xwNxonB2DqQkOWw==@vger.kernel.org
X-Received: by 2002:a05:6102:4188:b0:7c1:7ca9:94bf with SMTP id
 ada2fe7eead31-7d2a157ad1bmr1177241137.19.1793953296374; Fri, 06 Nov 2026
 00:21:36 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793278754.git.geert+renesas@glider.be> <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
 <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Nov 2026 09:21:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
X-Gm-Features: AclHuK-V7fgcHmuwvDEyfPRfTLsQvNGxgbL-okuZ_HotpWdWbAS1JxTmpUbfEsQ
Message-ID: <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
Subject: Re: [PATCH 3/9] can: rcar_canfd: Make clkp local
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 6 Nov 2026 at 09:17, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Sent: 29 October 2026 13:11
> > Subject: [PATCH 3/9] can: rcar_canfd: Make clkp local
> >
> > The peripheral clock is only used in rcar_canfd_probe(), so convert clkp to a local variable.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -467,7 +467,6 @@ struct rcar_canfd_global {
> >       void __iomem *base;             /* Register base address */
> >       struct rcar_canfd_f_c __iomem *fcbase;
> >       struct platform_device *pdev;   /* Respective platform device */
> > -     struct clk *clkp;               /* Peripheral clock */
>
> Unless I am missing something, I get build error
>
> drivers/net/can/rcar/rcar_canfd.c: In function 'rcar_canfd_probe':
> drivers/net/can/rcar/rcar_canfd.c:2250:55: error: 'struct rcar_canfd_global' has no member named 'clkp'
>  2250 |                         fcan_freq = clk_get_rate(gpriv->clkp);

If your tree has Claudiu's "[PATCH v4 3/7] can: rcar_canfd: Allow the
CAN FD clock to be sourced from fck", you have to update the new user
of gpriv->clkp.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
