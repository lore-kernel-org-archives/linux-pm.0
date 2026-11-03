Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695752;
	b=Mv4VqGpEyaWv9bO7qR9mQPjHlZ1T1LyT3cPepST4epi9B9L8OZNUs3rNZr7kW7lVmzbV
	 uGrZAdgguOPUH5QqX4z1tOZRJ0QJOAiTpug8uuSU54eGiVEr9/pADRlTsi5zWnTPPE4nQ
	 Jt+n5/Vk82o2bikOR5Ka92vCDgCtUgdHhXbGGH8JbNEAfTrPIp8rJPlIYH0hxg682zr2o
	 3tmeA5V1oSUF7lvGUSCZLEmTI2N031oMDvLISh/tN0H3ZgCf+K259DH1rmu3IWHUl34u6
	 9UeMRIIkQT7eF6nnjs5rNcsPLnoSPCF5LTj0aBhBJCldNByyZl4U81b4pYISRYqNIQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695752;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=dlJ5xMksR4WOvEPc9s2K/nzvHc7oGxq9usmZlWMYcc8=;
	b=0GvuF7ld+oRwVaWMrmFtGZFDTdcCQt5A+dO7HFC0d5TES8Rrd+nnR/nxRg7MzFNr2zyJ
	 tZUv1Vjfqq6YXfuqbzqvQVz05R44A/yDxOwy1725QCPh2vW6JWvce9q3P7Ugi+vNHArtx
	 R1JNHGbGk3C0CM/53vndKusojjkRPB+Q8CVWn5oTgbedNdJRDGN8kOBQc0OGdmQUGrCjn
	 GbLUDOfr7/LBJlzlYENvYBtVL0zr4u9b9dq+PCetx5t4rsaZPK0dAXARaWRSuQVA/InV+
	 +8JCKORLL+bKDdXKSeT6ApVfK8ZVh58cXJ9H5YQeGi2Ty9XKTJvy2QhwGOXs3vhZ+oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D4606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 08:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5D4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so1200942137.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 00:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695751; x=1794300551;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dlJ5xMksR4WOvEPc9s2K/nzvHc7oGxq9usmZlWMYcc8=;
        b=ghVBUhqySrSTJGKfgOXGGZZJDcsVNB/pxVtD9TIXVaXvLbM6S9NUuNjGgloN2CTinw
         4GyOnoML6wHTynwWtI+9smMTJhcU6cvAb9/248q/meJuEp/CWCwxH36oo25AnKbPuXAD
         Ci7dIis00W2XegEl+/6fPFASFq/YfK+VH0LLWtOCcDcazuyhuX6SBwBNWfpIpoNbjQhb
         XAMeEQNuvMNWGbZTX7oWZ9UEeaXprNLcXpdiTK5YjJs8jej7HM+vZagfZq0T3wvpNJLp
         uYXIqJOKLYN1dP5KKtbRrn24maA5dDEJCCORMAaRxzup6A4wJzmBDBB/eLnnAzbhyKTV
         YXvg==
X-Forwarded-Encrypted: i=1; AKwUvBxVsEVFB8kq+CxtjXwGOfFxFLU45el+nhQLUJqni4Al7pNckU5fnvsfAqjNEmFqAxWZeK1qmoYHMA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/BZUa1O8T3eNxQ9tWoDbhRZ0H/7Cf6Mxw/2r+xTxK3BN7BThf5
	S7nM2ZCNvb8wlMsIrSgt/TW7oRxIS+zbtqDjt1deHwUNT4cB280stbSGSG4TvCMJksU=
