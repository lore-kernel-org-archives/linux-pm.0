Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134197;
	b=QJ2FI0MCJ1KPcuYqJQiPw2Dn4tdVCPOZI4o7Q4qBQj2osm7j9YBXmwMzfM1EZWINtYiD
	 8wEjQfEaVysArm2LtjafolQtwCeqDjct++Z2s370IIb5CkjXp9vWV/H3TVH/PmITiLfyc
	 dCRIAQVnwBk828uAdnEV7WxrSECiszC+VgazP7LNpfsmsXpS4Egej/DPGyeFmK6rqKnei
	 YzFXPF7nY/Th1f6FYJv4o9nxMnWQLjcnRMZ/z6YaBQWdN3I3nvbNhV4hhhaop8pCuKFDD
	 z08d35z2jlKLwuCvrIEtKIpD5XwwqcPBAAG/DSA0+8/hrcW/yN0mA1CmCc6koq+eOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=womGwJTHKJOD+1XH3NXRfs1nx4BuGXpRtnEuUmoaI/A=;
	b=DTh4n+/HWoJcfGisAoW+CzVQ4cEgPmhnKm4Exeh1y6P/QnVIrLf8Q4dY9VZpnFxkJzXp
	 AngZb4HY9QsgGV5cElWtBVj5O2fErSSTUOibjafpd6mpNFoVeFLHFpjUPQgknqJEkFtLC
	 ixRv0TbWa26Q5eifjLsyMo4ya6r9KjZEpDagb1E7vF4CO+B7h5b0Y3ENcJaibCXVqz8wu
	 AQLoU88XeKkg79/8CXeIeZEf52jY79iCnszZWDmPdHbT2EamTZMyOybgnJMnAebIqq8+8
	 DxRtcdOKSJYu/GxeBXpIQtOPO39n0RhAmiFcwis1Rkqm7va8EfjJ+FLgNKeL/dY5uAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+g8D9oO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B050606A31E;
	Tue, 27 Oct 2026 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+g8D9oO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD611F01825;
	Tue, 27 Oct 2026 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134197;
	bh=womGwJTHKJOD+1XH3NXRfs1nx4BuGXpRtnEuUmoaI/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n+g8D9oOWgSr6eO7E3AJwHkYv7P+3NtQQWr3w96N/lGGIecQSI3UOQDRkzC+9W1kq
	 hc8K9ipWWWfgXBi1kDHX6NSt5La2dD0J6ijk35St7Hau/FGpWcma2ONjsBtaluYbUh
	 eSUa9shwBBOx2kgsfZY0TLc1QX+D0Qvl53807eoj7u02+F4Ly2t5Nqo3V675BPu/KH
	 oyzsS5B031jep4KsRCFL+8fdrj2N6MUSv6J2ZbXxYwU2m9gM3r/soqO7Djt39LlMBp
	 KI3OBjmfYNcH2jd1STfUIxNn/bzIdfxlyjCckHnP1CRoC5ojbrHRngDpoPBcPCWusU
	 kIIIjyCljcw3w==
Date: Tue, 27 Oct 2026 15:49:52 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: ulfh@kernel.org, angelogioacchino.delregno@collabora.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8188: Use
 access-controllers in the power controller
Message-ID: <20261027204952.GA896421-robh@kernel.org>
References: <20261011184755.2058017-1-michal@nozomi.space>
 <20261011184755.2058017-5-michal@nozomi.space>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011184755.2058017-5-michal@nozomi.space>

On Sun, Oct 11, 2026 at 08:47:55PM +0200, Michał Kopeć wrote:
> List the blocks that the power controller accesses in access-controllers
> instead of the deprecated per-domain mediatek,infracfg phandles, and add
> MFGCFG, which the power controller needs to enable the GPU timestamp
> counter whenever it powers MFG1 on.
> 
> Signed-off-by: Michał Kopeć <michal@nozomi.space>
> ---
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 14a320f0c70cb..cf0da77c5fd29 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1000,6 +1000,7 @@ scpsys: syscon@10006000 {
>  			/* System Power Manager */
>  			spm: power-controller {
>  				compatible = "mediatek,mt8188-power-controller";
> +				access-controllers = <&infracfg_ao>, <&mfgcfg>;

Do these providers have #access-controller-cells? Doesn't look like it 
to me. You should have some cells here that define which access 
control in infracfg_ao (and mfgcfg) the power-controller uses. Looks 
like you are abusing the binding to me.

Rob

