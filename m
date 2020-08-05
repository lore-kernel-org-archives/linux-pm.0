Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEBEC433DF
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5512250E
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596656929;
	bh=B90v1e6ZZyfhc6xnwUhJIYkBjrZ5okO/hOKVJ2QwbsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUPhBfc4pAQcdPQ/jHTaHv8jKF/d/beLm35HPTSTi4ooZyImsu3bxix2oBLMV5AYi
	 p0FSSSpQMw5hZOil8TGj+U1h0cXNrNUV5/OOG3OSKSxOQ6qSFIVp7Y1b0ctsa272Iq
	 i2etuFDopoqj7+xZWAfr0GA3riVQ4/NXrsmSJXVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgHETsa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgHEQ4b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:56:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A156DC0D941A;
        Wed,  5 Aug 2020 08:14:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so6159905wme.0;
        Wed, 05 Aug 2020 08:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NY4cETpE+tZbeXOcxF5VTOrE6Vn7Glw4DngqEOoM7o=;
        b=HGDeRUfxjgg9Lw1XSHWsEWR9SNv6Fdj0BbpUOXoMCji9wc1Kqx3YKXxYA9nsn5j1dT
         mpaGd6bveSvrq/8YEqoYyzaKlB9YWdtdqOwIJrGbD9eBN1X+p37XxpGbjlf56D+g4XMZ
         6NHL4VKXTcJ5J13Z6MV/9fM+pkHJX13BFzAKeZKi9qKS1j6kL58j1I+42K39VcyquV9B
         MYYol3bldM0F+kpurwZS45s2T9pzwyoXsNn51kkx1SxXokvhfbT2ZcbuDFy+DMGJjNX8
         ECq32rr1bLOtlxYgfNQlsL8OO8BKm68C6BP9gfOHT0tLfqXDQEkdtS0peE6+mT5x26cX
         Iinw==
X-Gm-Message-State: AOAM532gAB/1b5Bti1PYfX1riNtIvQGj/u04CDkdAvjs4qQzBV8+J0xH
        chK+jpOsx4+RpztYIcrNQ5PXurystdo=
X-Google-Smtp-Source: ABdhPJzOCKjcIrNX/wbT4dyw20wnSgtHhzNB/LC28frRr/pwBiTKtN/9dYEeDRtDsjtj55+uHTjYnw==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2690613wmc.130.1596625023972;
        Wed, 05 Aug 2020 03:57:03 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id q5sm2207888wrp.60.2020.08.05.03.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 03:57:02 -0700 (PDT)
Date:   Wed, 5 Aug 2020 12:57:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: samsung: Mark top BPLL mux on Exynos542x as critical
Message-ID: <20200805105700.GA6100@pi3>
References: <CGME20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18@eucas1p2.samsung.com>
 <20200805091601.11983-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805091601.11983-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 05, 2020 at 11:16:01AM +0200, Marek Szyprowski wrote:
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by marking it
> as critical.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
