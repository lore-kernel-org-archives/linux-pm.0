Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E97C41535
	for <linux-pm@archiver.kernel.org>; Mon,  4 Apr 2022 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347399AbiDDVSV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378924AbiDDQFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 12:05:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71930427D2;
        Mon,  4 Apr 2022 09:03:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFA21474;
        Mon,  4 Apr 2022 09:03:07 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6ED33F73B;
        Mon,  4 Apr 2022 09:03:06 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:03:05 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 8/8] powercap: DTPM: Check for Energy Model type
Message-ID: <YksWubveJv2ei2pp@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-9-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-9-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 21 Mar 2022 at 09:57:29 (+0000), Lukasz Luba wrote:
> The Energy Model power values might be artificial. In such case
> it's safe to bail out during the registration, since the PowerCap
> framework supports only micro-Watts.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index bca2f912d349..f5eced0842b3 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -211,7 +211,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>  		return 0;
>  
>  	pd = em_cpu_get(cpu);
> -	if (!pd)
> +	if (!pd || em_is_artificial(pd))
>  		return -EINVAL;
>  
>  	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

> -- 
> 2.17.1
> 
