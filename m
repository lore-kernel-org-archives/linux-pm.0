Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F842EEB7
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415269; cv=none; b=AL0hRsWtg4q0F971y9xTNtnz9h/uEFxx3u7Dew/zw6BCJEMarpKo6TM45cteYNjzXhTO+KJe7xPO/oQTBmGvQ3Ym6vtir6j2o+OS6kAjde5I8fZU8jjdbiJGEOH5kZJZ+4/LzE9m/dTjpG/ldirqfvAuajblmgTCmCyAgZnnD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415269; c=relaxed/simple;
	bh=t5o0y2/SJvXG9lCHetx3RMBak7avXDKQDjHj2cZyWwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSbjrGWS6R4j51nDZstswYNQTFHkY0Q98i8ho8KQXLfulj0O1apCIbrwI/375q34uZIgAke0vkqFd0FsyT8xBhq2ya/tvOUSVeBz47xZRcnoA+KaoFpRFVQiABPXRiRtVOXtXx7TPMRBjn7qzetG1uHJorWshkuiNKuU+zprGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kcf2W2fV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HUeS+n/b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kcf2W2fV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HUeS+n/b"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UB8E0q825720
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nk3YlK7n3Nu0vqzXpHhwmvmJkRiBA+wHllXI2VhY2wA=; b=kcf2W2fVOJsELi7L
	RKSgD79Df1gz7S98qhWXBTQIC8GkwYzCjqjPc8cdVBMJ8o6lroAqmVxlFxTvvbUr
	Ynpowtp/YQ5p4MAmodTjpmmMkTjgSG95TTUpmyPSAgMMiY9BUvM2klfmlKVtRIBY
	pPwAk8VniOBQUUoUrZedFvTBMS9jYwYnxd1CdvYuZseBQP39hI5BGV/uPdKOumA7
	GMVPqbN3Ryo3TjDIRKvGq1nwMrvItwugNggXZSo/Jir88nUm5P+dgUfKlb83g8oB
	mcTzg6UpQvjbajUFcu/mF2o49wOnkem6FmpvPREWzlcqTVr5o1s0NkrKbTydnxoJ
	s/cx/w==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5fprb1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 12:41:04 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eb7dc4e28so70548777b3.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785415263; x=1786020063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nk3YlK7n3Nu0vqzXpHhwmvmJkRiBA+wHllXI2VhY2wA=;
        b=HUeS+n/bbA5lTHRWfeZn7FIEPjK7VN1ROYM/JsKti/LH0a2ceoGKsFF60W+NYlFYdI
         54rEBdqPVzguA80g48Tt+U+8NPulYPvBC9mkGYQnM9jRO1eAtbzSFWyLkwwSIsxSgwmC
         eCR/z7jEw7bWWuTi1vHYHGyJHcbzaxA73tSUHb9eU1wGzzOprhl5ckJMvIMO5Q2vPaz0
         JIbYKFDMDgDl1TWv8Mc+gb/b5/T2j5uGgL0FjwdrNGhSqzYXkpiuvTPmkG7cltM1pDKy
         QauRRqOMe5Gss+NjhMoJjb3jlP4QrLD5mzg1Vv13R3C/m0nlyvyJfAF+8zHDVZWPkBZA
         zCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415263; x=1786020063;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nk3YlK7n3Nu0vqzXpHhwmvmJkRiBA+wHllXI2VhY2wA=;
        b=RfNvq87WUmS4lqdo1EVAumoDbYlWQSnUFNrQBmInrTERtg4R/AuxPovYQZhKOynPas
         Y0vuIYpMiyCxXBKEYdmpEekr+0cO1buN4qv6BF/2WZB2XwKb9kVg7EVGgNQ4If7P9CtK
         qXnC7RH0z/IcYXGLrb++mAgbe/Xv4nTfw/hmG+J7vtSMIqcLega7CDMohJwB1tltMtO0
         YDHf2RY90n5755VFUFnuXyBVnPB/SZALscksqy+HEKanXq6c8jmotJ4QvK453qDo8PK0
         l7DC4phVuT6tpmOcM8GQKSyxAKgWDbNjh8Jmlpj49gaNp3LARrpKVKUv2YRIgUvN0mZt
         5qew==
