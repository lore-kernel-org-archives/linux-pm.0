Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8A4825CD;
	Mon,  5 Oct 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220248; cv=none; b=bciXfIQGhPaXGhqXK2lO4Lj9fAoAG6M1b5FXrJqarYfQJWYLN39MH/rkAUassBfPgduislq7bZX1pPTrhm61/fmBnmuW60Wv0pXgkuSXVVmgMsmYXb8SvJK3VF+JdD9gp7PCwUiIv1LIq8iocxrPrSUGiQB6DbYJkw3NhUFYIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220248; c=relaxed/simple;
	bh=WvO8AvHdP763iC/ecDsrbDnpcD4GHUgVDmOYpnw4/Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3JXDg2z7vW+tZJ18tC4LaAqEQtE1ahB+rUG02UUiXkQQogkdVBxZV1g+4W0FXoPRpvCsd+BCpfxnt4XPU8BvajcBcDyL83s5JAE7Y7UKboNWQI8k2rEcizsVodIX8S3hKBVoMl9bxQGPBQBGrCtnrKHgQ2v2cuAiJVtNrmZNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp/nthAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp/nthAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0191F00899;
	Mon,  5 Oct 2026 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220247;
	bh=pcvFt8xaY1kshFcWy65cU/yZDcnefoUceheITFLU38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sp/nthARaDOMjoH02Vmvq6AJz2REe8NjSXrS3e+tDA0R1Z7IyUyo8EO8HzR4wua8T
	 ra6CuJJWxeZ9xMHZ64SYb4/Lqiau9XUIeP0nlxZOtdUYHAiIHZH5NisHJ6xvBBXh7B
	 16l/XKFKxkm5m0C5qqG8uQMSwGDFL6Pevn2nkI71mG2S/8B6vr+IiEwVLAU1Ee44pJ
	 4TWwJpWX4o8UxjYTO3kbTE07me/t51c02PTGFxTGIKHrxwmLDP1eYrbq/xNgjB5cCn
	 XPNLWSDUfLivS0xurAG4/yvsvQfdqCPwTI5vVRDTYSBS2FEPpLdvEBBUSyg4zC36iy
	 4y6Ad24GnhzxA==
Date: Mon, 5 Oct 2026 12:10:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kyungmin Park <kyungmin.park@samsung.com>, kernel@collabora.com,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: rk3576: add more DFI clocks
Message-ID: <179122024560.1035833.2113322065800192734.robh@kernel.org>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
 <20260921-b4-rockchip-dfi-rk3576-support-v2-1-04f847016321@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-1-04f847016321@collabora.com>


On Mon, 21 Sep 2026 23:15:03 +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> When the RK3576 CRU DT binding got upstreamed, some DFI clocks
> were missed. Add identifiers for them.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  include/dt-bindings/clock/rockchip,rk3576-cru.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

