Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A9C433DB
	for <linux-pm@archiver.kernel.org>; Fri, 12 Feb 2021 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D93764E76
	for <linux-pm@archiver.kernel.org>; Fri, 12 Feb 2021 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBLP5u (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:57:50 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35786 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhBLP5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 10:57:46 -0500
Received: by mail-ot1-f52.google.com with SMTP id k10so8813487otl.2;
        Fri, 12 Feb 2021 07:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSjbbaNIKklsxIEn5AtJtdKG7TrM5/PAZ+RSicaxCII=;
        b=ZjhczgzlBu32CW9IXKhdQHoiEuEA0GIEUzkLJf8jM7bb+1F0t31e+FGPt61BOZZDf2
         vYyeQLoKMhDIrcKKbDtsCc3bLdVTH4axH7t8cmKYNSmoBVwM/qPLl4ZPptkB6tMpRspP
         hxQoHEREQkid6faG4XSv+PIitHP2WcRQe3tUZRItibneRBpDsJfdxymU5ybFJEPU5ku6
         5EIBMd4ynseudM4UoUbARpTCnLft6eKEjzNd+CNEb8C6kNmos4e/iHqVdKH3X4QlGqpy
         eziupAnZTwBj8zS50ZWl1ZNq7UMI8WEjQNxEZZLM515t7e7EhxbJfucvk0x1QkbeY4Te
         Tfug==
X-Gm-Message-State: AOAM533FHWOEEzN6kH1b3w/HmcHhCbNcPfEMNiPJdK+6LdL6ne3ICQsu
        zhbOEtiGnQxBAzy2dKdV7dGHRCEClPbfHOLA7Ig=
X-Google-Smtp-Source: ABdhPJxrlmCpx7RQESMcBTpnckct/6GjNtdVIpA6+Hidss2QWym3ldzjlUJBrwRvvFayvCsrgkx/8UfBqoJJSTryaG8=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr2397056otc.260.1613145424507;
 Fri, 12 Feb 2021 07:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20210210172208.335048-1-krzk@kernel.org>
In-Reply-To: <20210210172208.335048-1-krzk@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 16:56:53 +0100
Message-ID: <CAJZ5v0jnb__EpZxMSSk5Aop3+=FXXt5+0jNfTy9G1ac4s+xTaQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: cpuidle: exynos: include header in file pattern
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 10, 2021 at 6:23 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Inclue the platform data header in Exynos cpuidle maintainer entry.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 674f42375acf..68e2b4cb4788 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4625,6 +4625,7 @@ L:        linux-samsung-soc@vger.kernel.org
>  S:     Supported
>  F:     arch/arm/mach-exynos/pm.c
>  F:     drivers/cpuidle/cpuidle-exynos.c
> +F:     include/linux/platform_data/cpuidle-exynos.h
>
>  CPUIDLE DRIVER - ARM PSCI
>  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> --

Do you want me to apply this?
