Return-Path: <SRS0=JyHV=EG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2563C4742C
	for <linux-pm@archiver.kernel.org>; Sat, 31 Oct 2020 12:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9108120709
	for <linux-pm@archiver.kernel.org>; Sat, 31 Oct 2020 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604148045;
	bh=rcpN1/oL7QoSzcJE8ZaUV9Ayj56GHByn9qo5alPZzvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yfmEGxzlxjicPY0iQvmhUSroOA6D1GVR/n1aOYWEq4ip9MalyRFlV7+PgsdfQXKlB
	 QI/4Xg40HBUz4DzxdMmEaGHZGL5D5l2tzlhC4xbA0UhKaUhs8v/d1AkRqMHK7R5dnB
	 DHycshljIxjosXqG6h7FKo0yVtsEJK8jf5JYo9pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJaMkm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:40:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53667 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgJaMkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 08:40:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id p22so5151705wmg.3;
        Sat, 31 Oct 2020 05:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKZimNoFlTDUwIyRR0BEoVG9+GJEQQemUuLJSx/vHaI=;
        b=biiV7pXpODDqNbVp1G+1xSDHKQlAyyMlTvQ4nLRB4e7RZR+u+Tj9I92IU4HahSrLtn
         cu2fAU5aXBCznIQKq2pe86B/V6UKRcrb5z3Bb1toThFZ8OMolVsquwxkZtcAKTQsxNpc
         bc6sQlLfq0SXJ7KVXYjZbcm0Sag5TjVQv74p36FMz1ikvLxwggLILHSZeB1R8n4BTpVB
         +16LMqjBWRSNtyYB7tPW0TNivh+b/jZTTctHesEVKn1Ajvxut/Ck6O5O0WaPUvIeYoAp
         CbZnMPTbrLoOij40V8pdYxnz1gdagh4p+5D/hVnOVSm2n0Y4snfUPsQNVWzK3pMFRUa5
         mpBg==
X-Gm-Message-State: AOAM5307zLk8hAW9YlvmRxHThfVb5VmulphNErvZ+uf8365Q1XMdhch8
        +PVim+zmNcNIa00fvOsRRscMYFeRbh7TWQ==
X-Google-Smtp-Source: ABdhPJwPMaxPU+T2aWFKKta+nNXVJhIGcFvUta4TdBBI7jlBuwAQdMEe6jnIIv22dfy379m4YkqifQ==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr7888308wmb.152.1604148038915;
        Sat, 31 Oct 2020 05:40:38 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k22sm1430211wmi.34.2020.10.31.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:40:37 -0700 (PDT)
Date:   Sat, 31 Oct 2020 13:40:36 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 3/6] PM / devfreq: exynos-bus: Add registration of
 interconnect child device
Message-ID: <20201031124036.GC9399@kozik-lap>
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
 <CGME20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9@eucas1p1.samsung.com>
 <20201030125149.8227-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030125149.8227-4-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 01:51:46PM +0100, Sylwester Nawrocki wrote:
> This patch adds registration of a child platform device for the exynos
> interconnect driver. It is assumed that the interconnect provider will
> only be needed when #interconnect-cells property is present in the bus
> DT node, hence the child device will be created only when such a property
> is present.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v7, v6:
>  - none.
> 
> Changes for v5:
>  - new patch.
> ---
>  drivers/devfreq/exynos-bus.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
