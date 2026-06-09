Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D33FADED
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002454; cv=none; b=mVGZgU18qd1RCFS9qwsHML/Tsi3hY9aWFV0J+PrscyRJS4VRpb+3rbJMwxQOkwAFkXUujvqf/1WXE/2XAOEdqv7Mu9phUTxIFC87ePOZ4ZGJnA/0r4hXX/VwvhxMTPNmzskDfF8ZFvT/X4K8XnSYtUkzbBiApml8sU4QdYUJwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002454; c=relaxed/simple;
	bh=hyxfqnMe5Ouf/EapDGIc9svZB0EABhylZgVnmg8WXeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1GMoNeJiWjmyGtsTFrzXRec7eDMSgdtokmNriBb+16sjCuo631/LcrzvRgJbuq5w19GM8bjlx3vdGI2sK6DXWvdXTT/+3zkZMxGu+6Az/uZ8z/q9SAaS5AimHAcjADxyqsuHlHxPGrl0j2A3H0hkTMieEZ0bRxU7CPu2B00Jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59d4aa96ef2so3793744e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002452; x=1781607252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI/ZYzohNaVdjObivz2HUaUTbbz4NQJssGLJM9gQD3U=;
        b=P/dUb4z0AUQ9QKEwo+BpeIB0AQz3/MPbFRC1g6TNqx85aE/Qnvy3fFtmY22c6kPV4H
         yjveIDjJu+zUhRLYGscRyvboCBX5b2vMn/hbjuyqn+x7r8lJi4tvbByRRA79a7P0XJrv
         JOl5Uj2dHF6rWrfxUIXRXjxQA9t84M4RbwHHhPJd/D5ZhY3nnHrkSFbp79yeTOeQCCzg
         jb8yKp9IyEZjwYQqggm+MGf0Yg3rX2Z7mBhD5+cCJ4wJFul0ND9gXFi9fGvg/GGMT6rN
         oejaVhl+SQbRnB3O/eQfUpRed0zVT8KLH9kTEv5PMbued9jy5BnuSl+KmCpmNk30wKg5
         Wm6Q==
X-Forwarded-Encrypted: i=1; AFNElJ86IPpCik8PyRLDdoMQ/oDnPDvnsk41S5nXs5JPL8yPG5iEDEACvYVgQPesw3yGSiMAHrUb898lNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD0RQ1pw8t7ZkVrr8xwy1Ui+kMKaXtZ2DD7FXrPxWh/3ipMYe
	cx7JScgAiejyDjWr/0uCjajoQupUIdC5STRytjmGoEyJUMdjU/JXINgFg6Hg6nCtofk=
X-Gm-Gg: Acq92OHLfKoTQ8wwFwmzOm9gUjzg2D/jIoNQIwQ5VNaJ5oenT7ZKUFXemFnr3N1YF60
	F4L2PSVkDLoRyQvtOUjse3PSHxOgW4opPtzB8LTcifClKUh9qJg04/4/ZBil3mE5NKi/YXJULoK
	xrv+weEV6iHNeh88edQQLv2hTml19NPYE7fNssX0uRbVagHvDY1GWM/vUn63HkC1eg+8Nkb5c+L
	0+Zi7whyzt+qDuDGnNlUUXdXrzaUTURrF6vKNPLXGrxGUqNZocklbg9YwNNGAaWVooh1a6/9xz9
	vrKMc9T2fJNm/+7pypPHlLUUKc9keytON5I0YIxyH/1czrpROZWjv9jmkX6nuniGUFvYYyWJ0Cc
	wuRqa6IX5OrkNS1Dsm7+ywXq6IOU4F+ZJbk1RXvh4HPzvdpi1ZpMQakT01WAO/bc3/vtQupxEXL
	BV1FGK0J1QGlGT+N6/7YlcNTqfWFMqjyGTl7AABy0RAigsFJVb+0He0rts5W1hpaWyUn8+/Xw=
