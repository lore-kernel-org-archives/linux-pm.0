Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432310;
	b=oieNwx5TWEw7ReJWuRoI/AvlNLjzUarNy87O+YFaEPTauLWaqo/M4/5pgl3m8pHCmrua
	 hfhmXndWQJMQAMa489iJimEEqh+6oJo1qvFstOkHhmUjAwuOsRhtIsSNI09aPqTA0L9CC
	 V1n3LxxYsAqmcXKiSYAtmGEzdPY3dAHmy34qQ0MubR1xWoUf6YKR1gXnUDED1OaDmjczT
	 lpKCulnOtIk086KvEUzjv92i11v5OGr2r2lUh4OqVzQvA0paS3jn2xF/w/ym2D+gviJy1
	 Rq3t1/vCFW9WOcDX8bwK10oYuMahojAI2urAGmaIhCYovz8bJVSpJuJ5LyrxrkzYT4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432310;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ICMJa1FXDkLpeqDBKL+J43KXnXXLbTYi1fHx2l/sa/I=;
	b=qGJRMs+Hw3EswiJ6oIQ73ueVsEjsNQv/sS2zRO8K2FmViMPkngNvi3brdZ4ju+jo6oGi
	 pzPLC5JPNyIBomBV3IJtmtQknfs+HTynP3EJ4kZeyIZryYNXzYzWHrS25ohP+KdzNdFW9
	 LQQ3WRscc4Va4mNtw9vwcB4OgfbV5qmzdmNBphLHJlMJ1aJ+6k7SPKRTkBve8VnwggSwi
	 91lx2cFzOxYMq6Pc06WRUehQfJM7/z8rgkP2IrIdzF0drIoUHoncXi7FZIWJ5nR9B0w3q
	 YCvlSd7lvCBEXSb/g2Ro67Wotu7XJgeWTY6gW1SORQ/u6P2oQAkA5SkAh7mpRlUZlFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFozejRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E5606A321;
	Mon, 23 Nov 2026 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFozejRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B011F000C4;
	Mon, 23 Nov 2026 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795432310;
	bh=ICMJa1FXDkLpeqDBKL+J43KXnXXLbTYi1fHx2l/sa/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QFozejRVYJDf+6Ka6Yqgp2wwhdOUwXrgWfgZzy69be+GIldHLaLHE6S2H5HQskd+g
	 Hd/QGXwNRChubRjVCtMuZt8JUBw7OoRQmjdJzOnATgNeOs5bQ8hIPfMog23QSC4l2c
	 m4gMMS7hFCbkSCqS2MMpsqY7x8V43UFIzU4umOXC7utNPtWGLVbaRnugVXJpJ4d7zD
	 DSVGNmEmNIpn+ar/6xQexD1719DC9FXpBO7j+Sp3JF2b4oYnOIMa5uJuMRkYXVWWP/
	 v2Z+DiLLAM6JWNNtmdPlj6Wdgjx9Z2QTu3EGR6vjActqeJwnzvBgwTDs8/aw9pM0BG
	 Mv5jOjy4L5IYA==
Date: Mon, 23 Nov 2026 12:11:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RESEND PATCH 1/7] dt-bindings: power: st: add STM32MP PM domain
 binding
Message-ID: <20261123-pretty-strict-caracara-bfcaac@quoll>
References: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
 <20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid>
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
In-Reply-To: <20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid>

On Mon, Nov 16, 2026 at 11:40:26AM +0100, Patrick Delaunay wrote:
> Add binding documentation for the power domains found on
> STMicroelectronics STM32MP SoCs.

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  .../bindings/power/st,stm32mp-pm-domain.yaml  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
> new file mode 100644
> index 000000000000..4ab477fb4499
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/st,stm32mp-pm-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP generic power domain
> +
> +maintainers:
> +  - Patrick Delaunay <patrick.delaunay@foss.st.com>
> +
> +allOf:
> +  - $ref: /schemas/power/power-domain.yaml#
> +
> +description: |
> +  The STM32MP SoCs contain a D1 domain which defines the devices assigned to
> +  Cortex A cluster, the devices in this domain are functional only when this
> +  cluster is not in low power modes (Stop modes) with clock OFF.
> +
> +  This PM domain node represents this dependency, based on PM framework and
> +  without wake-up path support.
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp-pm-domain
> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +  power-domains:
> +    maxItems: 1

I don't get the purpose of this binding. There are no resources here, so
this looks like fake intermediary (meaning: non-controllable). Why the devices cannot reference
final domain?

> +
> +additionalProperties: false

this goes after required block.

> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +  - power-domains
> +
> +examples:
> +  - |
> +    power-domain-d1 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).


Best regards,
Krzysztof

