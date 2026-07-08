Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0040928B
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527163; cv=none; b=tG/urA15nePY5V5WZ/B3sJnjf3v6r08YSfyxyy/16f0xEfY9PxexA76mbmJ609DqJ1WOdVAHCn+lJNd93nhftOlJxAPim4y3szXveFwubjw/wUafDT6+B3BVXsEbZ4hHvcDy0I6amfxruoA3LtP/NEw2tRF886y2PMSD357brf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527163; c=relaxed/simple;
	bh=y8j2/FQNeXE1C/2iMG1jjFg6VhJGfmA3AX/0fZrBhX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6/W54Ubxx4+a144RPXISP7YJz5IesWkji8QNoGLDBizKK3cZ9+92kzbAyd+yFOaKhpeENb8MHbNP28IukLsJZXPUYhJG85j76tWZS5naALb9gaXFJ62LN2ak7dda6UV0QWAy/+IINLQ980hR8kqfGCzEel36yNjQ+GHuE2k1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so84067266b.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 09:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527160; x=1784131960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hO17YRpuaXnOXgeP7ftbHwpUP+dSdnes8jnl1DmJr/I=;
        b=Fw0Nu8iZu7VHchet7/xbpqESWunQ0TzWqybBzjtPiPmsVebi3Y2lmrLLqlo2xH91Gf
         PL7k6e9kX4LBp0OduLoCiHI23mthubZscq+LM9Ux++fQL7qowairo/fL1ypoOO11gAia
         oxlclRnBs+y/QxTMQyOCCcKW+4prOUNM3yBJV4Dq18+0tLDdrLQjbN/cM/eAuht+S5Z5
         hGb6ScREoQoVfJjsmtkEZM78AvUXllHdo9qH1pu7jLjnadBdghM86E5b5EPePcv5U46R
         LWRZMX1f6WEKnmkBqgvU7MURi4ZSVcM/ff4/9DCISPHUCZsgx4Jqp0K9g01yq/Egru1t
         kkVA==
X-Forwarded-Encrypted: i=1; AHgh+RpOBSkJ6LCMbpO/0s79P3qyLiyJExn7UvCAKRbIT8grNGCNtTutYLoI5iV3a0t7+gh1qte7FtTxVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPlzdSJvi3HG7x13UiirUg3Dwli6AdOq8tLoGUCmnfcRN3GpT
	ddEflTgbU1NaElMHM4m0Dp0q+ijyLrascfeMSoWnohu0Lf/yKSihz0e715uU9VCUHtA=
X-Gm-Gg: AfdE7cmdosXLlDzZteXoUI4cv6oy5dCpakcS2T5C7s289qcT/AdaE719j5b7WIN+SzQ
	oZUTm6NVyMkf6GZC6sD/9qpQfAA5ALEGNv2AyFjihxV5DQxP863ck0X5E5j1V5IDlGRkjHnt3Uo
	Gmx9pZFXA+i30rv+DKGYBAWj4QEOKo2cEH9Wc15b0KlEHcngGZSmhKBVQsb2yngYr9cPTLVBfQo
	D8bPv1RvkxU0CJ/GSVdgEOUPi+8MiD/LRp8X2wBXkzEmiXb7KI3540q5LdMv0g6XDP5G8dhHyjX
	ZDQ5LkeCp1V4vVTTBHirF+BnrX76nBPSzhXywzHETYaJSVzxVaULjL8VsGNYTqyCunpNKat5nAn
	qX5osWuBO/xLGcUZUEH0tJVaLccrq1/gQg3Ieg0Xavui1Q1yP+fLBhqR8kP9PKiCof3pxEAxBTY
	ixPqicGYikzqHWwHEM8fABrFtKZJEowERVgqG3cnUr42U1+XJgPA==
X-Received: by 2002:a17:907:c789:b0:c12:33a2:a634 with SMTP id a640c23a62f3a-c15ce0d63e1mr141000966b.52.1783527159824;
        Wed, 08 Jul 2026 09:12:39 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3e54e83sm122304466b.42.2026.07.08.09.12.39
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 09:12:39 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so1513596a12.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 09:12:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrinLLtwfO1FelmiEbRqfWjj+jCLi3eL+Wv+BVxn2UgRVPgxztCFgvjko7GYvhgo8Phdkgv0uJ48g==@vger.kernel.org
X-Received: by 2002:a05:6402:1475:b0:698:1973:1da9 with SMTP id
 4fb4d7f45d1cf-69ab44a2082mr1330602a12.19.1783526681164; Wed, 08 Jul 2026
 09:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783505329.git.geert+renesas@glider.be> <3c76a2d4-a8b8-493a-9196-c5cc72958118@mailbox.org>
In-Reply-To: <3c76a2d4-a8b8-493a-9196-c5cc72958118@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jul 2026 18:04:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVUKYrrms0Vd4i3_nwq2LVjvnvFRWswi8UY3cA67u2-w@mail.gmail.com>
X-Gm-Features: AVVi8CdIlIxklIbGHNZaygjBAfJd_Dhsc8WBwlY036WlOLVf0uDAr_hqlDulMbU
Message-ID: <CAMuHMdUVUKYrrms0Vd4i3_nwq2LVjvnvFRWswi8UY3cA67u2-w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 8 Jul 2026 at 17:42, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/8/26 12:16 PM, Geert Uytterhoeven wrote:
> > Geert Uytterhoeven (10):
> >    firmware: arm_scmi: Add scmi_get_base_info()
> >    of: property: fw_devlink: Add support for firmware
> >    pmdomain: Make genpd_get_from_provider() public
> >    reset: Add reset_controller_get_provider()
> >    dt-bindings: clock: renesas,r8a78000-cpg: Add firmware property
> >    dt-bindings: power: renesas,r8a78000-mdlc: Add firmware property
> >    clk: renesas: r8a78000: Add SCMI remapping support
> >    pmdomain: renesas: r8a78000: Add SCMI remapping support
> >    arm64: dts: renesas: ironhide: Enable SCMI devpd, sys, clock, and
> >      reset
> >    arm64: dts: renesas: ironhide: Add CPG/MDLC firmware properties
>
> I think 10/10 did not make it either to my inbox or lore.k.o , but the
> remaining 9 patches look good. Thank you !

Thanks, I did something silly while sending.
Lore now has it, b4 still seems to miss it, unless I specify the
Message-ID of 10/10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
