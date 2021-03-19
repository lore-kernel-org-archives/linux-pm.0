Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0BC433DB
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B38061963
	for <linux-pm@archiver.kernel.org>; Fri, 19 Mar 2021 16:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCSQVt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Mar 2021 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCSQVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 12:21:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63501C06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 09:21:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e18so9710530wrt.6
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+7JtPWrzoVq9IfYXX5dUkVFHCMG2f/RW7isFZzxLUA=;
        b=kCDrU+/pozRLTw7JfiUzllg727f/Dvdtxcp8fBXJF3uJb/k0xBeZnoAfeakD1/zqha
         ki8k8iPrQ0TsHckjaXnoHA7IEaELvBJqrGMFvvz/bRO911SmVjhw70Zmdp3QJAmYgls9
         9wCw6Ysb0dcSXlUD0e9FC2LQXRROzc3lHgbjnDvnKBMeC/9IzVNglJaL0nEpQGQyytbC
         OTkqJni8+tuM+i/0xr9j1Dgl594p8Qqofbhe5eKjUHEJKpnvkRpfJUMAtrzxRxKSQMRj
         TBcb23H5QehIEdQ/d/ppbt/PZ7ncFbEAMj4JTAnpntFzj9nJC4j2MJwplqRdfx9JwWgQ
         5r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+7JtPWrzoVq9IfYXX5dUkVFHCMG2f/RW7isFZzxLUA=;
        b=lW62nN9WmGbzAyMJupnnQmb4oDpbrvLQ7JUw31khYVmKKDRinhApfHJrAG8b/JACFf
         eNOrHV9eA2X5uvG3TNelnMgpXY11ST2SdPEMmiMeoSFJ/Pr/eoie64h8XjZVMRrjeIhl
         ux/2TlZOuelbNdhcsN8611QwNaXRUhouNVYDXaVtNYnWh78We0i08qV19IvQwyEh1xT+
         dDF9UjAqbGulIIjURqbueBWWqPFwvCBtaEL9lH1HC2WtNEyqAO7d5TLVWsoxK8aQDkF2
         K21WDEdh3LBufNd1lIHxD/N3TJyXBGpYCNmPmwW3qdRd7f4jZHtqJwVULJPzxF9FJ09u
         jWqA==
X-Gm-Message-State: AOAM533sDqwDo8IuQ+n/3XDFpH2vPVlXeUoF1uEUJRHnu8rXlWurONTR
        GkWGifzOTlPkC/CcMMzB/59OzQ==
X-Google-Smtp-Source: ABdhPJzwBl5xKMtGiYizYyniDg1e76b+/vRNVyIXX1Ak+IcQQbjKxiJPZGQ3JYHmvmwRqiBJGUrS8g==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr5497712wrn.352.1616170903054;
        Fri, 19 Mar 2021 09:21:43 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85? ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.googlemail.com with ESMTPSA id w11sm8812705wrv.88.2021.03.19.09.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:21:42 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add co-maintainer for Qualcomm tsens thermal
 drivers
To:     Thara Gopinath <thara.gopinath@linaro.org>, amitk@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319153711.2836652-1-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0688c116-bcde-7980-6535-80000fac5afb@linaro.org>
Date:   Fri, 19 Mar 2021 17:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319153711.2836652-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/03/2021 16:37, Thara Gopinath wrote:
> Add myself as the maintainer for Qualcomm tsens drivers so that I
> can help Daniel by taking care of/reviewing changes to these drivers.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
