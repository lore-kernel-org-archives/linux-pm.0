Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1832EC10F12
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D875420835
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQPFvfXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDQIiw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:38:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41341 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIiw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 04:38:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id g187so13122070vsc.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxRIR85OOKmO8kLbWfk0rWWkYpo6efqqyC78d6FP60w=;
        b=mQPFvfXPHm2CgAyzXUeLmxgogkDxO6lBtNMsekeMdCI8ENmGNYBv6vCL3LXN7RoyGg
         S6Zp6kEClWFdBDaWq/+TOwXxBv6PDQi+Bqpvgw5ORUZf7G8QO8h8r20TO67e3WFrzOK2
         W4Y6SpcITh1T7VfqFzA01gcDjOLuQ+oSFPc+7u7tec06b6agLsLELeT8hIQcjt0UygBf
         DP4rKFfs/6O5MNt5nq+E1WhjEW4Fu2mMEbBYNJnvSCxD2NxcfrN2RmCV4WI6SLjv5FyN
         f7TEknDDKSVYhvNEFTPnVmMgltZNH1Oj8mpmomw/YtCs8MXrhgVuRJDRNQWlURI2F/Yp
         FuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxRIR85OOKmO8kLbWfk0rWWkYpo6efqqyC78d6FP60w=;
        b=dZ8M0hpK7ezbmOibckg/tySsaYc634lhzlRNvsiRUwWwq4elKNRpn5j3SYEvNwCh2r
         QVLFQ3Dct+1WauLD4Jb3RfSRI1sFiWKgyyL+/HeIdMS3zpSRtGjFOraaQvRFxddg9zb2
         XojYk3+69cU/Ad8R1w9B0NbwUnyqwBGShqEhcQ84xAh31UU0JAJyt/nn8+yGzY30kGMe
         ohGJ0K5eJjl1KVYT5iWOQTCa63YdXOboK1J8zPSNOk/Lqvm6OLhG7vx5woA4xFNASUMz
         dgtiwyV+zh+LVm8iXeMifwT/UHMWcO6wcTxynrgLjinMgglTegSXRdNZWzApamH57iQn
         8aPg==
X-Gm-Message-State: APjAAAV4JchsFwFAW65HuwIp8x6UhFNoRHxU7e/P0kh71N7CrAD13n8s
        SQWbJOFSW5OzvClGnos+/Fzz8Dj+weP9lyn1LUOcnw==
X-Google-Smtp-Source: APXvYqwMyeFtegD0Sd+jq06b6Tq07PJV5gS81VHUknVmKWrhy1N7/aC15LwRfNQZqr07vhxGopBlpEZkwsIa8xQ5/yc=
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr47103524vsc.172.1555490330972;
 Wed, 17 Apr 2019 01:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190416162305.24375-1-tiny.windzz@gmail.com>
In-Reply-To: <20190416162305.24375-1-tiny.windzz@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Apr 2019 10:38:14 +0200
Message-ID:
 <CAPDyKFpR6bwjUG_WtgvXJznBHcZBMOfTkj_Lb7aHPryvxC5mxQ@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: remove unnecessary unlikely()
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190417083814.ie-nkQcYMScUddvVY1tO0IcOvgJOOvZWT2rQ9_5-Yvc@z>

On Tue, 16 Apr 2019 at 18:23, Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 96a6dc9d305c..598a4e02aee1 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -391,11 +391,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         if (unlikely(!genpd->set_performance_state))
>                 return -EINVAL;
>
> -       if (unlikely(!dev->power.subsys_data ||
> -                    !dev->power.subsys_data->domain_data)) {
> -               WARN_ON(1);
> +       if (WARN_ON(!dev->power.subsys_data ||
> +                    !dev->power.subsys_data->domain_data))
>                 return -EINVAL;
> -       }
>
>         genpd_lock(genpd);
>
> --
> 2.17.0
>