X-Gm-Gg: AYBFou01+e61R+7TpUpuRkyUKl0OHPDnUMOI8DUovJJzw/H2Ua9aShvjDGwW5/LdVQm
	tR1XZa3c/1qw1Co3ohuSG7dFJXyVCoJo39qFqZ+RDHM8h6APV9VBAt91zjF8dpwIKBplRPdPt+i
	eeR7pkN4dHszU9c7ItCnWUe9myFwfXnHqrZ9DaT6OU8vTpS3X0Kdsc07iilWZDdGLYNq1WyptbL
	rj6eHm8sWY0opYZ0kbP1Nl9iQOCNZlvKdERIORg9nnwIMQZIw2E2qC+pcUMhcmRcN74hzDnYpat
	O5s8j/5xtZwn8b3lPHDdXH7GJx/326gJ9bQdtOxRg+qjOjlE+H6Ata/0GRqObhPIl84958k2rlf
	LiIFqmIy1mPuQsJYftehyYwl9LqCwQ5Jdt6VF/tYUhVOKD8KNa7QTGQrQLJWdzPQA/p2DLj4rUI
	CrOhIvdt1Dsi75zJoATZUnH3VR6Sos5ncfLNQ3rXaLtmBa1CFo9cpUfF203wpYiZEfmOgsCH7WT
	z115ZkVQclsfAvO66q3hEsz2KHOSj3ZdRqifFzhcwh5jt6Mi9MjQEggGDgFrz5aQStw8PVsZsUF
	1mPA5+qtwro7MnGSJ1NPV9+Vvx2zauFJnFFeTc5p0qsmH3kSa4W3jdQPSfliZDsKRg==
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7d072bb35d2mr4228142137.7.1793695750687;
        Tue, 03 Nov 2026 00:49:10 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07768d366sm11972430137.10.2026.11.03.00.49.09
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:49:09 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc603a168fso1250241137.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 00:49:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByhurOHRiPSmQSFKml5mMO9vE/lUQ1RzNm5okQrIyXQcZpS+zRbclC5j76hHkoLnCtABchjAoFNZQ==@vger.kernel.org
X-Received: by 2002:a05:6102:370d:b0:7c8:18a2:f769 with SMTP id
 ada2fe7eead31-7d0723dd1abmr4090280137.0.1793695749441; Tue, 03 Nov 2026
 00:49:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793026273.git.geert+renesas@glider.be> <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com> <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
 <20261028163940.GA2673734@killaraus.ideasonboard.com> <CAMuHMdVOT+DTZum525kmYfP+jzzPrxMnEeRAkapxOMGz4XMHBA@mail.gmail.com>
 <20261030112314.GD2587681@killaraus.ideasonboard.com> <CAMuHMdXR=dcooQoKwrycDpTaZjFk2CCueL08dYYFJLE9bP90cg@mail.gmail.com>
 <20261102160945.GH3368923@killaraus.ideasonboard.com> <CAMuHMdVHFquHz+OzpHirWENEEQeZbiXx=8eeRDKssvw++jGOUw@mail.gmail.com>
 <20261102230610.GC3548113@killaraus.ideasonboard.com>
In-Reply-To: <20261102230610.GC3548113@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Nov 2026 09:48:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_7c8b+oj0Xb4rHWA4v8FzBG98pRrCcON-uufKUtzUMQ@mail.gmail.com>
X-Gm-Features: AclHuK_e7CeN9r2CWRxTZ3YftMZc8LrnmvjcdiFK90YF4Wz4SjpA3pg2WAZWNlI
Message-ID: <CAMuHMdU_7c8b+oj0Xb4rHWA4v8FzBG98pRrCcON-uufKUtzUMQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Tue, 3 Nov 2026 at 00:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Nov 02, 2026 at 05:59:02PM +0100, Geert Uytterhoeven wrote:
> > On Mon, 2 Nov 2026 at 17:09, Laurent Pinchart wrote:
> > > On Fri, Oct 30, 2026 at 02:51:54PM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, 30 Oct 2026 at 12:23, Laurent Pinchart wrote:
> > > > > On Thu, Oct 29, 2026 at 10:08:28AM +0100, Geert Uytterhoeven wrote:
> > > > > > On Wed, 28 Oct 2026 at 17:39, Laurent Pinchart wrote:
> > > > > > > On Wed, Oct 28, 2026 at 03:43:42PM +0100, Geert Uytterhoeven wrote:
> > > > > > > > On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart wrote:
> > > > > > > > > On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > > > > > > > > > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> > > > > > > > > >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> > > > > > > > > >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > > > > > > > > > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > > >
> > > > > > > > > > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > > > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > > > > > > > > > @@ -28,5 +28,8 @@
> > > > > > > > > >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> > > > > > > > > >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> > > > > > > > > >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > > > > > > > > > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > > > > > > > > > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
> > > > > > > > >
> > > > > > > > > Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> > > > > > > > > R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> > > > > > > > > dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> > > > > > > > > R8A78000_CPG_SGD16_PERW_BUS, as well as
> > > > > > > > > R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.
> > > > > > > >
> > > > > > > > I could add them, but do you have any need to refer to them from DT?
> > > > > > > > So far I only added clocks that are listed as clock supplies of on-SoC
> > > > > > > > modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
> > > > > > > > Timer Unit (TMU)).
> > > > > > >
> > > > > > > So we have two conflicting goals here. One of them is to only add clocks
> > > > > > > that we have validated to exist (and ideally work as documented). The
> > > > > > > other is to keep renesas,r8a78000-cpg.h readable. We won't be able to
> > > > > > > satisfy them both fully.
> > > > > > >
> > > > > > > I think we previously discussed adding whole groups of dividers in one
> > > > > > > go, as some sort of middle-ground approach. Those are clocks that are
> > > > > >
> > > > > > That is what did in this and the previous patch: we need
> > > > > >   - R8A78000_CPG_SGASYNCDn_PERW_MAIN for n=16, and added the one for
> > > > > >     n=8, too.
> > > > >
> > > > > That's missing n=4 and n=32. While SGASYNCD32 isn't referenced in the
> > > > > datasheet, SGASYNCD4 is (in SCIF and HSCIF). Maybe that's just an
> > > > > oversight ?
> > > >
> > > > We already have the clocks for (H)SCIF (_BUS, not _MAIN!):
> > > >
> > > >     #define R8A78000_CPG_SGASYNCD4_PERW_BUS         0
> > > >     #define R8A78000_CPG_SGASYNCD8_PERW_BUS         1
> > >
> > > Wait... Aren't R8A78000_CPG_SGASYNCD8_PERW_MAIN and
> > > R8A78000_CPG_SGASYNCD8_PERW_BUS the same clock, just with a different
> > > name ? The user manual says _BUS, the clock diagram in the spreadsheet
> > > says _MAIN. The SCP firmware defines both, with the same parent (PLL5)
> > > and the same frequency. I have a feeling it may "just" be discrepancy
> > > between the user manual and the spreadsheets.
> > >
> > > *sigh*
> >
> > After my previous comment about "87 SGD4_* clocks" (quoted at the end),
> > I started wondering if they are really identical and ungateable.
> > The documentation calls each clock list a "clock hierarchy"
> > (e.g. the PERW hierarchy), and each sublist another "clock hiearchy"
> > (e.g. PERW_BUS vs. PERW_MAIN) which sounds like they are different.
>
> I only see PERW_MAIN, not PERW_BUS. There's a PERW_MAIN_MP sub-hierarchy
> though. And I'm fairly sure there are errors in the diagrams (at least
> in the VIO hierarchy).

