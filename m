Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188A392C3A
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433318; cv=none; b=ZSZThTJcaHkKId9FbcDaLkse3zLUDpFqI2zazM8o8xYkSbn/WmMZ3+pown3pGyUwawJBgKQvvnadQSIwfuBnSbqtipR6r8mZpxxtlD2Pn5BA6Pm6WncOH/RByVDe4fRCOiKE0f9e7IJoY5K0eoy1Eb/feDYFktcZX21pOXGl0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433318; c=relaxed/simple;
	bh=v2/j0Oj6p53ESVa3PLPBywwI9wRtN5XU+zJPWA/4EVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/c8QVAjeXbWB2uJ1scxfN6L9CNfLc5TvzNziT9nLvZrn0uNc6JgFGACGR0IYZHRexkZpWHicB0LewcWQCW7/IxnIM0dGkShW2rFRf3bYnM2OMsMxCegJG8BNH35En7uiZmQUVZM9Py5g0N41HDJb2NE7NUMPjLz+qTr72jKtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74aa416ebb1so519866137.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786433315; x=1787038115;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bbDA2HJhRK7uccW2i/9tvYlKy7xqWbKNdvfK5Qlf1as=;
        b=NzrZEM7o6X4Ln7afhdGjyp0iYIlHgD8q0D8erlOz4MoVKR4CvaaCqXwJHzS+C1gJVi
         CbEtv5hITMAmvhx9vcdZfdYMf4UZT6i72ylLHcTh4xzoe1TQJgGlNCsKHvfHKI7z3m0B
         XXqXFAAITR8oLxbJYBFpnP6A6ZL8sWhDGiDgKMV0gedJ3Nuzn47iE5KoQyoP6PWoOYz/
         QjAkiod09/UO2OsRTX4JvAw7MV9p4p49xbRKSpvpR/mr1j80aJvVo6ihr7tZauYvMGE6
         weQXJQIn0woIN6nYKOPfC1creE+vu+CF7B8DvLAh40WiFJTWE5zWI019rBe9a4lfmCe2
         dJ2g==
X-Forwarded-Encrypted: i=1; AHgh+RpPnOS4TzhcuYDI/WL1BO49O8kF6/IelmeyJeZLT4Ze4HihKbGRuis72jdAAtHAE4hLvFnBOgvbAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzggb5fffQhBRyc1qhN1DboFBZyzxxEuITywPEWL1M6GfiNMOOp
	G0TNgpKJrUQacKVl52FFIjjAHe24T3senIGgwSZbnIO6FiZ9FjtZrsHzDgymamv1
X-Gm-Gg: AR+sD11eqwJTPIsohNDSvbjAaaFnqlN5vNPqiiCg7yhgYy6c602kUwv2hzAtWWPN8wF
	17TlN8/RS1haniiu4XyVT16RNuHvqGy9Vi9nRQAEcf8hMhyVfk45K6meIK6JAF/1RRP5vA3WVyZ
	AFJ1TEdluGQKaO8kSIdq+Fmzl27IBTbZrSaDWDtPSh+3bU2il5fInOX0DzUAnoKLJIJ5jrCaF+m
	OTBoHhwiFsHSGuPReXf5kbHTTHDB53CZ10U2reFzjgMFu3vDxYgPPHW0wxGV2Dx95PKIXZObfki
	ccWoKJG/9yIiW4jXkUEa873uDqOiPGpxKREHCMhUdad4eG8cWcGd4MldwcJrWA/cBkGwnYWXsn+
	IZbNXa2EcACTs6ib+jn/POPxOccFD+NLGqw0e34wSuCUeR9bzSvNThCLtHRBz2mQXhOOrP+lw8V
	qUwQ8mkSBN0VRC6/PgHlUghXrEp+A0/U83CvUnz4v0ghllh1XRRA1ZdyVwQ6zst9YkKWKAUNSl+
	dsQhBGMT5JjbM6Dhk0heCwGjA==
