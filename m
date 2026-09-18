Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18452D2488;
	Fri, 18 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695364; cv=none; b=aqlU+7Ka+x6t3BX9YMj0UIcTtIojtFgzz3gHYaMAQW1mZzXf7bNahZ9jFXZcSsbcLwAWT6aToqZuIa8XWMd7tm/sOjiEXJ9bOfX/1eokqZFeDK+8KY7Sl4xibf7Maw1sVw/AJefLWnqn1otF+mIOWZmXn+9jF+ST9Zjh0YImy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695364; c=relaxed/simple;
	bh=yypjweXNErL1B/GaPeOA5qYKGC2xod71mU7gPTsotck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLlcwwq6AWqshr2jWR9uTq2tHz1wdg+znRT7D1JW7jDg8IuVjLkE8NxvQoLsjRLGo3IoXnCVMamtnRqxtGGJN5M4cpn1sS22ndRU5YuLza5QuJFI/NBGU6bg/SXkv+gRBli9XccZukK04qZZRuz+OqFYILEjB9Td8WHkHSapTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vaqXAAv5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vaqXAAv5"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B23B4DC;
	Fri, 18 Sep 2026 03:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789695257;
	bh=yypjweXNErL1B/GaPeOA5qYKGC2xod71mU7gPTsotck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vaqXAAv5+95uztFO9foAS27GLc9+QG1nx9D4be2NYqIXqWnIUVCSExZBX6CLnjV6r
	 XQPlt/DgZ09KpngOSgkjpjzHvdyjjrBG0DULdjS2ZHRnAUQAinVEfBcKMxEDEeJVvd
	 7ZBosumjGjIcwY5QOR7YFIMtZKv3puYILlUx7AEA=
Date: Fri, 18 Sep 2026 04:35:58 +0300
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
Subject: Re: [PATCH 10/10] media: rcar-fcp: Add R-Car X5H support
Message-ID: <20260918013558.GJ145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-10-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-10-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:49PM +0900, Paul Elder wrote:

Same comment about authorship.

> The FCP instances found in the R-Car X5H v1.0 have a different device
> ID. Add it to the devices list.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/rcar-fcp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
> index 15bcbbda3b853f71780aae876f6440b33addf193..8d62f07d38b7881270e94331b0564e4665664646 100644
> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c
> @@ -33,6 +33,7 @@
>  #define RCAR_FCP_REG_VCR_REVISION_M3N		(6 << 0)
>  #define RCAR_FCP_REG_VCR_REVISION_V3H		(7 << 0)
>  #define RCAR_FCP_REG_VCR_REVISION_E3		(8 << 0)
> +#define RCAR_FCP_REG_VCR_REVISION_X5H_V1	(12 << 0)
>  
>  #define RCAR_FCP_REG_CFG0			0x0004
>  #define RCAR_FCP_REG_CFG0_FCPVSEL		BIT(1)
> @@ -223,6 +224,7 @@ static int rcar_fcp_setup(struct rcar_fcp_device *fcp)
>  		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3N, "M3N" },
>  		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3H, "V3H" },
>  		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_E3, "E3" },
> +		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_X5H_V1, "X5H v1.0" },
>  	};
>  
>  	unsigned int i;

-- 
Regards,

Laurent Pinchart
