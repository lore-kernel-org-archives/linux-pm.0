Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397470;
	b=SnW+GpnSMs2VhoerQM4ofmfBUH87sYRlm8UCBaReFPvK5SPcYTvGkPiO9qd4w4WHKDRD
	 zKsT28RL4vlK0VdiB/tc4h3q+SU46rjVKB4aT53whArK78jKF7Q/+6AuklXaPZiXYNLtU
	 cQY2DxtKRZWGXGAJDK1Awe2BXnzqr153Z3P99T79k6zrukqsqjTJvpVqvKpxVCsQg6WHO
	 kqJ3+tYNNG771JRR9VEdmvspZ2YldLW2YoleJoFhcclMflARRtbHcKV40Zibr23Uo3x3l
	 AVbS3tw+rC3bq8a6sWpePxDQt8kLm7YKgKgYvPMCR7cw74UwI9i0A5qfqT0lsqkgPqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397470;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=bEGOgsDVGhIJx4rlG5jGs+QKv8RNAZHyuX7MzGnejOQ=;
	b=D/KaxP3nV4cdcdbhGCj3dtGGhck30eoKg3J9VJe+qISZcK6Cl/pIsoCGTvtSbuNbRaRz
	 8rFlhT5Fm1RpIYf4A6MYbiKbi8PbTSuZvrJtIyi6byQQyPy/Dl9db+xseRM9d35QNtWDn
	 TV/dq1ojsQXlRa8YHfiaQJ3Wi1gzo8iFmaSm5h0uaPS3E70lQ3tkR6eGCgy3idEW8xWOj
	 D6NS6fYuVMLkc7wyKfAm4Aol4z0gLybs6EPNbDHeSvq3p/ciag2ZEv2tMeV8cFlP4SiBt
	 cbieYriJSkUcf1CC2cd4HvEaxmK9URTF98xwzor5/C3VT68Bt/sLalbj8ETP+4dGfKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KSGgq7+O;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65945606A31A;
	Fri, 30 Oct 2026 21:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65945606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KSGgq7+O
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C05404B0;
	Fri, 30 Oct 2026 22:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793397333;
	bh=V3JgVLQtVdb5VLqlOWN8YJQxZQDEBr6c4IsRWxr421M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSGgq7+O2MKnE1J4x3pkNTGoCUu+L4ZbDx/P7Mwlk0aqZvussGRm4uRHhOLZdN3y8
	 RIqm/+a+g6zwT6xWpidRyUUJiUw3ygUeBTLd7MS7ElQ0AwSPcnlmm8JRhx0y+Gr8KK
	 4v3sVcCrS8xnyU72gzxn5imF7PlXojPXsM0p9frQ=
Date: Fri, 30 Oct 2026 23:57:46 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH DNI v3 01/15] dt-bindings: clock: renesas,r8a78000-cpg:
 Add CPG_SGD4_VIO_DP_{TX,OTHER}
Message-ID: <20261030215746.GB3144851@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-1-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-1-e052903a3832@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Oct 15, 2026 at 04:51:41PM +0900, Paul Elder wrote:
> Add the CPG_SGD4_VIO_DP_TX and CPG_SGD4_VIO_DP_OTHER clocks. The former
> is used by FCPV{B,D,I} and VSPD while the latter is used by VSP{B,I} on
> the Renesas R-Car X5H.

The comment message should probably be updated based on the discussion
in 04/15.

> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  include/dt-bindings/clock/renesas,r8a78000-cpg.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> index 5851a29847f961b9b4ec270f263eb3aa19e45308..8c1a01e28ddbb26c583d7c9b387400ef6626c06c 100644
> --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> @@ -12,5 +12,7 @@
>  #define R8A78000_CPG_SGASYNCD16_PERW_BUS	2
>  #define R8A78000_CPG_S0D4_PERE_MAIN		3	// FIXME Preliminary
>  #define R8A78000_CPG_MSOCK_PERW_BUS		4	// FIXME Preliminary
> +#define R8A78000_CPG_SGD4_VIO_DP_TX		5	// FIXME Preliminary
> +#define R8A78000_CPG_SGD4_VIO_DP_OTHER		6	// FIXME Preliminary

Rebasing the next version on top of Geert's v4 of the CPG, those won't
be preliminary any more \o/

Please define all SGD clocks in one go (see the discussion in [1]).

[1] https://lore.kernel.org/all/e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be

>  
>  #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
> 

-- 
Regards,

Laurent Pinchart
