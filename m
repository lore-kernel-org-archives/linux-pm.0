Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BAB3B6BEB;
	Mon, 17 Aug 2026 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952655; cv=none; b=u8JyYn4Sig/JgWz/iJ399hotkWqb+IDL0SVpGV146zq4IauuGPzbWjrlyZzfzpLSJ0ghBlOLKm5WfFyzS64m7OFNaPfopmmuhi7KhOebhh/fN2ywbqi112eOBQ/ygMFEnPGOYFcwndB2jjiKChVz+xE+0srYG1UsiHGErCXy6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952655; c=relaxed/simple;
	bh=l/jYvcf8rCTB/Nef5iMkr2YCab1jQY66Gy+BytBsQKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3ujhzFG4M1CbUy31U1dAXb26FZt2ucz3jSRJCyRxF3Ovk4KfbsYfZpZntLXyFd0sp+OFCqdDF68q/6ofZeyUaF4nTTG/kjc+C1oDoKU3bfGXhLr+ZAI/YukRwZ+WxWS/mMp3WQ2rtyP2xZ+hHkMP+9QtsBm30VItz9ERoFCcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzRYm+Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzRYm+Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01031F00A3A;
	Mon, 17 Aug 2026 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952653;
	bh=3IbxIvkXSdGUmIdqZNdFr0n8OgHN4CpP2gFX1ad04a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AzRYm+SajlUWLlqli7WPH1kxUntEOtGCykc2Rv2E3n59KVZdyjZ/h8mVOTZB4/V5m
	 aBn9J4I8wlNbCBSstuoFWt/vd2T6OFJrpYjw+kuSc9q91L/evRBoz5SMuPS2NaGaqo
	 NZSj+454j4CIY/RJ1NLpDw64O960cU40/QRyOgC8sR1V2Rq9qu958MNWKAsRUm2Ve8
	 s6RNiPtMYVNkHgJGJKZPXs+BROr47mR14qwC2iYflSoLZhkDo5IBfwYWMuN9WRqKWN
	 ZwVBy48gaqRFu72lWBQiDRCliqx0Z9zrQTb5ZliuTx57NxhRY9WUIen68b2vGfyocP
	 UgG6AeS5b9ngQ==
Date: Mon, 17 Aug 2026 09:44:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: devfreq: Document support for Airoha
 Subsystem devfreq
Message-ID: <20260817-warping-crafty-hyrax-fabb6a@quoll>
References: <20260810143057.651478-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810143057.651478-1-ansuelsmth@gmail.com>

On Mon, Aug 10, 2026 at 04:30:54PM +0200, Christian Marangi wrote:
> Airoha SoC contains multiple subsystem that are scaled to a
> specific OPP taking the CPU clock as reference. Such sybsystem
> can enter idle or performance state based on the system load
> and power consumption conditions.
> 
> Example of such subsystem are GSW (Gigabit Switch), NPU (Custom
> Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
> 
> Document all the required property and provide examples for the various
> subsystem OPP + devfreq nodes.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/devfreq/airoha,devfreq.yaml      | 114 ++++++++++++++++++

devfreq is Linux subsystem. How is the device actually called?

>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,devfreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/airoha,devfreq.yaml b/Documentation/devicetree/bindings/devfreq/airoha,devfreq.yaml
> new file mode 100644
> index 000000000000..2f84486cb209
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/airoha,devfreq.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/airoha,devfreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SoC Subsystem Devfreq

Here as well

> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha SoC contains multiple subsystem that are scaled to a
> +  specific OPP taking the CPU clock as reference. Such sybsystem
> +  can enter idle or performance state based on the system load
> +  and power consumption conditions.
> +
> +  Example of such subsystem are GSW (Gigabit Switch), NPU (Custom
> +  Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
> +
> +properties:
> +  compatible:
> +    const: airoha,devfreq

And a generic compatible... We do not take bindings for Linux drivers.

Best regards,
Krzysztof

