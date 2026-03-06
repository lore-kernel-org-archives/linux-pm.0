Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161E221540;
	Fri,  6 Mar 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782613; cv=none; b=KtS21G8brkDPmRd4FjbpW4nxggRyag1P0ZFOi2TvaFAkj3pMtSlFTgBGskTtEZ+Rb1oCpiAzeNbj0rW0hCZn7a6e/OlmkGSLwvPJRCys06sEzLX+yW+9S/OlWQe4zRTFPSD5QgKOZv38poQAk2ZXNrOlX47x2ftoPl4H1ATU884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782613; c=relaxed/simple;
	bh=ODvio30d2U39SOyQE9o3r70lLsCN1rTtdRiiHLywxLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meqO7yZhl8K051qAO31v3brH0XpR0vdewesG8o+HArEo9+kLWBWNPWZm/w94kZvq70JVFdNTFj3AG4A6Tw53USnoT4MByBpA3bWpWfH4jYtBd0LwvEcwnuMAWWU5DO2z5NjaEE2NT2Bm6OF0J8myEsbEi5PVkF1rZt46FdIZp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkFDc5bM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkFDc5bM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1943AC4CEF7;
	Fri,  6 Mar 2026 07:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772782612;
	bh=ODvio30d2U39SOyQE9o3r70lLsCN1rTtdRiiHLywxLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkFDc5bMXNYfmBMwQaaWuqd0OKTasExEF96N5g5MPImBTRBZfbKnC7a93tBaV/kTJ
	 uLoOANJ2eldrtDywnk0Hq0mrDL7JLveGXWRrpwRf2i+QLheux5xswai6e+6aJHNOtM
	 pUQd/sp8g5L/kxNhwLfzlHKY1XM0Zam9sBaXyviFYO6oX21Vb14VFzxl62KEAya62l
	 WuCKcXC88+yKXPjZcv0mOC8Xr+AUCczmgVdhvCQGhnCnn6UzohFPLh5d+CshHclIub
	 LlMkK3KGAzw4rwa07LbV3tQ6NDkGivS/6/vHfVlHJo7n9rM4IFvzsTgdmMNHMHeCwS
	 nxqd+L3/aQxzA==
Date: Fri, 6 Mar 2026 08:36:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
Message-ID: <20260306-hopeful-amusing-sawfly-e60c6d@quoll>
References: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
 <20260305-gs101-pd-v6-4-8cb953c1a723@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260305-gs101-pd-v6-4-8cb953c1a723@linaro.org>

On Thu, Mar 05, 2026 at 06:11:53AM +0000, Andr=C3=A9 Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
>=20
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

It is impossible to test a binding in a meaning of "tests", thus you
should not add Marek's tags to bindings patches.

> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> v4:
> - consistent quoting using " (Krzysztof)
> - add samsung,dtzpc to example
>=20
> Note:
> Because the properties added are 'required', this commit breaks DT
> validation of the existing DT for Pixel 6, but a) that's simply because
> the DT is incomplete and b) a DT update will be posted once the binding
> is accepted.
> It is not possible to write the binding such that it supports old
> (incomplete) DTs in addition to the full version, but as per above
> it's not required to keep supporting old DTs.
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index a06bd8ec3c20..c1ee9575092a 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -16,6 +16,14 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
>    reboot-mode:
>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>      type: object
> @@ -39,9 +47,23 @@ properties:
>      description:
>        Phandle to PMU interrupt generation interface.
> =20
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: Child node describing one power domain within the PMU
> +
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: google,gs101-pd
> +
>  required:
>    - compatible
>    - reg
> +  - '#address-cells'
> +  - '#size-cells'

I don't see improvements about quotes.

Best regards,
Krzysztof

