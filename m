Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB26C433E1
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379F220716
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597145497;
	bh=p32wtio7weVNEBp1zzXuw08zUK2gyCeyKmJ6OAdJXzU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sAFZOLkpGCOio9DfPbriDgFgCovzomeHtnJZ87/KUvA8917/jbBIro0rlocZd2Nn8
	 RQ9TF9m8Pr2NMgNGXgEZtV9R3NxBDbE8/wsuYn13OIult2VLRGnTSNyZwHXCEhfq2W
	 UxQkc5ztzrf5v/XDyfy1A+sEahHndGPI1XlWID6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgHKLbg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgHKLbg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 07:31:36 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180F020658;
        Tue, 11 Aug 2020 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597145495;
        bh=p32wtio7weVNEBp1zzXuw08zUK2gyCeyKmJ6OAdJXzU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hHdRSnNaGnZMkyftRrvf1+SaxKcgzK/2X2eQqJISSMYEoErpZkrEsLuZCMKNFRvNh
         1Bob9S49zn1cpSSkvIrV5shuxZhSaleCo8GDdh7CeXK5iL1cfOZD9tHCLDgeFf9YwQ
         JkOVysaoM0bXMT4GY45/mZfvmOnqModxuO4QWHN4=
Subject: Re: [PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <CGME20200807133152eucas1p1d83611a984f5c5d875192d08e2f5711f@eucas1p1.samsung.com>
 <20200807133143.22748-1-m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <2ab29b37-5e7f-1a7a-e29c-f20f95aec1a9@kernel.org>
Date:   Tue, 11 Aug 2020 13:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807133143.22748-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/7/20 15:31, Marek Szyprowski wrote:
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by calling
> clk_prepare_enable() directly from the clock provider driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Should we add a "Fixes" tag so this commit gets backported down do the 
kernels where the DMC driver was introduced?

Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422") ?

> ---
>   drivers/clk/samsung/clk-exynos5420.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fea33399a632..521cbbfc0987 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1655,6 +1655,11 @@ static void __init exynos5x_clk_init(struct device_node *np,
>   	 * main G3D clock enablement status.
>   	 */
>   	clk_prepare_enable(__clk_lookup("mout_sw_aclk_g3d"));
> +	/*
> +	 * Keep top BPLL mux enabled permanently to ensure that DRAM operates
> +	 * properly.
> +	 */
> +	clk_prepare_enable(__clk_lookup("mout_bpll"));

I'm going to apply the patch and then these two as a follow up:

https://patchwork.kernel.org/patch/11709097
https://patchwork.kernel.org/patch/11709101

