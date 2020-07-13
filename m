Return-Path: <SRS0=gH2j=AY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04509C433E4
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB1E21473
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jul 2020 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594680899;
	bh=FMnuW3gwBpdtYA8wx79LJuuMU1bOlbQ2lktPIstEzKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bvyDkQ3obmBwuqglbUM32oWzVcB9vPMAxX0HLQeorBGhqaW2x2hpi1Yw/uN7mFUTs
	 4vjxcpvvhcDMJsQPprCSKumGoo+Sc9T8RBvoR8wi3ENBw19Vzn6Y7NryVy1sAlIOxI
	 XL9D7YJHYPSezalrs3F0vwJ8r4YufeNGozwZqgsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGMWy6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:54:58 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39590 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGMWy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 18:54:57 -0400
Received: by mail-il1-f195.google.com with SMTP id k6so12673972ili.6;
        Mon, 13 Jul 2020 15:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lx27nXKsEHDAQ3zBwCOzlK62p9t1j+kSDxv2fkLBnl0=;
        b=omMEP7ix62sxfXYmZON9ompwOwJNPJ54PXm7iQ/l02jxQVcl/DBzLjFg3ULfadJeqn
         RAvoVohi4oCVIWPfRG0BJxLmm7GTWUE+bKyJ+CqvDtk+G6XnNyiksO2NbTXJMtiPDYKy
         ncivOCPxMNbhCfoBjRsjmbUDmbOEag6BAQpvnP71ti0FudDRVkHVIwln2swv/Q5YMF1G
         1hlpd7WEWZW5E1lwjeasJg/c7UsQHxTaXQF+tFunHVCN/K9SxY7pcLVQnoWLS6drc1xH
         YMnO7fYFMLYkuGCtExs3plDnqPZs6iYmOWyTivnccKl68dtqxAVhipvdL2uJZg9SuXjE
         05gw==
X-Gm-Message-State: AOAM533rw92vFKakVDVO0Oxj4DKBtI3vlLUVbN5CsnbWzhvT0yGpz9wm
        Ejj0GN5xuT6lwEdQsti3YQ==
X-Google-Smtp-Source: ABdhPJxKGIcBl7P0g7fSqwC5X3R2fzaMf2mpBeKTxIr+o8fUnEkwxEhRcUXiVhulNMpWIs3AEYRpIg==
X-Received: by 2002:a92:58d6:: with SMTP id z83mr2086323ilf.186.1594680896394;
        Mon, 13 Jul 2020 15:54:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t5sm8807373iov.53.2020.07.13.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:54:55 -0700 (PDT)
Received: (nullmailer pid 874330 invoked by uid 1000);
        Mon, 13 Jul 2020 22:54:53 -0000
Date:   Mon, 13 Jul 2020 16:54:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     mturquette@baylibre.com, linus.walleij@linaro.org,
        clabbe@baylibre.com, liyong@allwinnertech.com,
        srinivas.kandagatla@linaro.org, icenowy@aosc.io,
        p.zabel@pengutronix.de, linux-i2c@vger.kernel.org,
        gregory.clement@bootlin.com, sboyd@kernel.org,
        amit.kucheria@verdurent.com, bage@linutronix.de,
        tglx@linutronix.de, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, anarsoul@gmail.com, megous@megous.com,
        tiny.windzz@gmail.com, lee.jones@linaro.org, rui.zhang@intel.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, mripard@kernel.org, stefan@olimex.com,
        huangshuosheng@allwinnertech.com, jason@lakedaemon.net
Subject: Re: [PATCH v3 01/16] dt-bindings: clk: sunxi-ccu: add compatible
 string for A100 CCU and R-CCU
Message-ID: <20200713225453.GA874275@bogus>
References: <20200708071942.22595-1-frank@allwinnertech.com>
 <20200708071942.22595-2-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708071942.22595-2-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 08 Jul 2020 15:19:27 +0800, Frank Lee wrote:
> This patch adds binding to a100's ccu clock and r-ccu clock.
> 
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
