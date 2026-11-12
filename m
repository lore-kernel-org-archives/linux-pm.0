Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496161;
	b=jr2TuiW00E5A15Wje5oIyauiGnV53KgGVrljFMh3aKSfKE3Nov5p4PscO/A71kDuteRi
	 9DuhXA5qQ29+2dvVpwElFc2mbngVOmAFaeLFB51qq9Ylk63sj2Vfe33hu/JsuV128+HbV
	 SkdNS9IJyzxiWadpXIiLDUjeCeLzGvLMuBK6UzgJqpimI22GD6MsXC2vAnU4mfEvPt8Vy
	 rtm+H2wzWjzb11bg1oGXbRH8NIKdeMfTfpa4lBG4IYhPm7PHGzFpa/dqVRrD+2o6NsRnO
	 G+j0sytJILJBoJRNRJscuZxGxxWwnnU05AH3k4EuyAt/vKOz/e4vCOrFtfSlv1IDqCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496161;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=f2HclZgC7BHSQ1+tdHxuenXtHwqaRuALZpayUv998n0=;
	b=eBS9+Au4sqMYRvyYhPPl8Ux+kURjpgmJxWpCPn3nY7qlnfbTdYe67uk/CjXBdnSJqy9v
	 Jp84nXGUPivOSJAYmjVtoGYaidWFCN1p12TsZSYoabU6R+LWNMcvxkYysRaaAn0B2vbUy
	 qJnKK2+ldC9yua8xL2yERGwReVJAI8uTVg9bli7XrMs9tJZAaMclCIeI7LUMfcE3gztAz
	 ETAFU6qR1YFx3drEO6uoHx/wbphKINTimQQ+fzO7/mJJNFNz6FobGBqUI7hVkzIij9deL
	 sIYZrCB50C0MdLk3g52TVrUOB98k84YEnJtQPsROf+a3d0Qjrt7nvHZvkVMPdl+8ugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DD606A32E
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 15:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9DD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so1736307e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496160; x=1795100960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f2HclZgC7BHSQ1+tdHxuenXtHwqaRuALZpayUv998n0=;
        b=DWvIP0KQDJ923leEUA++tib9vontkmgYb9KfThoZnhBhA42xpJbGaE/RIuUat4T/s3
         Vyb4Qsk5yqoM/8Ba7F79RyuvqAGoRXsU58QjukfrHmxGaCL0CRIA3+RByFtWInXrITLa
         1INlpMYDB7Qy7upFPzgnruUQDJ2Vni7p/axxufVKi4sGznfP9EUB0f98c54ghOh6swxz
         tTgaanLiLwNr26a3ahcszBDYlOPElX6xp6/+T3L75QCSBep/v3hNqgjGbmfCbGLvuf7A
         lJISPT+AN44Jo3StGJJAi5qGhTtmtwJzUP5b5dju+k/P+B696uDfStqR38Xs5dzsdqwi
         t7vg==
X-Forwarded-Encrypted: i=1; AL+hErFkaIn0tvloy9euP9+ISAdUekuSIVbvTO+RfHcnSiz2yt2pwTqV1hz7gfIjPtTBLAou2TOQ7M2Q5w==@vger.kernel.org
X-Gm-Message-State: APuU4Z98DY4EyVrJ/Vpcin1Yfy7ZaoBhgnLgE57Fsl0xA+FhYfLE26df
	jrZoryTykfKrrns8hGbn0R5qA18cgF86Ru8m4AVoHrRifIC77N4cOKbAuq7YKvFsLJ4=
