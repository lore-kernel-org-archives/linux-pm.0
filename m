Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395744;
	b=YNDh903tcXIx9CZeU8gsqfFp3oPFxxEyBzSQXAKGyNOFGHuZ4K4kuIaM0GucRt5mLgnf
	 /MEVmfstnpNb/+OrrxMnbIh77CTx4DtJj4a1r+OgYke5TwgoMf/w5FdooSF+xiOtzMIP5
	 4faRB+SxBNcPL4Guu147GBMMPrpsKzaMMCMTMbrxTvkmEWoov2clIp5SVZLLPkMPNYWS2
	 hSIhyO7twEWkkBJzlpK3cM5Zljz4BwJbqCMqv18Um02eD4o8pWCrml+chpnxJvZuOxUGK
	 NSJmQZCOoq1p8uNishNXRnQOdupohyZXLRJSn5w5BSC+Pcw8egH1JQGyhZePN3ANZ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395744;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=l1Lbhj629oz8/zycvVccxrCvO8pNIQR89gCFuvSaebQ=;
	b=slpi9jvBfuTuR3K7pZZEpaFrpk1DMyo3v4XMMWBASstd9Xud3ATBMFRLK0DD8zOu52zS
	 +sB2nkrN2ifposDLJBP6dzNN5ZR1mvq9KckTsdJYdGNh3f0BIy4OQGeT1IPfJ3ElWo3p7
	 c1ZqkvEHpu7BnF+p4YBnxn4xrZVVMyvTlszxeICj6D436QJPbLXSTtv4VnrAa7JwEynKP
	 ymLc/fEv22+fdhFm29b44Ir2Y/xaisiSAh793f2Nw2NKsCD5RETaHeYK5b8JIvkA7R70J
	 fnwHrIIL/ZBJA2qxHw3I9cAKpj66jXR1pCvdMCkvGSXpyN9G2hzDuaA24pj+QnixaeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=VDAxPLoX;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9A606A31A;
	Fri, 30 Oct 2026 21:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1C9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=VDAxPLoX
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 691AD4B0;
	Fri, 30 Oct 2026 22:26:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793395606;
	bh=x0s+Y+p3LsGdfDBkbP2s0CxQ/lopajynmwGxRET4ls0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDAxPLoXOAGCeSldDjMULbjhBhz6GQsnwuh85X7yB4ax0DAoUlskp0j2xnOuPLXPM
	 pMlaNc+0ridxGE2avBNdJm86S8LceXd/QhYIy+6e9ZHv98yVTpGQlcTpeeTovoqcEr
	 XMSWuzg7m3bM8Lpp4DUJsNU79YGNnhZekeNVMJzU=
Date: Fri, 30 Oct 2026 23:28:58 +0200
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
Subject: Re: [PATCH v3 13/15] dt-bindings: Increase Renesas X5H MDLC PD
 specifier bit width
Message-ID: <20261030212858.GA3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-13-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-13-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:53PM +0900, Paul Elder wrote:
> In the Renesas R-Car X5H, the module controller's power domain specifier
> cell's bit width has been increased. Update the bindings documentation
> to reflect this.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
> I'm guessing that the maximum number is now 512 but I can't find
> definite proof of this.
> ---
>  Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> index 27d85dd49f9546230ba9632aaa324986261d2156..644b07a07955b98b1832074eefcfd63eb6d45adb 100644
> --- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
> @@ -12,7 +12,8 @@ maintainers:
>  description:
>    Each instance of the R-Car X5H Module Controller (MODULE CONTROL) provides
>    Power Gating for up to 64 Power Domains, and Module Standby and Reset for up
> -  to 256 modules in the Power Domain of each Module hierarchy.
> +  to 256 modules in the Power Domain of each Module hierarchy. Recent hardware
> +  versions have increased the number of supported modules.
>  
>  properties:
>    compatible:
> @@ -32,14 +33,14 @@ properties:
>          are always on, and for which there are no MPDG bits to control them.
>  
>        - The second power domain specifier cell is the module standby part, and
> -        must be the module number (0x00-0xff), composed of the Module System
> +        must be the module number (0x00-0x1ff), composed of the Module System
>          Reset (MSRES) register index in the high nibble, and the Module Reset

Technically it's high nibble plus one bit, but I think this is fine
as-is.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>          Destination bitfield index in the low nibble.
>      const: 2
>  
>    '#reset-cells':
>      description:
> -      The single reset specifier cell must be the module number (0x00-0xff),
> +      The single reset specifier cell must be the module number (0x00-0x1ff),
>        and thus identical to the second power domain specifier cell.
>      const: 1
>  

-- 
Regards,

Laurent Pinchart