X-Forwarded-Encrypted: i=1; AHgh+RqM2YJZVYfH2I5udRGXGKomCuugtBpnsp4AK6MclSwS4LQ61USNucuXIFqV1mDW7hzre4fgnWVgKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuz76kzUcmejEwFt/yzJZTXbciRGRBaohjQ+JTFNbeyqRw3wQJ
	xuuOoPLD/ppEecdKKLmsWpeLB06c93UIOd1/sNKpe5bLXj08F4kw1aISuEk+oxZp8LEQcsy9rZ1
	jXQO07M1Tc6NluuRZiIwrqAvTvteC8QX9vtg7CfJItV7kqD1SSE7HGSxl7kotrpWycCd/KuGxs4
	Q=
X-Gm-Gg: AR+sD13iLLJ4MguCtfxgzq34n4ADWvxuuCXOq6RddeaDONgTIU7Dynha2Ps7iV0yY0X
	o6Djdq1Gra2ymeOfMkWi9XJjK63m3bdWBteDKPE78Gut+REWrj1IxTb5+8dQqCkUVemEeFVxluj
	klmiEA7/VhTWDsbuVPYodAYf3QNJp2EyBytinRt+FiearzFzcxOFP9Qd9jR7Bf4/dqIIARSJzoX
	sdiyN/+epox/bKCqyv+sxYRm2yeZEgrFTmKFBPkQYjZcnUL2PDvNbnvVVwwDsQyC5JgA6anVPb6
	9V6ofcSX2V1xkhMplt73mDvQmWfeD+fWGl9MYADFGCpm3RHGEliKDV7pb1YqujlcDmEGoDgPJDs
	czGESyQTTFY2a6JzdCJU5W4FrwGXYFUolPBWFIo4GecZNzDF0kUvMXKXt9zyUzH7IZg==
X-Received: by 2002:a05:690e:4894:20b0:667:8c87:25ef with SMTP id 956f58d0204a3-6692f73fff0mr1225286d50.71.1785415263164;
        Thu, 30 Jul 2026 05:41:03 -0700 (PDT)
X-Received: by 2002:a05:690e:4894:20b0:667:8c87:25ef with SMTP id 956f58d0204a3-6692f73fff0mr1225272d50.71.1785415262619;
        Thu, 30 Jul 2026 05:41:02 -0700 (PDT)
Received: from ?IPV6:2a01:cde0:108:24ed:2206:62e9:bbc4:c360? ([2a01:cde0:108:24ed:2206:62e9:bbc4:c360])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c734cfasm1186898d50.6.2026.07.30.05.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 05:41:02 -0700 (PDT)
Message-ID: <16a17547-8292-46d0-94e1-0d9a49db55cf@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 14:40:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: power: Add power-limit-controller schema
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
References: <20260703-modern-indigo-wolverine-6b6eaa@quoll>
 <20260709180727.4015267-1-manaf.pallikunhi@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260709180727.4015267-1-manaf.pallikunhi@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ErfiaycA c=1 sm=1 tr=0 ts=6a6b4660 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=YG6TYCAIP6Cmhb9qLQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NSBTYWx0ZWRfX1tQc+iGD+X/9
 RTHM+mGyBBz+sXD0o4I3hrDYEq3G/zaDcg+RE2kjyATLHPAIgpecihGJ5u4IVwTnzyc24H8I2fq
 a0Pf43l1kxOPU/zqL0omWpyWJihaDlBomi5bFHz86q0zWC6uyiuwSa3uHrebcAoJolT2MJZHUde
 6D65TZIUDDLcpT0T53+SZCBHa5KGi+rOEhDALjBYf2qimGTjO6+HVdjKbGL++PrXlDO42DcLdlD
 Ly1PQSzLk4VXrlMU9i7XFpo90uLcZBMJepusHs1iByrx5shMjpYVNbG3ezVlqCt1qz+EYwo7pJ2
 Y5NWlzo4e8IjduGBbsuF/v6WyOtNxtPCwhA48qqo+6ILl6Fi9C+XL3Yakuu9IVarQBxMvWTIdtt
 TfMHetkdTsO5V6TM4wFLmR4H0cB6xyzspmqGIb5D4P+r5T2qwegiD1/4WzXVmgwY8OJp8NPWmei
 yqgnj8aMkftBQJus9vA==
