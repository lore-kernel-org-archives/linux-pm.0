Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C3258EF3
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306783; cv=none; b=L/PHPjRzwW++tCCCDOOjTaid2tiPSMsqDld/bTJr/q0uJ0ADhwur/6PfZ5MbtvcVNj1X5sQG69rxFrQllRqmGv0A513NdfXVLyg6Yhl5KE9WPfQ4ZPTCY0/mvtn66mN+KXgXuNW4JjruXCprDsYZTCSgUl4GNzym45DoAMerDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306783; c=relaxed/simple;
	bh=vX50m4/9mpoS9OAgy/n0A8z7SSW5XduuDoWYLqcBObI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6JGT/B2RVqiM3mGhH0qLXvFCGAPaKQ+XYGk7yJVrtZAwd7cGs090svl+fdVkkilUxjoenZ/xRCxAvvYKL7/AGM/fmHKcamR7w8T2q5qzNZxCeaYnbBwrCTnyISSlfGeugQLFXUwnbLIh9W3nn9BLFPm/QkU/sE3DkHJrQfUSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59d541955f8so377911e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782306782; x=1782911582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVDJhQYbmltFvjjEnnmNhAk+/lIL15u/vSuc+udanW0=;
        b=q6YLxH55bT132u9SUEmZEcWgBSJq+ZiCv1RZE1ZkMfWJWqbOCUZGPdSD9MQJ8ZKXjk
         Tnjlfd67lGB7hwTQMDfsw9d9pPgPH02dC1lR39FQ0ztljXBCb694J3Qj4lPDeOmUb2tl
         KiA2RlM2l4sFKo6hR0TXN0ZeR/iGRhtgy9kXstB5ejMfFlCzmEa1kxKG83vzODJOANGE
         TywovGIpG01scic6DZjD+txcNXV6vU86evJyVqmlzyTEcwHVy95p6zfrx70g/cpZEU7/
         RovcGbTwFGpfQ2eYir0QHdJlKBdYnY5QHQ3UKVX8a36dxOKuuIExKzJKnzOJR9h8JZE5
         40Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6tkaG0FvguuIevdPfSChMi7XlCMoP5uxm0zv1lPwyL+G2PBEH6Wz+EmHzDAGfJMazqLAKRxfZMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJriOujZySLHq9+x3yyK0tnKIv8QKXHxC6rTgsVK2B8Lb3pxd
	EPfjFj1Dqe/wj7JAm5BGWYIGJiWKQyp4CLRXyhsoPy0GxwgWczw0PQiyBDuDupRk
X-Gm-Gg: AfdE7clhRBBaYB6umekGbr28xXyN4rK57/+yFiPBWT5vrF2M2qbmL+BzCQI3uDLpMG+
	kX5yaNh6mWGJaPu52g0XAyXxFPXXomegnfoq16KDSlrsk73mnGNpnmXVAVWiWMf9nNLxZv909xU
	2mKusz36ClKgjbSZTdI4FbsiPP6+Ky9abyzZLzlvqM3ClYn9RyAd2WRNBUxrT4M0cdwbuKbQhUL
	LD0g4kKo/y4sn8ITpPRHZ3Ck7HjYJPs4gonJWF4GqhC3vLoKjHFCYea92Fh9OXmihZIaaVyitxw
	wFNq41khELLkmlPhwFH1IbphTV+7t6zfAzLYC/ziV8coeB5Gj58kkdj0CyerNQ2vNzR5E97jUpJ
	Tn+D5GE4S/yvlQuvoIsobIDf4UMKWCWsRX98f+nAgCbf1oRsatBDaQBJPHAOj5urFBCLJntK0uj
	kH/+aUPd0BPj7wIcXHXgJnRwomg6jPcxzfDHGY0k04QdectCOu0A==
X-Received: by 2002:a05:6122:2a53:b0:576:c4b:460a with SMTP id 71dfb90a1353d-5bbfbd95863mr10113104e0c.8.1782306781002;
        Wed, 24 Jun 2026 06:13:01 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb890b7csm10343833e0c.7.2026.06.24.06.12.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:12:58 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-728fa2ce6f9so357511137.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:12:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpHfcm+QNe0L9YtcrnkOvYyylK9/88AxkxGkpZEZWF8/5ZvGj/nBE0b5pKtJYYi8cVZhCQvToCAvw==@vger.kernel.org
X-Received: by 2002:a05:6102:3309:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-72b671e931cmr10142508137.19.1782306778248; Wed, 24 Jun 2026
 06:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajvVfSusxZfjNxVN@stanley.mountain>
In-Reply-To: <ajvVfSusxZfjNxVN@stanley.mountain>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 15:12:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpnXGUHRNrT856RkBtsrO_So+0sxJ47cG0OihoChB+1A@mail.gmail.com>
X-Gm-Features: AVVi8Cf8LN4jqx6II-ppStxUS-9RUJFFL6cy6NRwMFT9fQRCj9ODD57bZVky9AQ
Message-ID: <CAMuHMdUpnXGUHRNrT856RkBtsrO_So+0sxJ47cG0OihoChB+1A@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/rcar: fix error checking in probe()
To: Dan Carpenter <error27@gmail.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Wed, 24 Jun 2026 at 15:03, Dan Carpenter <error27@gmail.com> wrote:
> This code accidentally calls thermal_zone_device_enable() before checking
> whether thermal_zone_device_register_with_trips() failed.  Move the call
> until later to avoid an error pointer dereference of "priv->zone".
>
> The driver works differently depending on if we are using OF thermal or
> not.  We use thermal_add_hwmon_sysfs() if we are using OF thermal and
> call thermal_zone_device_enable() if not.
>
> Moving the thermal_zone_device_enable() call is a bit cleaner as well.
> The original code used a three step process to cleanup:
> 1. Call thermal_zone_device_unregister() to cleanup.
> 2. Set priv->zone to an error pointer to preserve the error code.
> 3. Set priv->zone to NULL to avoid a second call to
>    thermal_zone_device_unregister() in the rcar_thermal_remove()
>    function.
>
> Now we can just do a direct goto error_unregister and rcar_thermal_remove()
> handles the cleanup properly.
>
> Fixes: bbcf90c0646a ("thermal: Explicitly enable non-changing thermal zone devices")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> v2: Use the correct fixes tag and re-write the check in a cleaner way.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c

> @@ -510,6 +504,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                         ret = thermal_add_hwmon_sysfs(priv->zone);
>                         if (ret)
>                                 goto error_unregister;
> +               } else {
> +                       ret = thermal_zone_device_enable(priv->zone);
> +                       if (ret)
> +                               goto error_unregister;

This error path is the same in the other branch, so it could be shared
after the if/else block.

>                 }
>
>                 rcar_thermal_irq_enable(priv);


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
