Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BB322DB7;
	Thu, 14 May 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773910; cv=none; b=WTAjmnJ+dsf+LBVqL2CuRhGEwG1A8FJZXn0iM41ohx8ADPf4Tn0Rfk5fwujYGCjE7O25KBGaSpMIWyOPg/EsCbAknAFiWwvtc88a7Gi3r/A/VLTvugIcjDNzEVwuRE/DWcwklGJcfrli+siCQPhP5KuCfYXdNyoxl6XvGxpCQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773910; c=relaxed/simple;
	bh=CK5dy8dc4DrPGToMdCJE0mzXLluSsBycMp8vs+xX8fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQA+dS4Zp+abF8LHR4xzer2uTg4bNbcRPWeWBk1ZL2yScu+19nLAzu2Jwi8heRvqKZOCwlZMf9IeSrUUt75d7nZlsUwiYl3XToLrskBm1n9AGf7nblKlxrfaI/URzMgpInl3NpuhecNXISPw/GxxgJQ6p0hhDSF2GNkZWdjwrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF6s2tuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF6s2tuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1CCC2BCB3;
	Thu, 14 May 2026 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773910;
	bh=CK5dy8dc4DrPGToMdCJE0mzXLluSsBycMp8vs+xX8fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AF6s2tuOMR72IlL44Rk/T5know+vXIaYBTxKwt+TsxVT0ySdnjGUpiwlXZbZT/O4I
	 gibmDM+ZId+gZ2ssfmfXkOo9eV6xLiUewi62k9OKbEBHJHWG/4ItV04RY8eHQD8Bzl
	 Z9JSjDh5J+xk5GoDY00vmQ1GeqfMKw3etcPaAN5ck3BvAVRuIoVwqHMd3nqW0/nh+Z
	 60C8U9j4DrXUXrCpIQy8mya5XXl6L+IFAaHKYxpIxJp8vpguz597qvqVfBDwjWO+/r
	 CokrA15RzXU8iduHS6qE960BKpv3uMVg1cGZ87Z0ZxmBjspxdJkHxFg0391cxRi0E5
	 D3R3cpS889I5w==
Date: Thu, 14 May 2026 10:51:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>,
	Ben Grisdale <bengris32@protonmail.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 03/16] dt-bindings: mfd: mediatek: mt6397: add mt6323
 PMIC EFUSE
Message-ID: <177877390655.824406.15693208127712747845.robh@kernel.org>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-3-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-mt6323-v2-3-3efcba579e88@protonmail.com>


On Tue, 12 May 2026 08:18:17 +0300, Roman Vivchar wrote:
> The MediaTek mt6323 PMIC includes an EFUSE used for storing calibration
> data.
> 
> Add the devicetree binding documentation for the MediaTek mt6323 EFUSE.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

