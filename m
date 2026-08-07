Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75B3E9F9D
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095904; cv=none; b=Fgz+VtwYBrPJy3gKqG/ShdeJR5z2YSZNwSd+IVkCc39O8nlT8YJqBazdOgyenpfqtCUdLbdV1QbMs7Y4ryAZ1GfB0UaHeAGg90zgL3mgg0f8pKxtqUzb68R2JS7zRAL3ytOYh4X82xHOu/kGIvGWhIub3jYhGR5GpctOTdTaLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095904; c=relaxed/simple;
	bh=/y0CGy24AiO46TgwxkbP1tFuV0C+/wk51xS5fSunajM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YM0j8SL4slUZMBAvyWdUvij29y+Oh5HoklS2AldGPta+vW+EyV85pxE1GkQcI1cWFmK+qC7Pkz5E0+uwA3oB5B+HrHzkeSuXk1TflLVkE1bRLqIm23MmvO44d7ehlaiAAT4BntPMY6QOjLt7DVipTXfCKcSQslu7/iBQ/yh5ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-74ae4c75b20so1148056137.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095901; x=1786700701;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UAxJcsTBx78VxwObBjDafBX3xIovoIX98Z3YZn8IFUo=;
        b=dNI+tdUwLAo7GrSFof3sh8IQp5OJ4/78pDTa7QE5lbtHgbXP03bEkQNYI2A5DYTJt1
         ItLAcCL2a3TjBBh6E4Qs2lylRx3XVX/PPL1cycKmQWO5IymasJtEMjpBetfkW0nvGP4t
         91gdouvO99BZoR6S4L4PtgvEXw0wUo/ewfpMtp3m2isoWs+tYF3swkhDb4d+mW7jHyhq
         SPdNMnd1Ea0g79RKC5gOqs4NpuTYt5+Wk1Ustw6d2n7ZYVmTF+M6SboHyocokvGbT5Qy
         PGrxvTQrMI2P6apwxqj3h5IJfh2ex8rXB8Diktqr3kK7GPWRs+jSZKHWY67VSzfZOsEl
         qKQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3dSdBzuBn46Pop/X49bzPNcvH9AYYgdW1HJuSCWv8CfwBOWDrhQ/KrFzezVumbpLPeDrAtKOHYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzadwLAxG9jXElxNOBbvR3lcQ4dDOcgXWVIn6Qf9al9Jji0pbL9
	I5ce5/C815A7nUDZu+I3FPiuWyq2znN7efLcVj4z66ZYbG4GDy/k31eh5jkLvz/E
X-Gm-Gg: AR+sD102D2qJB6XBSD1BwZPSa7bi5lCA4+05avQQiQPs+AJ5gaZVp8aoxyhqQQ8qDgk
	gcxi6PHVMweqJGWvNMkx8lQmf9Oeta9U9xXCEs7DOmksh/dLbRhTg2huRPpUQc7zfo2Goesp1dE
	/LtsOHixwtIigAKrUREnYIqGRX9GfGR2REry5HAeW9JO2GwYRZovs98c9Foog3a9Tn4QlbnpimI
	6b685qeynw+cWpFT7rZPvz2s7olMmnyhZt+VL02XugAlhBW8ltC77KTHAsXi9HHwjDyG0WmkgPs
	2H9JwA8gD4cCgbAnSx9STw/f3/UFNPxeQC1unTrvTB0phQmlNQuGHWVnBSO4x6zKF54WJfxvQIH
	B52v1drueq/1a2PaNVmwCrlhawGhnBm4O8STg8TAffiFAsZQ9L14GAwCo5xmKXsLXlL1yUh7LSZ
	6wKoV6Tu+YWduznd26biUurqKZmzdd9Tne5i43icN6xC+U9aW4pYwGHicex6RMfEFISeL/1rg1V
	MuyywBpXahPyYcfeLy4S9s1Jw==
X-Received: by 2002:a05:6102:2442:b0:734:54fa:971d with SMTP id ada2fe7eead31-7623c58dedamr1360905137.7.1786095901435;
        Fri, 07 Aug 2026 02:45:01 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-979f3083dd3sm323665241.11.2026.08.07.02.45.00
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 02:45:00 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9770e900464so1447666241.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:45:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Room6g0YRg62Ww6dzbU245CoZ/41QEO+ACv+IEZEFBMLPjPBlEFztF0EH7EvAEFhoIi1OaA9gW5EQ==@vger.kernel.org
X-Received: by 2002:a05:6102:568b:b0:634:2450:7998 with SMTP id
 ada2fe7eead31-762aea86b92mr1369250137.4.1786095899940; Fri, 07 Aug 2026
 02:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807093058.42840-1-phucduc.bui@gmail.com>
In-Reply-To: <20260807093058.42840-1-phucduc.bui@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Aug 2026 11:44:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
X-Gm-Features: AUfX_mxQEzl3jQmvMQf06PTnHIHBcMyX38xj7RfXUAwYPkdJFJKwvIXHn2A4lc8
Message-ID: <CAMuHMdWJ3W2JKmxaKaa-A-Zk633cf4UwbESi+F1_h4tX1AhRng@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
To: phucduc.bui@gmail.com
Cc: Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	niklas.soderlund@ragnatech.se, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Phuc,

On Fri, 7 Aug 2026 at 11:31, <phucduc.bui@gmail.com> wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> platform_get_irq_optional() returns -ENXIO when the optional IRQ is not
> specified. Treat -ENXIO as a valid absence of an optional IRQ, while
> propagating other errors.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Thanks for your patch!

> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -491,7 +491,7 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>
>         for (i = 0; i < 2; i++) {
>                 irq = platform_get_irq_optional(pdev, i);
> -               if (irq < 0)
> +               if (irq < 0 && irq != -ENXIO)
>                         return irq;
>

So the code may continue using -ENXIO as an interrupt number (and fail)?

Why is this change needed at all?
The caller of rcar_gen3_thermal_request_irqs() knows how to handle
failures, as IRQs are optional.

>                 irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
