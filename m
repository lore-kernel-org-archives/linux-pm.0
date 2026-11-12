Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495447;
	b=nnCpe1nWAblrOe+8ATyQHUwI6AFfagfZQnFrVJx1LoeKCDBFQcuev7MEo4awNQ/upJAo
	 lZsibvRveizbgnHR9bwZUaTWbSm5UWHIVmQbt/i2YGhbcS6wUcANjG5DOxG3wQX2TuWqC
	 ncBeFw+lm2x/vXzqZnEr1l8snG0VvKAtgVIhaFL9bsPl9R+tJ8B4ccjIRV8CafSwzmH3B
	 zK+ygFzzSU5mi71/0Yp4yDtDMeS+VrDo2thKMC1RNHBzlAL61c+v+FApG4nEvCeQy7tmU
	 3ituqDltVVVxuPrhKreWyA8Veh2uUd9oFv0R/Yy2YOtDvi3CA3VMrf+WT/6Fv1JJzPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495447;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=mS1ut25pAkhX06KpI5+b6SzLMFwF8RaPMcofkkPb8+I=;
	b=rpAwamOJtuaISr5wc0WKrBRCCuAKE3v7qfKFE+aKtTmheeWAL8rUkJuWhAEycXLdhjxp
	 SEuyi1oo/xN2g8RI8z1/ZXPftAKIaVstuPsbXAWcrpe7z76b/GKGa0HPeiiI4VFKyEqD9
	 q6fV4T1Pb+pwU9qIF4gDIf6zei+q9bMMg23S8oF1X9ituXovI5lPEAbr6xQMTvF+s2dfn
	 eTNucjDPkENzWnMFl3jwNRmsdlY2+53t9iS6nRUS3cBYeqQ+pNm5BuJ+cgTlSWlZRxNzF
	 RPczUiM5qHotChQXK+Y4lPpIBP2gBy5VHfoMSL66FHRdHHgjLjcl84CZvG4Xlm4S1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7A606A32D
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A7A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso2290110241.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495446; x=1795100246;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mS1ut25pAkhX06KpI5+b6SzLMFwF8RaPMcofkkPb8+I=;
        b=rf488ZdYEMpRtM5VeQA0psto+B+TD0MW+fWGtCQz7QbgVJy7y3eqWXVqZf8Vm3x6Ln
         pM6t8gNX213mZN2rmKwg7QmBDhyluK0u4y9/GsAZhCDOPJBeYqexm5rHULhuJrlVlgfb
         WIrJ7bNLQH38p8JKMBYmqf3IgCyjXwq3rgdk6HCbdDgZGsTLSajys9OIQj4DcyohvKpQ
         iRuaJ7nZzZ4s/1qVdbYivXqOxfb525m1RIpik9ExvzoAto6oEgX41vsKY2W1YO9snN7l
         RDKj3sf4NE7Pj1RDBndbEx/skNg7spVlJKVQNqbBQEFxThYxSVbLUfcwN+xoSi3w65/8
         h3Rg==
X-Forwarded-Encrypted: i=1; AL+hErFxBDXCDTSHvY/fa+QYg8fyWXk8hu7E0B+5Xf3xI+evOD2jM6pFeiIOw8P3PyAEWHCbkSdjMqY+iw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ywm+lrRchxNYrdHkTf9gdIWTv4OQncJxz2wnBVEBbREfOFaTW
	grZzEeqNsZgxI9SpiDO3EBt7Mgs+beUV+pOf+MayFt+t3qXEajc0zGE5Bt29gi747vs=
