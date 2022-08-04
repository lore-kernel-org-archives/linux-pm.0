Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF281C25B06
	for <linux-pm@archiver.kernel.org>; Thu,  4 Aug 2022 18:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiHDSQA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Aug 2022 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiHDSP7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 14:15:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4A6573;
        Thu,  4 Aug 2022 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OauzY5NPoVxR96fxdrgvniM7lN8jaUTrviVvH2IM4yU=; b=aT1bG0pOIRzByuU5LSozgfLcvg
        yR/XAd4ZqQFMTxsjJVVFqVCxU1Hrcgg6VB+8gVCf92fpf2GuRCIESt+wh5CQo5DgCkep0zsUx4NoO
        pINKsNVn9f63uQ915yotJ/D/kZO1lNT0kgi+tpgh6ZKLrs7fkuHTjMwZMBgznCW01+jSDcUFXvPXx
        hZDDLX/Jv/92AAnEFDCekdVgOhxrs3EtBdwYE2gZyT9jIPp7i0psbIFIq/IygKr1u7wgiGaj3TgiZ
        dUNdKey6zGGYbdwDjAqghRl/UqelGLOI1B0PCNcI1aaua+r0q7ryA/igzPS9kfoP6lI2lw01RQn42
        WGMBHBcw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJfNm-0087nh-M4; Thu, 04 Aug 2022 18:15:42 +0000
Message-ID: <30e4c6a0-cd8e-5a86-ac25-ac2af5ec53dd@infradead.org>
Date:   Thu, 4 Aug 2022 11:15:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8.1, 4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-5-bchihi@baylibre.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220804130912.676043-5-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi--

On 8/4/22 06:09, bchihi@baylibre.com wrote:
> diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
> index 592c849b9fed..afef43a0e7ca 100644
> --- a/drivers/thermal/mediatek/Kconfig
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -20,4 +20,28 @@ config MTK_SOC_THERMAL
>  	  configures thermal controllers to collect temperature
>  	  via AUXADC interface.
>  
> +config MTK_LVTS_THERMAL
> +	tristate "LVTS (Low Voltage Thermal Sensor) driver for MediaTek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_CONTROLLER
> +	help
> +	  Enable this option if you want to get SoC temperature
> +	  information for MediaTek platforms. This driver configures
> +	  LVTS (Low Voltage Thermal Sensor) thermal controllers to
> +	  collect temperatures via ASIF (Analog Serial Interface).
> +
> +if MTK_LVTS_THERMAL
> +
> +config MTK_LVTS_V4
> +	tristate "LVTS V4 Thermal Driver for MediaTek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_CONTROLLER

You shouldn't need to repeat all of these "depends on" lines since this
Kconfig symbol depends on MTK_LVTS_THERMAL, which already depends on these
3 items.

Have you seen any issue that this is supposed to fix?

> +	help
> +	  Enable this option if you want to get SoC temperature
> +	  information for LVTS V4.
> +
> +endif

thanks.
-- 
~Randy
