Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C838EECAAA1
	for <linux-pm@archiver.kernel.org>; Fri,  9 Sep 2022 08:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiIIIhX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Sep 2022 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIIIhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 04:37:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141C113C71;
        Fri,  9 Sep 2022 01:37:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D006C6601FB8;
        Fri,  9 Sep 2022 09:37:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662712635;
        bh=J4wxsmKEaXLH0SwiwOsaRMS9ekCs5JD8wxfbrPlVQq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D5w/1RjmCkMnT6fAF9pmmHWIQ/LjgYU4uzrh3L2zQrZSNM1RVaCGdGdVHLBtD02AL
         UD5cU5CMtDLqGM3za3Q+0kOxB/yamTlTVeM6GsHLUccIoazLGV415h8ECGb4LddNfa
         grQA81TfQubySLuhVbu0vyuzckPXadi13RUHdtbpe4paqeph4Q+V6vrKrazf2w0sO3
         sxfVcg5y/KTa0JAal10cCgFXoF1jWE5WzmXNiwTZzmNSC+2BpgIGvwtk6mtLxCbqy2
         zdntr6bHlb5xUenu8HHGETGGgjQRWRPQauePJmCndggkYoOUtDBM9YAy4CZwxOKpBz
         VAwzH8f8XTb2g==
Message-ID: <76d76339-a67d-2004-7c84-62203a11cb11@collabora.com>
Date:   Fri, 9 Sep 2022 10:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/4] thermal: mediatek: add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     Fabien Parent <fparent@baylibre.com>, rafael@kernel.org,
        amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220909073609.32337-1-aouledameur@baylibre.com>
 <20220909073609.32337-4-aouledameur@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220909073609.32337-4-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 09/09/22 09:36, Amjad Ouled-Ameur ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MT8365 is similar to the other SoCs supported by the driver. It has only
> one bank and 3 actual sensors that can be multiplexed. There is another
> one sensor that does not have usable data.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


