Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23957C43334
	for <linux-pm@archiver.kernel.org>; Sat,  4 Jun 2022 00:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbiFDAO3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFDAO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 20:14:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592A58399;
        Fri,  3 Jun 2022 17:14:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CE5B6D4;
        Sat,  4 Jun 2022 02:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654301664;
        bh=i5uGvp8rnzzu5xp/HItVHeA1egCx6H0kZygEiRDU3YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oex+N+dBWYmtT2jhu2NNwjuIfQB4zLCvORTiRm8V8daKpWCX9GD17NSVUJk64Nhtc
         nmVc/9OhzCbYzT+7T9OwfLrmJn8CTXYX6dkPo1QoBeZycD7OK554OQHdGIrJWj71ar
         EL8fvIVdcUjvVzykkrTgse+8OP9MyeTdyexVjZcE=
Date:   Sat, 4 Jun 2022 03:14:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/8] interconnect: imx: fix max_node_id
Message-ID: <Ypqj278FfhmTKkNL@pendragon.ideasonboard.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601094156.3388454-4-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peng,

Thank you for the patch.

On Wed, Jun 01, 2022 at 05:41:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> max_node_id not equal to the ARRAY_SIZE of node array, need increase 1,
> otherwise xlate will fail for the last entry.
> 
> Fixes: f0d8048525d7d("interconnect: Add imx core driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/interconnect/imx/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 249ca25d1d55..3c074933ed0c 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -238,7 +238,7 @@ int imx_icc_register(struct platform_device *pdev,
>  	int ret;
>  
>  	/* icc_onecell_data is indexed by node_id, unlike nodes param */
> -	max_node_id = get_max_node_id(nodes, nodes_count);
> +	max_node_id = get_max_node_id(nodes, nodes_count) + 1;

I'd rename the max_node_id variable to num_nodes, as writing

	max_node_id = get_max_node_id(...) + 1;

looks weird.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
>  			    GFP_KERNEL);
>  	if (!data)

-- 
Regards,

Laurent Pinchart
