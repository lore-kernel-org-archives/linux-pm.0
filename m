Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4FC433DB
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0999F64F51
	for <linux-pm@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhBEVwT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:52:19 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43702 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhBEVwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 16:52:14 -0500
Received: by mail-oi1-f177.google.com with SMTP id d20so9036371oiw.10;
        Fri, 05 Feb 2021 13:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COL52QGXJvkARFQTtCnDnLk2UkHSuPhjiRfQpCqhUQs=;
        b=FW7DyoijCD6dtjhZyG8KiVrsjgrKlSR/O5KBRWZ0CbaHD6jgOumphSjD0pEqrIya4l
         BGRoBqgvqtEkPJUYtLvmf2x4CUSNq78lRguvaQt6UOSZRyxZ6Q8ccQW0VoxZDzUCQWOJ
         cF++1SC7LWsuE84nGpx/0efGsJIHRZn4rGxpij9wkaTrsWeb2QaUEaS5m7DF+FlvATcT
         ejLYKi4Ee1lhS1O0IlcPnvMhCH3sQsOdhf2b6wzEdDXLWsaBHAHCsr31GBInoCfx9I64
         jhPUgpfoKoHn/wva64RUsQZawLpoubKApfuniXn3CqgNz7F9rpw57fVJJ3qV9Ba6i8d9
         bSwQ==
X-Gm-Message-State: AOAM532Sr0m//LvunZPrsvyJiMZkWPmAUVw9tnA/28/rYLcUMJbtAm3i
        f0Vkh8bsWBHiAtjGfDf3rw==
X-Google-Smtp-Source: ABdhPJwoNAK2aJcbnmBeWAVOjt5glY3+Tq3cZKnS9qalBY1LrIf9g/5VoqrPJl2ZnX20hNYqZE5OWw==
X-Received: by 2002:a05:6808:140a:: with SMTP id w10mr4460954oiv.146.1612561887610;
        Fri, 05 Feb 2021 13:51:27 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u73sm2025538oie.30.2021.02.05.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:51:26 -0800 (PST)
Received: (nullmailer pid 3813194 invoked by uid 1000);
        Fri, 05 Feb 2021 21:51:25 -0000
Date:   Fri, 5 Feb 2021 15:51:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v5 7/7] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
Message-ID: <20210205215125.GA3810714@robh.at.kernel.org>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
 <20210121195250.492500-8-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121195250.492500-8-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 21, 2021 at 08:52:50PM +0100, AngeloGioacchino Del Regno wrote:
> The OSM programming addition has been done under the
> qcom,cpufreq-hw-8998 compatible name: specify the requirement
> of two additional register spaces for this functionality.
> This implementation, with the same compatible, has been
> tested on MSM8998 and SDM630.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 66 +++++++++++++++----
>  1 file changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index bc81b6203e27..17fd6a6cefb0 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -18,6 +18,10 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - description: Non-secure v1 of CPUFREQ HW
> +        items:
> +          - const: qcom,cpufreq-hw-8998
> +
>        - description: v1 of CPUFREQ HW
>          items:
>            - const: qcom,cpufreq-hw
> @@ -28,21 +32,9 @@ properties:
>                - qcom,sm8250-cpufreq-epss
>            - const: qcom,cpufreq-epss
>  
> -  reg:
> -    minItems: 2
> -    maxItems: 3
> -    items:
> -      - description: Frequency domain 0 register region
> -      - description: Frequency domain 1 register region
> -      - description: Frequency domain 2 register region
> +  reg: {}
>  
> -  reg-names:
> -    minItems: 2
> -    maxItems: 3
> -    items:
> -      - const: freq-domain0
> -      - const: freq-domain1
> -      - const: freq-domain2
> +  reg-names: {}
>  
>    clocks:
>      items:
> @@ -57,6 +49,52 @@ properties:
>    '#freq-domain-cells':
>      const: 1
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: qcom,cpufreq-hw-8998
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +      maxItems: 6
> +      items:
> +        - description: Frequency domain 0 register region
> +        - description: Operating State Manager domain 0 register region
> +        - description: Frequency domain 1 register region
> +        - description: Operating State Manager domain 1 register region
> +        - description: PLL ACD domain 0 register region (if ACD programming required)
> +        - description: PLL ACD domain 1 register region (if ACD programming required)
> +
> +    reg-names:
> +      minItems: 2
> +      maxItems: 6
> +      items:
> +        - const: "osm-domain0"
> +        - const: "freq-domain0"
> +        - const: "osm-domain1"
> +        - const: "freq-domain1"
> +        - const: "osm-acd0"
> +        - const: "osm-acd1"

Don't need quotes.

> +
> +else:
> +  properties:
> +    reg:
> +      minItems: 2
> +      maxItems: 3
> +      items:
> +        - description: Frequency domain 0 register region
> +        - description: Frequency domain 1 register region
> +        - description: Frequency domain 2 register region
> +    reg-names:
> +      minItems: 2
> +      maxItems: 3
> +      items:
> +        - const: "freq-domain0"
> +        - const: "freq-domain1"
> +        - const: "freq-domain2"
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.30.0
> 
