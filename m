Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1193B0592;
	Mon, 17 Aug 2026 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951702; cv=none; b=IfgqYKp1PHKOr73PxID76ZqlCFngrj1H4+ey6xiTLwgVFVNmtHz3Cm72d2F9e7jGv9w9oi13tEV9787jae1+eDV/sFj8gYpgCQjs7FuKdr3y8lTA8hW5g8Z202ecE8pEjvKzfmR+spHRELRvwl734tnkM2FEeblwp7Qp9i4fP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951702; c=relaxed/simple;
	bh=NTPCka+AzCW8wFydr1u2xb3QE1oXN/DlQwphmHfUDdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbJy/fTswnMA010eyKtcSxgvymIJwyUw4ud8XfbVj4CgPHDJxXQ2OdkmTBcnbxEeUONWeUQ3oQK/CGLRqoa+KZ/sFtSTywzIwUNfd1UuJVKSkcB1dYLZxprWOh2r/14HgjAKQGUZUceuAh0sLhZR6PEHaXddVCmSsbB4VXbOIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzX5FRes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzX5FRes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A2C1F000E9;
	Mon, 17 Aug 2026 07:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951700;
	bh=ez1L8EuXpvjZrmwXpLrYB3re7fNuMma9R9rfZ9jgWlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzX5FRes2wCPZfU8yoZCaoqTsuVGUZMSbHaWHEu2Cx/1f585h3wW5INeLRVBn80rR
	 M6zjHt1vbhCO/RUcvS/jbBB9EGRqFd6Tup8fh1pOKWE55PifqdihTFWpsCspuK7coh
	 y7uNjoDOy9yz4WWszehblkf9eP7n6g9khQw1Qd41KzRuUoufF0pfE5YwLlMXjEEH3v
	 uv+yeyOn3wu1c5t2tgCgGO/4wx9j6Vv3FVv4bCVJebY7oVsLaFI9pcTX8UX47Iig9p
	 BNxAMQiWhzOK/FCURtKMmNog0CugIWO2Pe0Dc0oBpDXa9h9zJR9Q17QZy0jmSMczsy
	 X5NomQnYBoosA==
Date: Mon, 17 Aug 2026 09:28:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Message-ID: <20260817-benevolent-nyala-from-valhalla-46cbbc@quoll>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-6-3079794f0f73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-kuno-soc-support-v2-6-3079794f0f73@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 01:01:37PM +0530, Hardeep Sharma wrote:
> Document the RPMh-based Network-on-Chip interconnect providers and
> associated node-ID definitions for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 82 ++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,kuno.h       | 89 ++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
> new file mode 100644
> index 000000000000..ffbf14356f12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,kuno-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on Kuno SoC
> +
> +maintainers:
> +  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
> +  associated with each execution environment. Provider nodes must point to at
> +  least one RPMh device child node pertaining to their RSC and each provider
> +  can map to multiple RPMh resources.
> +
> +  See also: include/dt-bindings/interconnect/qcom,kuno.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kuno-aggre-noc
> +      - qcom,kuno-clk-virt
> +      - qcom,kuno-cnoc-main
> +      - qcom,kuno-dc-noc
> +      - qcom,kuno-mc-virt
> +      - qcom,kuno-mem-noc
> +      - qcom,kuno-pcie-anoc
> +      - qcom,kuno-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4

Why are these flexible?

Look at other bindings how this is done.

Best regards,
Krzysztof

