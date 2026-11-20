Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161443;
	b=b9Bhl70wPCxxZigoxdW5ysFFfTb9yFjWUo/+cKqIbbJYdvHfC8WAWLWraafDYWdE14CY
	 tTBLXsW/AZFTd1eXrhTi4b7JZ6nbuewU9NjqSnrKQixuG3UzAfaCraYBIMqPgcQ8kJ9Dk
	 tTa8x8rJMyBZiP2Smki4zWSAam1SuUwQF0bTeXcWOKTRKeO84oC2aeiAcF4+vKo8rbZCD
	 h3K8kO7G+mNbzU8awRUeEOvbH8feD8IAgwdXCHr70u1I7zYh4NnZETas+jLy9T6qXcayq
	 9emLL8rqwbO6q1KOsrMmu7FyVuyPKnQU/tHefqAvDyL4TD4F5qxzVN192krl81X1TDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161443;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xKnU/TldM314xEN7UqLDGvv/eDTZSOGz68aX0N6/qi4=;
	b=OdKyxVnzsagmHgqj+Yrj+rVtrpkE0PbsRaFeU9Ya1VpdEegfvXhzVboKbamuTAevWiHr
	 U/62tKhMlbVfK3lF8qqWFGIEiVXgZu4l8sOwmzZAao7KmzUIAl1h2O3d9q0Gtp3Z13Kum
	 vVHsPyjV8fItagFnLSc9mGpeCx56Ut4EE955AUluCG4dB6bk0AW8wSovzElKsj12IvN5r
	 TUg3kUZtpC6s3zF1E1QNpjXE6w5x76AU8It1kcy5VIfwT+C3HHDYapJjRaPAoMAYtW6b4
	 kYg8qhbY2m4gZimh0LJ3plQ81f9uUILb77zmrATQ03SFpXQHpERZv2JF1V00xDLhgAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51130606A32A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51130606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a85c656c58so502804fac.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161442; x=1795766242;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKnU/TldM314xEN7UqLDGvv/eDTZSOGz68aX0N6/qi4=;
        b=0L+R2lMxfUwfLemYk5tXXD7D4EU/hzgSIO4ILWa4XacgyWz7BnCbW8pixqIHYAoP0g
         ILQaLGNNE4QZCMhV3uBS6m+PEQgUkNfTf/jJ2jz/ecn17Ger3OLq6VL27gn0A7AQHs9Z
         lGIXcUdy2LjWzOhqop0d2NRptMI3DJ4nOBpvhubS1KPfY6VI6vjahCD/f3r4tYoUYoZp
         0HDfaDq1WOT3JOWxsO2wwxkZHiQ+uBqJ/6g3k7TyoF7FIB56oK6cDE+C5ls6+PRBUjgO
         c8Thqri82zSOMOYidEvxewdAmqQPqSg01DiaJ+8NAeci3bVUCbFrfqnhc386DET4Cjgj
         8F+g==
X-Forwarded-Encrypted: i=1; AL+hErEQEeSuIZ7Pt1qoITTK7dHVV3rsxi0Wo92ZJxsqGxiTtAQgev5w2+ec8QtYH/ZjrqjiuWmRu315aA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/e7EUtsmqIMeLLY8tbJHD7Z9uGTT+bWsfbmMh5rC1GFd2CNAcN
	EcpsCRp469WjPGDMGnPqDm64msmtsf4PVhVYuZhCIqmvqDSzhNj0Sb7e0JRy4U7D
X-Gm-Gg: AYBFou1ZB+I8KhC2JzxY0rImt6a3jicCMv0quE3/O8yGPO1s9FKkcpoZrov5HJaY9dG
	GIGQzBgtAzqXKBt6JC8rNkcXSdQp6afyK/KFHR30p67GFB71psLfSAJaK+fQMlsmOguuHILAH/d
	kB0InPPyJgQC9KppeJt2yrtGikdiZMXq0Q7UZBfcNUU6iwEkBebjwFcQ9d9mCEpyt9STzw+XMbd
	T5FCpEB54FiGhm8q7/p64mrs44u55trZ51ba6Z6lcuo1kQv7s2lovKKK8+Fv9oW64Xm49/IkQfK
	sg2vnwZqXeF8CPnVteejgMpv/jFBmGqPwFj8efOkKsfLUN+2b/j6jIuGEyj7vZRBvqwk6Lha6PQ
	3LTXzrNlrxLPp/9OZ4EUpFhYT3OS1Uai90gvA9RnsdyeheUCvJz7Zi8X/t2QnhehmZg5K2Y+vmq
	hckYkXXOII6G8qq0GRQL7yloitTYna2CLfIzd+hcT1f6EvWC9khY2Sm+L8wOuHr8/h8ClPCWrDy
	TrleeTqfiNhWvwsPKU8flaVrF3Is8vqqcF3EBOfeJFiw+Z0X+uYkcZ9T+2lYxjLplJdqrMQB9AE
	u/vsCtq+BOXN5W88bTLsASix1/nXzVGJm41xLJVgQGwM0MhyErPI71ITCeH60uAhuVk0wt8=
X-Received: by 2002:a05:6808:13d5:b0:572:dc48:b773 with SMTP id 5614622812f47-57a06b1d9bamr3140378b6e.1.1795161442198;
        Thu, 19 Nov 2026 23:57:22 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3575f5bfsm1613708b6e.14.2026.11.19.23.57.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 23:57:21 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-563a0462094so388865b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:57:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEYmuLlumdmdCmi934kXMKQNxBSgpDptyqZmdnqxmAJ50cJ9wuOsLHLnUqZZs3Hrbh/DyCrhgTWGg==@vger.kernel.org
X-Received: by 2002:a05:6102:6c4:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d7393caab1mr683612137.13.1795160956421; Thu, 19 Nov 2026
 23:49:16 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be> <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
In-Reply-To: <20261119225017.15a7b5cc@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:49:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
X-Gm-Features: Aa3M54rfGlA3UrmhLbFF7B0m1MfxoFvw1pyboKcP24dUngkkG_fWLkpDdrOnbn8
Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andreas,

On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Thu, 19 Nov 2026 14:40:38 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > used for power management, so the latter show up as "deviceless" in the
> > consumer column of the clk_summary file in debugfs.
> >
> > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > the consumer device, too.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > The first change is probably OK.  The second change may fail if anything
> > in the oh->od->pdev->dev chain is not available yet at this point.
>
> Test on OMAP3:

Thanks for testing!

> --- clk-old     2026-11-19 22:44:59.810807920 +0100
> +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> @@ -1,17 +1,17 @@
>                                   enable  prepare  protect                                duty  hardware                            connection
>     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>  ---------------------------------------------------------------------------------------------------------------------------------------------
> - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> - secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> -    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      of_clk_get_from_provider
> +    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
>      gpt12_fck                        0       1        0        32768       0          0     50000      Y      48304000.timer                  fck
>                                                                                                                48304000.target-module          fck
> -                                                                                                              deviceless                      of_clk_get_from_provider
> +                                                                                                              deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
> - dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
>   mcbsp_clks                          0       5        0        0           0          0     50000      Y   deviceless                      mcbsp_clks
>                                                                                                             deviceless                      mcbsp_clks

Hmm, so the passed device is always NULL, and thus there is no point
in making the change.
Do you know if these come from the first or second change in my patch
(I guess the second)?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