X-Proofpoint-GUID: QjV7dDRjl7YjN0WoW38vmGbCm0V80aO1
X-Proofpoint-ORIG-GUID: QjV7dDRjl7YjN0WoW38vmGbCm0V80aO1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NSBTYWx0ZWRfX3HVzORrDMu1M
 jEMmZDgNHKMpefHBRdJBAY7Km5unUrMrzX0/pqKhlBvcNMfc6uoZt3UlVK8POvAcKiPB5wvbtTR
 YfqI3iL2Y1zjZO3bCZT6K8x2+am7Fd8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300095


Hi Manaf,

[+Cc Ulf]

On 7/9/26 20:07, Manaf Meethalavalappu Pallikunhi wrote:
> This RFC proposes a new device tree binding schema for power limit
> controllers that manage SoC power domains with hardware-enforced power
> capping capabilities.
> 
> Background
> ==========
> Modern SoCs implement sophisticated power management hardware that can
> monitor and enforce power consumption limits across multiple power
> domains. For example, Qualcomm's SPEL (SoC Power and Electrical Limits)
> manages hierarchical power domains including system-level, SoC-level,
> and individual subsystem domains (CPU clusters, GPU, modem, etc.).
> 
> These controllers help prevent thermal overload, maintain system
> stability, and comply with platform power budgets. However, there is
> currently no unified device tree representation that can describe their
> hierarchical nature and diverse capabilities.

I'm wondering if that could be described with the power domains and some 
additional properties

Documentation/devicetree/bindings/power/power-domain.yaml


