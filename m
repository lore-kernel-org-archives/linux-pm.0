Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AB3CF21B
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002995; cv=none; b=nuPIw1KHyK9uxi5IY+eX7cE75IkX346TB5USCPmqfow+G3mUOWUAh66wqFXfK/1qjkBdxGoLNaiewEL3XRFRreAkmAMpdqIYERPTAA7Ekd5Ak2vyu2Hct3wXNatMGoHt0f+9HFAsGRtfNiJ7my8F3Ftm59r6hV9FD9jIo1y/DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002995; c=relaxed/simple;
	bh=GhDmkVqz9xLk8j/r3kd6iLFuAL+7q+gHNK9WhqOKoUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn8Ax9a+SuyuHpGRlYl+EOYA1ZIZIMcWQM2zaRFn7BoLg0MbBT0PgEz71sEHs6ODWCh/xei0GZq24dWDfwEVmSEn6qON4fJ8EWh9hiyjwh8r3E0oNiRG0L1DRzbZ0TLn+wH65GTyyB/T5XmJuKhOv6d4nmIo9LVOYA/kTtby59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59e8ededf4dso3181966e0c.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002993; x=1781607793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABwH5YsbFhDWFIvQcHcNLXxsILyTTw3ghSNzBdmL3nU=;
        b=kdxOsGQ5xd69wH5slM2pZp+c52Fz2MxioMQE/Cm2dyDtC5ofN395bEDp65Hl0toWM4
         YEleJiWpppCJgOtDdFsU/OiA0yXveK/PSshEz2AvDDtXaeW5Pja2EFLGAqbWdS1NwA5b
         jLjX2A6IQLTYUFN0l9pBWILMknDm8i60s3NfwPnbWSaqqLaMUCwT/h/CkyRhoPUO9jl1
         h0x3qX2Klay4oBlQ/8+gz0I22g0hvmeWgcSqE8dv8Ou95N8yefcfzQH2wk//Sry4UllM
         Q0ofuKwWcT/nxOuDfyoOyMlNglapJrZwLNkpLmrdPeygdtV9SmJXpmX2gX8eQqg7lMvy
         Vahw==
X-Forwarded-Encrypted: i=1; AFNElJ9j029gYgmHI0BT7WetDtE7H201m4Pcc+udmjnKld1rrrKXkJs0z8ZwsG58kTsSi7mnLbWTUwkaYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDKpu0PzBefT86xvH/Kqc5vSCWvC81JRYtJmQRO+I8bB/jZen
	IVObw5EQrrNkF1egR1WIFSByUE0waQwqicUSoKPJw7BQiPs8HU9NyhH0tMCl/23Tjjk=
X-Gm-Gg: Acq92OHjXVlF4QDYFwo7EHpJAKrGEhv7+6SGAaFyonn2ZwiIakzwRBo9aTg5ZcXGxxM
	C2UyIcuevd57tymTkwIzv7kz5sUHHioC1zro2pgyxAQfktfKJ7YctPEvWAFkM61ZJluNsA3OV9W
	s8yD2LT8DvsDJn5pGyjurraca+TrDbs/+h4fd9VDKFLMWnvb1ir+ts7BVlH0PLcKyzBZQrb0s2x
	NoAmJb5DSXdbZvX8iG0knJCHfe8ZN3gPAVoyCLrRO3pzDcz5z3Sq5p9DGj+LGHEno7j/fgvgqQO
	TiDGAveXD/PV+Wo+US1nnSVmT9wu1q/1tqN6tXSs/xU+GX8aJIhFNFNzAa8TDHUCtrVzdGz2Mte
	/otqu/hjIzRIaGjdfFojC8oFv+mdzZG1ybYhPB1ySBeiEuxmhgYJAf9KnFyVKYwno2nZd4SFx1y
	RWLT9yHHm6bT/WeKfW7jMmZesu5+59Y4cmShocwSceO6IctAmGTnv7Z8WSTC5r6vfb8qeZDoU=
X-Received: by 2002:a05:6122:906:b0:56d:451b:e4dd with SMTP id 71dfb90a1353d-5ac5792009bmr8354302e0c.12.1781002945676;
        Tue, 09 Jun 2026 04:02:25 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d06a491esm16542380e0c.0.2026.06.09.04.02.25
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:02:25 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-963d7e5ffddso3196457241.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 04:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9eIDR7iB6s1Nswc4T8AavZIt6tPPMpLUneBn9EIqefV4qOmJo2gkp9s9G9fKN+xO/Hhtu7WyL/gQ==@vger.kernel.org
X-Received: by 2002:a05:6122:6e0f:b0:5ab:26f:4a42 with SMTP id
 71dfb90a1353d-5ac4d5208c3mr10293829e0c.0.1781002944871; Tue, 09 Jun 2026
 04:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424104050.2617041-1-johan@kernel.org> <CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com>
