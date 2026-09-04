Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B24C9010
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533990; cv=none; b=jOxI1KLcj40olgJ4YHiqZzE179dq6kB67UcFVo1+5GSCjqUl5CbD40JP6wJl5O0lfQ4aRIWAwRQvniK+IMU1c4q75QgizlGlTM8wcdbiO0haMmW6lxemKwsRA9MGOWPafzirZi+gfY3vX2LibA1H5q45G1i3EIjNrqiEcECjC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533990; c=relaxed/simple;
	bh=ghXH2BJF4jduj/BjXt7Xua8zEA4xRov01HKEMrdgGlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0POmwy+D0c6hW0FKz5EqNStKzQP801AbzuIoEFVU6HnXYtrP6a3dcwHb1GnIV6Xz9+9WNEBezEGzWlKfpwa3JsBALmE35yw5vlgS/GGzvkNk7qQZOv82D2/mgYRdwKYjrFmCEkLpFMqhbggi50ez9OKeUOnSgGkKvtOrphpO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-783906bdb20so381355137.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533988; x=1789138788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=inqGTZSC3u1CgB7ts6dRXUQ1Jo9pob/IqZxPyHHBxZ8=;
        b=pmCcE9SkUSPSSLcc9ymceEgydM3U0ODPY+rgfaUJdwr1v9AG4GsGEcN4wFyrNhasoA
         86Kgg9YC1QEx9eTLR+P1T6J7/XrEUvDJVBeEJnTnSgERZZ9qQ6482PH3xsyT7sU2L+yA
         aHmnqYskrCg7YcgXBSJuu/DxQLHSyWVx+yetZK4mevw3ujsfVnML0gY+H0GYzFPvb5cq
         PwPtgYFslSvS/pTeiGDwc5s5ytTdV1U6uAqXWG/Z9+5Rkup8czowxpF0lEq4KrmcxiVN
         XQUGWCUgGwrsavRMkrLYs3fVEPGXkO61XdEjcGn77f0SjD3WhjXmzaMos4VGD0P9bV/6
         GpcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvGes00L+EXJrhwREN6FFkMew78WxmHZjkmsYRH+n0VQf3gFOd0FAnqPMhz2eQq2B/I+KvRxK12A==@vger.kernel.org
X-Gm-Message-State: AFuF++kWmdz4vfN0taG72k7YFVVgfbZtql89oKY+prvawdmmrl5h2K9F
	4OK9XaHa9NrSL7tkcybzG203ovNe2AGZvhbkzyT7eXDiM68rmnMAe7DaKJ5fWJg5
X-Gm-Gg: AYBFou06KM+eAkypkcctIxVOSTZFqP14mBeI+FTVkNhOeO70HhOQxSTRSpzEiq/XA/w
	OlPhfzxsFg6f4E0e6347EjxvIW3lui8OEr6ZZq35FKK0B6G6cWXBywHELNm8eGAHyCUYZhcutvi
	ijr4M1/3gsWP56mgC7Qj/7iTnTGS/zzJ5kyhZWF3wb8CGG88w50Q561cs3c8gTflDZ24HcSAxDC
	3wvMzHOxVKtsMHAwTsTBCp9YDJTBqwBGz/CY+1dcrxuTJxPHX95hUlZn31lJ8mXOMqZG16o9h/e
	G7DJ16a8NuzAPEsi51I3Ct6MMnuR0PxsLGa+pJgNLCPx6bR+fMWfsTlRwMauTbnmsvqKy10PhX+
	L9M+5GVadYN069bOeq6rRJyskgMo1SulquWEuYQB2mdcYKsiGa6Qi6xo/+TUBxClFwTJ5Y8ypYJ
	b5mRFJAPABsoUmokTKWX1AS/FowbXMQEFswAH3q1XNePhnaaFWkoclm29NMMz7FUyrI5RY0Spon
	JYBBLhqFWfjGBUgpzrFeNAAvMsF/hnZt7qa
