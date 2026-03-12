Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28863C1966;
	Thu, 12 Mar 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328350; cv=none; b=Mof5pHBAB76LroKlR56H0TwuaZ+icLj90rsfSj7E6rFamGg/jQsasPPjknWkjAcYvmUW0jKLs0sekv288P3G4jPxtsd5SwWiMLe5y2GKkPUwGgZlJK0Uj45pH6vkgN7E3FUUnEc9LJaOivd6XpSMSbZjFVeRVZZleOTomzLWZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328350; c=relaxed/simple;
	bh=OFQkSwxZOQTDuacP85eO/H76W4BsofYz+Vr8zvUhZss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNqzb/CE8Kwme9sGejW0oGq4Z8gZ2LSum9iDQjA9+JVoah6xkXFpt2NTO+XEup/Nfg42L+/Xo0m7oUX8ZArPquu6SgkruT2j/hiKMFSTDld0xiOFhH3v3OvBIX9B2WTgSS+f43gZiT2ajGHKZVVq4lswrwYImKqABbu+w7ATaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo506PWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo506PWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE37C2BC86;
	Thu, 12 Mar 2026 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328349;
	bh=OFQkSwxZOQTDuacP85eO/H76W4BsofYz+Vr8zvUhZss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo506PWqIcT26ISjH6rrBUPGkXjhgqjAHzoarDnOYVpQsajPlcZiwwN/9V76E6z0u
	 LHZZXtz207GTup8BM5hEvD1fNuZ+bsa0maUCc01JFbscA1fGZo7Ndu34koaw7NS4nW
	 OsZXqmq5ByCJGcgcKY5inFwW+7p3k3cZ3HgDuPqVhfgcMGnawXSP0MEJo65OLa/mb7
	 7DqNOMSD7EyKmxloJzEk8iJxCS+dXWm85d8sIn2RsmdE1p0hnXaDLsTZsrQmeqw/yZ
	 dcuHyKTYnDhNF8A+9m7kjkj6DmSmjDtzmh1AlIv7uph1rGH9XYcADRTAC/LvfGtczf
	 TdA50RewHETyg==
Date: Thu, 12 Mar 2026 10:12:28 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
Message-ID: <20260312151228.GA3136988-robh@kernel.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
 <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306-gs101-pd-v7-4-03f7c7965ba5@linaro.org>

On Fri, Mar 06, 2026 at 10:29:55AM +0000, André Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> v7:
> - really be consistent with quoting (Krzysztof)
> - drop invalid tested-by tag (Krzysztof)
> 
> v4:
> - consistent quoting using " (Krzysztof)
> - add samsung,dtzpc to example
> 
> Note:
> Because the properties added are 'required', this commit breaks DT
> validation of the existing DT for Pixel 6, but a) that's simply because
> the DT is incomplete and b) a DT update will be posted once the binding
> is accepted.
> It is not possible to write the binding such that it supports old
> (incomplete) DTs in addition to the full version, but as per above
> it's not required to keep supporting old DTs.

This information needs to go in the commit msg.

> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index a06bd8ec3c20..dfe6f87e5949 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -16,6 +16,14 @@ properties:
>    reg:
>      maxItems: 1
>  
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
>  
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
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
>    - google,pmu-intr-gen-syscon
>  
>  additionalProperties: false
> @@ -51,6 +73,25 @@ examples:
>      system-controller@17460000 {
>          compatible = "google,gs101-pmu";
>          reg = <0x17460000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
>  
>          google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
> +
> +        pd_g3d: power-domain@1e00 {
> +            compatible = "google,gs101-pd";
> +            reg = <0x1e00 0x80>;

I'm assuming 0x1e00 is an offset from 0x17460000. That's not what ranges 
says though. It says both addresses are in the same address space 
(system-controller@17460000 parent's address space). You need:

ranges = <0x0 0x17460000 0x10000>;


> +            #power-domain-cells = <0>;
> +            label = "g3d";
> +            samsung,dtzpc = <&pd_g3d>;
> +        };
> +
> +        power-domain@2000 {
> +            compatible = "google,gs101-pd";
> +            reg = <0x2000 0x80>;
> +            #power-domain-cells = <0>;
> +            power-domains = <&pd_g3d>;
> +            label = "embedded_g3d";
> +        };
>      };
> 
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
