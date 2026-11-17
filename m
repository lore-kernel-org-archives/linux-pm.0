Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892864;
	b=MkbZ9DsgoJsaSwbq3m/FapTKZ0Ybl6JpoNO0iVInhs3Luvphj16XV8LAaolrAOMuc1Eu
	 4Ud0U94uzLTRiHRSlg/mimHV9357uPHViQHuHtIqSeOEyqbym09Y5i1clmdNtBxRF0c5s
	 jDltGV7i/8z49ttcOEKHA+flx1oXw+l4AVGedX3T3YEgMgz1dykCFw7YfValeI4w/XR2s
	 aQ5VPDzHP0nsylRV3M4swAR7ev6UZzQv+B4owbxvvaGHOB75aiHv2eVb5o0PDmiQz8HnW
	 vAhU6WCxtiw1J8VHO7XpR8sRKD1ZpsWnvGHfHaHOevO7tMuuX5ILxkg5DvtxayNPjEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NiXyMdzo/anqEnQBYGUdLPU8J41tqXReCV4OWaoYlKw=;
	b=R3AmFRcYD/9lGlaR+IJCPkEAZ8kI7S6VCOUlcM5cMNsc7wY8M33a5xIxQfz2O1QoihRy
	 up8FwaHoUSo3SBrqPraDhRzk3Lwo8k+gkK8SDKPMq4fSiWG7qAErQxFoQBZsZAYUfINTh
	 RiqP+HZ6NHTS2y4QPUePL2E6iUat7eseM0CLkzdrbii4R2xVg2Atl8RLPbcaBAO7boMop
	 J4R2gQ54lxxV6N/dYdT44ivpOYQWyyCIKj1sjEC2r8bV2T13TJC1b3FcSNpg9LV7/e1mK
	 iLeQxeabsTBy15/8HBYdho7Etv+5YGpegGMAV7ZOjb5fq6Wuf/qWaS5sxEgalUScuug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="FFFt/Kre";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E5606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 05:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FFFt/Kre
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-380b40319bdso1635499eec.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892863; x=1795497663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NiXyMdzo/anqEnQBYGUdLPU8J41tqXReCV4OWaoYlKw=;
        b=FFFt/Kre77y5uKQ3IbEMU2/kSG/zf+J4xKGmfWVv+YEsgTLoolyYVa8t9W61+i4KJZ
         WadczteemdnXaLDgsuqxQix0BYiS0LzVRTsSQPbPk2hKcLmsK00DHTuTluD4h7iTA8oq
         qk1cMvXd/5VODPOkLwug5RX8wz+6Qrkb3BXEEoO3l4+Tm/NMS9nkbvhgH3KTwH1w7toY
         c0l4W5cZXglp7fIK/UynOzqNz8/U5QU9Ncr9p1neGMt8gUveT01Axirz31gSsMfRAUBN
         v5QQmlG8OYnqmxJxfgvyaWP4IU3XPSManvD2dcgoiuUq5H0hSfIHP2dxdCCdFYzRnavX
         wP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892863; x=1795497663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiXyMdzo/anqEnQBYGUdLPU8J41tqXReCV4OWaoYlKw=;
        b=CfgVXiLD+5FejMYDgAjVb86VjUrxQg3tBY3Crq0Ngj0NTQw8riXrZxGirHj2syGJ9t
         pmrSzXziK1UY2xf7yoS8cuiioFgcWbL82LCI1tS/35N0kegxa4lmH+00/L9ZQXJJ+WZM
         HYHv3UUzNi77irVZNwH4xTFCPMJzw9gGIzj7b+nqBUzMPRMChpOwwYvOKIt/AtOZj14n
         0wpJ2YK28qrkkvFXRxSqnjZMXNv8IjqHcYxuHgF/C3E8Ymc3eToqhwmYtDgpOUWk5//s
         AgS3mdiD/EBCNbpSkefTkjL4CvResztUGo0AyFfMmLIZW2AsZL3+2R0b2+Cp+IwXm3Ce
         RdNg==
X-Forwarded-Encrypted: i=1; AL+hErHU9jXY4S6winpY73UiF2520q6ez58oKCMUvLt1S7bjwP7xn3d0l/r3BmFpFZs59SCGZY4MX3femw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C8BhKnI1C8hoDcf7/4emleaDWuwlekIL2Mq++KXdt/HMpB+OT
	33JbXYUYHuBdjnMaKU/N+UT/xg1XWdenNnuZ8lQK1bR1Utvbzc6rfhLLts3p0IKxyQk=
