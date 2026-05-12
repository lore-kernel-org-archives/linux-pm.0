Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07C3911A9;
	Tue, 12 May 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593020; cv=none; b=fqChEVk6RDgmip6ZWcu4cmZxZjQDKdBJLLvLBELW0/tqzmSsbkFVfS1WXw2pJ/L45hAJnwEqK9UIyWQeuxo+fvYX/2JTsNtLEG7rQaMcFCDqtFxeTJR7BnJdh8Q//UnECiVJpsaVYuqaSfX1gotNrqp0S2EyRtqa8ZRBdjWToDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593020; c=relaxed/simple;
	bh=x32bCq5aJ+bGmDmdT/N1et7DubPIFjtOHl9ouElgZW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ki8+GUnmfhQXlEwiadOzzMfSN3A9cykYSffLzGUZ+v5r1ghjGnOGuhKczhDocnLNrNFlGVZFgQC4a+XQppc7ppoPIp2ymmABLIjH429+UceUu+d04qNJBPHLiplA2U/i+MpWxkgpOXkrLilNKxEchS3lGw+Pj/0noJSZQdnXyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5by0G01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5by0G01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73AFC2BCB0;
	Tue, 12 May 2026 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778593019;
	bh=x32bCq5aJ+bGmDmdT/N1et7DubPIFjtOHl9ouElgZW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5by0G01+CuK8d7NBzJ7Am772HxNBgv0MQ45OjkYM2HyR9uLFfPo5YZnaTf4XO95k
	 ljIJvsMUfBmWw4l2OUDAjzteHlDwoLKOUFmxQkajXJV7apqBn1rSDhbozuOjdX0Lw4
	 cOJ3xCgX495b0TvSaELMpDH0LSxT15WLzd5UFN96n2bQds6hSWbEU5cT5xOoSShfxM
	 QcHAdDivIYMJI26fwH4cBBu5uHu16pUmiAqAQt8rT02zkM3sXGGaWlHrrXinNBbpTM
	 ZepIwf1yL6aIsSGxxMH09Z/NWpistREYLPi0qUUCCsaJQoFDaQ1Pj84pWLtT/XH+XK
	 5391L+ROVUElw==
Date: Tue, 12 May 2026 14:36:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 14/16] MAINTAINERS: add MediaTek mt6323 PMIC AUXADC
 driver maintainer
Message-ID: <20260512143646.15d0aa0e@jic23-huawei>
In-Reply-To: <20260512-mt6323-v2-14-3efcba579e88@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
	<20260512-mt6323-v2-14-3efcba579e88@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 08:18:28 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add myself as MediaTek mt6323 AUXADC driver maintainer.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..52249c301633 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16337,6 +16337,11 @@ S:	Orphan
>  F:	Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>  F:	drivers/mtd/nand/raw/mtk_*
>  
> +MEDIATEK PMIC AUXADC DRIVER

Given this is one of quite a few Mediatek PMIC drivers, you either
need to be more specific in that title or offer to handle them all.

> +M:	Roman Vivchar <rva333@protonmail.com>
> +S:	Odd Fixes
> +F:	drivers/iio/adc/mt6323-auxadc.c
> +
>  MEDIATEK PMIC LED DRIVER
>  M:	Sen Chu <sen.chu@mediatek.com>
>  M:	Sean Wang <sean.wang@mediatek.com>
> 

