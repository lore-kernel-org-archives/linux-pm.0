Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AA311C35
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139471; cv=none; b=FmSR37oIFBnCTialv02b0TUG/YkVvqAKH3rMYsncFQJsqUUxld7+EZYV9au35bVZ4Gzb65YIAXdEBmzIDIQDDGPEkEzoraZOH/mm77Wxodgh6irsbq5MWEoxua5O1ltD+fb2AxbFsBKcb+GfUFybvrb0tBVEDFhk3vABbi/TePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139471; c=relaxed/simple;
	bh=BCBnzIbovSj6nZkSdLu43I/N8uho8yIG58ObXHwQhSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X79OVvKJmkc00Dh6EskQMGitod/1VWHXT/Y8uaehbRSFHW7ZaKQXi9IIAMKQrnVQ5fmIqh/bhmuvy2qEuAhxFWzdnTnPt3quohejFXPmimFT/rtk7zbqpFdjVeA8+OMpSaYhvdOBCxCOduB5usEdJISKgza7TPGUvdtcxuI6tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-610e2e8f57dso174989137.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 00:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778139468; x=1778744268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egy2nC9k2RFpcPzSIv9jZ/VwU1PCVKckuVqW7m7bXrc=;
        b=iEcAgHHOWsFF/eED9EuupaFERrcrGuKufpU6ycfH9Xc7I7qR8ELCXZOW6BNct5GFbq
         RsNKZpdPTTHtMHY7bpiOCXWU5p4PnMc9eSZdxn8o3RU8jYjEmUEXFYZUjsbO9uacs61s
         ED5W1TgtVsoWNITLZOTzv1W6Ic34/HboFx1Go54qMZOdkzUHc/Bf/UHPjGENwmJl38bn
         994Yd74fmvfbLQFKTTXsQ5m/9NW+s59aK55rWTGHKxjdF7DyGy/uGECRV+m4B/BNXXKP
         D/9L3CA0fHsKPW34WyxcSgV3TLxIP/leiibafaGzU0Ob1b9288h9Rl2ezY3t0Rc2jdlm
         UPYg==
X-Forwarded-Encrypted: i=1; AFNElJ879VaqIHAKIcQzi2r3XbZRFMV+r4NIVl5Q3PnzON+4NjA3ZaimSQB4qOJqzlf6vXgVpX5PWuT3uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2pflDF4x9gJ4XhScBRgZXGMa+kNseiLolzI9pELGbrTKwyfU
	/q9EBQNs4Aq+DBYs5m83RzXEwy5VcVl9Ha0hkmA6c34aYoqx1bXNNjQDUFMx6vZT4kw=
X-Gm-Gg: AeBDiessVkRyarDQi0/XXSEgg9j3sZF2FFMgvYS4Ghy0KdOG/zY2wrnvzxU+t8v9/ih
	OUkc2yK78As4CssVRwmvGmhyYroKt1U4gx1hiTe9dvKPDfG8sKmXPPyaj9VLWTTRTnuGnFVwwGB
	SYWjKmn5IdWwJopYSky94IgyqTO4PNi/rlECwmq0WUJRwyD+XNIOn4vccZcsmqsle6Zr8S9xUm2
	rcf33lsL+BiiPNU9liclF4vDh9asw0DL1g0tYSp1P0GZ79i9MVg6fWpas2AYfhuqbS1Lp7SitQN
	GcJHhnyVsFXa5tTkGIrVdthVicGtVfSrlUCvVLDDQSYXOwoLRLk/JXdbF6NxK0pCKGwwIxCJ8uQ
	xln1XK/uuiRe8qr96/ArGQ9sKUeA1AXTuylr0/wL7yS92jVwJpm7E2B+CpYZByn+1c17OUq9QUU
	kSgCghc/kioxp1ajnbooa5WeNYxM+Y9OfPgAimBWsBP93ajVVlAS2k1XqkHYcXtzltbCyxErE=
X-Received: by 2002:a67:e102:0:b0:5f5:40ab:2d65 with SMTP id ada2fe7eead31-630f902387amr3251389137.22.1778139468205;
        Thu, 07 May 2026 00:37:48 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-630f858f550sm2966000137.3.2026.05.07.00.37.47
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:37:47 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-63124ac76f5so36243137.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 00:37:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+gG5RfHivLqd5LM77iBCIWjIMXadQNabQ82sA57VYAnV+VF2Z5W3WkIOHbjvGqnWfQ9da8jzj/Wg==@vger.kernel.org
X-Received: by 2002:a05:6102:38d3:b0:5f5:4055:4556 with SMTP id
 ada2fe7eead31-630f8e752e6mr3312584137.4.1778139466906; Thu, 07 May 2026
 00:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <053c312d07445517d8f9c84bfe3cc8fb72d4cd9a.1776793163.git.geert+renesas@glider.be>
 <bf83a028-3ef3-482a-9ce3-8aec16f6ebed@mailbox.org>
