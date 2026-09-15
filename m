Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240D34D93C;
	Tue, 15 Sep 2026 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437098; cv=none; b=RQYE9/n4SQ5TjgA54blZfWHIE3IuYdZGYPvZKhlP5GunbiJgl5QbQr3qnp7afbFtX0jqNLKGbRM8djrNmJlAzEIth/ycEpDIL2AVmm+0OgibIMiUruxtLDFxM0AX+nUfVP5qmhfRd+NEHtSV01XXUKGwtIXVeM2wR/0yMwGvgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437098; c=relaxed/simple;
	bh=Fh1/xrvhumv1NUji5CdpASC/TkNtEVxj65b2Z8liSnA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gSxQsOxJjn18bBCE0pr3i8Vqt/Cj5eu5sm+RSx/6S4GSu8WVqCwzdERt5RyuNWzyzD1SphtZNzDNiHTno+LxtRqyX1lAIccRKFz0XWkqTZDBIieB3WhwxthntnPSnXCZvRbzo6v7ZIchhk57L3YUveKWFRUYycAqZt0J2T3okPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGV5Fz2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGV5Fz2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACD61F000FF;
	Tue, 15 Sep 2026 01:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437097;
	bh=RPC3tMekOOkb5QsKYECBHnd3JiInI8Q3f1HYPTy8hBI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=mGV5Fz2ts6GMgtwlNTaZheA0T00bWo2nyPP2F1KN9Fi07MkJQqKvcZimw/u0YB3zw
	 wwvinIldj7AapRT2LwF+UnVomrvB8bfVOAtLQqjB4+bhB7jUdBHOluSi42NEYt1Hw0
	 rnrfgll9vwrAzlNtlAUimAxUuZGK1BxPQOO+/2hsQcsSUSgdSlNFlL4687EdTKO8nV
	 zCsgkdX3m663j2UL0isiXnjJZNPSUmic8A7gG8ZquIhe2xxB9ZLFg+OJ5UzDWkEtn6
	 9WA+C0NAuomKAdKoe6Y1TWZoNvIHME3wF69NHH9SjLDody2vJhVq7H3LpLnAzuQxJd
	 5G+h8uec1wtJA==
Date: Mon, 14 Sep 2026 20:51:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, linux-arm-kernel@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
To: Linus Walleij <linusw@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-1-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-1-9d0c17e1f816@kernel.org>
Message-Id: <178943696204.2694977.2443590518869733155.robh@kernel.org>
Subject: Re: [PATCH v2 01/20] dt-bindings: power: Convert Ux500 PM domains
 to schema


On Mon, 14 Sep 2026 13:54:29 +0200, Linus Walleij wrote:
> Convert the legacy Ux500 power domain text binding to YAML.
> 
> Move it under bindings/power.
> 
> Reference the generic power-domain schema.
> 
> Update MAINTAINERS for the new path.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ----------------
>  .../power/stericsson,ux500-pm-domains.yaml         | 46 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 47 insertions(+), 35 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dts:25.28-28.11: Warning (unit_address_vs_reg): /example-0/sdi0_per1@80126000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): $nodename:0: 'sdi0_per1@80126000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml
Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): 'anyOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml
Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260914-ux500-power-domains-v7-1-v2-1-9d0c17e1f816@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

