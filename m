Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093329;
	b=F8ugnITeZEFXQNJyP15CJO1Fmab8ZSIMxf5Br/G/oUO3whzV/HKWUf+SQjoor4YHUvXn
	 LI53EHtOgTZOR7IgEJVVU4hvOp723rFvfO26VtZ4CnD9FbLSBqhLegdabdhtEdfiF+HR3
	 kliW6ig0X5RNmocjPpqHElceG/U9ABzsdQlBB/Bewhh9j/VFCsWBQiF7xR8wNmMs0+plJ
	 L9Q34X5KRgk7JEWJfQTpcLNOVyuTUPhUros0sJ/fToMmF7Wx+5i2YP2MmdXYrDsaNqlai
	 0cY5H6Ob6G2u30o0iV9Go1MnuN1yEymb7dgsuDITdnox6RZ95mD3+4ZEsDqSbwgvGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V8WGmLvJrYrUF06O45/IMg99GC4FvPEC3Xa55t3AmUs=;
	b=ERVcn6D1UYLw9f6m/yGiZs9xi/RLQnAndz+0pGdO9DGgp3Q/lDmwchGGnDYRsq8kAHFG
	 i9BowRU2KYlKxjN5j34q3KptXY3SpEsfh9aJ4SezgrAH7LTZ3eud+kOO4VncmqwSJGUrc
	 UYSWhVHBZx8to3xfbUmyjJtMxXjOd/HPja/leyLI/siVWyTn4jG8vK7c7RMExyAbQDnKg
	 vR1CXN/cSeyGlCZMrQBDcZYI+SI0AhxEq+z28b4n/i8v5UJDflrtsTgYN/R5upnaFfrzh
	 dOLNekxDp75N0KVtExIijJD8mrBAG2EjgxQ2XGADggvXwFYPhkxV8PnJ9efYXcNl5+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdLL2UOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0249606A31A;
	Tue, 27 Oct 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdLL2UOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500091F01825;
	Tue, 27 Oct 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093328;
	bh=V8WGmLvJrYrUF06O45/IMg99GC4FvPEC3Xa55t3AmUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YdLL2UOg5euqAuLuGOHMpQN5ll00NfPwGOe33j9Rgmj5cJnXxE60fbWzRIIDIuPE9
	 evSlohBDpAaCPqG1shiGZtDS1GlKqI1FA0+Zx01zcQX7cDOOr7zAT2SJxRTBUijkCA
	 2e+g6/2ZoLQpUWTlD/in5ja7Gp9btcIjK86+623ZGznX2uK4YoiVxYkDEb1FCD9uwY
	 1r6G41UjXaqVD3yl13LrcQcCpw644+jVaa49DHYW4I+7uI+698gY6obXMuf6eTQyfm
	 8whWhHKoIXrVZ3rBhhKCJ/mpgy4XVMLkrW7UJvOPrq2UZhPeuzxz5mLroWS2irtNXj
	 BcRo341QNS2Rw==
Date: Tue, 27 Oct 2026 10:28:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <20261027-tangible-steadfast-serval-caccf3@quoll>
References: <20261026-icc-sm7250-v3-0-aa303226298c@brar.si>
 <20261026-icc-sm7250-v3-1-aa303226298c@brar.si>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026-icc-sm7250-v3-1-aa303226298c@brar.si>

On Mon, Oct 26, 2026 at 11:18:17PM +0530, Ishu Brar wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm7250-aggre1-noc
> +      - qcom,sm7250-aggre2-noc
> +      - qcom,sm7250-compute-noc
> +      - qcom,sm7250-config-noc
> +      - qcom,sm7250-dc-noc
> +      - qcom,sm7250-gem-noc
> +      - qcom,sm7250-mc-virt
> +      - qcom,sm7250-mmss-noc
> +      - qcom,sm7250-npu-noc
> +      - qcom,sm7250-qup-virt
> +      - qcom,sm7250-system-noc
> +
> +  reg:
> +    maxItems: 1

So no children? Why? Your previous version said they cannot act
independently and need regmap from the parent. I did not ask to remove
children, but to remove pointless comment. Mind where the reviewer
comments are placed.

Also, where are the clocks?

> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm7250-compute-noc
> +              - qcom,sm7250-mc-virt
> +              - qcom,sm7250-qup-virt
> +    then:
> +      properties:
> +        reg: false
> +    else:
> +      required:
> +        - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    interconnect-0 {
> +        compatible = "qcom,sm7250-qup-virt";
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };
> +
> +    interconnect-1 {
> +        compatible = "qcom,sm7250-mc-virt";
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };

Drop node, redundant, because you have exactly same example
(interconnect-0).

> +
> +    interconnect@1620000 {
> +        compatible = "qcom,sm7250-system-noc";
> +        reg = <0x01620000 0x19200>;
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };

Best regards,
Krzysztof

