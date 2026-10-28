Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194187;
	b=5BJdCX0Bnijo3idozoC/u8GpEh3MdSh4DL2vfpLUpy0kTqjicZ1o2uKxoUwYdYSIHyxN
	 VKOYdDlsLsTQpNIQSdyKT1OCm2d88BWkqI2QZLZa0MQiSHLnTBLf9e5pkUvp+0I2cPTWK
	 iU7X70ueZr0hxveEdTeLXKCclscrJKcbHaJVVkWZP2HLcHYfnqy9Qvx3d1GUfvFzPlcxo
	 U8pyGrMrYg5/S92FMem3u6ng3kfsiMEAuKjludfCJmvnlY50dsWYiS3bsLOtArIK8aud3
	 IMLQrifFCPNkumtRvED9B16rneMG36rv/9ZxhJBc04aPZ4kG79KpRTqLy2Urz9AKvhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194187;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+ZDZrqj/BPoTA6v4mR/qLoQhcDV/UIjpuvoi1Z0zPGQ=;
	b=dXG0ufqVBhnxEcYmYZ4Xlyih+LOo69Arr9JN3tgz5OcvcmTpj4xIvzliNX400GVJVZmY
	 EkGUt2kBboW0wVJm7o05fCSbgVIIUVLZkPvWGtIR92UDzKuCtAfGE15A0zbp7xojrPrGZ
	 aNiEQ7qoB0iNNnOma7/RVhfiN72O++I9+UMTzVOfilawcbeZ8RBPm8ltwAjpkcWeEDw27
	 w2ThUkQ6LS53hDJpNR2pKcZiOUQFP4IBT/MXGEwn2cbnvIa9ojAe3JSZsz4VvFOZYySaU
	 XOqci5zVM2VW2UGL7VAXD0hVw0bcaeS5TOBaK2TGE+gviJ5pXLiQzytypxfU4vqVfTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DC6WunDL;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1B606A31E;
	Wed, 28 Oct 2026 13:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA1B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DC6WunDL
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE3C034;
	Wed, 28 Oct 2026 14:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793194046;
	bh=8cQ5CvO/2sA2dQUmqeKVIlmOQmp+Y7f2f6c5x7Y+SrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC6WunDLJngl6a5oLdyhXtOxCbeD47TRHBYXKqGadYb+KVLYJL2wFP2W9sAuwBbuT
	 0ZrOdBnemjOFetphtsckixYkVX7RFSmvWk02kL7PZ8kp0LZj+sCKS0v9q3bHzCknIv
	 9SbqSAWUkTebMzav3ZRtsAa7t8pR/VLI8J3bBbRI=
Date: Wed, 28 Oct 2026 15:29:37 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM
 clocks
Message-ID: <20261028132937.GL15441@killaraus.ideasonboard.com>
References: <cover.1793026273.git.geert+renesas@glider.be>
 <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
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
In-Reply-To: <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>

Hi Geert,

Thank you for the patch.

On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> Add definitions for the clocks used by the PWM modules on R-Car X5H:
>  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
>  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH 2/7] dt-bindings: clock: renesas,r8a78000-cpg:
> Add GPIO clocks"
> https://lore.kernel.org/624a9fb09e4ec74b1995797e5121b86e7206f5f2.1792776697.git.geert+renesas@glider.be
> ---
>  include/dt-bindings/clock/renesas,r8a78000-cpg.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> index cd7192ccecd4e22c..8c30476d41448cf5 100644
> --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> @@ -28,5 +28,8 @@
>  #define R8A78000_CPG_SGD8_PERW_BUS		18
>  #define R8A78000_CPG_SGD32_PERW_BUS		19
>  #define R8A78000_CPG_S0D24_HSCN_OTHER		20
> +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN	21
> +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN	22

Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
R8A78000_CPG_SGD16_PERW_BUS, as well as
R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.

> +#define R8A78000_CPG_S0ASYNCD8_PERW_MAIN	23
>  
>  #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */

-- 
Regards,

Laurent Pinchart
