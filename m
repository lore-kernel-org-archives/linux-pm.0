Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428273;
	b=4LIqHMUIZigZbuca9shd75n+MOB4zjWHtFUfzdPhfgL/2nGZIerLYDm1PW2/NZZk5Y2z
	 agU0rOVRF2Xfv/bSdkf+hfJJTo0KeJs95qTgf5nJ0ra5CB6JXdwRK/a4dMZowSkj46yrx
	 pnmIUh6CLDiaEE0cg3GpFpyiZ9NUzNEbUlqG043rd4pa7oUhQ3DJFgM0Oud3samVGlRQ/
	 iwcacBCmo7mgdUfHYL7OhIHWabwMBtLsBGAcVOmJu/4Hx4PJoZRYL0FIygPzwsDar6Ry0
	 FZCU/N4fpMWoqZ3v2BVr+jOJIxOlu/eP/too49TxZqLQdHr+sm2THSBEEgNRCfZtpUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428273;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=PmiGcIdjfKIGHCu1gzOSxutdw7IHUOocB921VJoVgxA=;
	b=VU74X+yWP3YLPlJoTnV10vYG/mlm73JfJG/ITNNgjcp2aCLv8YSEyONLFVqFbSULHBK7
	 9EhENLCZE9O2umgf5mYqAlt9amoLgUrsoOXF8hpq3y6lDWFqMCYxeb/nXPQiOt1RkqM8n
	 +lFb4Z3kJk+Le7FFdeHI4UCHWAPfb3kN48hxPzQ22NiWcnjVTDcZitdbCH2OCA1MKpI9A
	 w4RBlMWeQg2+UqqOvb1BSt2IRfJD7q41UIdCRsd+M/lIF2oNfwiJAIMkho5JzcoaBZn2T
	 UUCHNQ+CZDExMqSxFZwCQWuZexBpRaDThbc5hxp8q1pacgwJYHRBNdq3qKvHkldLFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D9606A32E
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F9D9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3204927a12.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428272; x=1793033072;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PmiGcIdjfKIGHCu1gzOSxutdw7IHUOocB921VJoVgxA=;
        b=TNENpKn/44D2EAD+uEojpqDlNc73opSkDw4TAKd4cZoK5SWKIFwh3QMGmV7iUwgO2Z
         WG1RtuDjnI75GHEQQbWX6lrdQGQcUv0zZHfZctUX3OQt8j9clGk9VY2v4vcKUJdkrJKd
         8rm8pvpoRrj8wPvX7RL4J+JnueyJf1EsMe3otw/h5R4V0wN14UTMqCYw7Jkwxmbq2gf7
         pHZMsi4HyrpO3sZ2ADETn0pY4nl6TDtRmy2YPc5jOQfjRUnHpqXITu1IVILy4gmhJ/BQ
         dsC3Kz/aDAQlOuhE2DVkbJyVTfhmRAOmNiPLPwV69yyplggBrTlpMtrGeJuiX2s8tvaO
         AbRA==
X-Forwarded-Encrypted: i=1; AKwUvByTk0mTLEx3N90H/aZg37D6hE+DXEX4MD74/cL63x346T5RoNToad0A+eNID2xVZF3ogsp5SbsQfQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJKQF4JfspjEkeI/uPcdTQjH8ezNE9EJaScmieK0Qd+zQI61f5f
	86qjgIuYWxCDNdGHiY6U/E/c7O8zThxDDu6yXszXcUfaGLkitBpCafzk/z9S3CG9zJw=
X-Gm-Gg: AYBFou2mcM9Lj/RnCrhLt7/QwyZ1NUrmsLTYKBnBypqys6OSXvzDU2vz7gTorVCNzFe
	dubcXVbDrQ+hza5LUFnQxvZay2KIzXrT8RpwFKds52SjMHP2TikZ23LBtPR8DEBKHBqDxTt65av
	TtCDaDpUyz9LW1YldaFgeizSciR9niUZ2CRYJslKQg0Fe00pkDOsga7NtC5HRMTbh67JzICpnX4
	YeOMNk7knZxvPPJh/JJYXt9TYMuCz1Xbju1impxghDfSMA5hYtyhzVV8C3WXluTcA0qDtV+nrxG
	l4iTK4w59bivwmao4lxGzffupHipzrwD8Ko0MMNr7zPthntiCRVqKKfR8vFWNP8NabvMGTK5q4U
	AuUcs5jjXi8hxBavbiCAZ4TZaBmFgjdi/fb2lNiC/x04bDlVicQbBVqR+Y64y7CacYJbFjInCaa
	HZiA6zyHRX0IjmnuSV9oC/WAtyhifj9dCHPPGIUFEisfw47uspXz77wt4/sTKQK97y6d8aDRj6+
	ZPcBmLJPsSKc7I8yd3JNnC/cUWI7dgaJWRj
