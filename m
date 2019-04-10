Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BBC10F0E
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34802133D
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgThgCgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDJD0N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:26:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfDJD0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2019 23:26:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so530195pfo.6
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjLTw+m2ZEwqD7IRnenJTwcO08Oa8viTpb2e9ccyS4U=;
        b=LgThgCgOgkN7pRj4T2GtyzrHmfduHws5+SQcF+2AIjGl7LmENhPJB8jlNW5djJbR8H
         6FmJM/guN/c9YODnuQ3+CAG209rwzEYljgCvJVHJrAAbTeuFqr2a/QcqLRGAIi8OFzwE
         o7sGMo7fXEl+x5AhPK1OiMlhvjAcib4pixHo4b0BehcZa+KFDk6b3LzjH9uGFK0tFGEN
         NIvWjYhirgM4M6uILdsIUOhmq3zaqBLLhxNmZQAMqFdF4HMOiO0bDmtrfAeMmRKB5QaK
         seLKOuJ8AmjpSTqDdHvi+dJXj7SOKx1ycjqjMu8eyF7J09N4BbeEKYyoRJenr0V+N/c1
         eT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjLTw+m2ZEwqD7IRnenJTwcO08Oa8viTpb2e9ccyS4U=;
        b=sM5nfWs0pt6LCnWwJkzuBmbLcyVmWYlV0bvWfb/S6zJRg4oG/jBYh4EzI8gjCbsR4l
         Or7h0SD8qN6ZcUBHmx1E56FthPVNgDgn5tVzCK6UXd5wbDpb0Zrg6FK9CiS0gE6ZyjWZ
         8AD5IqrGpItLwxUlx0jjiXu1X2q494gdKOiJf0Z8fU3i1US1icMcYMGAVoyoOHL+e0lt
         oan8qJJ0HZ9KuDLOSo+j9nGY8eBNnX8ORj/KkYGcha6F+6YtmCeuob8vUNyDdr3plJdF
         MXu2IFfzhGG/80R+kDRBUs145z5khtUnZ7cUEsP0en93oAUP4WmeTOIJMklytIz1QHYM
         iLag==
X-Gm-Message-State: APjAAAWPxtqPhSXt8GTB9XD1wSeO5LhBeLk690Nnb/Wp+jN0q8KCc0K2
        Zgr83cfUt7+FdbV29wfECbVQKg==
X-Google-Smtp-Source: APXvYqwZerODFzooN1BoAnAvg6g1i9NOJ4zDlf5w0jfGkfzixlOMaLzkxMFtkfQa4oe1517myGS1dA==
X-Received: by 2002:aa7:9088:: with SMTP id i8mr41168740pfa.118.1554866771683;
        Tue, 09 Apr 2019 20:26:11 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id w23sm39848156pgj.72.2019.04.09.20.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:26:10 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:56:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Message-ID: <20190410032608.fqxahvys6rysvayy@vireshk-i7>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409172558.18778-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190410032608.jRieY2HM9L8vqVc0RPeW4hLWFQ7Cnq67ARKsuucYJsw@z>

On 09-04-19, 13:25, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value  based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt

LGTM.

-- 
viresh
