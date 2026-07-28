Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968F3C457A;
	Tue, 28 Jul 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232769; cv=none; b=RTkOBDtpsSlC/JnR8YdmSTwf1DPk3tThmm5BdvZ8Mzxxgb/Wj3kNqWBshbNXwWTZRieTZDuOwTmmhnAMMX0OLuxAmB2tMBipBYFm3yY0d4nAM5IvCWfz0ruADfJ/MJ99F6LrcKSaw+xQ729jwI0obKmzVz6EXDngTERXCTBTnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232769; c=relaxed/simple;
	bh=cPhwN7Lq7FdR5rmbJaJ+KhVqLnv0SVYqYuYmiB54p5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGGUf+AQjBImDRg3ObjzkQ1qPeugukpb4jD60Xyq6BDZNsVPRv4vuspXr1rKaBhVU1ckMqXRlD6Gzdms9xbrolufU7ApL1haIhaYY9B1Mf42cQaUjFPcna2bmGS+6FyhPK+LdNm3JhcFoRJx1zTQjBcd8sMpCTQf53Tze3VMXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNK++skC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNK++skC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DC41F000E9;
	Tue, 28 Jul 2026 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785232768;
	bh=XcpGEwAi/2YnkfZAtIkUhwvZ4Xx1tA03i/JXF0Vvceg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oNK++skCpKie7y91Mf4xhrJoE44OM2RCQgtjHIqx/mRp7w5oRQAJbeBu6uJ8wJNvV
	 sws0lWio7Bsuzhib5NY5fINLM/avUsuRaWKp7xRMBrbe0/6NVv+dG2BQSE/k7DLZfO
	 tPZlclunU96o0VdFCWsc2K0IdFmU/r0RtouWTm9dcLpnICdD7ynMyNl49e219kNwLv
	 j3RxuQbMSGMinDMJKwK1b5T6FC2cXFpWg7KH5NiNTlzzSh05FgJb7ehTMxqiLesG55
	 3vcQpTNxLOYb/moZIT3Y0m/pq8XlpUWeMPeStoldVzC5BmLrzLlWsJlXiHJPnqfN8E
	 gCakxy4UWzaVg==
Date: Tue, 28 Jul 2026 11:59:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, laura.nao@collabora.com, 
	fshao@chromium.org, wenst@chromium.org, jiapeng.chong@linux.alibaba.com, 
	frank-w@public-files.de, bchihi@baylibre.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Make resets
 optional for MT8196
Message-ID: <20260728-hopeful-phenomenal-stoat-3ec6e3@quoll>
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
 <20260721105230.101906-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721105230.101906-2-angelogioacchino.delregno@collabora.com>

On Tue, Jul 21, 2026 at 12:52:29PM +0200, AngeloGioacchino Del Regno wrote:
> Both LVTS-AP and LVTS-MCU may be shared with SoC-internal MCUs
> running some sort of firmware that checks thermals in order to
> scale frequency, or to take action for critical SoC thermal
> protection - and this is seen on most MT8196 boards.
> 
> Make resets optional, as doing a HW reset on such boards will
> result in either an immediate thermal protect shutdown or in
> a rather important and usually permanent system slowdown.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/thermal/mediatek,lvts-thermal.yaml     | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