> Proposed Schema Design
> ======================
> The schema supports a flexible, hierarchical structure:
> 
> 1. Power Limit Controller Node
>     - Root node representing the hardware controller
>     - Uses #power-limit-domain-cells for domain referencing
> 
> 2. Power Domain Nodes (power-limit-domain@N)
>     - Individual domains/zones under the controller
>     - Each domain identified by a register index
>     - Optional parent-domain property for hierarchical relationships
>     - Can be either:
>       * Monitoring-only (no power-limits child node)
>       * Power-limiting (with power-limits child node)
> 
> 3. Power Limit Constraints (power-limit@N)
>     - Multiple constraints per domain (PL1, PL2, PL3, etc.)
>     - Each constraint defines:
>       * Settable power limit (with min/max bounds)
>       * Settable time window for power averaging (with min/max bounds)
>       * Default values at boot/reset
>       * Constraint name for identification
> 
> Hierarchical Example (Qualcomm SPEL)
> ============================
>     System Domain (with PL1/PL2)
>       └── SoC Domain (with PL1/PL2)
>             ├── CPU Cluster Domain (with PL1/PL2)
>             ├── GPU Domain (monitoring-only)
>             └── Modem Domain (monitoring-only)
> 
> Before investing further in this direction, we would like to check with
> the community on a few points:
> 
> 1. Is a generic power-limit-controller binding the right approach here,
>     or should this remain a vendor-specific binding (e.g., under
>     qcom,spel)?
> 
> 2. If a generic binding is acceptable, does this schema design look
>     reasonable as a starting point?
> 
> 3. If this is the preferred direction, we would need to design a
>     generic driver that consumes this binding and exposes the domains
>     via the powercap sysfs interface — effectively requiring a
>     significant redesign of the existing Qualcomm SPEL driver to sit
>     on top of a vendor-agnostic core. Does that align with what the
>     community would expect here?
> 
> Any guidance on whether this is the right path forward — would
> be greatly appreciated before we commit further engineering effort.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> ---
>   .../power/limits/power-limit-controller.yaml  | 238 ++++++++++++++++++
>   1 file changed, 238 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml b/Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml
> new file mode 100644
> index 000000000000..9cd4d9d6414d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml
> @@ -0,0 +1,238 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/limits/power-limit-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power Limit Controller and Domains
> +
> +maintainers:
> +  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> +
> +description: |
> +  Power limit controllers are hardware blocks that enforce power consumption
> +  limits on SoC power domains to prevent thermal overload, maintain system
> +  stability, and comply with platform power budgets.
> +
> +  The binding supports a hierarchical structure:
> +    - A power limit controller
> +    - Multiple power domains/zones under the controller
> +    - Each domain can have power limit constraints or be monitoring-only
> +    - Domains with constraints support multiple power limits (PL1, PL2, PL3, etc.)
> +
> +  Controller capabilities:
> +    - Hardware-enforced power capping for one or more power domains
> +    - Multiple configurable power limits per domain (sustained, burst, peak)
> +    - Time window controls for power averaging
> +    - Energy or power monitoring and reporting
> +    - Power balancing algorithms across domains
> +
> +  This binding describes the common properties for power limit controller
> +  provider nodes. Individual controller bindings should reference this schema
> +  and add device-specific properties.
> +
> +select: false
> +
> +properties:
> +  $nodename:
> +    pattern: "^power-limits(@.*)?$"
> +
> +  '#power-limit-domain-cells':
> +    description: |
> +      Number of cells in a power limit domain specifier for child domains.
> +      Typically 1, representing the domain index.
> +    const: 1
> +
> +patternProperties:
> +  "^power-limit-domain@[0-9]+$":
> +    type: object
> +    description: |
> +      Individual power limit domain/zone under this controller.
> +      Each domain can either:
> +        - Have power limit constraints (with power-limits child node)
> +        - Be monitoring-only (without power-limits child node)
> +
> +    properties:
> +      reg:
> +        description: Power domain index identifier
> +        maxItems: 1
> +
> +      domain-name:
> +        description: |
> +          Name of this power domain (e.g., "system", "soc", "subsystem").
> +        $ref: /schemas/types.yaml#/definitions/string
> +
> +      parent-domain:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: |
> +          Reference to the parent power limit domain, if this domain is a
> +          sub-domain of another domain. This establishes a hierarchical
> +          relationship between domains.
> +
> +          For example, a "subsystem" domain might be a child of a "soc" domain,
> +          or a "soc" domain might be a child of a "system" domain.
> +
> +      power-limits:
> +        type: object
> +        description: |
> +          Container node for power limit constraints within this domain.
> +          Each child node represents a power limit constraint index.
> +
> +          This node is optional. If omitted (or if monitoring-only is set),
> +          the domain provides only power/energy measurement without limits.
> +
> +        patternProperties:
> +          "^power-limit@[0-9]+$":
> +            type: object
> +            description: |
> +              Individual power limit constraint configuration.
> +
> +              Each constraint defines:
> +              - A settable power limit
> +              - A settable time window
> +              - Optional min/max bounds for power and time window
> +              - A name identifier
> +
> +              Typical constraint indices:
> +                - Index 0: PL1 (sustained/long-term power limit)
> +                - Index 1: PL2 (burst/short-term power limit)
> +                - Index 2: PL3 (peak/instantaneous power limit)
> +
> +            properties:
> +              reg:
> +                description: Power limit constraint index identifier
> +                maxItems: 1
> +
> +              constraint-name:
> +                description: |
> +                  Name of this power limit constraint (e.g., "long_term", "short_term").
> +                $ref: /schemas/types.yaml#/definitions/string
> +
> +              power-limit-min-microwatt:
> +                description: |
> +                  Minimum power limit that can be configured for this constraint.
> +                  Represents the lower bound of the allowable power range.
> +
> +              power-limit-max-microwatt:
> +                description: |
> +                  Maximum power limit that can be configured for this constraint.
> +                  Represents the upper bound of the allowable power range.
> +
> +              power-limit-microwatt:
> +                description: |
> +                  Default power limit value for this constraint at boot/reset.
> +                  This is the initial value that will be programmed.
> +
> +              time-window-min-microsecond:
> +                description: |
> +                  Minimum time window for power averaging.
> +                  Shorter windows allow faster response to power excursions.
> +
> +              time-window-max-microsecond:
> +                description: |
> +                  Maximum time window for power averaging.
> +                  Longer windows provide more stable power limiting.
> +
> +              time-window-microsecond:
> +                description: |
> +                  Default time window value for power averaging at boot/reset.
> +                  This is the initial value that will be programmed.
> +
> +            required:
> +              - reg
> +
> +            additionalProperties: true
> +
> +        additionalProperties: false
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: true
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    // Multi-domain power limit controller with mixed capabilities
> +    // Demonstrates multiple domains with and without power limit constraints
> +    power-limits@ef3b000 {
> +        compatible = "qcom,glymur-spel";
> +        reg = <0x0ef3b000 0x1000>;
> +        #power-limit-domain-cells = <1>;
> +
> +        // Domain 0: System domain with full power limit control (PL1/PL2)
> +        sys_domain: power-limit-domain@0 {
> +            reg = <0>;
> +            domain-name = "system";
> +
> +            power-limits {
> +                // PL1: Sustained/Long-term Power Limit
> +                power-limit@0 {
> +                    reg = <0>;
> +                    constraint-name = "long_term";
> +
> +                    power-limit-min-microwatt = <15000000>;     // 15W min
> +                    power-limit-max-microwatt = <28000000>;     // 28W max
> +                    power-limit-microwatt = <20000000>;         // 20W default
> +
> +                    time-window-min-microsecond = <1000000>;    // 1s min
> +                    time-window-max-microsecond = <10000000>;   // 10s max
> +                    time-window-microsecond = <8000000>;        // 8s default
> +                };
> +
> +                // PL2: Burst/Short-term Power Limit
> +                power-limit@1 {
> +                    reg = <1>;
> +                    constraint-name = "short_term";
> +
> +                    power-limit-min-microwatt = <15000000>;     // 15W min
> +                    power-limit-max-microwatt = <64000000>;     // 64W max
> +                    power-limit-microwatt = <45000000>;         // 45W default
> +
> +                    time-window-min-microsecond = <10000>;      // 10ms min
> +                    time-window-max-microsecond = <1000000>;    // 1s max
> +                    time-window-microsecond = <28000>;          // 28ms default
> +                };
> +            };
> +        };
> +
> +        // Domain 1: SoC domain - child of system, monitoring only
> +        soc_domain: power-limit-domain@1 {
> +            reg = <1>;
> +            domain-name = "soc";
> +            parent-domain = <&sys_domain>;
> +
> +            // This domain exposes only:
> +            // - power_uw (current power)
> +            // - energy_uj (energy counter)
> +            // - enabled (measurement control)
> +        };
> +
> +        // Domain 2: Subsystem domain with single power limit
> +        power-limit-domain@2 {
> +            reg = <2>;
> +            domain-name = "cpu";
> +            parent-domain = <&soc_domain>;
> +
> +            power-limits {
> +                power-limit@0 {
> +                    reg = <0>;
> +                    constraint-name = "subsystem";
> +
> +                    power-limit-min-microwatt = <5000000>;      // 5W
> +                    power-limit-max-microwatt = <15000000>;     // 15W
> +                    power-limit-microwatt = <10000000>;         // 10W
> +
> +                    time-window-microsecond = <1000000>;        // 1s
> +                };
> +            };
> +        };
> +
> +        // Domain 3: Another subsystem - monitoring only (no power-limits node)
> +        power-limit-domain@3 {
> +            reg = <3>;
> +            domain-name = "gpu";
> +            parent-domain = <&soc_domain>;
> +        };
> +    };

