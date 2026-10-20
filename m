Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502547;
	b=G84RAZj6tUgsn7s7BTw+MU4yi5z5bjBh8Y71gDkjSZfH4BL6Xs/AV+KsI04m9EX75Wh0
	 Qf4r1YCP2LGqRBER/Y7u8D3XplXicRqOpwNzdVPp3meuJrAfg1gnerVit1UtirBvSYcKc
	 9OKwNjg5HFdavqCuzgk5Dv9tiXIc07468Ij/Ix0XfxfsQqqEXV/21YwCBavvlSCHR8C4F
	 EF9fg87e5vBHy7AfBhCR/kIPiGkZuDgTNVRD/7srtnrOqdfh+rmcKg6yX3BfwXKlRealk
	 KHCSD0cSycDFpdVnD8rlJ7FOMLt9oaHzbvVS3o0vugwMk7TEwe8sM0NbYzh+JA/1W+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502547;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=D+mxgjdi4ZCAmeQ/8ywDwvDse5W9MOG3smctM4dikj4=;
	b=39YLG62ZgoxqL/KkEPXpFfAD41FvidaI1IYiXrYnxi+yzQcUl9eDCXVrKS3stbXRt+Ou
	 DMxVnDA1y6mttWghKuisRZWuCRY4ZWFNt9ahvhnxaW3bMxzcXnEZwhyOXY4HWhBkit2ct
	 8Dq3Fs/o+t7EmoWSyy6sKGvnOD6IjHROP9XAFYlTcxpTTrUzsnpt5G5SEcEPr0Av3Memn
	 2pUJ30NlRIONoJ1CvfgU0B08mYrwvShgaR5oFGIm/cQf7gNjc9SfDrcQ8FmYmyUNtmMg+
	 Yixftn0DxVSCt519GlBnytZEB32p2AX04NDD0V+FcOsjrlQfKFohUVk4xlD3rzZo/Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC71606A31E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 13:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC71606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c315869241fso378006266b.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502546; x=1793107346;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D+mxgjdi4ZCAmeQ/8ywDwvDse5W9MOG3smctM4dikj4=;
        b=Y/lP57NAd/vHTOiU6lRlh1QnKppAqXwHXcj9vVJ3GMs64LLWoIb/ijAl5Te5wN4ZyL
         uefXrBZZsRYnHYN0IhgkuoOMaNnSY9BWheJce3UgpS3oHIGsWdUlBhj7G4f75redrUV0
         Z9fBdsLC4r37VxYOlfLtLII4QVJbmViazjW8Y136HZ34DuOu1q4hOjdLoUzQUnh2yI9b
         CNCZIG5DCt5LbhSlhQH6aw9CWGA3ni+zp0cRpQ2HolFnVj76rJlFeZ951gJCFoDlOFQq
         5/5KeyoipMClHJBo0w1UOB/06cHGqKdGQRVlGELdD8vmaDvqY+zozd05m93K3Gvv2G8C
         j5FQ==
X-Forwarded-Encrypted: i=1; AKwUvBzODCmZ+BpMwofQNZR3HDz+xOB4rd/xMhj4PM5A0t2Z9jHZXB8qeauZFDwEWSXZ2SQa1Vmlt2E/qg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJUZxa9fP9fA7hZ/ruYyBvFQGCgv3PqAU/+lRKgS+75vcQ7bcve
	8wgs/kYtHnK00FyklnIhNk/T8Z+srpsHykLUAbagDYMqs6tHvSmHmTbRpXsDOh4OxJw=
