Return-Path: <SRS0=sttx=DX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B0C433E7
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2220020848
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602863045;
	bh=V/U0kmweRArX1Zo/xyo3xmtjuE9JUMprHVBfe1Zea9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xbsg/zn0vq1DgW1SOb/PP8MqaOzgJW+HYK+5wL07xJ/JecdXFCzwiDCvXHIKdMoNS
	 AqC6akEYv8U/GSRXG0h8AQurzYzy1RfwYeEmCRkhU6JdEosRzZC6ANl2uoz3q3eEIx
	 VbRc85+F7nQWIkFNAisULels8xCfcagkA912F/NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408651AbgJPPoE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:44:04 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38463 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408459AbgJPPoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:44:04 -0400
Received: by mail-oo1-f67.google.com with SMTP id v123so713473ooa.5
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 08:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iE3PKDmOmeMra+Aw0jRHwZaBoymOOPVw1ZgEb7gnK1U=;
        b=Ioy15VmscHbG4fw9oG+FqmebPW2r09yHLd5r52ZRaRqRaj6gL3RKymBaoJnVhtG57R
         hfIb8SLjXpeqXEuZuxFVvA4xkpjLTj1Y3cZ/wsrleBRLcZcuCA1G75xB0ePrN6w7X701
         0LnU84KEjEMDihUPYW1Qa2vFAxj26DcHKzhhTCbFFrbo2nXaMkcyWSIAJgxhu/U6lCok
         ZTl+y2ndf0x2VXiag5xCUwWMi/ZbNHzBOvnCuC3BE0iR4MCjz2nMGXoU+jgJDGtvr6rS
         pQDu0vce0hQa/u8I9unfXgY1+pgBOyY5XBXUdNAloSSPrtd7ESRaxD+LAIJk1CdMYjUH
         8yRQ==
X-Gm-Message-State: AOAM5323UhQzwifBvoLre11dqcbmAGGE1PAgGDw8gMoyyfzp+PRGNcqi
        rKD68B5XcFMrXk6IjjYdYQx6H1F3WGJPsuCEnDo=
X-Google-Smtp-Source: ABdhPJxgKtP75kj/wh6bb7N2cpxWBmpZpR9PCOO3nrRoM0HFVaejqir89Aw5UMrw+Q9JAdSCtiECb2t0ab3FMuT69Q4=
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr3215587oov.2.1602863042054;
 Fri, 16 Oct 2020 08:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201013141459.28599-1-geert+renesas@glider.be>
In-Reply-To: <20201013141459.28599-1-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:43:51 +0200
Message-ID: <CAJZ5v0i_auNJh2XEAYf8b84NCNMMa98_TFB0rGsnMihL-UYUcQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Domains: Add curly braces to delimit comment +
 statement block
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 4:15 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There is not strict need to group a comment and a single statement in an
> if block, as comments are stripped by the pre-processor.  However,
> adding curly braces does make the code easier to read, and may avoid
> mistakes when changing the code later.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 05bb4d4401b26e44..f4a28c33fafa03b2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1270,13 +1270,14 @@ static int genpd_restore_noirq(struct device *dev)
>          * first time for the given domain in the present cycle.
>          */
>         genpd_lock(genpd);
> -       if (genpd->suspended_count++ == 0)
> +       if (genpd->suspended_count++ == 0) {
>                 /*
>                  * The boot kernel might put the domain into arbitrary state,
>                  * so make it appear as powered off to genpd_sync_power_on(),
>                  * so that it tries to power it on in case it was really off.
>                  */
>                 genpd->status = GENPD_STATE_OFF;
> +       }
>
>         genpd_sync_power_on(genpd, true, 0);
>         genpd_unlock(genpd);
> --

Applied as 5.10-rc material with the Ulf's ACK, thanks!
