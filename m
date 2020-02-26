Return-Path: <SRS0=X62Z=4O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9686AC4BA09
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671E124656
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmu0ChZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgBZCLq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:11:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37291 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgBZCLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 21:11:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id q84so1467184oic.4
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 18:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u/uS1fMpbXSukMymnz41XCHPdcIu8TO2CU/VdEdie8=;
        b=lmu0ChZ/FgDPtQGlWK6Rbqd83+DdMZgjE5nbcUq4IGpNTsD1zkXL2dTUlxIJN5wILC
         06IuFW1ag+mdNilLpWx4948QwaoOg+eafZlc4nYzd97PXBHBe2ccQGB9u9v9sRPg/WsS
         JSQxqVPzW61PyEO6v9vaWT5OAzh8uOwzYvZ9u1aXXQKwq+mOW5yHe+luKixTmR3CIyHz
         LAvVan4VZ03VO6CVX1DbeqA8Corv8uE5bncIuqrIVp4wvUEGUPZvb8/42RPdm1IWAGWL
         d5cEok/AA0bnc9KzhZK86HIdWB7c49mruzHN1N+O6wNtDhrqrEFI9AeQzIB6SadDtIxz
         //oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u/uS1fMpbXSukMymnz41XCHPdcIu8TO2CU/VdEdie8=;
        b=hxCYN5H49JWi6rS2OhscO3Qby0dRCKUyQ9lkct8eTOBDnkzG3b7MIsD8ou8swAH36F
         Ulh1Obot0frveN8KISeH3WtWZz6j84MBOg+3e/Ug0lxHfd7aNwqTZZRHTTR6hSF5SbxU
         OwTF+W2EVh7lq5N61PUgQ4cseHxBCUdE4/tXMgklljTJeeJcPkl4ueR3pz60nH5Msezg
         egmz/01qpgwi2XfVW1KvuhOzCZayBtocstdkzBEzW0U7awN1GzdPvI3tbS4JB6IpCs+X
         M+gmI1eQSFcpuaAEgvhzn/ETa/7O3cy2mSY+JUEOVRMuPbUU8I5PXi/BuRReNQmxAKA2
         O/fA==
X-Gm-Message-State: APjAAAVQrIyAPGT6eecOzqO1okSFVj63Hjw1vUY0dWaIQHn/zfyRwP42
        sSoYyhetT0D1vyb/YFGCzJs8RgqYotmusiBhqzJ7SQ==
X-Google-Smtp-Source: APXvYqzZdInnLy1DDni0f4aafChdUAgr22n+6IwChbEzWLmta8PK1dpLF7BWtYyYmXpKRVxz5b8I4y474iMM/AQarqA=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr1441788oih.30.1582683105454;
 Tue, 25 Feb 2020 18:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org> <20200225050828.56458-4-john.stultz@linaro.org>
In-Reply-To: <20200225050828.56458-4-john.stultz@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 25 Feb 2020 18:11:09 -0800
Message-ID: <CAGETcx_x4O_M4OJvCSZNu_wroYoyog9nAW7OivS56qzEhFmnHg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sending again because of accidental HTML email.

On Mon, Feb 24, 2020 at 9:08 PM John Stultz <john.stultz@linaro.org> wrote:
>
> With the earlier sanity fixes to
> driver_deferred_probe_check_state() it should be usable for the
> pinctrl logic here.
>
> So tweak the logic to use driver_deferred_probe_check_state()
> instead of driver_deferred_probe_check_state_continue()
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/pinctrl/devicetree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index 9357f7c46cf3..1ed20ac2243f 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
>                 np_pctldev = of_get_next_parent(np_pctldev);
>                 if (!np_pctldev || of_node_is_root(np_pctldev)) {
>                         of_node_put(np_pctldev);
> +                       ret = driver_deferred_probe_check_state(p->dev);
>                         /* keep deferring if modules are enabled unless we've timed out */
> -                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> -                               return driver_deferred_probe_check_state_continue(p->dev);
> -
> -                       return driver_deferred_probe_check_state(p->dev);
> +                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&

Is this IS_ENABLED(CONFIG_MODULES) still necessary? At the end of this
series, doesn't driver_deferred_probe_check_state() already return
-EPROBE_DEFER if modules are enabled and timeout hasn't happened?

-Saravana

> +                           (ret == -ENODEV))
> +                               ret = -EPROBE_DEFER;
> +                       return ret;
>                 }
>                 /* If we're creating a hog we can use the passed pctldev */
>                 if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
> --
> 2.17.1
>