X-Gm-Gg: AYBFou3KRnIy88qeHpgZJMZM30I+hi91vSULOx0bp6OS06gfjdpJudxRzY1dg9DQAQJ
	ans7eKyBylYSlnwYkFj3woslvglMCpKhYW31b+5R9/NSAJCfmtNmrJ7dkLj8lTiI9ltg8/LXlUn
	KbGR/2vEghsdWY/pnLryd+a+OGAO2uMu3626mgzFLNpOpFCcOoTpUOWtuT109VSUUX/rjLHVnlc
	STY1G7Aknc5jIIRe5Hbu/atm+8nyTnY5XiN+bRfmNg37YDHp9S1jR0pa0qDWbBWuMqqxM2eLZBz
	3kHF53aB3X61qH/cgYymbXvmClb+X4cR5a1k1DkIeLE4jUEPfj0woliEyiFbvmWHV2k/gOKZNWI
	yNzRr+Tlatm39XtrPjrlTm7MiHN49ayVqna/pZbUDH8Xf57gbrf8kHSxqAXRjAcGdZtrxkIBDou
	nW3BYDQv6Yj+bG534i/6KRNM7nwHssh/U63uJ9/HleVNKcapXNhRzywsJp5CA0MCqYDuQRPa4Ze
	V1HtSOxY+dEaEGe2p9xPShMQkribEfeCLLL
X-Received: by 2002:a17:907:e849:b0:c40:4320:de2c with SMTP id a640c23a62f3a-c419e73e2a1mr800237566b.15.1792502545779;
        Tue, 20 Oct 2026 06:22:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ca7f2sm498986266b.46.2026.10.20.06.22.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:22:23 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1cc392d8bso4019609a12.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 06:22:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwP2pvXBi58ITeY6Aer0Vbs+nirwBt2/Ab3tJdmaM1SBQ4MjBB/9/bPhl3n11SL56wc77MARVEujw==@vger.kernel.org
X-Received: by 2002:a05:6402:270d:b0:6b1:c7d9:b631 with SMTP id
 4fb4d7f45d1cf-6b3a8191a46mr7499369a12.23.1792502542847; Tue, 20 Oct 2026
 06:22:22 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-15-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-15-e052903a3832@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 15:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHcR8-9g+KZ4Ssj+mJKYBz1h6QSjWnaPL1BcQWC6v8RQ@mail.gmail.com>
X-Gm-Features: AclHuK_uZzRO_WalfaTseMvUVupoP686uPVQ89YYU5UfnQv3EiXJeP7RDzX6u2Q
Message-ID: <CAMuHMdUHcR8-9g+KZ4Ssj+mJKYBz1h6QSjWnaPL1BcQWC6v8RQ@mail.gmail.com>
Subject: Re: [PATCH DNI v3 15/15] media: rcar-fcp: Check device revision at
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

On Thu, 15 Oct 2026 at 09:53, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Verify that the device revision register reports a valid value,
> otherwise reject the device.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
> Changes since v2:
>
> - Add FCP type information
> - Reject devices with an unsupported version

Thanks for the update!

> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c

> @@ -154,15 +204,67 @@ EXPORT_SYMBOL_GPL(rcar_fcp_soft_reset);
>   * Platform Driver
>   */
>
> +static int rcar_fcp_setup(struct rcar_fcp_device *fcp)
> +{
> +       static const char * const models[] = {
> +               [RCAR_FCPF] = "FCPF",
> +               [RCAR_FCPV] = "FCPV",
> +       };
> +       static struct {
> +               u32 version;
> +               const char *name;
> +       } versions[] = {
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_H3_ES1, "H3 ES1.x" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3W, "M3W" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3M, "V3M" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_H3, "H3" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_D3, "D3" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3N, "M3N" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3H, "V3H" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_E3, "E3" },
> +               { RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_X5H_V1, "X5H v1.0" },
> +       };
> +
> +       unsigned int i;
> +       u32 version;
> +
> +       /* Check the device version register. */
> +       version = rcar_fcp_read(fcp, RCAR_FCP_REG_VCR);
> +
> +       for (i = 0; i < ARRAY_SIZE(versions); ++i) {
> +               if (versions[i].version == version)
> +                       break;
> +       }
> +
> +       if (i >= ARRAY_SIZE(versions)) {
> +               dev_err(fcp->dev, "Invalid FCP version 0x%08x\n", version);

You're missing a few variants:

    R-Car V4H: rcar-fcp fea10000.fcp: Invalid FCP version 0x0000010a
    R-Car V4M: rcar-fcp fea10000.fcp: Invalid FCP version 0x0000010b

> +               return -ENODEV;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