The clock diagram indeed doesn't have PERW_BUS clocks, while the clock
list does have both, and the main document refers to them as clock
supplies for e.g. (H)SCIF and I2C.  Sole exception is LBCK_PERW_MAIN,
which is in the diagram, but not in the list; the latter has
LBCK_PERW_BUS.

Note that S0ASYNCD8_PERW_{BUS,MAIN} is even listed twice, with different
divider chains, but still resulting in the same final rate.

For e.g. VIO, _MAIN in the clock diagram and _BUS in the clock list
indeed seem to be synonyms.

> > I also wouldn't be surprised if each (sub)hierarchy is gateable, too.
> > So unless we can get clear confirmation, I'd rather be safe than sorry.
>
> I haven't found any sign neither in the documentation nor in the SCP
> firmware sources that those would be gateable. If they are, they are not
> gated by default.
>
> In any case, I think it would make sense to model in DT all the clocks
> listed in the diagrams. That should make it possible to properly handle
> gates after the fact, should there be any.

In DT, we only model supplies and consumers, so only tail clocks from
the diagrams (i.e. what's in the lists)?

> > > > > - Some modules may need to know the rate of the functional clock gated
> > > > >   by the MDLC. As those clocks are controlled through power domains,
> > > > >   they are only specified as the last cell of the power-domains
> > > > >   property, and are not listed in the clocks property. How do you
> > > > >   envision this to work ?
> > > >
> > > > The functional clock (or its parent) is still listed in the clocks
> > > > property.  Compare e.g. the hscif0 nodes on R-Car V4H:
> > > >
> > > >     clocks = <&cpg CPG_MOD 514>,
> > > >              <&cpg CPG_CORE R8A779G0_CLK_SASYNCPERD1>,
> > > >              <&scif_clk>;
> > > >     clock-names = "fck", "brg_int", "scif_clk";
> > > >     power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> > > >     resets = <&cpg 514>;
> > > >
> > > > and R-Car X5H:
> > > >
> > > >     clocks = <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> > > >              <&cpg R8A78000_CPG_SGASYNCD4_PERW_BUS>,
> > > >              <&scif_clk>;
> > > >     clock-names = "fck", "brg_int", "scif_clk";
> > > >     power-domains = <&mdlc_perw R8A78000_MDLC_PD_APL 0x54>;
> > > >     resets = <&mdlc_perw 0x54>;
> > > >
> > > > On R-Car V4H, MSTP514 aka "hscif0" is modelled as a gateable MSTP
> > > > clock with parent R8A779G0_CLK_SASYNCPERD1, and used as "fck".
> > > > On R-Car X5H, R8A78000_CPG_SGASYNCD4_PERW_BUS is used as "fck" directly.
> > > > Calling clk_get_rate() on MSTP514 and R8A78000_CPG_SGASYNCD4_PERW_BUS
> > > > gives similar results.
> > >
> > > On Gen5 we will then end up enabling the clock twice, once through the
> > > power domain, and once through the explicit clk_enable(fck) in the
> > > driver. I suppose that's fine in theory (there's an extra runtime cost
> >
> > It depends, and can only be true for drivers that still do explicit
> > clock management.
>
> Yes, I forgot to mention that.
>
> > Many drivers that don't need to know anything
> > (e.g. the rate) about the clock have been modified to delegate this
> > fully to Runtime PM.
> >
> > On R-Car Gen5, the (now purely internal) module clock used for module
> > standby is different from the "fck" clock in DT.  So perw 0x54 is
> > controlled through Runtime PM, and SGASYNCD4_PERW_BUS is
> > controlled by the SCIF driver directly (but it is a no-op as the bus clock is
> > always-on).
>
> I expect the FCK input of the IP core to be connected to the clock gated

At least the FCK input.

> by the MDLC. Using SGASYNCD4_PERW_BUS in DT is likely inaccurate. It
> should work fine for now as the SCP firmware doesn't make the clock
> controllable, but I'm not sure that the bus clock is really always on.
> The dividers listed in the CPGMA* diagrams typically have clock gating
> capability.

E.g. DIV6 dividers (like the MSIOF parent) do have clock gating.

> > On previous R-Car generations, "fck" is the module clock, and is
> > enabled twice.
> >
> > > though) as clocks are reference-counted. However, the current SCP
> > > firmware reference-counts the clocks based on their SCMI ID, and the
> > > MDLC clock (perw 0x54) and its parent (R8A78000_CPG_SGASYNCD4_PERW_BUS)
> > > have different IDs. This can cause the clock to be disabled at an
> > > unexpected point. In this specific case, however, given that
> > > R8A78000_CPG_SGASYNCD4_PERW_BUS isn't controllable, it won't cause an
> > > issue, but in the generic case it can fail badly.
> >
> > Current SCP firmware indeed doesn't handle parent-child relations:
> > e.g. perw 0x54 has a clock rate of zero, and is not a child of
> > SGASYNCD4_PERW_BUS.  So the MDLC remapping driver ended up becoming
> > responsible for controlling the parent clock if it is gateable, which
> > is the case for e.g. MSIOF (see mod_map_in.fw_fck_parent).
>
> It's worse than that. The firmware doesn't implement parent-child
> relationships, but sometimes it tries to control the parent
> independently from different children :-(

Bad...

> Look for instance at the DPCKCR register. bit CKSTP is documented as
> gating the DP_EXT_VIO_DP[012] clocks. I expect that bit to actually gate
> the parent clock, DP_EXT_VIO (from CPGMA1). However, the three separate

Agreed.

So DP_EXT_VIO_DP[012] are/can be modeled as the same clock?

> DP_EXT_VIO_DP[012] clocks exposed by the SCMI firmware (and named
> SCP_CLOCK_ID_CLK_DP_EXT_OTHER[012] because consistent names wouldn't be
> confusing enough) all map to the DPCKCR.CKSTP bit in the backend, and
> are reference-counted separately.

That is really bad.

Are the DP_EXT_VIO_DP[012] clocks functional clock parents?
If yes, the MDLC remapping driver can work around this by always
controlling all three together when module standby is controlled.
If no, the CPG remapping driver probably has to return a new clock
type that controls all three together.

> > > > > So we could add e.g. SGASYNCD32 already, as long as we don't reference
> > > > > it in DT without testing.
> > > >
> > > > We could, but which one: "_PERW_BUS" or "_PERW_MAIN"? Or both?
> > >
> > > See above :-)
> > >
> > > > And what's the point if there are no users?
> > >
> > > Future-proofing, to avoid adding the SGASYNCD32 clock later with a
> > > non-consecutive ID.
> >
> > Then perhaps we should add all clocks from the spreadsheet upfront?
>
> It's tempting. Maybe doing it per-hierarchy ? When enabling devices in
> the VIO hierachy, I ended up verifying most of the clocks anyway. We can
> then try to spot all inconsistencies and ask for confirmation.

It is indeed tempting, and would match what we did for previous
R-Car SoCs.  Having unused definitions is not that bad, it might just
increase a linear table used in an xlate function (which we currently
don't have in the CPG driver).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
