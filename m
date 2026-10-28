Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174368;
	b=YELndh6lAUZoT1NFwtH8zGVXmH8OIgERJvTBvEf893FJUT19zpoL06GXrzjObJYsI0YM
	 T1z7RKn4JlrulgIK0Zz/uWHsZRZgEvACiFxaxXtyvkA095LIx86fjXKZtC/UfbYL65/t2
	 KFzgIX6lBeBkLJ1RZDfJxgg3ZY/75SFSeqZiQsafRCQR3EjgTWu5EBnT8+ZuKDFPalMgf
	 9xLJHrzOBIBLvLaY3Z3tOgEuBnOCPO+OreFC0zEIFTOykSOO2dQHyw6twZLVs6CLQyUEv
	 DHetNBE+IkYdvnFrZJarNqjjbZ1AViba4qICt1CEwDBflChqP59jKCzHzVKICa5Pw7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174368;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ekqXR/ezjwIhn6QWPuXucxfhVEWQ+CFyrjhl++9kcH4=;
	b=R3HiZseOSer1Tjso4KoFL6oa2dzepiH7B0SBe5dhNyOsIxT9fG2SUEbpboB8bMOZuG1N
	 DmDTxwFWWFX1LJraLRvZZRw5TKoWjkg0dj34Q0zJVq7rYm9U5cBXBPKVZsKbptCtH0UJ6
	 jYTJeR1WGoifwTjxh5SSRtAmIA7U3QST9wr4DhGR8zyBHCOwRizYRBjqMOER7cXTNz1ES
	 J0whf1/APppRoecI3Tw8PdGEA0i44smgZazzK4wWrl7CyD02USt4c7Q9ZOGSTq6QpCbzA
	 mGGkih2lwqPDiccNnGb9sjV9dX2E6/UvU9tNp1VAHWWUJ6kbrMQqDRVL3Ob6Mfv7jVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMly7bgE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65331606A31E;
	Wed, 28 Oct 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMly7bgE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A801F01825;
	Wed, 28 Oct 2026 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793174368;
	bh=ekqXR/ezjwIhn6QWPuXucxfhVEWQ+CFyrjhl++9kcH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMly7bgEdst89yXG5H5qp+z0eVdUxhFCOzUrDLjd32CQlRxQseiYxdycE6BwJ0RFM
	 wFxdC9tay2opS/NbFjIXOnayE7nZtw7w/XqwFV8qiAfqoKQBuqqf8bcW+Ef2r3QW+S
	 FiDIMLqEG1W/a/jsXTuVw4teU7e3nX1eU7CralA/3MW6ibKXYWsveXUCyPrMUlXD/Z
	 CmWq6hYaYVVNSen4Rh1smOdI/KHcpaJr8xZPbO4AzRwvd0kPrisOoi6OZarO2aDgLW
	 pWryvvve3iP0HjZYXmXuw5nEnhuRD/jMX2H1lyAwHY3aIP1tehX5Q+vKnfoGPDefdQ
	 3MQMZj4UTO//w==
Date: Wed, 28 Oct 2026 08:59:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	konradybcio@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <20261028-classic-sloppy-harrier-72dfcf@quoll>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
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
In-Reply-To: <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>

On Tue, Oct 27, 2026 at 12:42:21PM +0000, Ishu Brar wrote:
> Document the Network-On-Chip interconnect providers of the Qualcomm
> SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
> Bus Clock Managers, and add the header with the node and slave IDs.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  .../bindings/interconnect/qcom,sm7250-rpmh.yaml    | 105 +++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++++++
>  2 files changed, 253 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
> new file mode 100644
> index 000000000000..1ae1ebfc27e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7250-rpmh.yaml
> @@ -0,0 +1,105 @@
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
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sm7250-aggre1-noc
> +    then:
> +      required:
> +        - clocks
> +    else:
> +      properties:
> +        clocks: false

Entire allOf goes to the end, before unevaluatedProperties.

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
> +  clocks:
> +    items:
> +      - description: aggre UFS PHY AXI clock
> +      - description: aggre USB3 PRIM AXI clock
> +
> +patternProperties:
> +  '^interconnect-[0-9]+$':

We actually do not need to enforce -0: '^interconnect(-[0-9]+)?$'

> +    type: object
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +
> +    allOf:
> +      - $ref: qcom,rpmh-common.yaml#

Best regards,
Krzysztof