X-Gm-Gg: AYBFou1S5OV6NgYLtFjNPTHZbtJI2IhxdNMSa1tQPkBrLmA4qH6QokUA3wj5SIrcYCi
	cEp+AVFc1g4PvXNtprmozJQcIBvFnG7c0+NvDJ3ZxHoGgunRytfbMPAHaD/O0cPMUAdAJUN6dZh
	sLEw4Zfc94nNZSPwaGJNv8x7BqZnfTnL7xzj4uX5y7QNEh6Ali3O+vrGKUSGETeZ+EK5sCF6CI7
	pJcK82THf6QsbjOTJFXVymfnXaf430hSnEePOOeuuiXRvhmUTWV0AI711HIeOPKmg6jmKXqljvK
	lL/9AguEGuf+At+YJKBbQGtcQ/vKTIMtsuXdJyFuxNZVW8gCTlR750TMHXFdB/nJDsi6vRuPhB8
	KKCcFksrzpva7/4sVt3T0uwgehXcRATjYQFU3V65wGe+vX5mU8hTkWjRTy8UakdWcQPnbF91UHE
	vlmOZwgOHwjfFBL/Hgk28ww8c9eE2xAk1pg1btUulOUwa22A4En6JqCXf1RX5GfjjH/VFm6GQd3
	ImpHHBsuWq4lXVMfMcJP4cmQ4sZHacucfq/FGp4jj8Te5XY+9Dh1R10OD1mA1i5qerQci17rj+N
	dqhyILgfafucx16NncJ/jMJDuq70kQ==
X-Received: by 2002:a05:693c:88db:10b0:381:93eb:9529 with SMTP id 5a478bee46e88-38193eb98e5mr451811eec.19.1794892841137;
        Mon, 16 Nov 2026 21:20:41 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm39990857eec.14.2026.11.16.21.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:20:40 -0800 (PST)
Date: Tue, 17 Nov 2026 10:50:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: Simplify
 bindings
Message-ID: <avvkJSN9zh8tnS2x@vireshk-B250M-D3H>
References: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>

On 05-11-26, 20:46, Krzysztof Kozlowski wrote:
> This binding selects a few top-level compatible machines, but since
> commit 389de9c5a677 ("dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
> bindings optional") only qcom,qcs404 is present in  "if:then:" clause
> which enforces specific OPP properties.
> 
> For all other machines, this is a no-op, because there is no schema here
> enforcing a specific compatible for OPP nodes or any of OPP table
> properties: one can switch to standard OPP table (operating-points-v2)
> and this binding will not complain.
> 
> OTOH, this binding has complicated "if:then:" blocks so is not easy to
> maintain and causes false positives when regular OPP table is
> encountered in matched machines.
> 
> Drop all machines except QCS404 and move the subschema to top-level.
> 
> Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 78 ++++++-------------
>  1 file changed, 24 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> index 547265b8b118..dfc7a27a7bdd 100644
> --- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> @@ -25,22 +25,30 @@ select:
>      compatible:
>        contains:
>          enum:
> -          - qcom,apq8064
> -          - qcom,apq8096
> -          - qcom,ipq5332
> -          - qcom,ipq6018
> -          - qcom,ipq8064
> -          - qcom,ipq8074
> -          - qcom,ipq9574
> -          - qcom,msm8909
> -          - qcom,msm8939
> -          - qcom,msm8960
> -          - qcom,msm8974
> -          - qcom,msm8996
>            - qcom,qcs404
>    required:
>      - compatible
>  
> +properties:
> +  cpus:
> +    type: object
> +
> +    patternProperties:
> +      '^cpu@[0-9a-f]+$':
> +        type: object
> +
> +        properties:
> +          power-domains:
> +            maxItems: 1
> +
> +          power-domain-names:
> +            items:
> +              - const: cpr
> +
> +        required:
> +          - power-domains
> +          - power-domain-names
> +
>  patternProperties:
>    '^opp-table(-[a-z0-9]+)?$':
>      allOf:
> @@ -48,10 +56,13 @@ patternProperties:
>            properties:
>              compatible:
>                enum:
> -                - operating-points-v2-krait-cpu
>                  - operating-points-v2-kryo-cpu
>          then:
>            $ref: /schemas/opp/opp-v2-kryo-cpu.yaml#
> +          patternProperties:
> +            '^opp-?[0-9]+$':
> +              required:
> +                - required-opps
>  
>        - if:
>            properties:
> @@ -62,47 +73,6 @@ patternProperties:
>  
>      unevaluatedProperties: false
>  
> -allOf:
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            enum:
> -              - qcom,qcs404
> -
> -    then:
> -      properties:
> -        cpus:
> -          type: object
> -
> -          patternProperties:
> -            '^cpu@[0-9a-f]+$':
> -              type: object
> -
> -              properties:
> -                power-domains:
> -                  maxItems: 1
> -
> -                power-domain-names:
> -                  items:
> -                    - const: cpr
> -
> -              required:
> -                - power-domains
> -                - power-domain-names
> -
> -      patternProperties:
> -        '^opp-table(-[a-z0-9]+)?$':
> -          if:
> -            properties:
> -              compatible:
> -                const: operating-points-v2-kryo-cpu
> -          then:
> -            patternProperties:
> -              '^opp-?[0-9]+$':
> -                required:
> -                  - required-opps
> -
>  additionalProperties: true
>  
>  examples:

Applied. Thanks.

-- 
viresh
