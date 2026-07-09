Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF69329C60
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581862; cv=none; b=NT1FyvcxOAeiw5zMDd6fbWRP2Ef0zW4NoBNzbKLNCJuMuh+cj72bf9WrV/9mjjXnGsuEdQe1H9Em7uvMBlMSRLICJM4ej5fTjB3rLJ+H6qvOdNCMsJOPBK9xmq+FyA2UzvpVhz2a5K3fFM19PDdUiDyB6Qq2/gfnsO4osetzVpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581862; c=relaxed/simple;
	bh=gMx843/5S34JEAk8VaWDn/h5oOHvje0shPRIPDVNBUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtApT//lBIJkgRDylIbOBd5IMif+HLW4/b031SOUBxb256cGkcVzYZOBUb0oTX7S5Y3a/cSeia4tqRwaucrYBNNFDAsIBQXNdxco0HS6GpIOnxGjJOkDbvYkSzoSks7Fv0FU4sZQIUlH5+M8ioCTCenB5f4lTMFTj3Q4Dg5qgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NuwCZfDv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NuwCZfDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=gMx8
	43/5S34JEAk8VaWDn/h5oOHvje0shPRIPDVNBUs=; b=NuwCZfDvc91ju+YTsx4n
	eZWwMQbPm+QI4f+FRcoOPL3cEQKcFifbAWJOWfe20PCky4AkARDVTO7jSTImK0ng
	KYaZgKYF5nnCwqAs4KsFUVF7HIlFDaBKbPhucbl1UAZlMoXIFD0+WwRPxFmexC6j
	QsXrtzYDtk9TUduI/3rlJBSGTwEpt3LfNbh5UZqHQWE4jYOdmr4/5fNvvwsBYRFJ
	Wpd9tnh7uHCLgkA4+zbfkLwLNiQZ6I6kO2HYGGya2nLPUYso+L5Kh/hv0inG7DpN
	XsLyWddSoLcbgvRTYh3Hvj0cMvMcMhwLJQEQLct9v1RTgUPKVR6ylOLxKRfuhrsY
	Rg==
Received: (qmail 1017861 invoked from network); 9 Jul 2026 09:24:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jul 2026 09:24:05 +0200
X-UD-Smtp-Session: l3s3148p1@XaNSgihWothQT+F6
Date: Thu, 9 Jul 2026 09:24:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pan Chuang <panchuang@vivo.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Laura Nao <laura.nao@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"open list:QUALCOMM TSENS THERMAL DRIVER" <linux-arm-msm@vger.kernel.org>,
	"open list:RENESAS R-CAR THERMAL DRIVERS" <linux-renesas-soc@vger.kernel.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support:Keyword:mediatek" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 00/18] thermal/drivers: Remove redundant error messages
 on IRQ request failure
Message-ID: <ak9MldvSmaDyJn42@shikoro>
References: <20260709023048.599150-1-panchuang@vivo.com>
 <d31c4217-4733-4459-a9d7-265731d295fc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31c4217-4733-4459-a9d7-265731d295fc@kernel.org>


> all of these 18 are just one commit, no?

I think so, too.