X-Gm-Gg: AYBFou29+SwfFEtqGBoyZRzr059Z8n+BCi96m9F5kpRo0yA/h7daOSsvx9rz6kQMhBT
	otZ1NpsNDLHezBOQO0gXID0i1tUvz/Oo8DCjPeE52fxLG+reLPFPjaGREk4mdOqIZX2+/ThV78n
	UF6/Ivw3YLXnkOHOWSXJKkcM7D0X3jZydOY2s7k7A2yJrJ6CfSjOOhXC9HXeCOJG5n9Na0TXC82
	c2hXlS2Qb+W8jKjxx+3jDkyHLenODrCwuX/EnAXxwJ5NMu/g7TJtKpyS493SE2ENwCJ8k7b/ihB
	vRhh2LsIXYEuAJfBGQp9O4cFtB/OKh+HROqZYZlGnO4kY67Yr9A9Ur4winHdqdhGm+N9QSrKRZH
	prbUQIraMHIRegCBepcQfRsej6TAsnDvTMZhPVpzBBZi4Ad9/Y0qH8ijYrQ/gozUGZWC/dA2pnk
	uUr8c92fM/9BCf2siNIM8Wh3Is2vGKRPSh3BcMMrkjd2yxJAppk+UHK00a5sZgfSHrjhPiDbuUH
	OGBNQzfoaUoSKHExariJ/Nn1ThUFVf8WshilnPKhELtkXqlI+iCHNHoZGor9wPOifKljM0mQAOl
	firpxXEQfdAkMhuYq0C450OtaEKmwx+ZbDrPsMosEfKOmadWTcfslqADqtOds0y66z0d73E=
X-Received: by 2002:a05:6122:e248:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ee1bf5d992mr2466545e0c.0.1794496159658;
        Thu, 12 Nov 2026 07:09:19 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fec26fcsm5682721241.2.2026.11.12.07.09.18
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:09:18 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ed2f163a2fso1333332e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:09:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG4EheSDhMRe3kghs94X7bX9NTqkQykW6DkzHZ8dhw9SkzfmCRbw+lDCjD9wSD8coJhfBT3jyfLOg==@vger.kernel.org
X-Received: by 2002:a05:6122:54b:b0:5ea:b294:f0ab with SMTP id
 71dfb90a1353d-5ee1c298abdmr2507584e0c.2.1794496158519; Thu, 12 Nov 2026
 07:09:18 -0800 (PST)
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
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-11-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-11-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 16:09:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBEjh6YSazKAyBv8xAq1+oFG-dfEf=O58otP1wB9gRvA@mail.gmail.com>
X-Gm-Features: AclHuK9Zmur2PVIdNvv46swJ-VbufJjxD1dvyJf5R-d3EopJYyWzLSJYUjPuDQE
Message-ID: <CAMuHMdUBEjh6YSazKAyBv8xAq1+oFG-dfEf=O58otP1wB9gRvA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] dt-bindings: Increase Renesas X5H MDLC PD
 specifier bit width
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 9 Nov 2026 at 14:35, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> In the Renesas R-Car X5H, the module controller's power domain specifier
> cell's bit width has been increased. Update the bindings documentation
> to reflect this.
>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> I'm guessing that the maximum number is now 512 but I can't find
> definite proof of this.

As the Module System Reset Registers are at offset 0x900 + l * 4,
and the Module System Reset Status Registers at offset 0x960 + l * 4,
there is room for 24 registers holding bitfields for 16 modules each,
thus maximum 384 modules.

> --- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> @@ -12,7 +12,8 @@ maintainers:
>  description:
>    Each instance of the R-Car X5H Module Controller (MODULE CONTROL) provides
>    Power Gating for up to 64 Power Domains, and Module Standby and Reset for up
> -  to 256 modules in the Power Domain of each Module hierarchy.
> +  to 256 modules in the Power Domain of each Module hierarchy. Recent hardware
> +  versions have increased the number of supported modules.

Just change 256 to 384?

>
>  properties:
>    compatible:
> @@ -32,14 +33,14 @@ properties:
>          are always on, and for which there are no MPDG bits to control them.
>
>        - The second power domain specifier cell is the module standby part, and
> -        must be the module number (0x00-0xff), composed of the Module System
> +        must be the module number (0x00-0x1ff), composed of the Module System

0x17f

>          Reset (MSRES) register index in the high nibble, and the Module Reset
>          Destination bitfield index in the low nibble.
>      const: 2
>
>    '#reset-cells':
>      description:
> -      The single reset specifier cell must be the module number (0x00-0xff),
> +      The single reset specifier cell must be the module number (0x00-0x1ff),

0x17f

>        and thus identical to the second power domain specifier cell.
>      const: 1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
