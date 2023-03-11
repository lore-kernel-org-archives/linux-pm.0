Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F11C6FD1C
	for <linux-pm@archiver.kernel.org>; Sat, 11 Mar 2023 18:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCKSSA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 11 Mar 2023 13:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCKSR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Mar 2023 13:17:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438E6A40
        for <linux-pm@vger.kernel.org>; Sat, 11 Mar 2023 10:17:56 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id b3mwpUM6K9PB3b3mwp6Jgv; Sat, 11 Mar 2023 19:17:54 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Mar 2023 19:17:54 +0100
X-ME-IP: 86.243.2.178
Message-ID: <641d04a3-9236-fe76-a20f-11466a01460e@wanadoo.fr>
Date:   Sat, 11 Mar 2023 19:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/23] interconnect: qcom: rpm: fix probe PM domain error
 handling
To:     johan+linaro@kernel.org
Cc:     a.swigon@samsung.com, agross@kernel.org, alim.akhtar@samsung.com,
        andersson@kernel.org, djakov@kernel.org, festevam@gmail.com,
        jonathanh@nvidia.com, kernel@pengutronix.de,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        s.hauer@pengutronix.de, s.nawrocki@samsung.com,
        shawnguo@kernel.org, stable@vger.kernel.org,
        thierry.reding@gmail.com, y.oudjana@protonmail.com
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-8-johan+linaro@kernel.org>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230201101559.15529-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le 01/02/2023 à 11:15, Johan Hovold a écrit :
> Make sure to disable clocks also in case attaching the power domain
> fails.
> 
> Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org      # 5.17
> Cc: Yassine Oudjana <y.oudjana-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
> Signed-off-by: Johan Hovold <johan+linaro-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 91778cfcbc65..da595059cafd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -498,8 +498,7 @@ int qnoc_probe(struct platform_device *pdev)
>   
>   	if (desc->has_bus_pd) {
>   		ret = dev_pm_domain_attach(dev, true);
> -		if (ret)
> -			return ret;
> +		goto err_disable_clks;

Hi,
this change looks strange because we now skip the rest of the function.

Is it really intended?


Also, should dev_pm_domain_detach() be called somewhere in the error 
handling path and remove function ?

CJ


>   	}
>   
>   	provider = &qp->provider;
> @@ -514,8 +513,7 @@ int qnoc_probe(struct platform_device *pdev)
>   	ret = icc_provider_add(provider);
>   	if (ret) {
>   		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> -		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> -		return ret;
> +		goto err_disable_clks;
>   	}
>   
>   	for (i = 0; i < num_nodes; i++) {
> @@ -550,8 +548,9 @@ int qnoc_probe(struct platform_device *pdev)
>   	return 0;
>   err:
>   	icc_nodes_remove(provider);
> -	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
>   	icc_provider_del(provider);
> +err_disable_clks:
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
>   
>   	return ret;
>   }

