Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4014C10D6;
	Mon,  5 Oct 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220267; cv=none; b=HOXntXUhaFHIXbSjbYDcFt4JJMtHtqxNmwL8IyZ2mQwuXBsOUhOulRHdSCs0zpcRl3nkfbbKXgWdYDjAiytH0ZlIVEZtKo4lo0o3NEbY7PqIh7rHtlLAinc5PzWiNe8N4qjGfslCAwowLg3x2qga6yplV+ps8cisPz+TTfrRGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220267; c=relaxed/simple;
	bh=4S8cNXpKkbPdNq7sYbv67jo59HB9VfgZeryGUR4ExSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzmXoin6O1HgrdZ1WxMTFsY6S+kfxbbdYKboddqi73vkz4+VrsxG03gfi7AVTycTQBi3CR4n5Z8vS7kxeXJQLRWIJhbiWKEMUOdD4CS2k5n5I5eKtfsp7qLfZ9IhhyfIhgL6K2vAVOWESrjCcTOx5xB5pJ+coq/AbiZZrKqvRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol/xJsFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol/xJsFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07521F00893;
	Mon,  5 Oct 2026 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220266;
	bh=HYh2rxKMx2Wm+Lvc6QK3nB5xBauzxm6BmT4G4eVxSRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ol/xJsFgT2Yczz6kItqZg4PP+pPv2843l7xlxzUkrJigmBhMGNe0PAkqpxaMgl7+R
	 e0rZEDY8t4JKy/E54WTLLVpxIxf4gtJKewD84TlTTR+qRVPimWeUVX/xY6VlaaGM+N
	 VoeT7ZwIZhH9zLh1L5Ci3GpGlrF9Ss8XT0RSi/BdGEJo/ibQkv88zFUfH65ZSv8iTS
	 zERF4e1IFNdmw6A/EQ+HbwGY8UNtKK/+eYoQZ3d2P69bBQgucMVeJeZ/socIyT2QlI
	 iwz6KVzrVYsvjLGn5FdXBV2iHoIIz6VWDqVhn52hWnz2mM6PV3DUmUWcK36ZPm5aja
	 yDGeUGGFxRwsg==
Date: Mon, 5 Oct 2026 12:11:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-rockchip@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Brian Masney <bmasney+clk@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-pm@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, kernel@collabora.com,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/7] dt-bindings: devfreq: event: rockchip,dfi: add
 rk3576
Message-ID: <179122026463.1037372.13014542138147307791.robh@kernel.org>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
 <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-3-04f847016321@collabora.com>


On Mon, 21 Sep 2026 23:15:05 +0200, Sebastian Reichel wrote:
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
>  .../bindings/devfreq/event/rockchip,dfi.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

