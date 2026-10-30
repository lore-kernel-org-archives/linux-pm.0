Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355948;
	b=emrOpOb1ftKovIkQyiksfwVW1aaYoKRqsv0iFvz3LwFKfu9ftMWYQu98OAe88NMZZ/vp
	 H8yTscqbo87Di2ruhnD8a5S9ezMOrvWOgqvU3l61ZfT0hTCGEqelDPzA4sH/VSQQOgNKB
	 PrDrojb/0CXnm9RS/fQmXNLwRc7qSWHNeTecbCNy29CZkLoD3wgY6kO0OCz4m5bn9Ly7r
	 MyyAjreo31+0q0RA89FjdnT7JKTHFOqnakufd1kcSSffFjaibdlzUPs5eUk7qOzNyPzWi
	 sU8qGZQ6MVubOGT7qjNm3ne62lJFTg/7os/eATU8RO3J1Gg11MEKv+/ocWNlOT3R6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355948;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=N/lKB/c9Lq//6NoMXUd+nQ4qRj1zdlYJ2/JdgAh063M=;
	b=ZwCCf0ay2TypyKOHn1GceuAh8MH9mVRnr/JQQwpufS0Xa9CntUvT0nEj8s2+SuUBkUhq
	 OnoyhcahDXkjwp9rh61iGocbfR4hRGHFBEBbVxqxVihIzPY0BJeG0UuBQQU+hh5LETieQ
	 MqZyIknEXEJdZsGpEGmuhZ2pHsB7Si+lIe80WdT7UYVL8PI/vIcyPz2tuIVOJH4VYtok+
	 /3Otwj1Z60oume+vIW81pgdVKlcXdkpUhvCE2TiSSYYcpQquk89XDA3fMcFIdVUkO8enU
	 xCdX5M79Z5JK2n176RKR9xMCxl3i3ZHuSexp+j/e05+AwT9kWc5And3HNNq8PCM9vxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3D606A31A
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 10:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so259991b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 03:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355947; x=1793960747;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N/lKB/c9Lq//6NoMXUd+nQ4qRj1zdlYJ2/JdgAh063M=;
        b=rBe6ePu7oBy+pffwKM+KTyxBwnxL0P3E7l1sWMZ6a219ikVUUzHh1hyO5UFZoeS34d
         s5AyWuMGNcmbylEDbfFKZVnERZD55briV1xypGSm1LBira/8LtZQ7A8c+XzuYSCK7b8v
         kZRYkvAomlrnKyIs1yj04KwHq8DXtXwkalDMiy60XwE04n1MOm520M+aIHopXWYExeGJ
         ScFsPfc5odOQsl+E3H61I71sg5JBD750Rcc5kScRiqQFlh6X0ANFX20xwW+lIBRgwCQg
         2fXeMBqU23usvNmX73U9hxkbr136P1yE48Fj0ikHTNVZ6mWc2PoNMwGM/PRsE6QV3ufJ
         zDOw==
X-Forwarded-Encrypted: i=1; AKwUvBy0crdxH1+gXtL/DadMYroP77WaNFe+TjQTk9QXcVAUsNNh6Bqg0gHYU44SdL0hEeqFXXDSQ4PvaA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLB/XrD0ZiS9vjkIw51bJl07fjAuUYmt3a7X45b6YpRavz7Og/T
	6n6aq83lf9eVQKU6a44S+96w7NqZ6+lp9YCv2yFsRIhjzSBgzk8Dl4+bWQVwJ1UP
