Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266499;
	b=PvkbAdGzTta3XO6VVwGG27fh0kNYgB25BCn0EbWom71bl/h3f9BIrDU2I3EcxinEHhUh
	 4yW6ePgkQ9CnQ6BkOivI2z+oRYi0swhRDYN3l38oS0jXlgGaXAvERzctKGRu4jlxDnOkE
	 0anSHDPKKWR38eHFUM6d+olQ7hQAwJqmMpjrrH3+bgAjP7ROatr5y/o4NbhRRGjEKMJw5
	 +TphkMlWiN4kIW2kpME1jiY9nmLHw+gVyc2Bbn0DNgxpi6ouwGqNMCBP6MvsK9HSo62JM
	 V2Fz4XRYslC0OLM3/NiY1/jHb1DKJLuxfkwsx0rpkk8F/6O3z1fIdpDmdnQ/xBbN+7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266499;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+TjDNOPo6DMIDlKla7hkMSGhTEEBp7kLHL7Cw5vY/pE=;
	b=Jyh8AOuHjc9kFJite5gZD9n/XcLqGfEkCUf9KqoRlVj3iS5PR61iIekfr90AlzPPAxob
	 vYTB0iZVUjiwHtamx4Xot08CaVsjIg48tcI8hdnN9RGRWQF9WjR9EsGjxb4jQWQqMcxAk
	 uV8IAJxaTFF+heIDLsqx6BFkZXpPjBeK6oynfBoxGCexYDWCZmzHgYMu5TjEBG4/LjCrI
	 Lh9VxY5KfRL3KXiFNsisr4/xgSnA+jk/naamSrKzZHLcUznPW972sAPzyLAQSwy8xXPCc
	 2lAHoSILxLo++VI0eATYrUA9TZvfy8Pn1e7DEAEB0unzMcz5R2dvOdgGZH7s0s3SeSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJT30TrN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31CA606A31C;
	Thu, 29 Oct 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJT30TrN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520AF1F01825;
	Thu, 29 Oct 2026 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266499;
	bh=+TjDNOPo6DMIDlKla7hkMSGhTEEBp7kLHL7Cw5vY/pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJT30TrNGS2cGa89z5LwoTlblLOBRgESndzUX+etbxZZIOsw8exsSk8b9dWFZBt18
	 iwcZCGKGA41Ru66GRPUnQmN48Lzm2nn247D8IFiANAAi0qRNxx9gws5AcSo841PC5I
	 wdQzhVf75jAaG32f/6NyCq+nGCbIxIsm+AZ0TWtD7boNPzjyo2Dtb1jNa2cO77drt6
	 wJvA04Y6Q5D3pHL17VQDtThVHfUg1e/Vz7RgatUY7fSVSVnPISNdRt1NPbkDgkLUxY
	 wviyrGpRP1j6e0Hwepf1XP0u8NyPhX88xnznLch3rllpTkmzJthoQJHAeiWlXqt/W/
	 TyPU38JJWsNhw==
Date: Thu, 29 Oct 2026 10:34:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, maccraft123mc@gmail.com, zhangqing@rock-chips.com, 
	zyw@rock-chips.com, sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, lee@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, Zetarancio <zetarancio@users.noreply.github.com>
Subject: Re: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add
 rockchip,gate-function-disable
Message-ID: <20261029-intelligent-handsome-salamander-dffce5@quoll>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
 <20261026174834.1652309-5-macroalpha82@gmail.com>
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
In-Reply-To: <20261026174834.1652309-5-macroalpha82@gmail.com>

On Mon, Oct 26, 2026 at 12:48:33PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add a boolean attribute for the rk817-charger to control whether or not
> the system power is shutdown in battery off mode. The BSP kernel sets
> this value unless a device-tree attribute is present, and this attribute
> is to replicate that behavior.
> 
> Fixes: a592aa3a2a8c ("dt-bindings: mfd: Add Rockchip rk817 battery charger support")
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>

We do not need to credit non-real identities (like nicknames) without
even pieces of known identity. Just drop the tag.

Also, your SoB is the last one.

Best regards,
Krzysztof

