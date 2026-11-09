Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233933;
	b=Sa97vq0w1VUxoVd/kLL3ul2Z/iIvUVX8T+4ZUAWLKuRVM+6Rdf9Rzl0ElrG3wxkDk0tG
	 KIQJayO2z0cHfPrUficD5dCw+AwI6ZloL35y4+nlYpBS2LuK6VzbN4O5Mm0epFDlruK2Y
	 sB35rWcp/046PGk0/Kh2N9HSuTsbXb/SoRucxRCTOU6065iHoYVSZVOG3+PlhjJ8E97Js
	 R0TOymWjZ4rWA3ZQkuziQysH904/uAFZZuKpmSc5QxUvh+wW+O/Hs0w4qDIMlpfpn/vb/
	 /eyBauegO1vfyyoK2TpHJR8ePBD2Pd3KnJ6vwDdf+jtgr5kCebRhObbM4PVmOXmiAxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233933;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Tz1cDpa5AepSCwsliEOBWV2ZbIXpdMUmAVTrHLbgBBk=;
	b=GgTp8VimG0m6ub/OPAh+b1R3NlsxYK96Dh6MzWO5EUQnv3rZwV0pOgPrTt08G4MBF7E1
	 8koIhiDvAqLBSk0amufTsyE+5eL/va4pL375zUjd26dair9/yBGvwbac2vbV2vQFIcSmp
	 395CX7OC4JET3fIao2+0ow/6QzkB6buiUaDeQ24jDzaxG5wPRotkRMMEF1TZcmfVU4UK9
	 /UUBaUrj8vz/GVA/k+a115QwSFML04jjI9eIVeUitEj+tmFZp4W4QavcFSHwENnc4IIKa
	 8+OcpYxgV5kUBqnYqbqVwWuC2D1tuIgMJ4gpdoz3zVTbYnYqd6pMU+dFvsxZXTUdpTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D67606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 14:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14f7768acso643273e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233931; x=1794838731;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tz1cDpa5AepSCwsliEOBWV2ZbIXpdMUmAVTrHLbgBBk=;
        b=PPY8/bGeqGudIXagPy7KdrwxdoMfCCMETHzhdESVJ3QG/Yo1jaikspPXJ32T7MBCn2
         BhYS/ed3T2mlZ5wRiWDik+U+YOfZmDDUO6mExiho6hwdI3pz2IUHmRLN07j6dlNq8vmB
         qHSXH1V0uvNgm069tlyZ7PIxgmhdmjYq6wntJR0lOX8NIJN+ZliApUVkJaM+/lHT8o3q
         TobsPWbtyY+YLoTIB86m3BfrkKxIuIdlwJZcm0nWPpY4NJHO6+x9b34T2Pk9g/ohsv5I
         Mx1UReNQoJOGyQLnQsAgDzoUv0ntT2+xiez9SnRtGv37nySqcqDlOW8LBUgy5j0tkkLD
         s/Fg==
X-Forwarded-Encrypted: i=1; AL+hErGwijkOvm7C3oCo72zXS8X5AWH9M6gCAz5ij7y+3c07d4PbT7N/5iMmrHk8PT7JVlJ1zSnF1D+ctQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/i36UHBzXpp9QL83DVrZeNAuJ+rSX9OAc6xeOboNxgey91QY+K
	Fw29oHgPJfLrUbJBPZwl2j9+g1rth2G4ACKs/Hbq3J3PE9me16xXNvpZ2QXLw8ay0vc=
