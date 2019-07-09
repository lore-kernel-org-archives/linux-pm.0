Return-Path: <SRS0=yg//=VG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015FEC606B0
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 05:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0821707
	for <linux-pm@archiver.kernel.org>; Tue,  9 Jul 2019 05:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnbG1dpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGIFoj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:44:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35737 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIFoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 01:44:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so212132otq.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EqaZJyYgM0Os8ebMGdlkWjjcPY48Zl3Ke8JX40ALnsw=;
        b=jnbG1dpqI0K+YHq/9S1CeaYEP7TPEOBIvVGhWbP/GwvHf0hUw0j7jJmO2BrWnkkr0q
         rTzbdUNc641u+BMwgQEzAAC35Xy0R1R3oHIE0W4okbM3zaEsBFkdzLQiSTh+JmMzpGGi
         umUsPNbjX7wYWsnzhnSuiCvm9txeL5ajrc6XT8gRo9J4Vj3KBidkZ6AWBzszzmDvfUnb
         0I7u4pCq6i5Nz3vCPZmBuNpeOAGJO/w0ST+jsHQs/i0W7A5thVxLvEpW6KPXYYhxadVY
         OFFDEFCWqMgujbWTVHrfsNxLcwYXRgZaO/4dZNIyI39rQ1GpQYlBsuHMJknNLH58Cs3l
         pSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EqaZJyYgM0Os8ebMGdlkWjjcPY48Zl3Ke8JX40ALnsw=;
        b=svSjSmB7QQjCQHNQmW5NRICmu2tEqTkMSx7224PpNMhD2xloYCo61wwWqfCUGRtUCl
         qp+5YYwIdNFbLjTJzXIqT9NEnQp8D7aeld/Y1khxwux/rdnDCFxAMGERcNtcFI2AEaLg
         jLcJBYncUO2sHR2Jqc/xS08Jm8ftAJx13Tp8olyxLEPPfLBTmT3w14X7GJ9mbgO7Qddx
         SpQALLC+QSq5flfdi0bUDc0FSSE9lBlmtsDuzs01g+XJ1AYAF7b6coevR53mN9kPcBcJ
         x/pGu6n8wztxWZJjR+S3I5DKrYBCxtmpemQWzWyEA2T/191x8NjW1PkPUBYf4Y3/PA8r
         nw7w==
X-Gm-Message-State: APjAAAXW7qjBmWKZgqTC25QZR/GjAmuH15fgM/Q3D591fGepvi21dzwi
        6/bdvADc7mbsPVvtNelJSwFuRrXCiQ5CBatCswNU4sTgVAs=
X-Google-Smtp-Source: APXvYqxrhFRqVKYyJq1ZhsiBjelse+AtAmo3grTsG7ZGewv362i4vAyCgqz/v7JpkkyAnIm3AsGpr09SzdI4qPyUoVc=
X-Received: by 2002:a05:6830:13c2:: with SMTP id e2mr15699382otq.123.1562651079043;
 Mon, 08 Jul 2019 22:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190708123259.11805-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190708123259.11805-1-huangfq.daxian@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 9 Jul 2019 13:44:27 +0800
Message-ID: <CAMz4kuK6FOw2bxPzyrg0014zrU57k1KhUymyTfFYV6pVfw1vdQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] power: supply: sc27xx: Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Fuqian,

On Mon, 8 Jul 2019 at 20:33, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> devm_add_action_or_reset() is introduced as a helper function which
> internally calls devm_add_action(). If devm_add_action() fails
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice)
> and reduce the likelyhood of bugs.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index 9c184d80088b..58b2970cd359 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -1023,9 +1023,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = devm_add_action(dev, sc27xx_fgu_disable, data);
> +       ret = devm_add_action_or_reset(dev, sc27xx_fgu_disable, data);
>         if (ret) {
> -               sc27xx_fgu_disable(data);
>                 dev_err(dev, "failed to add fgu disable action\n");
>                 return ret;
>         }
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
