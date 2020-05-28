Return-Path: <SRS0=p2W0=7K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD3C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 22:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9D208B8
	for <linux-pm@archiver.kernel.org>; Thu, 28 May 2020 22:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjlvqeKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437212AbgE1Wd6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 May 2020 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437209AbgE1Wd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 18:33:57 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B55C08C5C7
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 15:33:56 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id k3so108708ual.8
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2020 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJwhQE9HCeUTmiQtOiXxx9Sh1XueYzXHCo6Y9/1H83Q=;
        b=SjlvqeKViVGc7aOIS9eI2nhNipm1JrZGMDy/o1jRikdumEEXnkEqCW6BJ3WM9EtI0G
         EjdYq017AM9wb/eys7oQOuC/Lwd1gLpHRCxbVFKCCYonJaiV2cEGPC463oXY8ubK7OSm
         NAkzAC23S5wEIW0UyRbu2fZ5IIsFBfzsyOoDLyedSQJOGehRF2Nd7E6qEehF3W9wzhhT
         x9j5j7YlkCde71vYDiyPZ1V/OKZHrH+hKDh01IUz7SVtuZCbWfCbGMm/bhJSN6ukP1+v
         XxNEXigd6eU8E3UhcGAn2715dp/hEKKdseUw3SeXbNp50dW/MA2wnc9ZVPuyOo5uTAH7
         kQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJwhQE9HCeUTmiQtOiXxx9Sh1XueYzXHCo6Y9/1H83Q=;
        b=qxezUEmgsvJ3S3jbGuXEkEevh5mn7kFIPWk0wofmcP4PZMFqxDZUKmoF799Na/EdUD
         VYwKMZCnvDbMk3mQAZt2/K1bAt2lUiTo2lOUNEnevIHXMDOCUbgU/xEvLizyeyKexZtL
         7wOSpOcm3o6Sfiay1FHyZV06MDsCEClnuYwFLq3BtXBP7ML1BzJ4huAr1pN7vO/iu1NB
         sBVGiMEc37IV6ifqrkjW4fBbQP/0Rwzi1nZTT/i2U5yS+sGfGE2eHgkLpIp+68mxW0V/
         P9fVcObzsstRJ6+GWHKGohFyiT5xqx68G3StdK+26uD4m36u7GdZJahKnBagfgrxdxO/
         7qig==
X-Gm-Message-State: AOAM533I65XsUBhOMXh54Xn/Avv2EhQwdRVSbPEWrWxjJ+SdiPwX3B4O
        BS4TgpI5Xil/3DZ7t8KgFyE4LJ8lqESVHWxFRr5SjbDHSrQ=
X-Google-Smtp-Source: ABdhPJwklG24qC78tLiUv+OAMMw6dDxwznIIbf38X/ZwCsQtI8hzivv650mDJNKc2du4KXbfksdIAeyKB5m3lhC8GwE=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr3866432ual.15.1590705235797;
 Thu, 28 May 2020 15:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <2735489.s4WY8YHBoM@kreacher>
In-Reply-To: <2735489.s4WY8YHBoM@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 May 2020 00:33:19 +0200
Message-ID: <CAPDyKFqVfk5aH=NyinUQXywZfQzf3EcGx6BiDp7qutRPcUV7dA@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Replace pm_runtime_callbacks_present()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 May 2020 at 16:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The name of pm_runtime_callbacks_present() is confusing, because
> it suggests that the device has PM-runtime callbacks if 'true' is
> returned by that function, but in fact that may not be the case,
> so replace it with pm_runtime_has_no_callbacks() which is not
> ambiguous.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense to me, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/sysfs.c |    4 ++--
>  include/linux/pm_runtime.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -102,9 +102,9 @@ static inline bool pm_runtime_enabled(st
>         return !dev->power.disable_depth;
>  }
>
> -static inline bool pm_runtime_callbacks_present(struct device *dev)
> +static inline bool pm_runtime_has_no_callbacks(struct device *dev)
>  {
> -       return !dev->power.no_callbacks;
> +       return dev->power.no_callbacks;
>  }
>
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
> Index: linux-pm/drivers/base/power/sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/sysfs.c
> +++ linux-pm/drivers/base/power/sysfs.c
> @@ -666,7 +666,7 @@ int dpm_sysfs_add(struct device *dev)
>         if (rc)
>                 return rc;
>
> -       if (pm_runtime_callbacks_present(dev)) {
> +       if (!pm_runtime_has_no_callbacks(dev)) {
>                 rc = sysfs_merge_group(&dev->kobj, &pm_runtime_attr_group);
>                 if (rc)
>                         goto err_out;
> @@ -709,7 +709,7 @@ int dpm_sysfs_change_owner(struct device
>         if (rc)
>                 return rc;
>
> -       if (pm_runtime_callbacks_present(dev)) {
> +       if (!pm_runtime_has_no_callbacks(dev)) {
>                 rc = sysfs_group_change_owner(
>                         &dev->kobj, &pm_runtime_attr_group, kuid, kgid);
>                 if (rc)
>
>
>
