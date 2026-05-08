Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AD377558
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229211; cv=none; b=UHSiCwWJAXmX/dy3f9yRemYPVAjpwb+eiOq2+QxY7jaJ93cxsBlFvoQTNoR+4zaCHN36D13Gy71QVawGKLg6xl2bDq+q8qeIR/DnLqkxtaoVVoXh+o5A55ikDQSKGfzQEmrKGArCaRZs7xAbOJr63l0ZZWjyLr7C3kG9oPio2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229211; c=relaxed/simple;
	bh=OF+KbbPBry4fiTqCO/A0vEBAM9IFzJmbWYXTqxwsniM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVzqD7y+AMY+yE3XbzTTAKMca3ShRrkIo/vfithvTtCweXL/cpMNo/s1fbV/KHPcnvrX8LvgpwmkgTk7sfZvyTLr9hzZkajk7Qa0f6OhfnAMiJm3lNMEgGXxtVKYZzWU+gNlI2X/Z9q7w2jM2S3yvfuWx9OU6d67TQKnuDDK/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de431da8fbso1397393a34.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229209; x=1778834009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUNwtFp7LXv7nOLjMf/BlzJYT09wzG6WamyTo0Ov/no=;
        b=Aj9Eb8/f8qiDuhrsjTqcRnk3nlysKu2wMVhecGJ1uFu2Z5pBU720n55ZSOa9QflJGJ
         Rtws8u4LKrHiOYn80TnaTasXUIMdne5O1Xzcgi3z8QuT03u2x2p/oc/hnYKKo1mSkpvg
         63faj8eqgHwt1IOhXmW5irX0rAy8cvPNqahaMdqq1OwTTaMxnk7GIBycM/RuCvS0E0Vw
         BASvx2KQXYX5aNtDNXmIn4kjb0/iVMSJyb+FfNw8FBuNIgzgiOL7EdL2p8O6vbFR+jEs
         OFOdYnPIT6phEK0ghmuGO7NNzZsng83/IEpNeIaWi3Otszo+Z8BxDWORB9Vlz5Y1nn7p
         MNuA==
X-Forwarded-Encrypted: i=1; AFNElJ/hy2KAOBtsnxmvx1ApCFxx/xSGJmooGElNdSlaZ+VPo5nMjaAqbpgj2Ie/M3IcJCntPWLvpn++ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTVYWgjzgvj0GiIiEvZ8i850Par0mtoU4DB+WSysFH6A9n4UO
	qRXXYd9HKMdPJwi0/Lq+pnpq9fv1GLBiFOzfItnqBmf098zW/v9IhJHf6iuTnITdEQc=
X-Gm-Gg: AeBDiet0JyEBxvZ4+zHm3w8YJaSGgc6eWo1zYKudkduQurYu5LYVS0LdAfhRkApaHTk
	1TeLd5aUBYUjK51Zd7RZGdB4zYIHZYSLxz/i8f0K+Prk3sFtWuordrEHufmRTJGT3yGiOlwn4bE
	1rHOmsunQ7GnQl0mtdo0XzqJlZJjpKSF8syCIJry7IulXXWjTypz1j9qLbkKLO5/S2NkU+EqYjw
	iMzkiEV25rZWvVZeW2ULo3LFGwPEpRaE6jYJOVxZbllAmuN4BH4gmWFm/xq9layk1FIlAyLaI4K
	0XXM7I9gY5+VsfuKbCDwcMKx8L9unegA/EZm5RlXKBYKPDNVWnZIcJ65T1zF6e3QNa+PJpcVaXW
	TnlmwFIoHC8/+xSR2IKKO7SKVrpr7n2jmmsEzKsgk8O3EsM4EqneCzKusR3hFzmRY/o+Oc3SqJf
	A3vWI7bJCkJQWgMhuMjY8FtxqIsK0phpQcKXkscfGGnVEP8SThdTz5+y46A1RKTV7MjktTOVw=
X-Received: by 2002:a05:6820:16ac:b0:694:9206:5bdf with SMTP id 006d021491bc7-69998cbb26cmr6031558eaf.4.1778229209126;
        Fri, 08 May 2026 01:33:29 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c1ba56sm746376eaf.3.2026.05.08.01.33.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 01:33:28 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-42fdab683b7so942111fac.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 01:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+894gWGcrIp6akCkHPqIaET0Z3F9WP/TTkpwZsOx/FB5lme40oyFnHrj2OLsPX0IEkl0Um2JIy1g==@vger.kernel.org
