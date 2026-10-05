Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AB2E737F;
	Mon,  5 Oct 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220233; cv=none; b=m2Ft35aZ1+tOgqfZxxwSm4/uLpFOuYMf8wxMkpdRmlOUb7ubxoztC6Mfpbc/odAXQjcyeDoT6d5HC1oYyIHXTwu6GrkguLTbsIdaDNEZqS+HWGk8WDNR/LpjEY85JAe6kfDOxa7HzyDquTmC9mHyi4zRJxZdDUZqmiUzjOFwIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220233; c=relaxed/simple;
	bh=MdNvIjk6b04rBqjKwGV5sZ3jt2ij4j7RVrdSaLsIXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r72/LAOeIeCRv8jNH7F7fbb2pTgM2oItdoTvvafnjqRZdq4Eyi2gxztcmLMrdPcoJV99rNRBlunocG41G7MpgNkrd3JYUSwMDExu3L/j22w4HyA34UiD7HnAdwXsayzDVbngQysx9RMvikb9v0fOmyTRHVylnVAIPb0e/Mr9Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKyy5TK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKyy5TK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0DE1F000FF;
	Mon,  5 Oct 2026 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220231;
	bh=UN+0KQ6+baIoIku59PSGDsGhm5f/8IGhpdwUQjJPi3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JKyy5TK12gHCl9UX5YSSAspsM5VH8x7K/XzxmwBltCzcJhaZILIu5AM0bhGkZYDWe
	 D1shk9qetU773PUH912sYF/bUdGOdd2+350r3hsTUAERRBq2CSkfVvhIGXZH8B2LaC
	 P3bkxQPNkJK8KZ67pa7P+F03c8s3GbkvcI9o39F22aOf7S/9Fb/5KBpJlrPKI1U+KA
	 3zQyuNmXfxCQogXAiEu613oR2HOkJnIdwKH+ZI+8U5XsMHtPNSdFM6s0Z8sswDuFBL
	 zzW9T0y5rx5BMIo868eYKMaRh4mqtNo+KJ5jEb8zi/404L4WU90ff2aPfN7uRC9ub0
	 u0fQgZpoW4saQ==
Date: Mon, 5 Oct 2026 12:10:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, Brian Masney <bmasney+clk@redhat.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-rockchip@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: rk3588: add PCLK_DDR_MON_CH
 clocks
Message-ID: <179122023048.1034613.3306957783492842218.robh@kernel.org>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
 <20260921-rockchip-dfi-cleanup-v2-1-43ff34ac8599@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-1-43ff34ac8599@collabora.com>


On Mon, 21 Sep 2026 22:32:44 +0200, Sebastian Reichel wrote:
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> On RK3588, each memory channel has its own DDR bandwidth monitor
> silicon, and each instance of that has its own clock gate that drives
> the monitor logic.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  include/dt-bindings/clock/rockchip,rk3588-cru.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