X-Gm-Gg: AYBFou3B7U7Z3dkyhAt3ssnRHd3X0c9uB3rjJBrXknBzvpccxJ4qYAySeonENRFQgTv
	2ezAfq4qUi5PIliomrIlX5qsChuMEyZKVWZ93N12mFCFDo/XY9IEMq76lFm/wgYmP5wpUr7bGyA
	CNIhRwjh92Equ8jrr5mbl3hBFUdjI3Ijvy49dR5Zx1wkxA23KxEROcJVnvd2UFHfpz9gWQumF8m
	7McJ3FwofzIS6q44HnufvpKF7++dWERFzV0yQIxe+iQ5YxODjfj+NG6runLh2K9Xeie5Gtygu3b
	TSTjMb3fpfAcd/SdPt3PFwIiG/nQsbl76bQTtXlt7N7zGc/EtRRylxZSebBRPExoeIu750NOgXE
	tmsPiCHU2mx2NrDsEbUg4MxNwxoGNUXidCWURD+5gSOUKF+ykxRYNWyP8DHlepN6ErTwog7VpwT
	4lOLTLcRa7EiMph7qVFTLjZ0kTMO1loyWlJUd955vluSS55iNRbqfa/+6opSJf7esssGdsyaKVI
	vlbXp+KXDcZ+bDfkfnDQ9/5nN3f7NKRr2XJRsfRK3ww/nweHBqrwER8049/2eUbZysbSXjqGvUn
	ZwKIAjWFl6t79F7b5/cgZcE19cpWUynUNZ5TsdMIPkdiod/WTztYwjXsEOUCE6frIT/ysVs=
X-Received: by 2002:a05:6512:3b81:b0:5bf:dc20:c3e3 with SMTP id 2adb3069b0e04-5c14c015228mr1177242e87.30.1794233931256;
        Mon, 09 Nov 2026 06:18:51 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b8070cfsm925279e87.39.2026.11.09.06.18.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:18:50 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab27b4924aso7234481fa.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 06:18:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH1eD39Gt8RP/xvPQHZx1TMWSxeMbOgSn+VOy9KSLYmJSOc+SoAMmcz0X+NbMg0asVmLt38teb84A==@vger.kernel.org
X-Received: by 2002:a05:6402:51d0:b0:6af:9a96:5324 with SMTP id
 4fb4d7f45d1cf-6b722473406mr2715103a12.33.1794233454340; Mon, 09 Nov 2026
 06:10:54 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-13-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-13-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Nov 2026 15:10:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVh2RiRhBHmuYupK5H81njgaqNCuFWVUiHjTN17+8a+dQ@mail.gmail.com>
X-Gm-Features: AclHuK_UOMGJNMSt7XpVPImhuSlb374iqFlByrKa5-w4LBZZoP4MvZOgp7Ag9nE
Message-ID: <CAMuHMdVh2RiRhBHmuYupK5H81njgaqNCuFWVUiHjTN17+8a+dQ@mail.gmail.com>
Subject: Re: [PATCH DNI v4 13/13] media: rcar-fcp: Check device revision at
 probe time
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 9 Nov 2026 at 14:36, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Verify that the device revision register reports a valid value,
> otherwise reject the device.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

Thanks for the update!

> ---
> Changes since v2:

You missed the changes since v3...

> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c
> @@ -14,28 +14,80 @@

>
> -#define RCAR_FCP_REG_RST               0x0010
> -#define RCAR_FCP_REG_RST_SOFTRST       BIT(0)
> -#define RCAR_FCP_REG_STA               0x0018
> -#define RCAR_FCP_REG_STA_ACT           BIT(0)
> +#define RCAR_FCP_REG_VCR                       0x0000
> +#define RCAR_FCP_REG_VCR_CATEGORY              (1 << 8)
> +#define RCAR_FCP_REG_VCR_REVISION_H3_ES1       (1 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_M3W          (2 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_V3M          (3 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_H3           (4 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_D3           (5 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_M3N          (6 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_V3H          (7 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_E3           (8 << 0)

For R-Car V3U, the revision number is 9 (according to the documentation,
I haven't boot-verified this), which is missing.

> +#define RCAR_FCP_REG_VCR_REVISION_V4H          (10 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_V4M          (11 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_X5H_V1       (12 << 0)

"git grep -l renesas,fcp -- arch/arm64/boot/dts/renesas/*dtsi"
shows a few more SoCs having FCP blocks.

Interestingly, the documentation for all of the recent RZ parts (G2UL,
G2L, V2L, G3L, G3E, V2N, V2H, T2H, N2H) claims they use 9, just like
R-Car V3U.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
