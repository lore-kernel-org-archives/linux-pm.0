Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364151815A;
	Fri, 18 Sep 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749685; cv=none; b=qOPxgtEOMWy/D5kpVuhJlQSXVU51WbGlAsmo3EsSypMYgP5e/1wirwaJuzkrNj/fWsCj/nd494RI4JY8WxRMiKZSB0JHgAnbS33g17wC5vKEpNLDZXmbF1gltUpRfjAlkon+Gu3hYlP08GSu8LYPyqKcYITXpAv5Jq183nqHo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749685; c=relaxed/simple;
	bh=BOZWafU3f4ITSsJBLEr368j82TV+YUOqf180XRodaHg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=t/OUKBYf8xYux/ipKfcrjyS8tPYN3AXt4745qrW+O74UxaAIlbRKUS6osKO4jTlGt9d/9N7xCANx0vF5aeAm16RkSLKUVDCcMwgy4sCZtpmT61m5N0cNf2teJUxteoxZdTJFbJ3afJXw4nsPEKoUz3AsmW6Uxfi8CLQbMdSaQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICXEfZWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICXEfZWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057BC1F00899;
	Fri, 18 Sep 2026 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749681;
	bh=WbkQpYzW8fMnBq57NK7jpTmVbQoZoa+LajFAmJqaKwg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=ICXEfZWGgydsyAdHsmcIuO4df3Y4EmINakIsTIkpaCi6VmkVnmH7MXbZGhReGj2Ow
	 ZXF/3hck8Ye7aD4t69fCe7WHqgn9VD3D3XWtRv8FrP3OM42vigP7m8SJJbwOSf82wK
	 +GkZH2rTy7zUpje/4SmZg6BCJmATbTrN3RcIyaCYxa5RAlT0aqjFteGuDJVV3qyN2h
	 D5qJn0E5oegFAxnC7eIwVZB+XTJWijZsTQuJ3o08jgBb+aOql6zky8m1PSF+0mRWkx
	 vWpzhYyJ7S8vphq4LER8kYXpb7Tyx42RQN6x9nC3byDve67DG9lTwceG9x7XqXa+p1
	 qmKaxYqoSi75g==
Date: Fri, 18 Sep 2026 11:41:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-rockchip@lists.infradead.org, Chanwoo Choi <cw00.choi@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Brian Masney <bmasney+clk@redhat.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
 <20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com>
Message-Id: <178974864695.290479.16274908479214373555.robh@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576


On Thu, 17 Sep 2026 16:04:09 +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
> like other rockchip SoCs do. Unlike the RK3588 however, it only has two
> memory channels, so only two per-channel pclks for DFI.
> 
> Add a compatible for this SoC's variant, and add it to the conditionals
> at the bottom of the bindings file.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml: properties:clock-names: {'minItems': 1, 'maxItems': 4, 'items': [{'enum': ['pclk_ddr_mon', 'pclk_ddr_mon_ch0']}, {'const': 'pclk_ddr_mon_ch1'}, {'const': 'pclk_ddr_mon_ch2'}, {'const': 'pclk_ddr_mon_ch3'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

