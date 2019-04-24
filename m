Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BEC282CE
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 06:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4BB20656
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 06:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="PEknDINQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfDXGvq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:51:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36038 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfDXGvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 02:51:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so13740199lfi.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2019 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y5k8Zl0aW5C267C4j/HBp5q69Gzp36YYg8rvv3NnlIo=;
        b=PEknDINQJpTKcxr0/R3I3nmMCQyoBfZ/VBea+uvb0fqIBZ7YTFhEl+648C8mWnGL3t
         CLVkuvIYKX3Be+Ebqu8zF3qcsLTuIVmWPGbin5acRFkugLbtTQElBu5+1IgQLVPBcpho
         OBGdSOW+qOeIuJg7rikCabQoc4EORnETlrCzVtfL4XAMBaOb4KeFJZepez6qaV21zZL9
         ntTMuWib1AeANgkEmY4MfEj7WNiGhF2Uk9LCe1PaDy4KQU6kyF29Xz6jabRFLkOtxO1O
         POJ0SjMIV8yR2Fe5VOR6SKliKFBbOsdjszy8Bkcog+045LR0EQbZ8ParWOb3m3BwAjYS
         WQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y5k8Zl0aW5C267C4j/HBp5q69Gzp36YYg8rvv3NnlIo=;
        b=GDQfX72OhQ3FAKctGwS4iIzFWJ/Bu9SJBHWk4UesRIsABMI/+KswwhnWmIkSFoR3OX
         kBuFfqF1Bd3tAgfX7yuc5akktHGsgml1OI2yRJqhG8yvqhpU9t1l0Q8+PEWVHcf1oLxy
         iIf2F5GS6vjjWLokqePgomkFit5QcRh3UsduzZA4hA80wbgDkI2qWG+GiSVE3N27fEfz
         oDlphanIUf/rCEBh4SAE0rf1rdXCG28Q7TLf7f14an82ggApb6vhd5fj0lhXKhQ6kzs1
         bFP3c8qFRHJuBTzRGv1ALHLHCpO5IfCr7tKR8yghLp5yZEU8XLQNNwhKuiH43J0XmFWh
         +1Dw==
X-Gm-Message-State: APjAAAVHJH+LRg4wvDxpsh2YloiiEWkroc2W/ST0YSEmKxT3vSIbcJvb
        Exp0Ru1/Kj28ZLvc9C2IwXpzCg==
X-Google-Smtp-Source: APXvYqwTWGHFt0Z9hzIOoW5N3cDb4IokKrcHceoGe4bD/GincDKNG9kFWy3rhhtW5zGfjidqhZzw4g==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr16190801lfl.67.1556088703925;
        Tue, 23 Apr 2019 23:51:43 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id e17sm3828721ljj.20.2019.04.23.23.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:51:43 -0700 (PDT)
From:   "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
X-Google-Original-From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Date:   Wed, 24 Apr 2019 08:51:42 +0200
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
        marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com,
        hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com,
        dien.pham.ry@renesas.com, biju.das@bp.renesas.com,
        erosca@de.adit-jv.com, george_davis@mentor.com,
        joshua_frkuska@mentor.com
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190424065142.GD16573@bigcity.dyn.berto.se>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424051145.23072-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424065142.aMOv6bz4vXDLFox-ngweCr40Zqi8js1PnQX6j9ITEbY@z>

Hi Jiada,

I think this series looks good. Unfortunately I'm out of office for the 
next week and are thus unable to test it. Please don't let this block 
this series but if it's still on the ML when I'm back I will do a proper 
review and test of it.

On 2019-04-24 14:11:43 +0900, Jiada Wang wrote:
> There are issues with interrupt handling in rcar_gen3_thermal driver.
> 
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> Since the irq line isn't shared between different devices,
> so the proper interrupt type flag should be IRQF_ONESHOT.
> 
> This patch-set fix these interrupt handling retated issues.
> 
> ---
> v4: remove 'spinlock_t lock'
>     add Fixes tag in ("thermal: rcar_gen3_thermal: fix interrupt type")
>     fix typos in ("thermal: rcar_gen3_thermal: disable interrupt in .remove")
> 
> v3: fix to use correct code base
>     remove unused "flag" variable in rcar_gen3_thermal_irq
> 
> v2: use irq type IRQF_ONESHOT instead of IRQF_SHARED
>     disable interrupt in .remove
> 
> v1: initial version
> 
> Jiada Wang (2):
>   thermal: rcar_gen3_thermal: fix interrupt type
>   thermal: rcar_gen3_thermal: disable interrupt in .remove
> 
>  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++----------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> -- 
> 2.19.2
> 

-- 
Regards,
Niklas Söderlund
