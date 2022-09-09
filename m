Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9025ECAAD3
	for <linux-pm@archiver.kernel.org>; Fri,  9 Sep 2022 08:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIIIhM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 9 Sep 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIIIhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 04:37:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740D110A88;
        Fri,  9 Sep 2022 01:37:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B05F66601FB3;
        Fri,  9 Sep 2022 09:37:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662712624;
        bh=sUFQFPB1ZomN7xd2eFsCtP/mZPhFujgM6qQtJ4pPldY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m2CiJOwI2T/J4+wtOj/gwUevwNkJ49cTBVeYVI33A75SO2K/Z8X/12qc4+byfGehM
         rNM+x8S4QB/zsUwr4ouCVQsl1i35bBr4NYncva6qVZ0T1HfjL+GjV4d5jN7gx9+hlk
         ocgAX5gFwvF+DkBL1j+l/FdPzG/tXir7gAkkuOi5cHvW6aP6EXRJZKyuHj99b5ulTN
         TF2pK9/lXh+0TNq1BWMkW87gZaPdqvFgAKTvlFgrKas3N/8+YK1K2YvAS8bInDvTzc
         KqhiF+e0+sidAA3tV0/HankEIaYRqr5KRoUoyyFctVQsGOxE74aFtxlZKlN02GdTYK
         dY77+FHZDY77g==
Message-ID: <a3288784-18d2-c553-4a76-ddae4de3a751@collabora.com>
Date:   Fri, 9 Sep 2022 10:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 2/4] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220909073726.32423-1-aouledameur@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220909073726.32423-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 09/09/22 09:37, Amjad Ouled-Ameur ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Add logic in order to be able to turn on the control buffer on MT8365.
> This change now allows to have control buffer support for MTK_THERMAL_V1,
> and it allows to define the register offset, and mask used to enable it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Sorry for the previous reply. I got confused by a local tree.
The driver is there upstream.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