X-Received: by 2002:a05:6122:e445:b0:5a4:b637:286f with SMTP id 71dfb90a1353d-5ac534ced38mr9523841e0c.12.1781002452127;
        Tue, 09 Jun 2026 03:54:12 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6413983sm16287577e0c.1.2026.06.09.03.54.10
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:54:10 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so3365099137.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 03:54:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++S8adyws4WqV1FL8O4EQPsyuiI480AUnkdXq3bp+eSUDuL3rTrDUzepjt/LHVkhh/MOqnxm7iBg==@vger.kernel.org
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6fefa23308cmr9810049137.20.1781002449956; Tue, 09 Jun 2026
 03:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424104050.2617041-1-johan@kernel.org>
In-Reply-To: <20260424104050.2617041-1-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 12:53:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com>
X-Gm-Features: AVVi8CetX8T8pmOMrkxApWhVJ-6xKFmHvEBHTn3nlMEVF0vLCRTeJQ-YaR22GmU
Message-ID: <CAMuHMdUHabMGJyJ7e7yp7DLC+JJc9k6NK9p4anj2wRKNuwZUng@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Fri, 24 Apr 2026 at 12:41, Johan Hovold <johan@kernel.org> wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly if a device that lacks a release function is
> ever freed.
>
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Thanks for your patch, which is now commit a96e40f4afdcb52a
("pmdomain: core: switch to dynamic root device") in pmdomain/next.
On e.g. R-Car H1, R-Car M2-W, and R-Car H3, this causes scary messages
when systemd-journald.service is started:

    synth uevent: /always-on: failed to send uevent
    genpd_provider always-on: uevent: failed to send synthetic uevent: -22
    synth uevent: /ca15-cpu0: failed to send uevent
    genpd_provider ca15-cpu0: uevent: failed to send synthetic uevent: -22
    [...]

Reverting the commit fixes the issue.

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -33,9 +33,7 @@ static const struct bus_type genpd_provider_bus_type = {
>  };
>
>  /* The parent for genpd_provider devices. */
> -static struct device genpd_provider_bus = {
> -       .init_name = "genpd_provider",
> -};
> +static struct device *genpd_provider_bus;
>
>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>
> @@ -2325,7 +2323,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
>         device_initialize(&genpd->dev);
>         genpd->dev.release = genpd_provider_release;
>         genpd->dev.bus = &genpd_provider_bus_type;
> -       genpd->dev.parent = &genpd_provider_bus;
> +       genpd->dev.parent = genpd_provider_bus;
>
>         if (!genpd_is_dev_name_fw(genpd)) {
>                 dev_set_name(&genpd->dev, "%s", genpd->name);
> @@ -3567,11 +3565,9 @@ static int __init genpd_bus_init(void)
>  {
>         int ret;
>
> -       ret = device_register(&genpd_provider_bus);
> -       if (ret) {
> -               put_device(&genpd_provider_bus);
> -               return ret;
> -       }
> +       genpd_provider_bus = root_device_register("genpd_provider");
> +       if (IS_ERR(genpd_provider_bus))
> +               return PTR_ERR(genpd_provider_bus);
>
>         ret = bus_register(&genpd_provider_bus_type);
>         if (ret)
> @@ -3593,7 +3589,7 @@ static int __init genpd_bus_init(void)
>  err_prov_bus:
>         bus_unregister(&genpd_provider_bus_type);
>  err_dev:
> -       device_unregister(&genpd_provider_bus);
> +       root_device_unregister(genpd_provider_bus);
>         return ret;
>  }
>  core_initcall(genpd_bus_init);

Apparently this is done too late for drivers/pmdomain/renesas/rcar-sysc.c,
which registers PM domains from an early_initcall().  Doing all work in
rcar-sysc.c from the postcore_initcall() is not an option, as the
CPU power domains are needed for secondary CPU startup on R-Car H1.

Note that R-Car Gen4 is not affected, as it uses rcar-gen4-sysc.c
instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