In-Reply-To: <bf83a028-3ef3-482a-9ce3-8aec16f6ebed@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 May 2026 09:37:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN2zaZrY2jKKXpNqrP8xSqc-uJTr-siTBgaA=-EY_4BQ@mail.gmail.com>
X-Gm-Features: AVHnY4KGlUYo0uuTDH3tynnil_8H5d8OEIYrlJIco2kr0W3O9LQYd8HP5vniIEg
Message-ID: <CAMuHMdWN2zaZrY2jKKXpNqrP8xSqc-uJTr-siTBgaA=-EY_4BQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 10/14] dt-bindings: power: Document Renesas R-Car X5H
 Module Controller
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Thu, 7 May 2026 at 00:58, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 4/21/26 8:11 PM, Geert Uytterhoeven wrote:
> > +  '#power-domain-cells':
> > +    description: |
> > +      - The first power domain specifier cell must be either the Module
> > +        Power Domain Gating (MPDG) register index (0x00-0x3f) from the
> > +        datasheet,
>
> I agree with this part.
>
> > or a Power Domain number, as defined in
> > +        <dt-bindings/power/renesas,r8a78000-mdlc.h>,
>
> I do not understand this part, please see end of this email ...
>
> > +      - The second power domain specifier cell must be the module number
> > +        (0x00-0xff), composed of the Module System Reset (MSRES) register index
> > +        in the high nibble, and the Module Reset Destination bitfield index in
> > +        the low nibble.
> > +    const: 2
>
> I am unsure about this part.
>
> There are multiple MDLC blocks, AON, SCP, HSCN, and so on. Each MDLC
> block contains multiple Module Power Domain Gating registers (MPDGn) and
> multiple Module System RESet register (MSRES) .
>
> I do understand and agree that the first power-domains-cells cell must
> be the identifier of power domain within the MDLC block.
>
> However, I do not understand the second cell. The MDLC bindings already
> contain reset-cells, which should be used to refer to a reset within the
> MDLC block. Resets within the MDLC block are operated using the MSRES
> registers. Why are resets conflated into power-domain-cells ?

The Module Reset Destination bitfields in the MSRES registers are
2-bit wide, and control both Reset and Module Standby.  Hence the
same register bitfields are referred to in the power-domains and
resets properties, through the module number.

Module Standby controls the clock(s) going into the module,
and is modelled as an SCMI clock (SCP_CLOCK_ID_MDLC_*) by the SCP
firmware. This is very similar to how MSTP (Module Stop) clocks are
handled on earlier R-Car SoCs (except that the SCP_CLOCK_ID_MDLC_*
clocks have a zero rate :-(.

Summarized, the first cell is the power domain part, and the second
cell is the clock domain part.

So perhaps I will clarify like this:

      - The first power domain specifier cell is the power domain part, and
        must be either the Module Power Domain Gating (MPDG) register index
        (0x00-0x3f) from the datasheet, or a Power Domain number, as defined in
        <dt-bindings/power/renesas,r8a78000-mdlc.h>,
      - The second power domain specifier cell is the clock domain part, and
        must be the module number (0x00-0xff), composed of the Module System
        Reset (MSRES) register index in the high nibble, and the Module Reset
        Destination bitfield index in the low nibble.

> > +  '#reset-cells':
> > +    description:
> > +      The single reset specifier cell must be the module number (0x00-0xff).
> > +    const: 1
>
> [...]
>
> > +#ifndef __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
> > +#define __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
> > +
> > +/* R-Car X5H MDLC Power Domains */
> > +
> > +#define R8A78000_MDLC_PD_AON                 0x40
> > +#define R8A78000_MDLC_PD_SCP                 0x41
> > +#define R8A78000_MDLC_PD_APL                 0x42
> > +#define R8A78000_MDLC_PD_CMN                 0x43
> > +#define R8A78000_MDLC_PD_ACL                 0x44
> ... what do these numbers represent ? Shouldn't those be register
> offsets from MDLC MPDG00 according to power-domain-cells ?

These are Power Domains that are not backed by any of the 64 Module
Power Domain Gating (MPDG) registers in MDLC blocks.
It is not clear to me if they can be controlled manually, probably
they are just always sequenced automatically on power-up.  As the
documentation does treat them as separate domains (see e.g. Table 14.1
Power Supply Voltage Monitor Functions), I figured they would better be
exposed as separate domains, instead of as a single always-on domain,
like on earlier R-Car SoCs (cfr. R8A779*_PD_ALWAYS_ON domains number
32 or 64).

See also the X5H_Power_domain_structure.xlsx attachment in the R-Car
X5H documentation.

> If those are power domain IDs, then I am unsure why e.g. for SCIF the
> domain ID is R8A78000_MDLC_PD_APL in [PATCH/RFC 13/14] arm64: dts:
> renesas: r8a78000: Add CPG/MDLC nodes . Could you please expand on that ?

See the "Module Standby" attachment X5H_MS.xlsx in the R-Car X5H
documentation. The "PERW" tab shows that all PERW devices are located
in the PD_APL power domain, which is always-on.
This is different from e.g. the UFS controllers: they are located in
their own PD_UFS0 and PD_UFS1 power domains, which are controlled
through the Module Power Domain Gating registers (MPDGn) (cfr. the
"PERE" tab).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
