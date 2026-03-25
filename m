Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29292396D2E;
	Wed, 25 Mar 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438779; cv=none; b=I73I8kFwHsxIvmY65XEgW0ia7gKHsSE/N9nvmbRN1EBSZMpm8OALo0awDTGi61+qAffH2p6KGjktEL6VXGRohGvTCHYyI0Vdb2EzyTNYronuA7dhXZTdpNoXjaC+pvB4qD6y2Bs7X3Nngj7ZenTe2BBGbRFoRB4zG/JtfhpPpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438779; c=relaxed/simple;
	bh=HqQGah3jFHWYTLGI1EMdEZizLPIWFhT2k/UK9jothyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgUGe/awK5yGinfV+6IWXPHoMpkbUVEpi7qJ6JTh/cOri22meg+z6SNNJPG02gzLsMQ4ICqyiDuF/veYcKt54StQvu2jsjnZwLO8YN9U/U43eyVEH3dD46KH07QOyUf5LxNPyz2nUTjEFac+IjeX0G0brF6LfPMU9znll3QUPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj5B7Tex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj5B7Tex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D9AC4CEF7;
	Wed, 25 Mar 2026 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774438778;
	bh=HqQGah3jFHWYTLGI1EMdEZizLPIWFhT2k/UK9jothyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj5B7Tex5cvNWBKZtG3QpU8cpmdYtpmXLMt4HRcNnU07dUfNKXpBcQmeiJN/Bh79C
	 KQCcMMQXIpjhFs7NRM/0wWxuPiDldulelCyHRLZGPo9sxgU6c0NiaKzNo36T+KAABh
	 Nu1Lhb5R9Q5FfYoJAusjE+Cqe2FhF2t9ysWlDDrHWHiW+vGtst2Ujrs8/eXOgtXXnT
	 VwE8tDjBhC7QlvpU4kfN3ENh3trlGqM2Em6TcL+/OxDxUWMhj6TfFLqfrVfG3B4CpC
	 M43XRdeNBeCYIuXIXz+AVbDWymzg7U6rFNyd0UOW9nnYsynd3uVxV1JvQJPXdqEPHI
	 88MUfs9a7zHWw==
Date: Wed, 25 Mar 2026 12:39:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, lee@kernel.org, 
	conor+dt@kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: st: convert to dtschema
Message-ID: <20260325-speedy-amethyst-beaver-08a3a4@quoll>
References: <20260324155935.183952-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324155935.183952-1-krishnagopi487@gmail.com>

On Tue, Mar 24, 2026 at 09:29:30PM +0530, Gopi Krishna Menon wrote:
> Convert the STiH4xx reset controller bindings to DT schema.
> 
> Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
> Suggested-by: Dhruva Gole <d-gole@ti.com>

Both suggested you to write this patch?

> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
>  .../power/reset/st,stih407-restart.yaml       | 31 +++++++++++++++++++
>  .../bindings/power/reset/st-reset.txt         | 11 -------
>  2 files changed, 31 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> new file mode 100644
> index 000000000000..d7adbc00f5c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/st,stih407-restart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST SW reset controller
> +
> +maintainers:
> +  - Lee Jones <lee@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: st,stih407-restart
> +
> +  st,syscfg:
> +    description: phandle of the syscfg node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - st,syscfg
> +
> +unevaluatedProperties: false

additionalProperties instead


Best regards,
Krzysztof

