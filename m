Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DAD389DEC;
	Mon, 28 Sep 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620230; cv=none; b=p55rE8JNzlrR4XErwWlSjwODVHtK9y4jcSTh5qG/fPLfIJTwqtzeCEqo1eRBY4faXJK3ofBMjrQ7RLX7VJpfqIqS+7J+nablvK2z3vlk6zjgm0rbw2Ur8E3VUuOvqPgg+F/yhV+G4X+2HLhWBKycFGZasmEQnU8UyEHRlGJNXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620230; c=relaxed/simple;
	bh=UmjKDdACY9RW5RFdNa3x/ak3/dl6E+u8fsNRcxo0Twc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDGe7bbXnfZnHsD8wMb1TPJGF1HcDHM/QzN7Y8cwKMFoGMjSFmn2QIHN0ZhSqOTTqz82ozfLyywHKcSdBgnD94kL+SVJxGKn9pb8HWGlKHOyljV6cw73sfv3S3Q5yJx4upkZoWwy2hLB44tTfwxeyQeGm2IzsRL/wWwgWbZQatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq8Y3eCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq8Y3eCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803661F000FF;
	Mon, 28 Sep 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620228;
	bh=WcqjPQGfmSN4aaf9xy/4ayNG9PspGR26tXpmCJnxJJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sq8Y3eCSAuDhH+OQq3T83rFPJbzAzozQjMr6D+FsLlgNEfiRr15TqqJ82LhPukgCq
	 RxmrD0SalntQV8KHjT0w4QAaB2G786S/76g3pezYGB6NHBEZfWFUkQjTx/43h2UFXM
	 pPsI/S8XBUqljPalELxlZ00KPMKgpN8cOvEBVPUuQVjsR4b+klL7XuomPEtxV7CVpQ
	 lLBKy5NNbe6X0JKyNzzBPZcJmjFdX7k4lYOsbVqrkZ3QqtqWmxRXIK/v6A/ZunNG2Y
	 DGRD6CJf0NpK2rdsuH1TtbqkADjvs71Id81uOPlTO+xGUZxcF2YwJm7WfLSVFpfyqa
	 liXkHmgQD3OuA==
Date: Mon, 28 Sep 2026 13:30:26 -0500
From: Rob Herring <robh@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: spacemit: Add power domain
 controller
Message-ID: <20260928183026.GA211865-robh@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-1-0acd2b36b96f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-04-k3-pm-support-v1-1-0acd2b36b96f@kernel.org>

On Fri, Sep 18, 2026 at 02:40:13AM +0000, Yixun Lan wrote:
> Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
> Domain Controller is SoC internal module which is part of APMU (Advanced
> Power Management Unit), it is responsible for managing power across multi
> power domains, which includes power on/off, isolation, power-on sequence.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  .../bindings/power/spacemit,power-controller.yaml  | 43 ++++++++++++++++++++++
>  include/dt-bindings/power/spacemit,k1-power.h      | 14 +++++++
>  include/dt-bindings/power/spacemit,k3-power.h      | 12 ++++++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
> new file mode 100644
> index 000000000000..f869285f84da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/spacemit,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT Power Domains Controller
> +
> +maintainers:
> +  - Yixun Lan <dlan@kernel.org>
> +
> +description: |
> +  SpacemiT processors include support for multiple power domains which can be
> +  powered on/off by software based on different application scenes to save power.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spacemit,k1-power-controller
> +      - spacemit,k3-power-controller
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to APMU syscon to control registers for power domain

Sounds like the APMU should be the power-domain provider directly. You 
don't seem to have any other registers for this node.

Rob
