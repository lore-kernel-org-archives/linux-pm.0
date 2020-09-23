Return-Path: <SRS0=ZSGc=DA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF5CC4727E
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED439221EF
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600877016;
	bh=k5JyL/OD5XvV7dyoVemCMtbl/Q5o792UhN2cKifhF1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H3Z06VYRlXaADk5CZYmfGt6q+yOH6WKBKxQVNc5h9PiA2u3P+mdOe6G3DIjYVYnFY
	 Zk2jTXOIQUy95haB0Uhn6r9n6bJzXlG3HgfhtTtaXHFICoy8GZAVM28GwIAZrOC3k9
	 oSNVrOSnEIrTsvOefj8kTonX5QgNjAR6IBfYijmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIWQDc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:03:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41526 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIWQDb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 12:03:31 -0400
Received: by mail-il1-f194.google.com with SMTP id f82so87460ilh.8;
        Wed, 23 Sep 2020 09:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7oNf2n/2S4LdD+hJ5wvJbkdup7gyW0tYobtVU4/lCo=;
        b=LJxua3tbHd2IGS7253Qjbw6lZg6qeXG1jQn/HsZinU323Ehay5oRodKmTGClYHstgl
         lEuIXhDet/nt4yQjx4fd4QGoElccOnJ7DXI2w/IJwXrAwDkrhNuMZGY9OKIMuqxtKjS2
         rc9eX4STQkTYRceH4zTR+Yr1ddzNu6pnIadQcTCGbLma1vmXR2dRIZzxkLjCOEVaOGgo
         LdXkd9UpBQXCZg5nxS/0u3ybqrNAeMZ9oxTFhkY7F8jlxuKLaNMj17LT1D23xb0hdFGI
         DSwwohR52Ubp0XEJwAYplruwZc8C9srqRg+TWk0xk1P0Th7wzpqM9wYfQtvFT0ktx8iq
         BUyA==
X-Gm-Message-State: AOAM532hLT+wTZhwgfso4u4dmfww7avgJ4aCSQr5aPmByL+cCzNuRZVK
        gLLsa/EvjrYcHJCqiiogVw==
X-Google-Smtp-Source: ABdhPJx8Jk2Cu+4knjIJI93h2RDm8Bp12YNWlPvaSS83rCXADkAPJBrKwucmpTFhKApUGVNahPjd0A==
X-Received: by 2002:a92:bb57:: with SMTP id w84mr421072ili.41.1600877010279;
        Wed, 23 Sep 2020 09:03:30 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v24sm129353ioh.21.2020.09.23.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 09:03:29 -0700 (PDT)
Received: (nullmailer pid 836373 invoked by uid 1000);
        Wed, 23 Sep 2020 16:03:28 -0000
Date:   Wed, 23 Sep 2020 10:03:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        amitk@kernel.org
Subject: Re: [PATCH RFC 1/8] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
Message-ID: <20200923160328.GA833754@bogus>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
 <20200917032226.820371-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917032226.820371-2-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 11:22:19PM -0400, Thara Gopinath wrote:
> Introduce a new binding parameter to thermal trip point description
> to indicate whether the temperature level specified by the trip point
> is monitored for a rise or fall in temperature.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 3ec9cc87ec50..cc1332ad6c16 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -161,6 +161,13 @@ patternProperties:
>                    The active trip type can be used to control other HW to
>                    help in cooling e.g. fans can be sped up or slowed down
>  
> +              monitor-falling:
> +                description: |
> +                  boolean, If true, the trip point is being monitored for
> +                  falling temperature. If false/absent/default, the trip
> +                  point is being monitored for rising temperature.
> +                type: boolean

What if you wanted to monitor for both?

> +
>              required:
>                - temperature
>                - hysteresis
> -- 
> 2.25.1
> 
