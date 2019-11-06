Return-Path: <SRS0=tRrS=Y6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B2C5DF64
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA24B21882
	for <linux-pm@archiver.kernel.org>; Wed,  6 Nov 2019 03:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573010894;
	bh=klzUrztVAl3UamjupliqgwKiRbL2zpv78QeK1CPbV8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JPX1tCSSx+QroB5i9Kusf6VOja57hw1otRd3IXtLkMMPfbv+ISPvRNGGqheBFYhvA
	 5KrO/v8e3HteeYi/vMmacLAsNKgSrcG/T55u9xz/pGdxx0U8LSf96O0+5aL/8/0vMv
	 HNh/c2gR/JnYcBZbJiUF59LTxIrMFt0Qcusvy58c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfKFD2N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:28:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38928 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfKFD2N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 22:28:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id e17so11095048otk.6;
        Tue, 05 Nov 2019 19:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0oTid0SW10XwZb1RF+BrVVIvnOR1wYdO6Pj1OAvnFY=;
        b=rM7ZfqNACRtWroo00blzihto1nv27ttoBG1XtZ2fonRNzv7wF6jho2APRDuckeILpl
         +8pDvQb3/vTOgtDNjF7Ml+A/Taefe3XjBgTyBKx1Gos2HiPua4F2qDjeA5rJf2qrfGgA
         FiINv1eKe3A3urrY28TTbtPXQJuJsntHD9I3EUgIJo9gE9Bu8uo312z8wHwcSJzrTo0S
         XFcsqPB98kSxOVVK/gnlXDSZk/oXwEo5jOV6iiONRD8udqu9vPgM21h1DWRmsu7AXx5U
         o3UXJ5piPxdKX4k5LKl/HWfuG5XgHKJizZZbst9sje6gnXKIA9GgHky2A4bNL9WeJXFL
         +7Fg==
X-Gm-Message-State: APjAAAWgNrrexDFCHmGpV3ljN9Gc0W+m1K8LZWJ5qe5m+k5j6uBWz/Fg
        AhOwaxs2sz9dnBIFwhTfZA==
X-Google-Smtp-Source: APXvYqzvmFAIynZbAa+Lau3VpEysLExen+Ata4ibdUunVPAd4NoDWn0KHV+ZffT5oKe/kQcLjtQNQw==
X-Received: by 2002:a9d:6141:: with SMTP id c1mr152751otk.117.1573010892175;
        Tue, 05 Nov 2019 19:28:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 100sm6852434otl.48.2019.11.05.19.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:28:11 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:28:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 3/3] dt-bindings: arm: samsung: Drop syscon compatible
 from  CHIPID binding
Message-ID: <20191106032811.GA24162@bogus>
References: <20191028152050.10220-1-s.nawrocki@samsung.com>
 <CGME20191028152100eucas1p2ed6bd2d53670c85f6bf550af0631a55a@eucas1p2.samsung.com>
 <20191028152050.10220-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028152050.10220-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 28 Oct 2019 16:20:50 +0100, Sylwester Nawrocki wrote:
> The "syscon" compatible string was introduced mainly to allow sharing
> of the CHIPID IO region between multiple drivers. However, such sharing
> can be also done without an additional compatible so remove "syscon".
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/exynos-chipid.yaml         | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Rob
