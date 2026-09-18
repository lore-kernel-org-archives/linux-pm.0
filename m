Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB713368A9;
	Fri, 18 Sep 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695172; cv=none; b=SiJWr45WfXKOt3Iu675xOcSon76pk5sp9BzQofjbHCrpPtuqu+lNNGvit7lL5hrjzmIpJGILFw88T58DTDh2g0IDzuzv1nB1o5qBkgz7Kst+9wz/LgoA0VMlQ70Qx7sjCFFs68vx9OAV/4BFh78cF9DXJ2E1hML+1ZjTyWcoLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695172; c=relaxed/simple;
	bh=IwpDpmi4gI8G7NWAlsxwrY6cMV9XanhKgPpbSrtKgFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gClqsvYDn95Ycc21IdD8g+0eKd6BB4PH1utI2j/r2KW1bmvXIOVkgmepcGsn2mGyFJ2W7Bj/Fqfo0Epncz1qldRou6FvNbsi5b4C/3AHeFAVCPYAjVM4uIsRwxaJ/o6RR9NyEGM4+v1zXp7sK212ThMNXTap6OnVk/2FHc8uFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=A0xRdBJV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="A0xRdBJV"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDD6D4DC;
	Fri, 18 Sep 2026 03:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789695061;
	bh=IwpDpmi4gI8G7NWAlsxwrY6cMV9XanhKgPpbSrtKgFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0xRdBJVPyHnhQsGfyyY9EnnLNnnL8xpTrOXbdRPxudG2i4PcPiWZt++ko/I2fWZE
	 o6XZBgEPa76W8fBYWapSb1ajzIyLYEOX1MZgPj2emRNSSYv8HR7K3bYOWWmCQYb9Ai
	 ECQOjZ9M/fxV8umEUGQ6eZZOLwPOjkJgpW5IcPFc=
Date: Fri, 18 Sep 2026 04:32:42 +0300
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
Subject: Re: [PATCH 09/10] media: vsp1: Document X5H SoC ID
Message-ID: <20260918013242.GI145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-9-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-9-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:48PM +0900, Paul Elder wrote:
> The R-Car X5H uses 0x04 as the SoC ID in the version register. Document
> is with a macro, as done for other R-Car SoCs.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..c5066aa17f0139fe7072687325beaa0e04ba260a 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> @@ -814,6 +814,7 @@
>  #define VI6_IP_VERSION_SOC_D3		(0x04 << 0)
>  #define VI6_IP_VERSION_SOC_M3N		(0x04 << 0)
>  #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
> +#define VI6_IP_VERSION_SOC_X5H		(0x04 << 0)

I don't think this is correct. You will find the right value when
enabling the VSPD.

>  #define VI6_IP_VERSION_SOC_V3U		(0x05 << 0)
>  #define VI6_IP_VERSION_SOC_V4H		(0x06 << 0)
>  /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */

-- 
Regards,

Laurent Pinchart
