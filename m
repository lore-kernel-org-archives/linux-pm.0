Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BD1E8826;
	Thu, 14 May 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773710; cv=none; b=CuAYf5NA6p0osEJBxx6WuzqpHuRi9frD4rYF8pYzL4MEqfCi4XJAtkIuWPf5hNtkIXOy+XL21xNNL6kJlnvklXfLr5Z9WfO98fGlswv4eFUtfwky0XfCJO/5+o8GrTrlA4pxvLPghg1FKGjGOT8vtsAUChmswqxZtfrroyx3nCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773710; c=relaxed/simple;
	bh=99/YmHRV/Y82fkZD0R48lVXiAZc/PRWolZfuIGwP27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiO29accD8kpmOs9OJ7ID81Z87id1AFihhoPOu5didqRWknTB5/PQGb5jnwcdlapm2pEHVnKgGTcRd4mbJ5jd5pnJm/3yN8lXFGUMWMC86Kiu5ZhMqJldxIU0wiJ5AHk+m3Z74FzVxq4iXT7txKwmdmrKrlMTDiNjwt0yVYgjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7X1VVsX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7X1VVsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C2C2BCB3;
	Thu, 14 May 2026 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773710;
	bh=99/YmHRV/Y82fkZD0R48lVXiAZc/PRWolZfuIGwP27I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7X1VVsXS2LJ35c20vQm++re5sDMpfP21kid1EyL9bEGyj0dLJzGrqd3PPfbd2mZm
	 RXdnIsp/nSkGZl4NOEcevRk8foA4t4sSmY/dDN6uClkzyceduknHASc1ZyuyGd+JdW
	 8O0OiFhPZ/zXzczSC5BMSM2NclDxXdJdDuF5R9lPAl1R+AkCokRr1ODgo2w1//eQfb
	 Rr6Fy1wIf5ORqVpSkOHt1mMuANSTd7eX8JVUyeEUfNMxPRihOpPmY6ZS4TzlERZDl8
	 WqpxfZQ1lSNPdECtDQrjYSaQ3ktVPXKC4DQ74+TWXxZIWh2n6vOU3AX0GScDnmO8iF
	 3fdxdOJ+MH+MA==
Date: Thu, 14 May 2026 10:48:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ben Grisdale <bengris32@protonmail.ch>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 04/16] dt-bindings: mfd: mediatek: mt6397: add mt6323
 PMIC thermal
Message-ID: <177877369030.795769.7510562882994447015.robh@kernel.org>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-4-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-mt6323-v2-4-3efcba579e88@protonmail.com>


On Tue, 12 May 2026 08:18:18 +0300, Roman Vivchar wrote:
> The MediaTek mt6323 PMIC temperature can be read using AUXADC channel.
> 
> Add the devicetree binding documentation for the MediaTek mt6323 thermal.
> 
> While mt6323 exposes only a single thermal sensor, newer PMICs like
> mt6358 provide more than one sensor. Therefore define #thermal-sensor-cells
> as 1 to avoid breaking devicetree ABI in the future.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

