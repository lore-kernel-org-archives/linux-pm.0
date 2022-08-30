Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A8ECAAA1
	for <linux-pm@archiver.kernel.org>; Tue, 30 Aug 2022 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiH3QZz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 30 Aug 2022 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3QZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 12:25:54 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42435FC3;
        Tue, 30 Aug 2022 09:25:53 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id c17-20020a4a8ed1000000b004452faec26dso2059171ool.5;
        Tue, 30 Aug 2022 09:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YaikjxgLyqtsdLt2khR2V2BKYtZ+YK4d/SvwCpASp/E=;
        b=i5BhVP7JqbMkkk9UFs7mz2wftvBvSXSKl7B9qYKEA3e9XBTW3/X0dE+IPGJU73Srh/
         LZFKxJgg7mEny1eMRqn/iz5uSUvjSia+pt2sFLO2ooBf5n1VyYF9eTqRni39m+nxyj05
         0aqieBfcZWM5Y57LmqaBsvJK2CVnhy815BBkZHAuYJQGUTJgWykCGniQU/NAI3uO+04c
         GWfzhlOm/ip2DPzNs/qDFph6Ik/014vT0JtGD5czmkwH7FC3NVjBF8OR0qy2uWxcegKm
         RLzoo1AkDBc7bONvv+CVDDphFZfYOZF2om8BEOWTxs68vLy05cLjhdBKUO78TVPnK5zG
         zSew==
X-Gm-Message-State: ACgBeo3IjHmkoz58Svl79zRhRBmVl2RlWvw8MupxDZVrJ4fGGxhaNKDj
        hVCHNhDZ1cwIt1QWnEgpRabs7q/3Hg==
X-Google-Smtp-Source: AA6agR7prvgwV09hc+PdOo95qlSdVRWy8WF9lKniw/j7mhhG0n5nzc730p6IwvmEgZxOf/5UVllw7g==
X-Received: by 2002:a4a:ddcc:0:b0:44a:d491:b11e with SMTP id i12-20020a4addcc000000b0044ad491b11emr7542038oov.34.1661876753193;
        Tue, 30 Aug 2022 09:25:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c4-20020a9d6844000000b00636f7059b27sm7595493oto.5.2022.08.30.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:25:52 -0700 (PDT)
Received: (nullmailer pid 1514589 invoked by uid 1000);
        Tue, 30 Aug 2022 16:25:51 -0000
Date:   Tue, 30 Aug 2022 11:25:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7
Message-ID: <20220830162551.GA1514331-robh@kernel.org>
References: <20220828081022.96813-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828081022.96813-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 28 Aug 2022 11:10:22 +0300, Krzysztof Kozlowski wrote:
> The qcom,adc-tm7 compatible is already used in PMK8350 so add it to the
> Qualcomm PMIC Thermal Monitoring ADC.  Based on downstream sources, the
> new compatible for TM7 differs from older TM5 by allowing configuring
> per sensor decimation, time measurement and number of sample averaging -
> unlike one configuration per entire device.  This was not reflected in
> the bindings, therefore comment the new compatible as incomplete as it
> might change and its ABI is no stable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
