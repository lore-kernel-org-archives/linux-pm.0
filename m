Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D42CCA489
	for <linux-pm@archiver.kernel.org>; Tue, 26 Jul 2022 11:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiGZLTo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGZLTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 07:19:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DD730F49;
        Tue, 26 Jul 2022 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658834383; x=1690370383;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ABO1vc8TQN3jq3u/kMUZdKq6N7zMTog4CpKlzMZ7bA0=;
  b=rKJ6uomUAqkKvMtrY3/8B2ormqf7rGiLFJWHd6YV8RNr8zzEvTZAYy2l
   cS18l0nezxLou8EA2bx1sCSJAlm5NDByM+7hYoSFbpWc0XVEdI3/7f1uH
   8CnoFS/WNiraf3jHWAouv8u2MRXa9bBgV2+wZ7y8q1mFBtkKVy8751kuO
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jul 2022 04:19:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 04:19:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 04:19:42 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 04:19:37 -0700
Subject: Re: [PATCH 01/10] dt-bindings: interconnect: qcom,msm8998-bwmon: add
 support for SDM845 LLCC BWMON
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Rajendra Nayak <quic_rjendra@quicinc.com>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
 <20220720192807.130098-2-krzysztof.kozlowski@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <902c7c6c-e2f7-d441-cb6f-a803238c8df9@quicinc.com>
Date:   Tue, 26 Jul 2022 16:49:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220720192807.130098-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/21/22 12:57 AM, Krzysztof Kozlowski wrote:
> Add compatible for SDM845 Bandwidth Monitor instance measuring traffic
> between LLCC and memory.  It comes with different register layout:
> called v5.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml     | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index c2e697f6e6cf..32e2892d736b 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -27,6 +27,7 @@ properties:
>                 - qcom,sdm845-bwmon
>             - const: qcom,msm8998-bwmon
>         - const: qcom,msm8998-bwmon       # BWMON v4
> +      - const: qcom,sdm845-llcc-bwmon   # BWMON v5
>   
>     interconnects:
>       maxItems: 1
> 
