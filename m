Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C973EE4993
	for <linux-pm@archiver.kernel.org>; Mon, 21 Aug 2023 17:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjHURPR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjHURPQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2023 13:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F19CC;
        Mon, 21 Aug 2023 10:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E897462D54;
        Mon, 21 Aug 2023 17:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B5EC433C7;
        Mon, 21 Aug 2023 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692638114;
        bh=moX1NDNRIw8jZEhzXh/VvYgaJynBFa9IjTOZmpRM6FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5rju92Kh4lU1L6z7wg4kSVd4xT8r5IdF27ap5RgXT+Wmwqn0nrXtUDMvXoUV2Nki
         VQ77gyf8z+mOXIpJrmDz/JLWHR0WmGyzsGyMx9T8bBZv824ueq3mz8Q66PwZ3LQZ6B
         gIw7B449eeVOthZaIIXXULOK4PWSlsc8SUJbuBRrNZM1klN9hmgXFJc4M+izI4sN82
         6d0O8vPFRKUxhbnQDDqNd7xGVoulVygoTeWMuu62k0vU0RiQIOlqdvIaWD+4o5Eghs
         fG+jH8Xrdf5M4vUO6nJlGaW/9ayMH8OHSGdeNscOFgcba7ZXUS9tP2sN20+81u3iyv
         EoOFuyKK3VpMQ==
Received: (nullmailer pid 1979228 invoked by uid 1000);
        Mon, 21 Aug 2023 17:15:11 -0000
Date:   Mon, 21 Aug 2023 12:15:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Dumazet <edumazet@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5/6] dt-bindings: timer: add imx7d compatible
Message-ID: <169263811048.1979170.9429510140636771779.robh@kernel.org>
References: <20230810144451.1459985-1-alexander.stein@ew.tq-group.com>
 <20230810144451.1459985-6-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144451.1459985-6-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 10 Aug 2023 16:44:50 +0200, Alexander Stein wrote:
> Currently the dtbs_check for imx6ul generates warnings like this:
> 
> ['fsl,imx7d-gpt', 'fsl,imx6sx-gpt'] is too long
> 
> The driver has no special handling for fsl,imx7d-gpt, so fsl,imx6sx-gpt is
> used. Therefore make imx7d GPT compatible to the imx6sx one to fix the
> warning.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

