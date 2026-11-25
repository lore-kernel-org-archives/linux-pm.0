Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607976;
	b=Zh9mNJgfuRjb3Me/rVk0wVXcTr3NZlHrinkUQ3Lu9nLOGagms/S0B4Re6ea8isJpTTbU
	 +lFlkvjT05/6mNT5gSaUQLPH7o3uKUZCSM9PptXKHIj9LOKHa53Xz8vrCIBK0btEj/0T+
	 eu7m3WxHIhsABIk1ZdD5FfWfuj1AkYNt1zEZv5pJ8lZ+Y7oGiYu9TNBUezgDnr71W+zjM
	 0Z7F/ohNdDd87dhZNiWvr1ZDoepqkvwcCDKV7Ft1nn7VKJyBZhI4OjKuM1AvrTJJEoFMJ
	 l6qEz6RJGRUxY7dk/iWrh9x5kK3mO2YICqRvky/7znMPiEGIZBcLiaRLmpCYdPoWnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607976;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=yq9L9HAGZojBDbYgnQq4VN708e+LNAMcIM6ZkR0zdZY=;
	b=QkZJXeBOrDpjIV3W9tZpTM/U7r8TwINt1QRxQRZWNk2nb8HQtLVjXsZDbkd9Y/Nwjsq0
	 4ZYkH93YCB3rS16aGdJjHRESsqtxFK5vP2VrchnUBTpUXAORnkl2K/fQKutj+gNaCcNop
	 tYnusq7hRVaVfZavW95sQ6BBtKBAui4k7LUptXZWeJTnni3h2qkMfLA2/qZ23x4yfOp0N
	 MD5fGhLD6TINNjFPch9Wgo0RuMlxsw0OA4gDiKfQjg2IDQA5rgeD/IbMQS82e7piZaJzs
	 78n3AdDDKWhYP9c7VomeLh8W/QuvZTeCn6l91T5H2TASjZ+7cE1NEz+wLjHBPDXjRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtKm0SAD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45814606A323;
	Wed, 25 Nov 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtKm0SAD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626601F000D2;
	Wed, 25 Nov 2026 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795607976;
	bh=yq9L9HAGZojBDbYgnQq4VN708e+LNAMcIM6ZkR0zdZY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EtKm0SADy2kDQBI+UCsVxQBSHvpu4H4feN8jVZoYdEz/tbdDI6Wb+l1I65jVbFUhG
	 zMhymZb1+uvUNvmmNTfK2f0ujN4Khx4asffmk0iLlK3r6MiBoUE3mTgIR01E69XKs1
	 8MG7OFgo8ZZezejRPGabfdxmG9oESqlcdw5zv2Ga9lRGCARzYQyA0wdPVwiwgjLbkE
	 SE8EvzU6xvSt8karKsDg70tgDeaW/oGk68ZoD45F5Z+3rvfmiSaVisjqO8Qe56vAt2
	 GGJDMvu2NmK+SikbafTwYyBFelayrEo+CgSFFr9gXL5GXwVeHalLW115xTY4m4PFeO
	 Gv/tqSfApNzTg==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V4 3/3] arm64: dts: rockchip: Add Battery Gauge to
 Anbernic Vita-Pro
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, heiko@sntech.de, 
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org, 
 t.schramm@manjaro.org, xsf@rock-chips.com, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261124191346.434143-4-macroalpha82@gmail.com>
References: <20261124191346.434143-1-macroalpha82@gmail.com>
 <20261124191346.434143-4-macroalpha82@gmail.com>
Date: Wed, 25 Nov 2026 12:59:33 +0100
Message-Id: <179560797327.84329.17059711157215907702.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-24 13:13 -0600, Chris Morgan wrote:
 +			0x7f 0x88 0x92 0x93 0x94 0xd3 0xff 0x5f
> +			0x20 0x00 0xab 0x10 0x00 0x91 0x68 0x00
> +			0x00 0x00 0x64 0x3c 0xa0 0x89 0x00 0x00
> +			0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xb2
> +		>;
> +		monitored-battery = <&battery>;
> +		power-supplies = <&sgm41542>;
> +		shunt-resistor-micro-ohms = <2000>;

> +		status = "okay";

Drop, why do you need it?

> +	};

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
