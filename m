Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A762E5B1B;
	Tue, 28 Apr 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362578; cv=none; b=QqP16szvp1bSKudkr4taBDHxNG8Ccay9s2bi7UQwPSjPvjlfPDezhb0vdJ5kSAxMikZ3Vkv+ri7oNI4q3SmTPNr74VkgDrQWRXNowRKFez/1Ng+9GKz3RFV3FAokMLTf45v14uDYjli2cVYqsejmL7WibPi39RfL21omfQYDmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362578; c=relaxed/simple;
	bh=3ElNfMSZSM4UEx+D4roCAQFNWHGugNmlQtBq5aXJQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtPmDEyXHR58YmVY0Gr8cyOEh+zN8uNc1jCp3a9a7quX3OkFOtjc+VMcToClXK0rq5fbK5HuinK6C16k1Cq+mnWJQfNvDQTgQq9GNT5gEK7ljJFMvgX2Te0rRi5FpstGSHhRBnWW8iCP+4l98RpQbJoOcz60z7zr/tZtfgvcWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYu2LQAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYu2LQAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD74C2BCB6;
	Tue, 28 Apr 2026 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362578;
	bh=3ElNfMSZSM4UEx+D4roCAQFNWHGugNmlQtBq5aXJQ8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYu2LQAQ2bTwVIgJMiupZ1xKfY2vpDjaxpd8EnJGy1SX/ZZa+8niTzyTrDhCd6j3s
	 AlzDvAoAhWuB6Pwp0J8RMdWayozbqMlgxyqkM4Xs/ftQePufk0+a6WEFHcfzak3BMN
	 tDYAUtaP3/4ZYN+kmQKDaGQvbNlRbEjFYQ1sF7ermCGfdLwp/5gE5aAncpA12ApXcx
	 rxee15S0csAOCdOBIC8lC6YDePeAFd8lpnlQWfP7TOB3F784KmvosGNmlkM+3KIXri
	 17+IAykFGNqqIBFq5lcp+48EIcU7HRNJqipXN95nSiCCSaFvLjl8NpQb9WAn2vZtM3
	 Kt+hJiUL0zsBA==
Date: Tue, 28 Apr 2026 09:49:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org, 
	simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com, neil.armstrong@linaro.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: display: panel: document Anbernic
 TD4310 panel
Message-ID: <20260428-golden-tamarin-from-heaven-c500e8@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-4-macroalpha82@gmail.com>

On Mon, Apr 27, 2026 at 12:09:11PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The panel used by Anbernic in the RG Vita-Pro is a DSI panel based
> on the TD4310 controller IC. It measures approximately 5.5 inches
> diagonally and is 1080x1920 in resolution.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../display/panel/anbernic,td4310.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> new file mode 100644
> index 000000000000..2da957cd5d49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/anbernic,td4310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Anbernic TD4310 Based Panels
> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +description:
> +  Bindings for Anbernic TD4310 Based Panels, such as the RG-Vita-Pro

Description says what the bindings are for. Your description says that
bindings are for "bindings for"... Just describe the hardware.


> +  panel (a 1080x1920 5.5 inch panel).
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: anbernic,panel-vita-pro
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Panel power supply
> +
> +required:
> +  - compatible
> +  - reg

supply as well. most likely

> +  - reset-gpios
> +  - port

Best regards,
Krzysztof

