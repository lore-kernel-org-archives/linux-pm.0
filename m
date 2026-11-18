Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007379;
	b=pIKL+boEtBW1KAioI2Q6jcii88xtX42RTmzduL2bVOzx5I5rvdPZtEAXu/3iXXi/6Jet
	 qAu5xVJueKqSqzxgtMA4DqSQNNf2RgYPkf8KQRbFAsj4UyJ70M4Nt0jPpzcnVQBMNfYP/
	 pNUrjhklAkSRSnjSHUUum7R/DrjXH/T8u5AH3eYBhN0WisIwzZ4Ep/HJ9NEHRyJ6YQYei
	 ZeB44kk5JB0H5GhMk5yGvR2fplYTXC8Zeh9ajcWzT9mrJgEDfctv37uudX6FYQXwfRnF0
	 EuL0rXbPn1fNvjhktgXUOii+iaUgpJI1zeXGzhjAi5cmjPXk1Nbf9dPZGQakZy6CV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007379;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=Jv7xiOwj7vNDJYc94swhTjLaxDuF+oYg+FR9gK6fY2k=;
	b=B/vYij58ms++tTqOcbVC8A80gmeee7fjil4lJ/QjLMSQRroEzrScWteNMM3OcDtLgiP2
	 4h4lncQ3WIaQkf7L+dXtEVcvYVzNDhoSD25Sr1l33t4e8N8v+ZYAGg6216xlRYp6zwa6Q
	 fNReEMadWq2XogFYoFUFNe2Q/IbIHwdkLNM144jzyG9xGSz67WCtZjwH85/awoQ1pWrJy
	 9YoPAKVTwvpFwiekcSumwYQQdq73Rs506YU0jHVAME1KI8lg5KZ2fCAadPhaaUXFH3EOJ
	 4GOpBgGhVl7xXwb08l5t4ZrXdBABWdH8WKUm6MKHK8X7k4zZpOo6K2KMuuCisaaRU7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIFRxVfh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682E606A320;
	Wed, 18 Nov 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIFRxVfh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17311F000C4;
	Wed, 18 Nov 2026 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007379;
	bh=Jv7xiOwj7vNDJYc94swhTjLaxDuF+oYg+FR9gK6fY2k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=UIFRxVfhZOBpR58i+xWgwvJgi6ckSkf4VwBHNoJ3oGbBDCcSsuXkCOfPMo4zrzi3e
	 BfE+/OETp17fb1q6nTdCw8/NFY9jPBp5etRRCTPBfhPM5lgZI5otxcQtzM1TOLy0rq
	 FgZF5Zul7iQw3weqflU0XlPuIrhdbodrWdIBEJ5dT2wuTjUlHDYsGThmQOtlkG7RNh
	 csA/Fd/GsKvMRZ2QK8cLgpNzMUKxDVTxZZXrgrSXr5afa6TpDblOzW+G3nuflrU0HK
	 J/V8m8RCEbki+pCvMVlkUPH7RGxR4eBYXnsw8N6RhaToUrfDdkOYA3wy9AzVDxma7c
	 jUGaDT3OmqMuA==
Date: Wed, 18 Nov 2026 07:09:36 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, 
 Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, Heiko Stuebner <heiko@sntech.de>, 
 devicetree@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-1-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
 <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-1-32ff1546b0e4@collabora.com>
Message-Id: <179500707079.165885.1994428844573235279.robh@kernel.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: devfreq: event: rockchip,dfi: add
 clocks to rk3588


On Tue, 17 Nov 2026 16:35:37 +0100, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> RK3588's DFI has pclks for each channel. They just weren't noticed as
> missing until now because nothing ever gates them, and they're ungated
> by default on power-on.
> 
> The RK3399 clock situation needs no changes, as there the hardware
> really just has one monitoring unit for both channels.
> 
> Add these clocks to the binding, so that drivers for this device can
> properly know about their existence.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml       | 84 ++++++++++++++++++----
>  1 file changed, 72 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml: properties:clock-names: {"required":["maxItems"]} is not allowed for {"minItems":1,"maxItems":4,"items":[{"enum":["pclk_ddr_mon","pclk_ddr_mon_ch0"]},{"const":"pclk_ddr_mon_ch1"},{"const":"pclk_ddr_mon_ch2"},{"const":"pclk_ddr_mon_ch3"}]}

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-1-32ff1546b0e4@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

