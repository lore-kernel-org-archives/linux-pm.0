Return-Path: <SRS0=Ui8E=ED=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE200C388F7
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D2E24724
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603922860;
	bh=s93hgAZBJXZW7aLi/sJVwH+2Bt3BegWezU5N485Chc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VI2d/Oy5dVSUF4kYTgcRhZdOrrAYn+F+aR1XQWd3VRNqPvCRMWhok/tNSPVU+lHhX
	 /HlUnc4Ff4Fq3xbc6fQBWFz+4b3SznJXMAe1gbyHq29FfH0yUwCi+dMR5vRIu0QEwX
	 PaBWxRGWjLhoEFVascQzXVsSfKHnx/Mwmfs/SEO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgJ1WHa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:07:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35093 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgJ1WH2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:07:28 -0400
Received: by mail-yb1-f193.google.com with SMTP id m188so495173ybf.2;
        Wed, 28 Oct 2020 15:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9i72jITznoyLWceCi4kjFUr4fNuDlp2txdWJ3Q79bE=;
        b=JvAitL9dJsvtpMeWcXUMRz59fkrK+t5aPGQHX+TavYnsnoaG0Ujh3N/hItJvcMzpq5
         +vaqJ6oczXVJSyDKRQEDQxd1aEoLcA0MDTaEk6dzOXaDzVuCc+4SDmgOexwfxNJpZf0k
         37kPoaa4RMI+S+gBGK4Q32wJq95ELTLvva2rYH2pdM6ms+PDiDDvP28KOplFBRzMFaGj
         +j3l31LH2zDfczlEjqXW8QAA6bpoMUND1ByKrnaA8l1BfwbydA5Hgl/QcWfrHVqf9UVd
         jSfzxidU3glXvkNRVJbhcXG5QsVbkBHgYvHJn/mbTWMv2nG01bquMBvo0D67L43WLYBX
         UF1Q==
X-Gm-Message-State: AOAM532yh/hXtmozSHSGYRSZzi6LnJ/VSGGyozTa8mSA6Xazpb5XIYDx
        TVaC98mbnWxaH0H1z9IX6FvilVlIZQ==
X-Google-Smtp-Source: ABdhPJxVfBAexzDeSfthE/C5FdehItFG5LcxBVZpHOboZx3jsIuqwOA58jPu7ZgCp/788T3Wo1UzIg==
X-Received: by 2002:a9d:7390:: with SMTP id j16mr5739710otk.144.1603897740272;
        Wed, 28 Oct 2020 08:09:00 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x13sm2134399otq.75.2020.10.28.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:08:59 -0700 (PDT)
Received: (nullmailer pid 4031254 invoked by uid 1000);
        Wed, 28 Oct 2020 15:08:58 -0000
Date:   Wed, 28 Oct 2020 10:08:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v8 2/3] dt-bindings: arm: cpus: Document
 'mediatek,freq-domain' property
Message-ID: <20201028150858.GA4029348@bogus>
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
 <1603700349-5922-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603700349-5922-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 04:19:08PM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree documentation for 'mediatek,freq-domain' property specific
> to Mediatek CPUs. This property is used to reference the CPUFREQ node
> along with the domain id.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 1222bf1..e995b26 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -255,6 +255,12 @@ properties:
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  mediatek,freq-domain:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      CPUs supporting freq-domain must set their "mediatek,freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the domain id.

This needs to be a common binding shared with SCMI domains.

> +
>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
>      description:
> -- 
> 1.7.9.5
