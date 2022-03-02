Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E10C433F5
	for <linux-pm@archiver.kernel.org>; Wed,  2 Mar 2022 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbiCBS0O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbiCBS0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 13:26:12 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD2D8840;
        Wed,  2 Mar 2022 10:25:28 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id j2so2516789oie.7;
        Wed, 02 Mar 2022 10:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k1UB1OHIG6YIwAeg2LTAnVW2kRcqK6QcDUgM9dd33ZI=;
        b=pBqwIEBcmY2C4hydgsDsrWcfsrc1zuAeFpVANcVuur4iHA/T1KnAxzOdosd/rRK1Dg
         1q62l1oFzvcMaINQ/VdVJq8v1ZCLdpB8QMJJiKn9O6iW3Pix1BsiEg+MkWWThEXwBfIe
         d8yaiIG94l93832dc7sysDkH67jmIZdhu9KfSHf5zQ3Qzj3qvRtym4Yjpp3NXgZNjMzg
         ISHIsrO9mjPtJ9kkdWzo2JSiisdwN4FH4Pe6276sVsmbRcc791rQ87hOa6L8QqaCHmJZ
         ibfj+7HqnpC/U3MVJMpQODhTVLO2gAKbRXJkIm/lB26D/lbQiEZgRLqk4rEtRuYGi+e3
         FCiQ==
X-Gm-Message-State: AOAM5319E0hk5fAL80gDxHnMQaXp2cZk1GBmQuHTREggMj3J6Dw66jxA
        niNf7WKdIwKyF8WUTsB50g==
X-Google-Smtp-Source: ABdhPJxPSBwz4w7OpDd6tKba77B/a7QpLHWJN4TLiCq+6nd3Bm/CtNUwn+iS+ke2qok7qZLWAlXQvQ==
X-Received: by 2002:a05:6808:f93:b0:2d7:bf6:a33d with SMTP id o19-20020a0568080f9300b002d70bf6a33dmr1033774oiw.161.1646245528091;
        Wed, 02 Mar 2022 10:25:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a69-20020a4a4c48000000b0031bec1608fbsm7977929oob.17.2022.03.02.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:25:27 -0800 (PST)
Received: (nullmailer pid 4005227 invoked by uid 1000);
        Wed, 02 Mar 2022 18:25:26 -0000
Date:   Wed, 2 Mar 2022 12:25:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ab8500_fg: Add line
 impedance
Message-ID: <Yh+2lrxFkSZkOQCK@robh.at.kernel.org>
References: <20220301124254.2338270-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301124254.2338270-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 01, 2022 at 01:42:53PM +0100, Linus Walleij wrote:
> To improve the inner resistance measurement of the battery we need
> to account for the line impedance of the connector to the battery.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/power/supply/stericsson,ab8500-fg.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
