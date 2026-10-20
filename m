Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498860;
	b=OlkF1KopOQ1hc1lZ6fRqlLvffKb7MhF/rKErNRvxkPqmTj3yN4oXEJvDBMQz/uoznGGJ
	 9igReO6GMXTMgV7txNcLRDnVS/VEX6cxZt+M226Wy9XDp6gkMNgIVE2Bb+zVlnHy/Sk9P
	 VU7GZejbssI5yXJJ5FYaZX/ukjSzKPB+bHe7iewFHMl+LD9scRhoTlX4q6JljLoXyqlaF
	 EDmjgDbBZoFcGbvaL0HCRPCvbw3+15HwYS7vgxcZXJJnQFyMjlWo4YVnOWQEjf70MkCdf
	 LHVn5rJa4fbtDVWdge684yNGz/lbxtInt4NEOV3zN9K/hFetEtYT3UHzKJKJz1/bFmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498860;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=w8ekeggAdWyBqH97gBi+p9TPg4z/iYMBplVI65cJ2lQ=;
	b=vk8vkaTjK79P/Ngwm1rb0WcvX9k+Sx8RwHGhq/LxWCDsMitdgFGtOy3UObayhDoe1A1U
	 res6GG/avp1Ed6hseuuYNVFNPeYQWt/jLQlJjLdv6/CRqJKjkk29DTTB3k0niQheyB2Zg
	 WNSA54gt35UUcJ1wl8bsBkTs5dBCGZoHDRY7frdNxfT5XqV23PCGdPNRtLQI0xVTta3v6
	 amRLgaf7hKrMMPtDQEb7/kDUGTWVZqU5ACfIv58nBddzAyLAkQNXmUidM6+S/JztZdzO0
	 7sMP/CyV3FWVmg98PIyhZc8Yyk/5Cwego/aP7Vtt/G6ajna9+NDdxt0UFdx5Qr+hYXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B48606A31C
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 12:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B48606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso983617e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498859; x=1793103659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w8ekeggAdWyBqH97gBi+p9TPg4z/iYMBplVI65cJ2lQ=;
        b=0N9/bgcen7MOhJoAMT1gkO4+55ZJQBVYbUB3oniJJYURCh2mD49Bl7w8FuUKYiQeuy
         x0Jof5KfIPL1cqJ8KciR5ubnwkCf5ta1g1aSl85xToKDQOJc7GOm/MtS9MNqSuLrlJR5
         Px3/agIRHCy4XKgyiZu/qzpnJkosiWc6qqOAnyvlems8aAJE3JL1oyxAeqINnqVWHkIx
         IXa9HNsdBLRRQRIqtOyZE3IHOXJ/JuZZSB1sQVFPULNWCMYe7VMXuLEfEjEUhfsVDfwG
         jOaJB36/+53aALHossvb8ZQc616ZQ+8Kv2WEd3YzCUIdQIgCJ6ni3gTwBOZG1QQpic1T
         g7WA==
X-Forwarded-Encrypted: i=1; AKwUvBylBQsvUg1DtzvSNHFSxVh5GeY7LScpyoUCzHczVkBgRSXReEuKAaCIWwhmT5bW5Ki6sdND7Qw+KA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI92X0Q+lbeVDXfHmGB6vjhfgm8Bsh1OP5GgFCYkFWZ2XQtdGye
	FzJmgs3reehb0FDEnxKrlQLSqw05lqGtpaRTPWvt4fgYiPk4LVrGR+UmeD/Lm+lxau8=