X-Received: by 2002:a05:6102:5789:b0:74a:be82:73a6 with SMTP id ada2fe7eead31-76b560a071cmr301436137.8.1786433315138;
        Tue, 11 Aug 2026 00:28:35 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a365fb92bsm149797241.1.2026.08.11.00.28.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 00:28:34 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74aa416ebb1so519858137.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoyTUO5Xb7r/alXXAYserphB0CP9BDKYbOFzFvSe83cDxXv+TCXwSF5TJLLG9v3XJFl9yTN8OHWSA==@vger.kernel.org
X-Received: by 2002:a05:6102:4187:b0:75f:e517:ec96 with SMTP id
 ada2fe7eead31-76b51b25220mr340921137.0.1786433314033; Tue, 11 Aug 2026
 00:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810111841.77898-1-phucduc.bui@gmail.com> <20260810121914.GA2757863@ragnatech.se>
 <CAABR9nFkFyhzQO7UGsaiSDcZ8km9=nv-2+4xWo40EG6c555Lbg@mail.gmail.com>
In-Reply-To: <CAABR9nFkFyhzQO7UGsaiSDcZ8km9=nv-2+4xWo40EG6c555Lbg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 09:28:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXR1GH7-nPmYv5i7ooB3kpqjOvY3A3vR36vYLVnv99Og@mail.gmail.com>
X-Gm-Features: AUfX_myuDTBVQLkzG41xoEKKZVf2OG_s5XczCeosvzRfItD6qUWkIcj6z1Z8K0g
Message-ID: <CAMuHMdXXR1GH7-nPmYv5i7ooB3kpqjOvY3A3vR36vYLVnv99Og@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal/drivers/rcar_gen3: Handle -ENXIO from
 optional IRQ lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Phuc,

On Tue, 11 Aug 2026 at 04:02, Bui Duc Phuc <phucduc.bui@gmail.com> wrote:
> > > -     if (rcar_gen3_thermal_request_irqs(priv, pdev))
> > > +     ret = rcar_gen3_thermal_request_irqs(priv, pdev);
> > > +     if (ret == -ENXIO)
> > >               priv->ops.set_trips = NULL;
> > > +     else if (ret)
> > > +             return ret;
> >
> > I'm not sure I like this.
> >
> > The old behavior is that for any reason we can't get the optional IRQ
> > the driver still works, but without hardware trip points.
>
> Regarding the old behavior, it was handled like this:
> ------------------------------
> irq = platform_get_irq_optional(pdev, i);
>         if (irq < 0)
>                 return irq;
> ------------------------------
> As I understand it, this is essentially the behavior of
> platform_get_irq() itself:
>
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/base/platform.c#L301

Except that platform_get_irq() prints an error message, too, which
we want to suppress.

> This could be understood as rcar-gen3 not actually supporting an optional IRQ.
> If you still want to keep the old behavior, then I think we should switch to
> platform_get_irq() instead of platform_get_irq_optional(), since using
> the latter
> could give a misleading impression that rcar-gen3 supports an optional IRQ.
>
> Incidentally, I also don't quite understand why rcar-gen2 supports an
> optional IRQ
> while rcar-gen3 does not. Is there a hardware limitation on rcar-gen3
> that requires
> the IRQ to be present, or is this just a difference in the driver
> implementation?

On R-Car Gen3, thermal has an interrupt.
On R-Car Gen4, thermal does not have an interrupt, but routes this
signal to the ECM.

> Regarding the benefit of the new behavior:
>
> If rcar-gen3 actually supports an optional IRQ, I think the benefit is
> that it reflects
> the actual state of the system. It allows the developer to know that
> something went
> wrong and investigate or fix the underlying issue. In the case of
> `-EPROBE_DEFER`,
> the benefit is even clearer, as it allows the kernel to defer the
> probe and retry it later
> when the dependency becomes available.
>
> If we silently ignore the error as we do currently, the driver may
> still be able to provide
> thermal information as you mentioned. However, can we still guarantee
> the correctness
> and safety of the system?

-EPROBE_DEFER should indeed be handled correctly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
