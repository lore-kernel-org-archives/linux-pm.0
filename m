Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856C3ECBC8;
	Wed, 21 Jan 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021079; cv=none; b=gJGpsV6BL0vCFQeroUohxQQVMPlPO6frwImpZSgxdSEMVQ+RFqZanbDHLTOxkDU2Thc+4XLPKKmX5sxzxxi713JTseSv1lWTgb6ezO12ioG/OQaD7XtRm2t9YxIc70fvtWgppl4P2CshogjL80Vf8HqU7J6kubITTiMQ+kFQFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021079; c=relaxed/simple;
	bh=wZE/s1l1NOJXYc8o2baQjkj9gVvGsCEaAvDmPO+gaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLWlurHcLoxv/pU9i0w19Ys6F+7Umu2Nuo9Vl3PhnHjjCHran+KwN7czdCpyoQobz2TWhbYBpLY7fgOg/J45ujJ6IPdnNTSp5p+KypgE+Y7Y7+C3fOgJ7HWw9iONDHRcfPNN9rsWcq2OtFYpD4Bdjd/ebNV+UDCqDJTSozbcKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frdt+oEU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frdt+oEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ED0C16AAE;
	Wed, 21 Jan 2026 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769021078;
	bh=wZE/s1l1NOJXYc8o2baQjkj9gVvGsCEaAvDmPO+gaMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Frdt+oEUZNmgSY81no4KQ4SWHaX8UV9q6oHzYrTauxwn6EY06LkllofP3ZhTr+5v8
	 s3qASNeWBs96LWLvrVt1n8jlHArExTqSvCXA0uN+tkkXvoW8NBSqIwb0+o7ZrfB294
	 URFXrC4bXefltMQIbSw50mt29gLlL/ZeMoU9VN0ajHO9FjIawX25UrTFxi+8J804Ut
	 ItG1YOEV2/agcMWLyGOEhMZ64XZT2zYSAIMdSSOqSaAtb2PP0FVoDdeqwkHyLXa5nc
	 9ivYlNQk93Vk9Av81NpnRuN7V2S97j+HxQdK7iMwaF0oz858/YWfSsxlte4fApLZzE
	 J5DpSI4aQMNzA==
Date: Wed, 21 Jan 2026 12:44:37 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	matthias.bgg@gmail.com, ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 4/5] arm64: dts: mediatek: mt7622: Add missing clock to
 audio-controller
Message-ID: <20260121184437.GB3842411-robh@kernel.org>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
 <20260113110012.36984-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110012.36984-5-angelogioacchino.delregno@collabora.com>

On Tue, Jan 13, 2026 at 12:00:11PM +0100, AngeloGioacchino Del Regno wrote:
> Add the missing audio_mrgif_pd clock to the audio-controller node
> to both resolve a dtbs_check warning and ensure that the AFE merge
> interface is clocked while using audio.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