X-Gm-Gg: AYBFou3rGYe8fY+BAMNNJi5OI40VbABRhmhubBR52e0/rE0Dbp1Aw1Ox1wqpqR6o261
	IU1hbcTR4EdIcRhQxfkuj7WEbEFd2rXE8UHOy5laMlkNscUsxW9mWOU85eZnfejdlS8PM6nlBE2
	0Co+Gsf6wdd750J93Xmcad759ALalCiivewaSkdb0RoPItcvvQ1xJGmpTi0R0gp8qO+1HGRQf6l
	WUt2N+TY/eFlALKRhBzEhX2MLyMvu/i+ut2AWzAEIkKuxaGBG8vcMV1/Anb10ez6HG7oHHOuh7R
	JPT7TJ/x5SxTpm3JJgv9x38RO9oXNKOEzoOVc/BmAZMfQBKHzigjAlUI6fHIs0RVSMQprLxAIWG
	tRR6FSOYx8XLjP6nSneUxIRluPhkhxVbD5NrXc6t2qRb49f46LvDofUfIkTXSJd77qn+6zUpQMs
	3/zO9tLRTtsWGSHvUo3UldkUtqMXCC9736lczY/HoLzudZc+FNwUihxRoCnezZmrdDLS/q3Bq91
	5iLWAs4wPvauRw73veV/9tRu25Lfbx3h7WJ
X-Received: by 2002:a05:6122:4004:b0:5ea:7126:38a7 with SMTP id 71dfb90a1353d-5eaaa62c43cmr2813770e0c.13.1792498859323;
        Tue, 20 Oct 2026 05:20:59 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabe1b2026sm7656690e0c.17.2026.10.20.05.20.55
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:20:56 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9906034086cso909898241.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:20:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYwMLX/yArmOV0u7RboYxuIAwlxNfM45ou+RI7lX+YNQFL7ZIq5YfmyqzX3riZSfLNHK5HUIH0vQ==@vger.kernel.org
X-Received: by 2002:a05:6102:509f:b0:7b8:1a1b:8e79 with SMTP id
 ada2fe7eead31-7cc36495eeamr2517275137.0.1792498854605; Tue, 20 Oct 2026
 05:20:54 -0700 (PDT)
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
Date: Tue, 20 Oct 2026 14:20:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLC7Zw9x6=iz2WMeuPr=rhqKMVPpRdVqFcHJxmAYC79w@mail.gmail.com>
X-Gm-Features: AclHuK8ponr4NJ0lS94fhAlbo48BEUWSxi4Wc_0ZZ5rhhDlLA3L5w0smnHDD8jQ
Message-ID: <CAMuHMdXLC7Zw9x6=iz2WMeuPr=rhqKMVPpRdVqFcHJxmAYC79w@mail.gmail.com>
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

Thanks for your patch!

> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c

> +
> +static const struct of_device_id rcar_fcp_of_match[] = {
> +       { .compatible = "renesas,fcpf", .data = (void *)RCAR_FCPF },
> +       { .compatible = "renesas,fcpv", .data = (void *)RCAR_FCPV },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);

I don't see a good reason for moving this around?

> +
>  static int rcar_fcp_probe(struct platform_device *pdev)
>  {
>         struct rcar_fcp_device *fcp;
> +       int ret;
>
>         fcp = devm_kzalloc(&pdev->dev, sizeof(*fcp), GFP_KERNEL);
>         if (fcp == NULL)
>                 return -ENOMEM;
>
>         fcp->dev = &pdev->dev;
> +       fcp->type = (enum rcar_fcp_type)device_get_match_data(&pdev->dev);

s/rcar_fcp_type/uintptr_t/, although this no longer seems to trigger
a conversion between pointer and integer of different sizes warning?

>
>         platform_set_drvdata(pdev, fcp);
>

> @@ -215,13 +332,6 @@ static const struct dev_pm_ops fcp_pm_ops = {
>         RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
>  };
>
> -static const struct of_device_id rcar_fcp_of_match[] = {
> -       { .compatible = "renesas,fcpf" },
> -       { .compatible = "renesas,fcpv" },
> -       { },
> -};
> -MODULE_DEVICE_TABLE(of, rcar_fcp_of_match);
> -
>  static struct platform_driver rcar_fcp_platform_driver = {
>         .probe          = rcar_fcp_probe,
>         .remove         = rcar_fcp_remove,
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
