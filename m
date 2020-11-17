Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A96EC2D0E4
	for <linux-pm@archiver.kernel.org>; Tue, 17 Nov 2020 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4772A22447
	for <linux-pm@archiver.kernel.org>; Tue, 17 Nov 2020 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="xPgauBoU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Uayn81f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgKQTb7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:31:59 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:59010 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKQTb7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 14:31:59 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 14:31:58 EST
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 0766FC426B; Tue, 17 Nov 2020 19:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1605640941; bh=fNVLaeLK89HxXWT1t4MQYc0C+RfxRj4ffhGGgo+FdT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xPgauBoUP0hJZrqL1JzyyOOM3kwzCyBxckF/XM4xHw0QCjCiX19KeLqDmRrKuJ4Cu
         /R5Hatof4U+2LjQ5rtWjdZDX5mIZu9M89EwyawR1ab3yLoxiSumNuqzNtowuD3Y/Sb
         r8gwoy4KtastSHVkUht6x9m1/WAWegw+/3cwObjY=
Received: from g550jk.localnet (80-110-101-0.cgn.dynamic.surfer.at [80.110.101.0])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D4D12C41C4;
        Tue, 17 Nov 2020 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1605640939; bh=fNVLaeLK89HxXWT1t4MQYc0C+RfxRj4ffhGGgo+FdT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Uayn81f9Tl+iUcaN02xegWm30zMMzQ0onSzs5MMwnYc1+chO0ibSljQOYJg2psSN6
         XW1DYIpZ3S6FpIOAofLOcbSZ/Ef8yZH7rNFAVndi05fdVeONqu0oEs717Tt/39VDEN
         9StYAjC1baOyqclWUvyajPxCTQtmaGgy4vKEJZtw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-pm@vger.kernel.org, masneyb@onstation.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, saravanak@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] interconnect: qcom: msm8974: Don't boost the NoC rate during boot
Date:   Tue, 17 Nov 2020 20:22:18 +0100
Message-ID: <12664003.xQlZNtUij4@g550jk>
In-Reply-To: <20201109124512.10776-1-georgi.djakov@linaro.org>
References: <20201109124512.10776-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi

On Montag, 9. November 2020 13:45:12 CET Georgi Djakov wrote:
> It has been reported that on Fairphone 2 (msm8974-based), increasing
> the clock rate for some of the NoCs during boot may lead to hangs.
> Let's restore the original behavior and not touch the clock rate of
> any of the NoCs to fix the regression.
> 
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  drivers/interconnect/qcom/msm8974.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8974.c
> b/drivers/interconnect/qcom/msm8974.c index b6b639dad691..da68ce375a89
> 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -637,6 +637,14 @@ static int msm8974_icc_set(struct icc_node *src, struct
> icc_node *dst) return 0;
>  }
> 
> +static int msm8974_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
>  static int msm8974_icc_probe(struct platform_device *pdev)
>  {
>  	const struct msm8974_icc_desc *desc;
> @@ -690,6 +698,7 @@ static int msm8974_icc_probe(struct platform_device
> *pdev) provider->aggregate = icc_std_aggregate;
>  	provider->xlate = of_icc_xlate_onecell;
>  	provider->data = data;
> +	provider->get_bw = msm8974_get_bw;
> 
>  	ret = icc_provider_add(provider);
>  	if (ret) {

Regards
Luca


