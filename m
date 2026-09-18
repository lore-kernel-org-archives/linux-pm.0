Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1D347BA7;
	Fri, 18 Sep 2026 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693435; cv=none; b=b20HRMlpjVpj1ZKWxJMHgnI2MZ2zrVq501kApti9v0jwM9jl8X1U+XqaWnkirI2PCXcgrNK137wv/WRnqpqG/urz46LqI4aWIempF1Hyg/5jRhtjGqj6MR7F+n25AqDHhZWvYPaZd1PwvuODTXBovD1AqAn+9IIraEsId97bfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693435; c=relaxed/simple;
	bh=Nkyaf8Y94zPujszAwuZIi2QbwdTBSAWXR98+hXXnwO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdwT8XMEXG+32q9GwFEwwRxA969TVQbLTB9aGmLVCN6NDgcT/HXWnvy0ZUA8s0YrssuxDMw1/XyPhd6k7kAPggycvhRPKoTkIXXY9F64KA1DP4yq16qiwPEAkfIK774PVPU+Fj7kFAMC7fsTEB8Q578q2vbJ2VeDzvRDAsj45Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LXhxiWH+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LXhxiWH+"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4FC9921BB;
	Fri, 18 Sep 2026 03:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789693328;
	bh=Nkyaf8Y94zPujszAwuZIi2QbwdTBSAWXR98+hXXnwO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXhxiWH+BmeY3PvyTMXbhxh4w61f+qJEytkkQG9jPeOl4J99LEcIqumZxRreqX7ag
	 DWHOMQXJIQ4yXtVO3NzQaWa14M7NGkqTKcQoZCnnFEotNmuVrCkMt6va96KbUeGucE
	 7ZM8vfGh1U+agHhfzlqEc4NtSGrn0J8gOyn5Lf7s=
Date: Fri, 18 Sep 2026 04:03:49 +0300
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
Subject: Re: [PATCH 01/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGD4_VIO_DP_{TX,OTHER}
Message-ID: <20260918010349.GA145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-1-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-1-4c72d4e086dd@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Sep 17, 2026 at 09:04:40PM +0900, Paul Elder wrote:
> Add preliminary clocks for testing:
> - CPG_SGD4_VIO_DP_TX is used by FCP
> - CPG_SGD4_VIO_DP_OTHER is used by VSP
> 
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

While those two clocks are not directly controllable, we need to ensure
that the parents are enabled. That will require taking a closer look at
the SCP firmware. As the X5H CPG driver in upstream is alone a barebone
version at the moment, that doesn't have to be fixed now. This patch is
not an immediate candidate for upstream.

>  
>  #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
> 

-- 
Regards,

Laurent Pinchart