X-Received: by 2002:a05:6102:1606:b0:778:9e3c:5760 with SMTP id ada2fe7eead31-78a4a9621d7mr1903142137.11.1788533983070;
        Fri, 04 Sep 2026 07:59:43 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a47ae8dd2sm1994654137.8.2026.09.04.07.59.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:59:41 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97cc20c05d3so354007241.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:59:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxiWdaruF5NBIaarr71Ivq7nbxhDPohvW4dmcc7VFIQSeRC6G8zW33DbpPXOCt1QKCh4Z7UqdQrbg==@vger.kernel.org
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id
 ada2fe7eead31-78a4a7186d7mr1918546137.7.1788533980738; Fri, 04 Sep 2026
 07:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
 <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com> <b2f486b8-a391-41bc-8a7f-dc81c6752205@kernel.org>
 <TYCPR01MB11865BD2FC199EFC6BE613A5DA2A82@TYCPR01MB11865.jpnprd01.prod.outlook.com>
 <a7cc6bf8-706a-4b51-a0ce-d6246045d5da@kernel.org>
In-Reply-To: <a7cc6bf8-706a-4b51-a0ce-d6246045d5da@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 16:59:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuhpaEjzoLowag=RUMah-LjtSkmkDSJu_ZaYYHAHHcSg@mail.gmail.com>
X-Gm-Features: AcwNN1XOIqok-XF1Ox7YMle_czDmXRTGGzFdPMRVImnv13pc2p3_Z9A1m7XbeZw
Message-ID: <CAMuHMdWuhpaEjzoLowag=RUMah-LjtSkmkDSJu_ZaYYHAHHcSg@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain definitions
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>, "magnus.damm" <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 1 Sept 2026 at 16:15, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 01/09/2026 16:11, Ayman Chaudhry wrote:
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> On 21/08/2026 17:03, Ayman Chaudhry wrote:
> >>> This patch adds power domain indices for the Renesas RZ/G2M v3.0
> >>> (a.k.a. R8A774A3) SoC.
> >>>
> >>> Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>

> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/power/r8a774a3-sysc.h
> >>> @@ -0,0 +1,30 @@
> >>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>> +/*
> >>> + * Copyright (C) 2026 Renesas Electronics Corp.
> >>> + */
> >>> +#ifndef __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
> >>> +#define __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
> >>> +
> >>> +/*
> >>> + * These power domain indices match the numbers of the interrupt bits
> >>> + * representing the power areas in the various Interrupt Registers
> >>> + * (e.g. SYSCISR, Interrupt Status Register) */
> >>> +
> >>> +#define R8A774A3_PD_CA57_CPU0               0
> >>> +#define R8A774A3_PD_CA57_CPU1               1
> >>> +#define R8A774A3_PD_CA53_CPU0               5
> >>
> >> No, value is 2. Or not a binding.
> >
> > The values are pulled directly from the R8A774A3 hardware manual and
> > as a result are not sequential.
>
> So not really a binding.
>
> > This is compliant with header files for similar devices, so if we were to change
> > the approach now it would probably make things more confusing for the
>
> No, it is not compliant. Maybe it is done the same way as old devices,
> but feedback was provided already for a few years, so plenty of time to
> accept it.
>
> > user and it would also require some special handling. Given that this is
> > compliant with the style for similar devices adopting the same bindings,
>
> It is not compliant.
>
> > it's easy to understand as the numbers come straight from the HW manual,
> > I would actually prefer if we could stick with this numbering scheme if
> > possible.
>
> Nope, as explained many times already for obvious reasons. Otherwise
> provide me clear pieces of code which you bind here (as in DT bindings
> header purpose).

I agree all numbers < 32 match a documented hardware bit, so technically
we could use the numbers directly in DTS.
Note that unlike e.g. interrupt numbers, the power domain numbers
appear multiple times in DTS, and are also present in driver code
(drivers/pmdomain/renesas/r8a774a3-sysc.c).  So having defines means
having less magical numbers in driver code.

BTW, due to similar pushbacks against offseted interrupt definitions,
we are now ending up with duplicated defines in .dtsi and .dtso files:

    arch/arm64/boot/dts/renesas/r9a09g077.dtsi:#define RZT2H_IRQ8   24
    arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.dtso:#define
RZT2H_IRQ8  24

So please let us have our symbolic definitions ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
