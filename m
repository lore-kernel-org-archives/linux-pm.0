Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E1CCA47B
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jun 2022 22:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbiF0WSm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiF0WSl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 18:18:41 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BED7642;
        Mon, 27 Jun 2022 15:18:41 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id a7so1893287ilj.2;
        Mon, 27 Jun 2022 15:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TinNrZwW9VbhH3StzTR7UiBzPmI2Egrn9VNHzUuDipc=;
        b=SGjviu5FM4SHUfUFTNYol31ObKxPYxXVl3YfdjhpYP78xhHwiRzIIHlq7pvzNZo/e5
         7y8VFGWv4EQESIsSV72tdiKKTva0HGxuIJu+m+r84Eqa0aWXVvSPuLWwzMj9Lq6p3s2G
         2Re0688AkJh0QiOIKZd5EdV+nvfbvlmNpyMtjqF3ws7ccehmaa8kXvshlKRM9zwcusT9
         OPyYc8BqmCGENIzSpemGDKthBVLVlf8Fllr/L3xyRHOPL/7ZZNQx8JbxcilN7UWrkyyW
         t1X1ydDXNSz9eOAjyjNdb62GdpZDyWVQfleS+qdGtRmNVi5CA+zh9GbHUQeIlL3I4z3a
         N+bA==
X-Gm-Message-State: AJIora/fl36ByvKVxqyK+9j2zgBr/r3N++IvT+A7bI7yBnpWSOZIf6l6
        3uY+SZuYmxNPAK5wiH4C6Q==
X-Google-Smtp-Source: AGRyM1uvU2Wwldp0sFih7rHmPBueA66RFAVQTQjb+le6I+JxZPEmEYOG82wWeDLq2Y/S9FZ/R//loA==
X-Received: by 2002:a92:cb0e:0:b0:2d9:224b:94f7 with SMTP id s14-20020a92cb0e000000b002d9224b94f7mr8029211ilo.44.1656368320491;
        Mon, 27 Jun 2022 15:18:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d18-20020a056602185200b00669e1a9588esm5817053ioi.43.2022.06.27.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:18:40 -0700 (PDT)
Received: (nullmailer pid 3066682 invoked by uid 1000);
        Mon, 27 Jun 2022 22:18:38 -0000
Date:   Mon, 27 Jun 2022 16:18:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marex@denx.de, robh+dt@kernel.org, kernel@pengutronix.de,
        paul.elder@ideasonboard.com, abailon@baylibre.com,
        s.hauer@pengutronix.de, linux-pm@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, aford173@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, Markus.Niebel@ew.tq-group.com,
        festevam@gmail.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        abelvesa@kernel.org, abel.vesa@nxp.com, djakov@kernel.org
Subject: Re: [PATCH V2 1/9] dt-bindings: interconnect: imx8m: Add bindings
 for imx8mp noc
Message-ID: <20220627221838.GA3066625-robh@kernel.org>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616073320.2203000-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Jun 2022 15:33:12 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
> strings.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
