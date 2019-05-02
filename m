Return-Path: <SRS0=Sohe=TC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5750C43219
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FFC2089E
	for <linux-pm@archiver.kernel.org>; Thu,  2 May 2019 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0Riy5kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBJUv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 May 2019 05:20:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41603 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBJUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:20:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id g187so948541vsc.8
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNJVGPbOxg2kRBxh1El4wavsDt4YEPwZec1MghYKBfE=;
        b=l0Riy5kWhdImYRXC1CVWhiw5O4KQ5ybhA5LG5F07esaYKM8JoI2kqUaEEEIxJsqi1b
         eLMmRMZ1yV3qTgcw7ShHris+VR+Owy5JFqvNYHelfZDUhssvg3CALh7MMIqYDMEMSn9C
         iO+boe9FbQqRhdabtdrmuTp/9/vS9w97zcvdKP9xfSfEPZg/wq1TqVhD62fnlNztY8u4
         G7kVprA7f0k49DAtYmV4eBuWTV6AnYZeGNT87crDBe8LVZ63UJNAWEBq00Zo0X1FjlEo
         N6VPErYHpsNq8rzy93cpyuTssDmubuxhP8nnR0poF3BQMlNLGi+AG/2LpNlWolBHvyND
         wmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNJVGPbOxg2kRBxh1El4wavsDt4YEPwZec1MghYKBfE=;
        b=Pdchf22+khbCoJFki9eVGTBHk50PVwp5yGsQZa8i4uxgK2EY2v4wtvIZSO9VUYkEYF
         aGc3XQOkiBoJuLnaHO5VgayWgdT1E9NL5Y1q5Co1BiUwNEjj1VoUUON5ocZZPoRxpMVx
         mWq4gW3TRYBBgWqpv3LQz1fd1lhMP09KULtqEykpVALTyet/F8BFdS6QAH0TEhlZwaTb
         YP+AzakOJkjMbrXXguzUc6NbbqXUjEVpwilMDjvbwS9J46Fx7ore7N5w2+Saci4t2IDE
         c0VTYKoVT0jcenSUIwg7xiJ1qI0Hmuzk3sjgyWqodgvwtpE1GM7E16Wrm8AcgSW3piBz
         h+qA==
X-Gm-Message-State: APjAAAXWBTHCGyQNjtJg7IXSjPrbMAx7Oxl5w4zZyBMcJHnx3EkRb1q9
        9SeMffB9Loojq7ZZXdz3x5Ge4VUhuzexWXYSYB4IZA==
X-Google-Smtp-Source: APXvYqxQnKXvz5GVSpaYVC2i6/O/AsYV3F/wVoCaXfBXyyH/tP9MhhlIiPefmCQOHhFeClZCS7U8UrgkkEpu/XmlC8s=
X-Received: by 2002:a67:c987:: with SMTP id y7mr1345838vsk.35.1556788849949;
 Thu, 02 May 2019 02:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556636234.git.leonard.crestez@nxp.com> <8f53bef00e72aa35d146210bb71ca05b8a3af141.1556636234.git.leonard.crestez@nxp.com>
In-Reply-To: <8f53bef00e72aa35d146210bb71ca05b8a3af141.1556636234.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 May 2019 11:20:14 +0200
Message-ID:
 <CAPDyKFpx8wXS4Fn8HcfZE6RvE5vOvsrp=utKvOmuaAxEWTVxXg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] soc: imx: gpc: Use GENPD_FLAG_RPM_ALWAYS_ON for ERR009619
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190502092014.2rl-o0HFYAT5r3xTfeAw6MmbiLDSzc_RJ-7PtyKtRRA@z>

On Tue, 30 Apr 2019 at 17:06, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This allows PU domain to be turned off in suspend and save power.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index a8f1e47ce698..d9231bd3c691 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -427,14 +427,23 @@ static int imx_gpc_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "failed to init regmap: %d\n",
>                         ret);
>                 return ret;
>         }
>
> -       /* Disable PU power down in normal operation if ERR009619 is present */
> +       /*
> +        * Disable PU power down by runtime PM if ERR009619 is present.
> +        *
> +        * The PRE clock will be paused for several cycles when turning on the
> +        * PU domain LDO from power down state. If PRE is in use at that time,
> +        * the IPU/PRG cannot get the correct display data from the PRE.
> +        *
> +        * This is not a concern when the whole system enters suspend state, so
> +        * it's safe to power down PU in this case.
> +        */
>         if (of_id_data->err009619_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
> -                               GENPD_FLAG_ALWAYS_ON;
> +                               GENPD_FLAG_RPM_ALWAYS_ON;
>
>         /* Keep DISP always on if ERR006287 is present */
>         if (of_id_data->err006287_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
>                                 GENPD_FLAG_ALWAYS_ON;
> --
> 2.17.1
>
