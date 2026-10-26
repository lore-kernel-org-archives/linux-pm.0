Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010394;
	b=Yz+D6i2/eJRwsUzF49eCEneRwiXhqdrD75kxzLW1FVBGV/rFjxORf6cidfl+aXl4iqwv
	 GBW5YlgmcdOJcY0cfcN3sKaTmbIVd18EqgHNHKZ0TqyRqEb9JWqI4ZZxLOlsBLIuSlTuX
	 yBzH5cpZzycPpfeBDJgYUi0aXBVaLpD0bPmmVCcy9B4PCvKboTArKYW96lvs7utQtNy9c
	 t6SgAW0hJtQBDXIVdBPhjGoINVqzO58zGmQcYWPE0e5i+Px4eUUeFgt+jy+xpwiSt0iGx
	 Mq58w1t/QiHxNiAFJIsa4Il6l+mRCp8DxCHxQG8tQuW6hfy6WAjyQ6oBzeJImMwcQPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eHcMPsGRbqJbXvtG9Us6VT3nO3822zW0WZWA0+by0e8=;
	b=Q1iN9X/v9zlOouokHFEgc3Excq6zfmpzccC9ojPbC0jvfJjjmmW5zuAUrBzt4ODW8t/Y
	 CJ9jFLx0gU26ReuKAWCWcrh8H5J0PIngqJ5emQaukNaJxNN5txaQ5BKy6CHocf7S6iiyj
	 Xbqx7bi/a5U4uR24xIetzBLYzv/a+pkeJWumY2WnjMcdKv6VzgMN+l2bpsEajr+ci20sR
	 lLbnW+zEDEVq1kotQ6LrtQTca9fEPmdEqZNj5cn3nhD5syw+x+ny/VW8AZUrXfGcyGCyt
	 /meTOCmiB1dJKlg1oBfJKko9M9WAjsoBRkFXtO0cQr4UtL5dTPPs2PYPUn0mxIKOlkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PRdQQT3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD796606A31A;
	Mon, 26 Oct 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRdQQT3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB871F01825;
	Mon, 26 Oct 2026 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010393;
	bh=eHcMPsGRbqJbXvtG9Us6VT3nO3822zW0WZWA0+by0e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PRdQQT3/otIPoJ1Uzl1HCJ637GIeKYnkt2E4sfRnx/b/i2a6QvXc7Uz+RwIxdFMtp
	 t2tJE7O4V7Eh3GmQ8jkHdvhyfsea/dJW7Hp1/kvVIAhxez8DRovHsvMA3F6UCjHpLL
	 OJjrA8XL2JaWCcxh8U9XQp4ajtJeSocMadD6FMu4KYXNai+mTfXARmAOrflEYPXEZ7
	 I3zWelFh4WjVf8em2jf+8ZIZnLO4BrbojDbkhaMTS+aLcTjdlDSQ7++IUK/usut3vS
	 jQeWTZceMwLrscW612/f+3BH8PGs24ywgzec+RR/b8KG73s6evD6nqQI7adD2lVAB6
	 czsszmTjJu1eQ==
Date: Mon, 26 Oct 2026 11:26:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC bindings
Message-ID: <20261026-cherry-muskrat-of-piety-4911ee@quoll>
References: <20261024-icc-sm7250-v2-0-0e755894b188@brar.si>
 <20261024-icc-sm7250-v2-1-0e755894b188@brar.si>
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
In-Reply-To: <20261024-icc-sm7250-v2-1-0e755894b188@brar.si>

On Sat, Oct 24, 2026 at 08:40:53AM +0530, Ishu Brar wrote:
> Document the Network-On-Chip interconnect providers of the Qualcomm
> SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
> Bus Clock Managers, and add the header with the node and slave IDs.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  .../bindings/interconnect/qcom,sm7250-rpmh.yaml    |  95 +++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++++++
>  2 files changed, 243 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
> new file mode 100644
> index 000000000..f8891faa8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm7250-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM7250
> +
> +maintainers:
> +  - Ishu Brar <patches@brar.si>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +  See also: include/dt-bindings/interconnect/qcom,sm7250-rpmh.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm7250-aggre1-noc
> +      - qcom,sm7250-aggre2-noc
> +      - qcom,sm7250-config-noc
> +      - qcom,sm7250-dc-noc
> +      - qcom,sm7250-gem-noc
> +      - qcom,sm7250-mmss-noc
> +      - qcom,sm7250-npu-noc
> +      - qcom,sm7250-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +# Child node's properties

Drop comment

> +patternProperties:
> +  '^interconnect-[a-z0-9\-]+$':

Why this has to be a pattern, not 'interconnect'? And anyway, pattern is
'^interconnect-[0-9]+$' if you have multiple children.


Best regards,
Krzysztof

