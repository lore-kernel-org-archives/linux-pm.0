Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C5C38A2D
	for <linux-pm@archiver.kernel.org>; Tue, 25 Oct 2022 10:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiJYKZ7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiJYKZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 06:25:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DC1EC4B
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 03:23:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b2so21096887lfp.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/rueLkErXcyJyPk78wEDhbANCqJ+K9rCJeT2P0Ue/U=;
        b=P9QtxjbP8BFwnXyVhC1nZOpLkGohvfxMoxUcx+V/gFCCpd0hQ8tmqS2XyAqd2JmI7U
         Bk6ZTrpwAKjBEGgqbBTKNk7+V/mgWAWmKDWcsI+tZqwH7d35nbajBYcHqQWIwePGBmbq
         p61WuoWF63rHOfppgToZyeER/ZPP2xKAv+fijEcHgeXTcwN5rdpZbOWSqejnJuQL9Zwf
         IBkpOBl7CoUo73EZNvtTdFO+aQ5CZAwjEBKi0VL6VesW+xu7VxW9/dl7YFvIfRi/VkMN
         OhcfsrIs1kHdDXU7UBhuBJUvKpM1SO+a6eFOxxKuEVS/vKnVjBCuJYAwU7XeoxcmKEYO
         Q6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/rueLkErXcyJyPk78wEDhbANCqJ+K9rCJeT2P0Ue/U=;
        b=TjF5znFi9SC6fsA58pkaKOrBfCzfswzzV7mroNYn/bQ7kljSc/znGIEJN94EI1eDgs
         /u6bI4iytnDfzUiXG8HH9O/MYUYYlttQHThUzGrWN7k0F/tWFOH3tYjEpVQ5lgya9wvz
         dTvBoUR6dFTa5L7uh3+B9Z3DyMmIjCv5xIjNWimimNBEwlPsYXixVnCeoVVwrjy9UwmP
         GRw4CYDIvC5jOf5RaThU+AR5zBCNjXUdFujyS4bUwQlBDghOViQ7wu3vFjCDCxge1Ekf
         uS/Rh98VwUQw1U4C/aZG4x5J0DnLlT5FDrQA2wWec43mWyjdGYZUJ+/yEqcxs56/1Gbd
         FRPQ==
X-Gm-Message-State: ACrzQf01g/FblRSEARUQDBaMFeY2GsbTqDACsNb7+J6ip7sfUyE7EDND
        QjsQSCCSjjd+n/y9ym+s/JC9XA==
X-Google-Smtp-Source: AMsMyM5idpO1iNIZWroj7oq6xtgot4wdscnkHql4eiEWNBLInMpsyhaJYtPOx8iIUnNqcSl1mPx/lQ==
X-Received: by 2002:ac2:509a:0:b0:4a2:2bfc:3487 with SMTP id f26-20020ac2509a000000b004a22bfc3487mr14039269lfm.458.1666693386339;
        Tue, 25 Oct 2022 03:23:06 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id g5-20020a056512118500b00494978b0caesm348359lfr.276.2022.10.25.03.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:23:06 -0700 (PDT)
Message-ID: <98ed35ac-8dd4-e81f-713e-2e5213731976@linaro.org>
Date:   Tue, 25 Oct 2022 13:23:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC
 mode
Content-Language: en-GB
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221020115513.93809-1-ulf.hansson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221020115513.93809-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/10/2022 14:55, Ulf Hansson wrote:
> It's useful to understand whether we are using OS-initiated (OSI) mode or
> Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> Therefore, let's extend the print in the log after a successful probe with
> this information.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

