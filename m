Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615342EEA4
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746985; cv=none; b=IFQYWNEF1XQuL+turuS2t/AJfIl3YL9SCGzQRYjXFbmlKNAc4jcQTrA2KpoosIKzJ4whXuqtIuZ+6++gXWflMzMZModpxt1aRzWe6oNT+goyMCinuko8+/kLM8pXP7GJ9s0T0K3W1PzQADeadkZzZeErovIdvixzYsj4Znii+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746985; c=relaxed/simple;
	bh=BODU8nH72xA0ScZ+HzwpHMr8UOUoOL0Z1xiarATGzqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmKYgsTfBltbOZJWBQXLT5D1cZc08jAcG//m6oE1qglg+kCXFJWmwa2X8Tylnyue01XIr62qUQZAkGN/cmdw/ZBWnR6/mJHUJ/JJMd3oU/aRgwuZ39Ohr/VueUq5hwmaO6CTRcNtSs/hd1aBeQNzNHR2ZudavRbqAuR0QRPrtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c12758e75afso109655666b.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 08:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746980; x=1783351780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PSkrSvBcOj2Vfr1tOG9HdESUGrp+uU5X3MHl1xNqsM=;
        b=fxBPE9WHNjpP8qDMapYGvxUxwUkt8X0LGqFveXTJXLcZUOCS/1FEaiZFEL50strdSf
         2YOpaLuVXkBGCxJH0SAvlujRvOv8sJe2Y9UaF2L04cvtMCHcKi7L4DJEKxUBSPU7+QXk
         H5qBZDqnPyTr3iqodyU+ZeLonEFjIdR5pPJShGw6B+mdLnPQAgnC68kFQ3mZF1LsvC2L
         7jh+PLLjQgb74VjmEjcEbugKk/SZFv2DNrPCDoah6HpIYg5prlJgMa2NgNnPF8AIxlp/
         0soSDlNNwtH7NdBXk+QEdWYGalkemwi1O+VexVGHjx51QWgbBEJKPFq5ysKXIdpDu/eM
         UOKQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Eid2baxtQmSbM4l2MW+lXKVY7GLYe1X6sUX4OlcivaHvT6Ssb6Q0DB/J8dlpvXdl1Qq6S8eqRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyysFWmoJvg1ZUawqZTHt+dlW7hvJQVui/dgqHoB3Lo/TvBaT/x
	m2IIvyTCySl4cpIIjJnQikQnQEjgXTBiWQHPjEGF9DhPWfY2Nu8NBm+I9w8Sv+mUYOQ=
X-Gm-Gg: AfdE7cnGXGsU1C2XERa4aBIGdGhdrzqEN0cgtF6Uj9yEg7KqmcoqqWwfoRAaD2znSUW
	avHP1c/xdTVFK3O+n198SoE7sidJIAcaF7+4o03vm9xNyue3TZUlSod4I+AMwKrYL3156yO0e/F
	IqSRdcRIf3PLv4jZka3XgzolGsFeaCSnbJ/fNvden+Q7m4QoJgN8q+o7H1hd5ElZClM2c1nR4Sl
	DVLWtlqCbliE3K13u+HX4sDPqgLp6CDd9s8D5wqVNhy/kA1ITGr+h/uSKU0XAXvH/QVpFKh6W2m
	dXkyyas6lcLKQE7Xuq+steB4ej+KcP52Kg7gS+FrDFR0ANQW/8tKBXTNxvb9pWXTehJblNxSGSB
	Laa9dMmIkmPCwdfRiLo/kCMZRj1vx5FNMrxi36gcNYMnq6YywZrY9zGx/TS9wgpwDEXCKqKBRgV
	lBOrevTPup85zQi80Ac9P4AaI5LheOpg3PiiQN1oJwWpfULv/bRnLtAgq/urDO
X-Received: by 2002:a17:907:1c88:b0:bff:738c:7a64 with SMTP id a640c23a62f3a-c12061e36f3mr876672066b.49.1782746980192;
        Mon, 29 Jun 2026 08:29:40 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05cbfsm805274866b.36.2026.06.29.08.29.38
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:29:38 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6983f5c1c52so3797768a12.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 08:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqcFeiz0pdzuzOLcCqMBB7HbD32EmrvSaDOsADc7nxFPd3ROllLH4eg3CVGyHs3xFhqWiekPmYhaA==@vger.kernel.org
X-Received: by 2002:a17:907:3c8b:b0:c12:f84:85d4 with SMTP id
 a640c23a62f3a-c120f8487bamr796791266b.24.1782746977928; Mon, 29 Jun 2026
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629135917.1308621-1-arnd@kernel.org>
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 17:29:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
X-Gm-Features: AVVi8CfSSg4DcoB7CGCYddSfqoWpUaOwYUjpkorP-3LR7U8E7vJ9ucbePhiZLD8
Message-ID: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marcel Holtmann <marcel@holtmann.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andy@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
>
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> Not sure if this the way we want to take this, or if the gpio name is
> an appropriate replacement in debug printk.
>
> Since most of the callers of desc_to_gpio() and gpio_to_desc() are
> otherwise in drivers that already depend on CONFIG_GPIOLIB_LEGACY and
> include linux/gpio/legacy.h, only a handful of instances remain that
> are otherwise in files that otherwise only use the descriptor interfaces:

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>
>         fwd->descs[offset] = desc;
>
> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
> -               desc_to_gpio(desc), gpiod_to_irq(desc));
> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
> +               gpiod_name(desc), gpiod_to_irq(desc));
>
>         return 0;
>  }

Before, this printed:

    gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189

After, this prints:

    gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
    gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189

Same results for instantiation using sysfs or configfs[1], although
the latter does have optional support for specifying the name.

[1] Documentation/admin-guide/gpio/gpio-aggregator.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
