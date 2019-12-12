Return-Path: <SRS0=HhKR=2C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85BAC2D0C9
	for <linux-pm@archiver.kernel.org>; Thu, 12 Dec 2019 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5C2173E
	for <linux-pm@archiver.kernel.org>; Thu, 12 Dec 2019 23:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8NY5D0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfLLXqV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:46:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbfLLXqU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 18:46:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so337113pfn.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eIHQNr9eba5L4XlIbOyWJRxI2gHfserq4iuA29IFaDM=;
        b=X8NY5D0iToa7JChnlhDAEszCIxTzy3LeWj/cfBf7BkV8CYiBtUDe0n81/4Gs32p8ai
         wl+gKwVYoOCPR/C1Q0o8ibrQett7r8j3amhvEjrlim8MYysj3YsObaDwTuD1EQeddqbc
         qfro0Tk+k3ZN4+MYsTiR5ECdbZGpWUBMB7A4VCGFV/Ku8wvYMmZGCmzWqxZ3z+ysaOc/
         ij/ms0WrKYveYecgTzJE4830I3L1LUDmFY5Dxq37WZ+KepfZW3h5LzWTp1iu8PiZ4W9a
         UuKaTJjjdUAFfirNmhXU7vnFVev0Jh9gYV4t2bRrHaLCTdKFfwXA6EXf63Sw4nbgSN9Q
         ejrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIHQNr9eba5L4XlIbOyWJRxI2gHfserq4iuA29IFaDM=;
        b=Xrpkd5bJx5f2Dwa1hCncAu/dXyNG0UPWt04RRY/ZyuD0lE01w9/O2DFa7LvSg7G/dn
         MstQtHkZ+r5Vri2mRKtMR7sWtpJwg2xXp2ct2SwxYcSvfxYOqhk0jXNqlYF5ZPfVM68d
         JoTCysjH4EQXZRgPB6BnyrkLRnH0Umi86mI3mlgU7/dd9drSxjFyTgWWReSbOWLlE1I0
         RzZBDwfLg2hFfQW+uV2vYv9GV9akIV/kzUJuPdoEnVDVMHLW8zWodXbqLp1fc1GyEPv6
         GGCp4eixmnkxukRjyh7SH5htgPshRdeBw5duBMGJS7p5ysYIYqMMZ4osfx4oAuGrRB0x
         hk/w==
X-Gm-Message-State: APjAAAVrBCE441wQcS0nvGTQNMdG0f71mYXnN60O4WrDgzhVnMPnfDTW
        UjjYhPKMSA2e/kmr0rlpdIKiIA==
X-Google-Smtp-Source: APXvYqyUAxx1/zJ6on6c1Dj9UNuN3zylY3ZgaoNYxmxea1rF+cz0ibCIgbQEAcmHbeEwobHtnzm+/Q==
X-Received: by 2002:a63:f814:: with SMTP id n20mr13440185pgh.318.1576194380117;
        Thu, 12 Dec 2019 15:46:20 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v16sm8442495pfn.77.2019.12.12.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:46:19 -0800 (PST)
Date:   Thu, 12 Dec 2019 15:46:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, swboyd@chromium.org, stephan@gerhold.net,
        olof@lixom.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] drivers: thermal: tsens: Work with old DTBs
Message-ID: <20191212234617.GS3143381@builder>
References: <cover.1576146898.git.amit.kucheria@linaro.org>
 <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea3317c5d793db312064d68b261ad420a4a81b1.1576146898.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 12 Dec 02:38 PST 2019, Amit Kucheria wrote:

> In order for the old DTBs to continue working, the new interrupt code
> must not return an error if interrupts are not defined. Don't return an
> error in case of -ENXIO.
> 
> Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/thermal/qcom/tsens.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 015e7d2015985..0e7cf52369326 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -110,6 +110,9 @@ static int tsens_register(struct tsens_priv *priv)
>  	irq = platform_get_irq_byname(pdev, "uplow");
>  	if (irq < 0) {
>  		ret = irq;
> +		/* For old DTs with no IRQ defined */
> +		if (irq == -ENXIO)
> +			ret = 0;
>  		goto err_put_device;
>  	}
>  
> -- 
> 2.20.1
> 
