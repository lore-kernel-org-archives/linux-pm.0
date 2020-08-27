Return-Path: <SRS0=43vj=CF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA74C433E2
	for <linux-pm@archiver.kernel.org>; Thu, 27 Aug 2020 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC5A2080C
	for <linux-pm@archiver.kernel.org>; Thu, 27 Aug 2020 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUyVtGY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgH0WnB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0WnA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 18:43:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF5C06121B
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 15:42:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r13so4856688ljm.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pcU9aUbUl4TsqruqjB25HWTFFDbqp5NR2RTfcoKiZA=;
        b=cUyVtGY4l+LoL3wR2SzxDMdStxapZTbtWykZgqn5aYmKeamYFI4RlnlzwgXxR5ZiLH
         XkzwGUaNNQ/Tfw3G1cY12uZLp2+65yELJ0k6aaVJ4sPiILv8buG5SG5rdmuqhfc/UVRk
         z5i/7gKqZ+EOqd0h0dVCPLG47W+bO5wffx1CCgvcF/QgZ/zX/TvuD99CT8ZNc4DauYjw
         /4dfKgH8Mexvkr/AdVyyu0OGSGUVLc6SYdfd+W9o/p1vee9uuw+cBqoQBOUztk6IlNtO
         5e/fubZ6bQJqatAAPqA8L0o+mkcn8fC6JmyJ8ddOTAx66Iy67QZWJTpI95/YWjtG3FUc
         ZBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pcU9aUbUl4TsqruqjB25HWTFFDbqp5NR2RTfcoKiZA=;
        b=STqXvZk1BGcZYCpH2ELlLw+ldP7x+lmcVn7CBQuLPUHjgwhORqOaZHS5KalraVB9ao
         pfxWsiIWM8xX7ltlUI7npuIfpd3LUjXVBZEJemlslMx7GRK4pK3KQvywTygL2eDjlWGp
         c83xwJyl1S1uXbEPjUd97C1Cs7xxo1CTzKZkUGPmapUiFAZt2EhBjAvb0T1ER516syN4
         s/aY5k4iRi9oN7bg5LlW1BLc91xYtlrrF39k49tDGZxA/9fvTdVHd1TR9TSfABCrDvdn
         dkY94+aQLA8X2/LGe3r2Zv5OYMm+ralrr5nX63x9RAL5CGJzjxfY72L71gwnCnwLNxs9
         qByA==
X-Gm-Message-State: AOAM533QuPTL061GyYB5GlgF2qIDZ03gxdvoaLYcbnxkZhsHnE8ALoax
        rW5IVvq23kwXnfbcXILugpKYwUIrmMlscmxTNpuAUA==
X-Google-Smtp-Source: ABdhPJxuq5HLMjGEaukBGNErQ2RJktB/q1HsZFR2gQYz/fssJ1HSn+vRmpdeaTizzWq+YVLPW97XMnpPvqQGTAjQhjY=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr11284682ljo.286.1598568177595;
 Thu, 27 Aug 2020 15:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200808043512.106865-1-john.stultz@linaro.org>
In-Reply-To: <20200808043512.106865-1-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 00:42:46 +0200
Message-ID: <CACRpkdbyv2=k8RqvH80hb51eH+zjvhjJTuiJtxv5JO47p5ptCg@mail.gmail.com>
Subject: Re: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state()
 evaluation since default timeout has changed
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 8, 2020 at 6:35 AM John Stultz <john.stultz@linaro.org> wrote:

> In commit bec6c0ecb243 ("pinctrl: Remove use of
> driver_deferred_probe_check_state_continue()"), we removed the
> use of driver_deferred_probe_check_state_continue() which
> effectively never returned -ETIMED_OUT, with the
> driver_deferred_probe_check_state() function that had been
> reworked to properly return ETIMED_OUT when the deferred probe
> timeout expired. Along with that change, we set the default
> timeout to 30 seconds.
>
> However, since moving the timeout to 30 seconds caused some
> issues for some users with optional dt links, we set the
> default timeout back to zero - see commit ce68929f07de ("driver
> core: Revert default driver_deferred_probe_timeout value to 0")
>
> This in essence changed the behavior of the pinctrl's usage
> of driver_deferred_probe_check_state(), as it now would return
> ETIMED_OUT by default. Thierry reported this caused problems with
> resume on tegra platforms.
>
> Thus this patch tweaks the pinctrl logic so that it behaves as
> before. If modules are enabled, we'll only return EPROBE_DEFERRED
> while we're missing drivers linked in the DT.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Rob Herring <robh@kernel.org>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

This looks sensible to me, but I'm not the best with the device core.
It'd be good to have some Greg or Rafael stamp on this.

Can we have some comments? Reviewed-by?

Yours,
Linus Walleij
