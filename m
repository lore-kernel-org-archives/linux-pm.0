Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87CEB64D8
	for <linux-pm@archiver.kernel.org>; Fri, 16 Jun 2023 17:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFPRk7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Jun 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFPRk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 13:40:59 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FF52D4C;
        Fri, 16 Jun 2023 10:40:58 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98273ae42d0so29556666b.0;
        Fri, 16 Jun 2023 10:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686937256; x=1689529256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zb2fdCvlXEJFveb4hOYKT1MsVDEIuHPNbjf8DIi/xM=;
        b=eWrk+FAShktJ4aeS4QdZLuv3vi3UzTJXW2EzKtAzsGdzYlURrrZdxnfmBzf+5BXxa1
         rPf+HVesnH9qZbdzV1Q4cWB6jH31c4lhhUBfIqqBVJFleuN3Wme+lFqHeHsOoDBXHG6s
         ocB7lnSQsUiIxs5/s0n3xgKO0YNTUSfiDWiQ/kgjgj5fBx9ftR/bD01sdaY//fcj3nJG
         taq83Xgprem4cweHbR6jL/ijtSqDV3n8utj2A242GNI0Ecr9kpHybrEKPaVDxOC4YbV+
         65irO0UJ0Q2SaoM1BbHtonKq+y7qgBe79Msk6XB/7bcGVtxAhW+QBkrMjmNoS1tD2P3q
         jv5Q==
X-Gm-Message-State: AC+VfDyxNPomlERb5yxIlidQlPW1WtIzy8eFGNu6hLA/XLjYPJkTl6Ac
        bVYmC9CaFAdJGXuEOnIT6b0Vqmri7wiYpWVhgl0J74VC
X-Google-Smtp-Source: ACHHUZ7DCJcQBWoiJshIQx0/iXWzL53rwc3n/l/z55JtJ7q8MN7zln4I5gTZdrI84PakCd89MuGMvbXCRBE4Y9cvVM8=
X-Received: by 2002:a17:906:4c:b0:987:2c00:edd0 with SMTP id
 12-20020a170906004c00b009872c00edd0mr61261ejg.6.1686937256452; Fri, 16 Jun
 2023 10:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530095536.61907-1-ulf.hansson@linaro.org>
In-Reply-To: <20230530095536.61907-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:40:45 +0200
Message-ID: <CAJZ5v0i8kW=xY8dhn+N5AdT77xD7gDUtTFyfkYdkLpSBAwkzHQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Move the verification of in-params from genpd_add_device()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 30, 2023 at 11:55 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The commit f38d1a6d0025 ("PM: domains: Allocate governor data dynamically
> based on a genpd governor") started to use the in-parameters in
> genpd_add_device(), without first doing a verification of them.
>
> This isn't really a big problem, as most callers do a verification already.
> Therefore, let's drop the verification from genpd_add_device() and make
> sure all the callers take care of it instead.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: f38d1a6d0025 ("PM: domains: Allocate governor data dynamically based on a genpd governor")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 51b9d4eaab5e..5cb2023581d4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1632,9 +1632,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
> -               return -EINVAL;
> -
>         gpd_data = genpd_alloc_dev_data(dev, gd);
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
> @@ -1676,6 +1673,9 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  {
>         int ret;
>
> +       if (!genpd || !dev)
> +               return -EINVAL;
> +
>         mutex_lock(&gpd_list_lock);
>         ret = genpd_add_device(genpd, dev, dev);
>         mutex_unlock(&gpd_list_lock);
> @@ -2523,6 +2523,9 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
>         struct generic_pm_domain *genpd;
>         int ret;
>
> +       if (!dev)
> +               return -EINVAL;
> +
>         mutex_lock(&gpd_list_lock);
>
>         genpd = genpd_get_from_provider(genpdspec);
> --

Applied as 6.5 material, thanks!
