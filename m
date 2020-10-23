Return-Path: <SRS0=XRtZ=D6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FEC5517A
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCAB22460
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603469704;
	bh=aETcbSYtKNWIOcn7U1l4HIJ+nEKrmd+9dHzCw5//954=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n8au63B6rV1Z6w2Kz+QWj4fuouQkMBPY8auoWYMNTy7qnMyJ95XmRAo7RJPBv7d5a
	 4UZwOYTFQYInl/tuRX9RBjr3BWvckeUCUv0o9yYotdNSB5NS7r1otM4jjbofuUbsGA
	 HEtPxiTO1EiK0nnyhHC213J+iMb4kIOZ4iE8EgJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373871AbgJWQPD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:15:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41027 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373787AbgJWQPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 12:15:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so1878184oih.8;
        Fri, 23 Oct 2020 09:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvCVkpNgTNIbURGGw2woJK1FfE+oLd1yKdhTrG3ufOA=;
        b=h0LnVm6q0HlSKbfuDE+sESMByzZ2Y+8A63A4ZRmnyXKVODjPkGDhprJ3KHZZFxQcyC
         XFHIQ0Rij7Hu3/kJBn9l9Kp4s2Yz2AaBdqe/7t2kyYVUWP/43mSm8djtsZ1QdxLN17bY
         8wtNl+4oc/BoXaW3X1btGQUhrLYv30mEVEWGBByplQksqUxuuvNXlBzuW8X4gH4d9i2X
         ndUfcbcweRWb1rKgpXHh33gPJjuUZN/544LOujBf6+7FoTleUIvWpyfC9zscd2qaBNoO
         0cB6TmQaprzgTsm1JE1yL8NKWmQ/2RAt/WcSq90ZUgHpa//RGQAUKgvVK5bTlQ86e2Ui
         nE3w==
X-Gm-Message-State: AOAM530Yd+CN9kGvJkea7lTYvYmRqp5LNOyjJAXet9zn4D7cAbK6E+VA
        BWKPs2/ram7CG6MZieGosNnZkJtWpw==
X-Google-Smtp-Source: ABdhPJyYeCMsL52JQAqym6VgKty0inwrQaF/J8jiig+S215ihWN6sR4ZPDJA9lEOshnTKG5zylY9Vg==
X-Received: by 2002:aca:ab54:: with SMTP id u81mr2114700oie.90.1603469702099;
        Fri, 23 Oct 2020 09:15:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b139sm558165oii.19.2020.10.23.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:15:01 -0700 (PDT)
Received: (nullmailer pid 2801225 invoked by uid 1000);
        Fri, 23 Oct 2020 16:15:00 -0000
Date:   Fri, 23 Oct 2020 11:15:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        wsd_upstream@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20201023161500.GA2800310@bogus>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
 <1603441493-18554-4-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603441493-18554-4-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Oct 2020 16:24:50 +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml:46:1: [warning] too many blank lines (4 > 1) (empty-lines)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1386572

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

