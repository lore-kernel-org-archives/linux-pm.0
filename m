Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3B44C510;
	Thu, 13 Aug 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614064; cv=none; b=BmWQvMlUcjj0rPppCm8INuphh2PZ7pH0OnzMoX9y742W9YsEUUwfQpl11qhdN8wZp9GRANUn3+MlzY2+XDWDal8FYFcWKXw+x90qGeLJl6TaWkIk15La6hPeD+7VaiEHFLnchBdn73k3j1xbGUaLeByaEbUAusnsQry+Ge43yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614064; c=relaxed/simple;
	bh=1DUessA3WA/PJxV03YIb0/PBofH0SZXtXWo26ruA6kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLLnHsCppMbIf0tIL6a0FIe9LbHbR030iidk/7DcGhd6K3EjJ6LDsQsaXKzEdjXr6AZHoSdQvfo41eAk0baOdOouPMYMKpcUFRSoFOa/DfVzTYE7pVZunFCRVFDgjTs1NAsZotEt7rfKcVO9WMg5WDeR6CtEptCpnU18NjJA8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1g5mMhG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1g5mMhG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDA1F000E9;
	Thu, 13 Aug 2026 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614062;
	bh=6h3fj9EFBuuSiOTmlTPz8/Niiq6x1nTLTw/heMte0j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1g5mMhGy1EyRLfp+81037Gi7tsVylVXWmPWfvyDRkbMsgaVcD/p8jZRfz6EVv6+z
	 y+zqNqBO1HD6Wp9Qu/nc36LUS7jvcsAEdhK+0bs+iixzg9yPOl7tZbCuXaW1wwBZwZ
	 f0tnhuzZkfYxBLtkgXc/zVYP+tiWrX1Qg6J2dg8541aaZOt5fVKNcxw8RzvAmM7SvA
	 /W5CO4MZX6XZQ2/TqxfcAiNaOLPZmm6DcviPMbAwPXrcKxDXUlY0hISDG6pAn6KdqI
	 eu1RiQjMzeMJuV6IKVLrcqu2IY16BaJJHn1DFXWOyNXePeHBI3JLOgz5GUhNqv7DXk
	 n/SUhkJXy+o2w==
Date: Thu, 13 Aug 2026 11:40:50 +0200
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
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Message-ID: <20260813-glorious-secret-mantis-dcc083@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-10-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-10-5e0ede4a0c72@oss.qualcomm.com>

On Sun, Aug 09, 2026 at 12:57:09PM +0530, Hardeep Sharma wrote:
> Add the device tree binding and clock/reset IDs for the global clock
> controller (GCC) on the Qualcomm Kuno SoC so its device trees can
> describe the GCC block and reference the clocks and resets it provides.

Almost each of your bindings commit has different style. I would assume
this you would write once and copy-paste.

> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   | 56 +++++++++++++
>  include/dt-bindings/clock/qcom,kuno-gcc.h          | 95 ++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
> new file mode 100644
> index 000000000000..ff01ff31c2e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,kuno-gcc.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,kuno-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on Kuno
> +
> +maintainers:
> +  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks and resets on Kuno.
> +
> +  See also: include/dt-bindings/clock/qcom,kuno-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,kuno-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Board active-only XO source
> +      - description: Sleep clock source
> +      - description: PCIe pipe clock source
> +
> +  power-domains:
> +    items:
> +      - description: CX domain
> +
> +required:
> +  - compatible
> +  - clocks

Not a power domain provider? Then it should not be allowed or explain
oddities in the commit msg.


> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false

Best regards,
Krzysztof