X-Received: by 2002:a67:e709:0:b0:604:ec90:ba14 with SMTP id
 ada2fe7eead31-630f8ee2fa0mr5929351137.11.1778228781677; Fri, 08 May 2026
 01:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <053c312d07445517d8f9c84bfe3cc8fb72d4cd9a.1776793163.git.geert+renesas@glider.be>
 <bf83a028-3ef3-482a-9ce3-8aec16f6ebed@mailbox.org> <CAMuHMdWN2zaZrY2jKKXpNqrP8xSqc-uJTr-siTBgaA=-EY_4BQ@mail.gmail.com>
 <fa28c6fe-484c-4133-824e-649c52ef2200@mailbox.org>
In-Reply-To: <fa28c6fe-484c-4133-824e-649c52ef2200@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 May 2026 10:26:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUU=RohST4LDDD27W5dj=HwJFApMcDpsXATQ1MaMH-tUA@mail.gmail.com>
X-Gm-Features: AVHnY4JJUxMOqvyoeb-hr7ynluUAgTja2N2yaP-Ep1K9EfNyRckxSh-cxJzmeNw
Message-ID: <CAMuHMdUU=RohST4LDDD27W5dj=HwJFApMcDpsXATQ1MaMH-tUA@mail.gmail.com>
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

On Thu, 7 May 2026 at 23:36, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 5/7/26 9:37 AM, Geert Uytterhoeven wrote:
> > On Thu, 7 May 2026 at 00:58, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >> On 4/21/26 8:11 PM, Geert Uytterhoeven wrote:
> >>> +  '#power-domain-cells':
> >>> +    description: |
> >>> +      - The first power domain specifier cell must be either the Module
> >>> +        Power Domain Gating (MPDG) register index (0x00-0x3f) from the
> >>> +        datasheet,
> >>
> >> I agree with this part.
> >>
> >>> or a Power Domain number, as defined in
> >>> +        <dt-bindings/power/renesas,r8a78000-mdlc.h>,
> >>
> >> I do not understand this part, please see end of this email ...
> >>
> >>> +      - The second power domain specifier cell must be the module number
> >>> +        (0x00-0xff), composed of the Module System Reset (MSRES) register index
> >>> +        in the high nibble, and the Module Reset Destination bitfield index in
> >>> +        the low nibble.
> >>> +    const: 2
> >>
> >> I am unsure about this part.
> >>
> >> There are multiple MDLC blocks, AON, SCP, HSCN, and so on. Each MDLC
> >> block contains multiple Module Power Domain Gating registers (MPDGn) and
> >> multiple Module System RESet register (MSRES) .
> >>
> >> I do understand and agree that the first power-domains-cells cell must
> >> be the identifier of power domain within the MDLC block.
> >>
> >> However, I do not understand the second cell. The MDLC bindings already
> >> contain reset-cells, which should be used to refer to a reset within the
> >> MDLC block. Resets within the MDLC block are operated using the MSRES
> >> registers. Why are resets conflated into power-domain-cells ?
> >
> > The Module Reset Destination bitfields in the MSRES registers are
> > 2-bit wide, and control both Reset and Module Standby.  Hence the
> > same register bitfields are referred to in the power-domains and
> > resets properties, through the module number.
> >
> > Module Standby controls the clock(s) going into the module,
> > and is modelled as an SCMI clock (SCP_CLOCK_ID_MDLC_*) by the SCP
> > firmware. This is very similar to how MSTP (Module Stop) clocks are
> > handled on earlier R-Car SoCs (except that the SCP_CLOCK_ID_MDLC_*
> > clocks have a zero rate :-(.
> >
> > Summarized, the first cell is the power domain part, and the second
> > cell is the clock domain part.
>
> Thank you for the clarification.
>
> Since there are up to 32 MPDG registers, and 256 resets, can we encode
> both into a single cell ?
>
> (mpdg_register_offset << 16) | (reset_bit_offset << 0)

We could.  I did consider it (with a shift of 8 cfr. 256 modules),
but see below...

> I cannot tell whether this is much better, but it at least ties the PD
> components (power domain and clock domain) into a single value, which
> matches reality a bit better. The current split power domain and clock
> domain description in two cells gives me the illusion that it is
> possible to mix and match power domains and clock domains in DT
> description, but in fact the two cells are strongly tied together.

They are only tied together in the sense that a module (hardware block)
is part of a power domain, and has module standby (clock) control.
Some power domains are backed by MDLC hardware registers,
others are not, hence the need for the additional definitions in
<dt-bindings/power/renesas,r8a78000-mdlc.h>.
I am not aware (yet) of modules that are part of a power domain,
but do not have module standby control. If these exist, we
need an additional definition (R8A78000_MDLC_MODULE_NONE?) in
<dt-bindings/power/renesas,r8a78000-mdlc.h>.

Due to this separation, and due to a possible future need for expansion
(R8A78000_MDLC_MODULE_NONE, MDLCs with more than 256 modules, ...),
I went for two cells.

> If we cannot encode the two into a single cell, maybe we can at least
> have some sort of macro for this, e.g. this (0xff as no MPDG register
> bits for this block):
> #define R8A78000_MDLC_PD_HSCIF0 (0xff << 16) ((0x5 << 4) | (0x3 << 0))
>
> What do you think ?

I (and I believe the DT maintainers) are not so fond of defines for
numbers that can be (more or less) just read from the documentation.
(and 0xff should be R8A78000_MDLC_PD_APL?)

> > So perhaps I will clarify like this:
> >
> >        - The first power domain specifier cell is the power domain part, and
> >          must be either the Module Power Domain Gating (MPDG) register index
>
> ... for power domains which are backed by MDPG bits, and which can be
> controlled in that manner ...

OK.

> >          (0x00-0x3f) from the datasheet, or a Power Domain number, as defined in
> >          <dt-bindings/power/renesas,r8a78000-mdlc.h>,
>
> ... for power domains which are always on, and for which there are no
> MPDG bits which can be used to control them ...

OK,

>
> >        - The second power domain specifier cell is the clock domain part, and

Upon second thought: s/clock domain/module standby/

> >          must be the module number (0x00-0xff), composed of the Module System
> >          Reset (MSRES) register index in the high nibble, and the Module Reset
> >          Destination bitfield index in the low nibble.
>
> I can understand this.
>
> >>> +  '#reset-cells':
> >>> +    description:
> >>> +      The single reset specifier cell must be the module number (0x00-0xff).
> >>> +    const: 1
> >>
> >> [...]
> >>
> >>> +#ifndef __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
> >>> +#define __DT_BINDINGS_POWER_RENESAS_R8A78000_MDLC_H__
> >>> +
> >>> +/* R-Car X5H MDLC Power Domains */
> >>> +
> >>> +#define R8A78000_MDLC_PD_AON                 0x40
> >>> +#define R8A78000_MDLC_PD_SCP                 0x41
> >>> +#define R8A78000_MDLC_PD_APL                 0x42
> >>> +#define R8A78000_MDLC_PD_CMN                 0x43
> >>> +#define R8A78000_MDLC_PD_ACL                 0x44
> >> ... what do these numbers represent ? Shouldn't those be register
> >> offsets from MDLC MPDG00 according to power-domain-cells ?
> >
> > These are Power Domains that are not backed by any of the 64 Module
> > Power Domain Gating (MPDG) registers in MDLC blocks.
>
> I suspect that might not be entirely correct for all of them, please
> read on and see CMN below.

Thanks, looks like R8A78000_MDLC_PD_CMN should be dropped.

> Let's take PD_AC00 , AP core 0 , as a domain of interest. My
> understanding is, that the domain structure for PD_AC00 looks as follows:
>
> PD_AON {
>    PD_SCP { };
>    PD_APL {
>      hierarchy is SYSSS
>      always-power-on
>      PD_CMN {
>        hierarchy is CMNN
>        power-gating-bit is MDLC_CMNN 20
>        PD_APU0 {
>          hierarchy is SYSSS
>          power-gating is done by APMU
>          PD_ACL0 {
>            hierarchy is CMNN
>            power-gating-bit is MDLC_CMNN 16
>            PD_AC00 {
>              hierarchy is CMNN
>              power-gating-bit is MDLC_CMNN 0
>            };
>            ...
>          };
>          ...
>        };
>        ...
>      };
>      ...
>      PD_HSCIF0 {
>        hierarchy is PERW
>        power-gating-bit is MDLC_PERW 23
>      };
>    };
>    ...
> };
>
> With this in mind, I think CPU 0 DT node should refer to the PD_AC00
> power domain this way:
>
> cpu@0 {
>    ...
>    power-domains = <&mdlc_cmnn R8A78000_MDLC_PD_AC00>;
>    ...
> };

So we do have a few modules (I found a few more) that are part of
power domains, but do no support module standby.  One more reason to
decouple them in power-domains.

However, CPU cores are controlled through PSCI (the slightly less evil
brother of SCMI? ;-), so
Documentation/devicetree/bindings/arm/psci.yaml applies, too?

>
> The MDLC driver would pass the PD_AC00 domain ID to matching SCMI power
> domain management protocol call, or, for bare-metal MDLC driver, would
> have to internally encode PD hierarchy, walk it, and apply PD operations
> in each step.
>
> I think even for SCIF/HSCIF, the power domain reference should be
> something along the lines of the following description. The MDLC driver
> should internally encode that R8A78000_MLDC_PD_HSCIF0 is a sub-domain of
> R8A78000_MDLC_PD_APL .
>
> serial@c0710000 {
>    ...
>    power-domains = <&mdlc_perw R8A78000_MDLC_PD_HSCIF0>;
>    ...
> };

R8A78000_MLDC_PD_HSCIF0 is a not a full sub-domain, but merely standby
(clock) control inside the PD_APL clock domain?


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
