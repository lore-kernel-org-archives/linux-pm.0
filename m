Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1A3C9EEF
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201829; cv=none; b=pthG32FBH6XhC5B9leANQYc9GZjbgbWxqoPZK7CPkeiQNDUnsDY9xqAreYrRnCJt2hag8x+OnkcmZE525VGh7ggI+GAw7sXoBXQlAiM5Fk9Ffr80aNuvSAb6K+Rp2KXXNzU2bN1sWdt3iP7HqfpRsn86whQ1NSyM67IbcfQiu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201829; c=relaxed/simple;
	bh=9/9WurOzF9dwMznlkRpWinreZjoxe94EtrhFlkOjeOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpo1p8vKGMA/XuDxIV3prfeLeZRrVEIcNT6CMxgze0FseSb3X2xY8k2rLysmiUScXK4M8yG5oq3vg49sQt9QoQcegjmBBDYWhlk+7Odbx5xAPCiiBNeE0PsTkxLPSDXugDwjJJD/E0d0ot08Z+7BZwxru4MbtVOl3g2WG+0rsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bbfc48715fso573887e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 01:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201826; x=1782806626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Wevye877SnOLln/AlwHOkqlk8j8CTpCElmFHp1hxM=;
        b=GAtsTJ1tZPGyDfsBmr/QzSVlkDax5eJSFZlOpvExuJZQDIhzMymrdEaKREI435RYd8
         CQRVYZt4S3wGjGN/geIhb57NmmL9A2i8+5bZtzlIlUxz54c/IZVkbDqtx1EzlnOc9pDK
         Xvrw7i96EE0/Ljc3lIqweds7glq1PikjTHyjFdLh7wXJ1xP+oG9tqMrlsWiU/dgKdN/v
         1HbkikRrfccSXF3W0fx4AOgmRW3fQ8p5TCQHAoXdTFGp+lHlIYoN6HP8eeVMrvlk54Do
         WPA3ho29S0Hf80oQgoW8fISu78vuzf00QwF7BcD4BOWs2ef42WKsanWdDBkDU16f6oHy
         Q8zw==
X-Forwarded-Encrypted: i=1; AFNElJ+DXvwLB2VrqhmuttXlFcK4fWjoifoy9Ssfwor8FfhihGYNWOy6ECVzUeGjJfWGMKxZVJW+Ooi9aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo31j1Dqx+KscIZe5ELyfM7cdLdCchzIapLwo8a3h4iUYPBhhH
	3lpSkEdvTBeVDbog6cZpcJO/JUzSMBLfy0pgI5GvC0LKDXkTUmZ9d93OmpKJLBd0leQ=
X-Gm-Gg: AfdE7cn1CxZHuZPtcs7mp4TFkmFlup41/55d2xL9m5lx8AQI997YAwhrdnqC+zN6dcs
	AHnCwEk6+CquT3LAwvr7axNKLzffa3jWgnxLYSwA12PTuIpA69HbxO4hU/wStTK7Q5DxYyNsO3G
	EXKnYjXyXA+ZZOEvG5D/8nn0csXsgOKtFBvlc75KC53qPYsQAVuBO1OjocjeyUkvlM337YQaVD9
	qxElyF39S7qaZd9EWXMbs39PR0Q7PMg80ywR45bePEN7trSCMTimuCC7eADoVwElsupv0Y9O/aI
	1688IFjguCciudA0PG6VWDUxJfoimecyjhMlt3Eeu7eeYEyIP9yFp5Wg9MbxOjCuV0uH/sFfHTi
	rTqQ6Z+J9eWLz1vfFA//OlbTqnzAZ0gvGdr5PLU+UkK6ticsIAVMvZLs+odC03HYaESqANNAOJZ
	aqpg45uVw6cM0R+sdqs6m/a9Bg3gWle+RUBqWG8qMuqdkDwA7Htg==
X-Received: by 2002:a05:6123:b2:b0:575:39bc:c6d9 with SMTP id 71dfb90a1353d-5bc2aca615cmr1212674e0c.3.1782201825831;
        Tue, 23 Jun 2026 01:03:45 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfba73cfdsm8631414e0c.14.2026.06.23.01.03.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 01:03:45 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96387cf6335so518675241.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 01:03:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+n5S7QdpQuilMIace5TordCZ6LsaI5x0QiyuzzXKThrr2pi7r1q3iZqgvzv6ayc02ivI9o4ucMeQ==@vger.kernel.org
X-Received: by 2002:a67:f993:0:b0:6cd:23a8:3a31 with SMTP id
 ada2fe7eead31-72f83501311mr955964137.1.1782201825012; Tue, 23 Jun 2026
 01:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajo6iQ3VWvcxedA9@stanley.mountain>
In-Reply-To: <ajo6iQ3VWvcxedA9@stanley.mountain>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jun 2026 10:03:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXkXCj7ijeQmOkK7OQSAGkYgBZJyMJoEV4i_XhamwDSQ@mail.gmail.com>
X-Gm-Features: AVVi8CdbyX-JVUOWc5no0UNDnFuGEWPAevzQbiu2OWUTSFIMBurTqmBhzrOsCSk
Message-ID: <CAMuHMdUXkXCj7ijeQmOkK7OQSAGkYgBZJyMJoEV4i_XhamwDSQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/rcar: add error checking in probe()
To: Dan Carpenter <error27@gmail.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thanks for your patch!

On Tue, 23 Jun 2026 at 09:49, Dan Carpenter <error27@gmail.com> wrote:
> The thermal_zone_device_register_with_trips() can fail for a number of
> reasons, including allocation failures.  Check for error pointers to
> avoid an error pointer dereference.
>
> Fixes: 9d617949d490 ("thermal/drivers/renesas: Group all renesas thermal drivers together")

This is not the commit you are looking for...

Fixes: bbcf90c0646ac797 ("thermal: Explicitly enable non-changing
thermal zone devices")

> Signed-off-by: Dan Carpenter <error27@gmail.com>

> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -492,6 +492,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                                 "rcar_thermal", trips, ARRAY_SIZE(trips), priv,
>                                                 &rcar_thermal_zone_ops, NULL, 0,
>                                                 idle);
> +                       if (IS_ERR(priv->zone)) {
> +                               ret = PTR_ERR(priv->zone);
> +                               priv->zone = NULL;
> +                               goto error_unregister;
> +                       }

This check is already present below (out of context), so it would be good
to avoid duplicating it.

>
>                         ret = thermal_zone_device_enable(priv->zone);
>                         if (ret) {

The issue is that this call was added before the error checking is done.
So this should be moved below instead (to the else branch of the next
chip->use_of_thermal test?).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