In-Reply-To: <CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 13:02:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWk+wR6V4qJ9ArN22RTKDaOtmAu9kvxN6ZOzykwAk3HUA@mail.gmail.com>
X-Gm-Features: AVVi8CcGHfQNQ_XrOeYBXFDxJS8e2DDpJwQ1JOOtUUPkG5Byv8GOXBOUnw7INDk
Message-ID: <CAMuHMdWk+wR6V4qJ9ArN22RTKDaOtmAu9kvxN6ZOzykwAk3HUA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 12:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 24 Apr 2026 at 12:41, Johan Hovold <johan@kernel.org> wrote:
> > Driver core expects devices to be dynamically allocated and will, for
> > example, complain loudly if a device that lacks a release function is
> > ever freed.
> >
> > Use root_device_register() to allocate and register the root device
> > instead of open coding using a static device.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>
> Thanks for your patch, which is now commit a96e40f4afdcb52a
> ("pmdomain: core: switch to dynamic root device") in pmdomain/next.
> On e.g. R-Car H1, R-Car M2-W, and R-Car H3, this causes scary messages
> when systemd-journald.service is started:
>
>     synth uevent: /always-on: failed to send uevent
>     genpd_provider always-on: uevent: failed to send synthetic uevent: -22
>     synth uevent: /ca15-cpu0: failed to send uevent
>     genpd_provider ca15-cpu0: uevent: failed to send synthetic uevent: -22
>     [...]

I missed that there is another set on e.g. R-Car H1 for the clock domain:

    synth uevent: /clocks: failed to send uevent
    genpd_provider clocks: uevent: failed to send synthetic uevent: -22

>
> Reverting the commit fixes the issue.
>
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -33,9 +33,7 @@ static const struct bus_type genpd_provider_bus_type = {
> >  };
> >
> >  /* The parent for genpd_provider devices. */
> > -static struct device genpd_provider_bus = {
> > -       .init_name = "genpd_provider",
> > -};
> > +static struct device *genpd_provider_bus;
> >
> >  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
> >
> > @@ -2325,7 +2323,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
> >         device_initialize(&genpd->dev);
> >         genpd->dev.release = genpd_provider_release;
> >         genpd->dev.bus = &genpd_provider_bus_type;
> > -       genpd->dev.parent = &genpd_provider_bus;
> > +       genpd->dev.parent = genpd_provider_bus;
> >
> >         if (!genpd_is_dev_name_fw(genpd)) {
> >                 dev_set_name(&genpd->dev, "%s", genpd->name);
> > @@ -3567,11 +3565,9 @@ static int __init genpd_bus_init(void)
> >  {
> >         int ret;
> >
> > -       ret = device_register(&genpd_provider_bus);
> > -       if (ret) {
> > -               put_device(&genpd_provider_bus);
> > -               return ret;
> > -       }
> > +       genpd_provider_bus = root_device_register("genpd_provider");
> > +       if (IS_ERR(genpd_provider_bus))
> > +               return PTR_ERR(genpd_provider_bus);
> >
> >         ret = bus_register(&genpd_provider_bus_type);
> >         if (ret)
> > @@ -3593,7 +3589,7 @@ static int __init genpd_bus_init(void)
> >  err_prov_bus:
> >         bus_unregister(&genpd_provider_bus_type);
> >  err_dev:
> > -       device_unregister(&genpd_provider_bus);
> > +       root_device_unregister(genpd_provider_bus);
> >         return ret;
> >  }
> >  core_initcall(genpd_bus_init);
>
> Apparently this is done too late for drivers/pmdomain/renesas/rcar-sysc.c,
> which registers PM domains from an early_initcall().  Doing all work in
> rcar-sysc.c from the postcore_initcall() is not an option, as the
> CPU power domains are needed for secondary CPU startup on R-Car H1.

Same story for cpg_mstp_add_clk_domain(), which is called from

    CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
                   r8a7778_cpg_clocks_init);
    CLK_OF_DECLARE(r8a7779_cpg_clks, "renesas,r8a7779-cpg-clocks",
                   r8a7779_cpg_clocks_init);
    CLK_OF_DECLARE(rz_cpg_clks, "renesas,rz-cpg-clocks", rz_cpg_clocks_init);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