X-Received: by 2002:a17:907:6d28:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c419fefecc2mr607001966b.36.1792428271757;
        Mon, 19 Oct 2026 09:44:31 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm376554766b.33.2026.10.19.09.44.31
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:44:31 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so183055666b.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 09:44:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxh6sETWAMczNMrWES6dF7JjF/45pXFgJwBOQ+6UwtTREVzDOyIw4jc/1YQ07MoE216JpCPEE1T6Q==@vger.kernel.org
X-Received: by 2002:a17:907:9605:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c419f31c8bamr564444366b.27.1792427870527; Mon, 19 Oct 2026
 09:37:50 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
 <20261019144256.GC763679@killaraus.ideasonboard.com> <CAMuHMdWkAvkxHkzRVviF_NkZHP7UeCBjebxciE6jFN_8ViM=aQ@mail.gmail.com>
 <20261019152203.GA5830@killaraus.ideasonboard.com> <20261019161436.GD3705@killaraus.ideasonboard.com>
In-Reply-To: <20261019161436.GD3705@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 18:37:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRvguzV+3CpOfkR+b-a0p5TrmUUF1fV0kdafXuNLV1oA@mail.gmail.com>
X-Gm-Features: AclHuK-8scCJz9rF32kL_0712rSWvXw0tvi_Wr1HURn1pKiiIZROkb3-2ONTagY
Message-ID: <CAMuHMdVRvguzV+3CpOfkR+b-a0p5TrmUUF1fV0kdafXuNLV1oA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 19 Oct 2026 at 18:14, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Oct 19, 2026 at 06:22:04PM +0300, Laurent Pinchart wrote:
> > On Mon, Oct 19, 2026 at 04:56:28PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 19 Oct 2026 at 16:42, Laurent Pinchart wrote:
> > > > On Fri, Oct 16, 2026 at 05:55:40PM +0200, Geert Uytterhoeven wrote:
> > > > > Prepare for mapping to other than fixed-rate clocks by adding a clk_hw
> > > > > pointer to the clk_map structure, and populating it up-front.
> > > > >
> > > > > Move r8a78000_cpg_priv.fixed_hws into fill_clk_map(), as it is no longer
> > > > > needed afterwards, and drop NUM_FIXED_CLKS.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > > --- a/drivers/clk/renesas/r8a78000-cpg.c
> > > > > +++ b/drivers/clk/renesas/r8a78000-cpg.c
> > > > > @@ -16,19 +16,24 @@
> > > > >
> > > > >  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
> > > > >
> > > > > +struct clk_map_in {
> > > >
> > > > The "_in" suffix isn't very explicit.
> > >
> > > I can add a comment...
> >
> > How about calling it clk_id_map ?
> >
> > > > > +     int dt_id;              /* DT binding clock ID or -1 sentinel */
> > > > > +     u32 fw_id;              /* FIXED_CLK() ID */
> > > > > +};
> > > > > +
> > > > >  struct clk_map {
> > > > >       int dt_id;              /* DT binding clock ID or -1 sentinel */
> > > > >       u32 fw_id;              /* FIXED_CLK() ID */
> > >
> > > BTW, do you think it would be worthwhile to reuse clk_map_in here?
> >
> > Possibly. I was about to recommend just using a single structure and
> > leaving the clk_hw pointer NULL and unused in .rodata, but the memory
> > waste isn't very nice, especially if we end up with many entries :-(
>
> Actually, you could even turns clk_map into
>
> struct clk_map {
>         const struct clk_id_map *map;
>         struct clk_hw *hw;
> };
>
> It should consume the same amount of space on 64-bit platforms. Doing
> the same in the MDLC driver would save space.
>
> Or, if you want to save more memory, you could drop clk_map and store
> the clk_hw in a separate array in r8a78000_cpg_priv, using the same
> indices as clk_map_id.
>
> struct r8a78000_cpg_priv {
>         struct device *dev;
>
>         const struct clk_id_map *map;
>         unsigned int num_map_entries;
>         struct clk_hw **clks;
>
>         struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
> };
>
> where clks is a dynamically-allocated array fo struct clk_hw pointers,
> having the same size as the map array.

IIRC, I considered that option, but rejected it, as I still hoped to
put the (at that time multiple, per version) tables in __initconst,
so they had to be allocated and copied anyway...

> Too many options.

Hehe...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