X-Gm-Gg: AYBFou1GC36EET513BGNTXW2C5O/v0WJKu16wqxrcfKan2Y1ScwIs6prkl65v+aafa7
	3od65siRMInnzsG2nQB2HqCsI6N6cgwpEEa5Z+0AcE5YyO/kuAKxknnlHZJpMMv0fQ9rsfx3Ney
	UcVIGOAFqGRJFntf5al70OiKtT+geRaQjKXMUkUFlMNiuJw2lCZwLQETuobBAAeLVBL31v8shRa
	nDM2DI2E/CDtQl98NG4tfQsSXqIuQ5BwkP+cMoBSGSUkDEtUhY75yAnE5RQxD5f3FQKQl9WNtmb
	yrCJebiIRLl3fjzOwuXaWBS9IPoOp9M25OEajyfvq8l1VJ846wFsX4wa09GSONzjsTA2xxXTe0L
	fA50sSpzRG/orsKeRUaFb7mrY/oX8Fk5wJCx65Ag/lacnkQS8qmt3kyasbV/KYW0dpuFw5UFKMn
	IWmCz3rpT+5J3ouyay4CmFJO/h4TDgUmTPa9q884mw0wxvfiLKedNMB6qYR/uojfA/ThDIsswOz
	zJcD3U5g8M9vbryre3sxwVTmixjzikKN+pt+uFE4PB4tJeC334plFIoatJB/wxMT/wMZVwSz4FG
	Nil04iktMr6nMyG42wMtvBcTOKjstACTFVWG7gs6ySX1v8dQr51aQ8M9Rb29KBhKOao=
X-Received: by 2002:a05:6102:512b:b0:7d2:c786:5a95 with SMTP id ada2fe7eead31-7d4fb2a5924mr2500124137.13.1794495445856;
        Thu, 12 Nov 2026 06:57:25 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d62241eca6sm2975315137.11.2026.11.12.06.57.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:57:25 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7a6e560f580so3197100137.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:57:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHLsr6uvXrU91X+pwO61gIvsEpNrng+m+MfHO3ilA1RYlg8a/GnnCrugGwJWOweAF27SdE0lEdxrg==@vger.kernel.org
X-Received: by 2002:a05:6102:f10:b0:7c3:9982:67d7 with SMTP id
 ada2fe7eead31-7d50609c9damr2546296137.16.1794495444511; Thu, 12 Nov 2026
 06:57:24 -0800 (PST)
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
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-5-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-5-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 15:57:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUvhf=zEmd2tfodo7zf1hh9n8m88Okk7KZpq0n=mDR2A@mail.gmail.com>
X-Gm-Features: AclHuK_otbzgK2u3WYfd1DmRW9SD98NHgBcVxYwHNEPtms-IkWdgisCPqESp0Ec
Message-ID: <CAMuHMdUUvhf=zEmd2tfodo7zf1hh9n8m88Okk7KZpq0n=mDR2A@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] arm64: renesas: r8a78000: Add FCPVD and VSPD nodes
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

On Mon, 9 Nov 2026 at 14:35, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> Add DT nodes for the FCPVD and VSPD IP cores in the R-Car X5H SoC.
>
> Use the SGD1 clock as it is likely to be the clock used for data flow.
>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1574,6 +1574,196 @@ mdlc_aon: system-controller@c1338000 {
>                         bootph-all;
>                 };
>
> +               fcpvd0: fcp@c5010000 {

Please preserve sort order:
  1. Sort by unit address,
  2. Keep similar nodes together.

[...]

> +               fcpvd9: fcp@c5019000 {

> +               vspd0: vsp@c4800000 {

Do you want to sort the VSPs within the VSP group by unit address,
or by label?

By unit address:

    "vspd0: vsp@c4800000"
    "vspb0: vsp@c50c0000"

Note that adding the vspd* in a later patch than the vspb*
means the latter need to be moved in front of the fcp* :-(

By label:

    "vspb0: vsp@c50c0000"
    "vspd0: vsp@c4800000"

> +               vspd1: vsp@c4808000 {

> +               vspd2: vsp@c4810000 {

> +               vspd3: vsp@c4818000 {

> +               vspd4: vsp@c4820000 {

> +               vspdb0: vsp@c4828000 {

> +               vspdb1: vsp@c4830000 {

> +               vspdb2: vsp@c4838000 {

> +               vspdb3: vsp@c4840000 {

> +               vspdb4: vsp@c4848000 {

>                 fcpvi0: fcp@c5030000 {

Shouldn't we keep al FCP nodes together?
Same for the VSP nodes.

>                         compatible = "renesas,fcpv";
>                         reg = <0 0xc5030000 0 0x1000>;

For the contents of the nodes (except for the renesas,fcp properties,
as I couldn't find the VSP<->FCP links in the documentation):
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
