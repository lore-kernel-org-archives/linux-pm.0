Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3672227BB9;
	Thu, 18 Jun 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801518; cv=none; b=HphKrrVBr/EkcIW6JpH6mMqI1TJM9HrDiAfG9CJ6ktW8o+ijp80t5hKsSpLpkkmWNnT92diYnkQL6l6FN2IbIqhtycDgBIvFI9ZCFgg8IuDWeCvFvAt8qdCHVUqvAWsKDNJQWmta/K6lACcn2PLoQKqZbLb2bIabQjMInPha04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801518; c=relaxed/simple;
	bh=7jO5PWoE2N5ydihCITbr3HpSBs4kiBOQ62fm0mBEeq4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rJKVDoYzjmNAzinTzjP5Oq4RdHCxNrKnryYg5OqC/Ou8nSHSieWY1nGdcS7Vqano0NqdIZV61YjWV12o6pj7vdKYQNrNSB1OtBpG/OU2Uvmg1MMCrO/yFmwpmIyqX7lzzEsEvUld902CTbjcUbSAd2vl0Fyaq8b/gkQxCM4BjyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRz3Arfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRz3Arfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECA1F000E9;
	Thu, 18 Jun 2026 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801517;
	bh=+C7UJ5EIB57xL4KV5//HXNlxtQfTiI3AQWlDNB9xG9M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=cRz3Arfn81Xxb0sb5xjVuc9aHEbbew8OcSDJxv/ZQWPs6orcRzAeN2C+dIx2RArvC
	 NxqS0oBMA4GI7gesRaqxmeuVANuET6TQ1GMQSsm6gGujTjolJMi5hiFQM6cZ7GS1zj
	 cUb9z5VIgT5bC3c7Kc8XYT9PRIYm9uhF2cawTytA+LLC9GYJMt5jc5nYKDsJLzcOn2
	 +LoJNrvv+dVlmX/MzxNlEQamZooeOeMlq7/aa4uWYOedDUylJvasepXktDtifWt+Hw
	 obOgwDjHstjkEzlU9nqPrTDH/uR1biK3+vvZJuMxyQcCyqGt+XWe6fJ43wKvDdcqvL
	 zXdtW9BTCB+XQ==
Date: Thu, 18 Jun 2026 11:51:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 dmaengine@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Mark Brown <broonie@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Linus Walleij <linusw@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
Message-Id: <178180151626.1898523.11669770093439143903.robh@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: power: Convert Ux500 PM domains to
 schema


On Thu, 18 Jun 2026 07:00:47 +0200, Linus Walleij wrote:
> Convert the legacy Ux500 power domain text binding to YAML.
> 
> Move it under bindings/power.
> 
> Reference the generic power-domain schema.
> 
> Update MAINTAINERS for the new path.
> 
> Assisted-by: Codex:gpt-5-5
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): $nodename:0: 'sdi0_per1@80126000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.example.dtb: sdi0_per1@80126000 (arm,pl18x): 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/mmc/arm,pl18x.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