X-Gm-Gg: AYBFou0d8muGMpPkk4xeAglZTTPfYpO86tIw/IO6jPgYAlglgv4Sz92St/jRSD+W44H
	bYh5HUuyYkP7F9NhapO3lbqEMbYXINoiW85+KKBK7cNdk52c6E3o+TP2IQThybCoH1D+AtepYCi
	ObGncQtgTgzLSaXWTvmf28+W4UjzJZQy4ei0lXMl7cnxJm+qdxIzwPu6ADae6jTDJqIYjcNzves
	HZU/RaYiL/lrbeqk0roCOVRU5d4gpMWNj7zF+Ty954ZiaLZG+JmmHAXYlgRlx+YcG1P3vG/WFN8
	Llo64mce/IOtLhlX9WZhglX5Pfu7JZl/4QLE+xHk9qdQpD9iTCk7mq9hdqoBc566uSmB0hXMbhc
	uRZHI8pVfQyz64/CVcDxaSt/NGi4YVZShtFgmeva9Lx6/3tENmSGHOS/Ae9nIim5xdVwDLm/5c+
	wkXpGqKNb1ke6hm7AxmxO31+DAlbXfCpmwf9dz7NERXEnqd+lS8vc84CIrwVZXu1EIwQHJ6RsZY
	maSLzQUUcLq3FXIL3QQ30l6qDLAP15U1eA9I8y4U8PSAC6V3ZFLo0ddG3t5rWe7WWydBpiXr4bH
	n601XWKto4+LUZBbrF5sl0r1ON9UBMtDItaWUiGzzB1eSBqitKOwGET/NrNMjDCwwA==
X-Received: by 2002:a05:6a00:10c5:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-8a9bc8321e4mr1603752b3a.32.1793355946981;
        Fri, 30 Oct 2026 03:25:46 -0700 (PDT)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ecf563bbsm598436b3a.1.2026.10.30.03.25.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:25:46 -0700 (PDT)
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so1503461c88.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 03:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwC9lmwrOJxQNdb+NDjaqDo5sgn9SZ9rCjtJzwXdKWbVXyfPCgxEd8PJ+fIOfZJ07/OqtFu3GTiYw==@vger.kernel.org
X-Received: by 2002:a05:6102:9d4:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d0728d38cemr726412137.36.1793355567237; Fri, 30 Oct 2026
 03:19:27 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793278754.git.geert+renesas@glider.be> <2f986484ade3f3ab7785a088b476b4bc6f53c157.1793278754.git.geert+renesas@glider.be>
In-Reply-To: <2f986484ade3f3ab7785a088b476b4bc6f53c157.1793278754.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 11:19:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDs38CWQv+-1d6iMa5Et-w53iVbjSTyQS5uVcvq+E8Ag@mail.gmail.com>
X-Gm-Features: AclHuK8TLIiJXfBZEbZO-sDHcOFpgPhdmma0xCzHFZfNFDpVgGdGYD9NeIfWwIY
Message-ID: <CAMuHMdVDs38CWQv+-1d6iMa5Et-w53iVbjSTyQS5uVcvq+E8Ag@mail.gmail.com>
Subject: Re: [PATCH 4/9] can: rcar_canfd: Add support for R-Car Gen5
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Biju Das <biju.das.au@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 14:11, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The CAN-FD block on R-Car Gen5 is similar to the variant on R-Car Gen4,
> but uses split global and per-channel interrupts, like on RZ/G2L.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -636,6 +636,23 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>         .external_clk = 1,
>  };
>
> +static const struct rcar_canfd_hw_info rcar_gen5_hw_info = {
> +       .nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
> +       .data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> +       .tdc_const = &rcar_canfd_gen4_tdc_const,
> +       .regs = &rcar_gen4_regs,
> +       .sh = &rcar_gen4_shift_data,
> +       .rnc_field_width = 16,
> +       .max_aflpn = 127,
> +       .max_cftml = 31,
> +       .max_channels = 8,
> +       .postdiv = 2,

R-Car X5H does not have the /2 postdivider, so this should be one.
Else the bitrate is twice as fast as intended when the external can_clk
is not available.

> +       .multi_channel_irqs = 1,
> +       .ch_interface_mode = 1,
> +       .shared_can_regs = 1,
> +       .external_clk = 1,
> +};
> +
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>         .nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>         .data_bittiming = &rcar_canfd_gen3_data_bittiming_const,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
