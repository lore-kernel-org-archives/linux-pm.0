Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4725EB64DA
	for <linux-pm@archiver.kernel.org>; Fri,  7 Jul 2023 13:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGGNyp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGNyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:54:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682C1FE6
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 06:54:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313f1085ac2so1891747f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688738082; x=1691330082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJTnI5bOFiXZjxSo5gJqvfLEvH8akrdBST5kBTlYRFc=;
        b=sJI9rAeW8PnR8hPPhBs1hw92d5MffHd6A8tD9J3bnyTqmrwlpJRem5yoxcmcZKdtQb
         fhginQmqQtbHo0VT/F2Bs3cv2U9Ik8GlIiRJKdAfqQoOy/12dsTt8yBcKw5wv7bodx2e
         uK6jOiozjTi4BniZM+JPjbUrmEN4pLCEMf+CWdGbKuK9qQB53tyT2uJsvSqQhbwE+Jmv
         vHiXGxxhUhSMwLTPs09/dQT1oXtPvikUVAE5uVh9gGGYrbVJWhIp46Q49b7Qq33wJGUa
         5Htztozuv8Wg9QzEIHvx+B90napody1iuDt/GS+63Wum00RdAmUdR5zIiCmq73S3Egbs
         O4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738082; x=1691330082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJTnI5bOFiXZjxSo5gJqvfLEvH8akrdBST5kBTlYRFc=;
        b=GJRJfF96Ty8UVvgWzot2rqK5gNDnqC45ii44HNhT43jaPXBU/vgC/V+zvEx+ToHgl9
         0e1gq9drYIxnsCSmbyOOaQkr9Owxt/5PBtQxoBDDG5NKdtwG5F8Qw8s1oBX2JfU93H65
         fjOQhs5PZTMHrDacCt7bYuUl44kabowftBREuYR8t9Dfz0V3aqsXFGfTAzC0LaBj9MbN
         4D/j+Lw2MHfhqz7UUNvAREoK7I5v4Fzb5e+qLRZi7b0Dx4n3UTvxAIn4DNDSGNtv6ud0
         TGLVTByi+KpOh3dBxT8K04YDqBpnfvqNIJUrjQYcqxI+1RXrvTzm+4kD9LB7sa6f9l2G
         nSnQ==
X-Gm-Message-State: ABy/qLYfScv+qQMuaM96iyJfZgUBsEJmljlGWG106tD5KTK+1Q7kBIWd
        r6wztHE3iJDUQ11bmQtkB8VRzw==
X-Google-Smtp-Source: APBJJlG1MkdrB0Xj9FT9FqWVWR4LUOzvfLqDindJnHI+5SJr2VEpgOpqSvIWpTwJAITINDE/EiJxRQ==
X-Received: by 2002:adf:dd05:0:b0:314:3939:fa1c with SMTP id a5-20020adfdd05000000b003143939fa1cmr4529614wrm.8.1688738082129;
        Fri, 07 Jul 2023 06:54:42 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d4e91000000b0031433760a92sm4477755wru.115.2023.07.07.06.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:54:41 -0700 (PDT)
Message-ID: <a993d0a7-e7e7-d30a-0848-6a3612b72345@baylibre.com>
Date:   Fri, 7 Jul 2023 15:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/6] thermal/drivers/mediatek/lvts_thermal: Use offset
 threshold for IRQ
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-4-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> There are two kinds of temperature monitoring interrupts available:
> * High Offset, Low Offset
> * Hot, Hot to normal, Cold
> 
> The code currently uses the hot/h2n/cold interrupts, however in a way
> that doesn't work: the cold threshold is left uninitialized, which
> prevents the other thresholds from ever triggering, and the h2n
> interrupt is used as the lower threshold, which prevents the hot
> interrupt from triggering again after the thresholds are updated by the
> thermal framework, since a hot interrupt can only trigger again after
> the hot to normal interrupt has been triggered.
> 
> But better yet than addressing those issues, is to use the high/low
> offset interrupts instead. This way only two thresholds need to be
> managed, which have a simpler state machine, making them a better match
> to the thermal framework's high and low thresholds.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
