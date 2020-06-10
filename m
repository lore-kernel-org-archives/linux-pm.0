Return-Path: <SRS0=jqOB=7X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E0C433E3
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8332C20812
	for <linux-pm@archiver.kernel.org>; Wed, 10 Jun 2020 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eocK2D5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgFJJqz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgFJJqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 05:46:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C8C03E96F
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:46:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a9so1655917ljn.6
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veq+9NOWY9jhOHWHfiSDBHJjCR3y8kFCK6ZQ7IkSXyU=;
        b=eocK2D5fg8ysvRo0qAQELuhikgf34yW+RuZF/BmE2TJGjRV13nf2A6HeCRQ7FKHtuV
         EDzYm0aR2R7QwSPASpqa3kqqk7z3M795lh6Sc0eTTAWV6bhE8QwyFwI90ilpCJFDLNmo
         9RDWqA0YMEI35jjTBJZ4R3ptB8+HE2ImnV2X3kB71j9vTfu46Y9wSLBHALV0ZcqyAi1b
         Xz065zwjZ4t0HfcIPOPx5uPrZB5kcfCI899S3wNso0KrO/SEbFORlAcVKQPiUYSmtw10
         gI65A0Y5V0m2FfCdbDp+WkVNAAMC+9pXmSmvDmJlcVgOmWn+o61dioIjkcYQ3JOMCBKQ
         gvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veq+9NOWY9jhOHWHfiSDBHJjCR3y8kFCK6ZQ7IkSXyU=;
        b=agzs7nF4oDL90AaThrJu7dp61gh1kCGRrS5yM2a7RA1otzW1586yuz2Lfaooqb7pJp
         IMGCZJUM5ZO6etDzFiDKLsajCe5YT+7bpm1saFAyX8NWCwsQG1krtBUeDZocFPJrIHVt
         IZDZCo399WpyIl7I4WqDm1kNnuaXLMfRwaRIkDS53pC8gpmtPLpPHEesN/us9ZZYTwuZ
         6FXICOcL4E0LnKl8NDFHCfdmrSCcoE49Oyv8jm78qlzBhH4tLwCOkNssOMs2KHtC0A/m
         H8rv/UzNaGlUr+F//TpuCR3k6lMYtw5kUNtaYwr5SambuZl4g4Nxcizexw17fpJdoIXq
         nzXA==
X-Gm-Message-State: AOAM530Y0EiHvSY+wiQZdV8L8vegK5Lmydun4y9VHUdDPuBLPDX7CpWC
        UTlZDtRHwn+9cYvo5HbHnn+xU/QInQf6VBtlLwk1dQ==
X-Google-Smtp-Source: ABdhPJx6ZhHz1m36PS68+yVtfRWfuYn7CcqJNRHrV/4hYK/YvqbJYUu3WP3KpaP9b+35/qNyI+xerrZ0ItZHfnFCHbQ=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr1351794ljj.283.1591782410483;
 Wed, 10 Jun 2020 02:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-4-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-4-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:46:39 +0200
Message-ID: <CACRpkdazmx7g9_gc4daqivUmM7HpR20k0HVeiGW=PaZVwDq7xQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/6] power: supply: gpio-charger: add
 charge-current-limit feature
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Add new charge-current-limit feature to gpio-charger.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

That's really neat and useful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
