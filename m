Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F1C433E7
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C318420657
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594398686;
	bh=euKtksIq2/7MC0Mi3qJ2A5NRDnWyitzcHd8aU3VneGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EgQosQMgQF/13oGuTOlFgqTZOe9siyI1qf44fY4yCFVVeVF7UYmsNS9GKN0gSt5aM
	 Qq77IrsihX/6oN0TDvos23mv/T8EgyUz9137jiTwkvAqln0EHVSXMSly8EgsJt81uA
	 w/IrvkzXDemb8Ws12wG4v1ku2bEqAM86YKyDM/YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJQbX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:31:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43357 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 12:31:22 -0400
Received: by mail-io1-f66.google.com with SMTP id k23so6631962iom.10;
        Fri, 10 Jul 2020 09:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ri5Ju8/pmRRLLJvGOFF2lCmuUcpkIXlf+EO6oa9lkeg=;
        b=nqA8jhOyMWl6zDz1D/rGpo03eDm1D3IS/FdHuyF1LPT26sjCt792sMeuNcIO7mOvL2
         OUme2VhRUu2LUw5xB/KIpJTaSDWxKohp/V32eTKEb9MBnBcn2tUyyyzpizmNYhZZYG1O
         22L1C11jZKSJ85zgzMqp2/8NhieoBucz8bLIdfjrHWadipzweQie9XiPB72eHY71kb9h
         r2t68aE26ZIrP4KdYJtrj5XtPOr9X3iRn3BMf1LV1mbvH+oaBZv984BV0sQcaOGi5Sca
         70x0K8HnQNPXXdctyZ7Q26RH2MUaxHPybRG0ckrYP1guNH9A7kpKgXuQrF1fdnmfAvE7
         ykTA==
X-Gm-Message-State: AOAM532UptoJOIU/48bAvz08dzheXFh6VdzoZlzsLAZkisG5KOc1Bb5i
        yX66bbthYC/CoHiJp8auAZ6HPfnLCJ9E
X-Google-Smtp-Source: ABdhPJzvLnRx24MgOhUZQEp05+U4gq81sv1JxrEdwFInJenxWlUIT/AyApoNCnP+LtIFrZS4Zidw3A==
X-Received: by 2002:a6b:9042:: with SMTP id s63mr49394517iod.195.1594398681647;
        Fri, 10 Jul 2020 09:31:21 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id a5sm3706284ilt.71.2020.07.10.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:31:20 -0700 (PDT)
Received: (nullmailer pid 2759342 invoked by uid 1000);
        Fri, 10 Jul 2020 16:31:19 -0000
Date:   Fri, 10 Jul 2020 10:31:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: interconnect: Add property to set
 BCM TCS wait behavior
Message-ID: <20200710163119.GA2753833@bogus>
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
 <20200710015652.19206-3-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015652.19206-3-mdtipton@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 09, 2020 at 06:56:48PM -0700, Mike Tipton wrote:
> Add "qcom,tcs-wait" property to set which TCS should wait for completion
> when triggering.
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,bcm-voter.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> index 5971fc1df08d..f0c3d6b01831 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> @@ -21,6 +21,16 @@ properties:
>      enum:
>        - qcom,bcm-voter
>  
> +  qcom,tcs-wait:
> +    description: |
> +      Optional mask of which TCSs (Triggered Command Sets) wait for completion
> +      upon triggering. In most cases, it's necessary to wait in both the AMC
> +      and WAKE sets to ensure resources are available before use. If a specific
> +      RSC and its use cases can ensure sufficient delay by other means, then
> +      this can be overridden to reduce latencies.

I have no idea what any of this means to provide any meaningful comment.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: QCOM_ICC_TAG_ACTIVE_ONLY

Can't use defines here.

> +
>  required:
>    - compatible
>  
> @@ -39,7 +49,10 @@ examples:
>    # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>    - |
>  
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +
>      disp_bcm_voter: bcm_voter {
>          compatible = "qcom,bcm-voter";
> +        qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
>      };
>  ...
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
