Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295539BFF2;
	Fri, 18 Sep 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695146; cv=none; b=SFUyufl687DJnGDoBFHCW4XSnpC2XAKXvhJNBiRUr6Cz2JhsodkFwHOiaZC3c3sJWFqt4t4u1at3VihvmeS5ESXBkkYyUU0rncrWxThTKwo5cUJOR86iua3s+g21XDGajuDgeBEdM4Xb6kFVQoY1zODb8LXfHy/b+5B8FcHPz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695146; c=relaxed/simple;
	bh=P9V2jQvBe9oGgYWi/miJ/s3R+7V5TrEwLg8xnjx4vH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZTKM3ujjYvYp3vxeExsgoWI8dMTctwIFqB325XkewbxgKxrb0ORqX3U6/y4ltqMB7MnqwIot0alU0q9rS+1+yenTHvyoRL1Gy8hfiJjmmvlbUJMyNC50AYgo1tk8dIOVD+9fDvXG5pG2fkoLP7VfWG+1u619dFo9Y9I7f42BNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LW/3+CA+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LW/3+CA+"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F5D74DC;
	Fri, 18 Sep 2026 03:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789695026;
	bh=P9V2jQvBe9oGgYWi/miJ/s3R+7V5TrEwLg8xnjx4vH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW/3+CA+qgIj4NRFJC2sJbnyB/6ql8NuGDCdJxa8jRiaCZIhTz03FGhQWmwbgwU4O
	 T6C1PeilSzx6ARD2ExZtIKR2z94aO+7xaPVTRg/BOO8812XJyxCjULm9AOM9hCmVs/
	 sdHOwo0yZfxR2J+fhz9/MH9fDOTS3pq+DIRK4vUQ=
Date: Fri, 18 Sep 2026 04:32:07 +0300
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
Subject: Re: [PATCH 08/10] media: vsp1: Support full VSPB on R-Car M3-W, M3-N
 and E3
Message-ID: <20260918013207.GH145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-8-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-8-4c72d4e086dd@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Thu, Sep 17, 2026 at 09:04:47PM +0900, Paul Elder wrote:

Please preserve authorship of patches.

> The M3-W, M3-N and E3 SoCs integrate a VSPB that reports the same
> version ID as the VSPBD in the H3 and H3-N, but includes additional
> entities compared to the VSPBD. The VSPBD device entry in the driver
> matches on the version ID only, which results in the VSPB being handled
> as a VSPBD. The driver therefore doesn't support the CLU, LUT and HGO
> entities in the M3-W, M3-N and E3 SoCs.
> 
> To fix it, split the device entry in two, one for the VSPBD with an
> additional SoC ID match, and one for the VSPB. The VSPBD entry needs to
> be listed first, otherwise the VSPB entry will match on H3 and H3-N as
> well.
> 
> The VI6_IP_VERSION_MODEL_VSPBD_GEN3 macro is renamed to
> VI6_IP_VERSION_MODEL_VSPB_GEN3 to indicate that the VSPBD is the special
> case.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/vsp1/vsp1_drv.c  | 13 ++++++++++++-
>  drivers/media/platform/renesas/vsp1/vsp1_regs.h |  2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> index 762a9e776a94d50accad070068f92f6dabb81035..5597595414fe787413c7daa5a3142faa9ced8408 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> @@ -781,14 +781,25 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
>  		.wpf_count = 1,
>  		.uapi = true,
>  	}, {
> -		.version = VI6_IP_VERSION_MODEL_VSPBD_GEN3,
> +		.version = VI6_IP_VERSION_MODEL_VSPB_GEN3,
>  		.model = "VSP2-BD",
> +		.soc = VI6_IP_VERSION_SOC_H3,
>  		.gen = 3,
>  		.features = VSP1_HAS_BRU | VSP1_HAS_WPF_VFLIP,
>  		.rpf_count = 5,
>  		.wpf_count = 1,
>  		.num_bru_inputs = 5,
>  		.uapi = true,
> +	}, {
> +		.version = VI6_IP_VERSION_MODEL_VSPB_GEN3,
> +		.model = "VSP2-B",
> +		.gen = 3,
> +		.features = VSP1_HAS_BRU | VSP1_HAS_CLU | VSP1_HAS_HGO
> +			  | VSP1_HAS_LUT | VSP1_HAS_WPF_VFLIP,
> +		.rpf_count = 5,
> +		.wpf_count = 1,
> +		.num_bru_inputs = 5,
> +		.uapi = true,
>  	}, {
>  		.version = VI6_IP_VERSION_MODEL_VSPBC_GEN3,
>  		.model = "VSP2-BC",
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> index 10cfbcd1b6e0b3a9c0a8daaa990babfaeb8dde0c..4c0315656e9f81a9656b58fb6f0233f8a22ac0e1 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> @@ -792,7 +792,7 @@
>  #define VI6_IP_VERSION_MODEL_VSPS_V2H	(0x12 << 8)
>  #define VI6_IP_VERSION_MODEL_VSPD_V2H	(0x13 << 8)
>  #define VI6_IP_VERSION_MODEL_VSPI_GEN3	(0x14 << 8)
> -#define VI6_IP_VERSION_MODEL_VSPBD_GEN3	(0x15 << 8)
> +#define VI6_IP_VERSION_MODEL_VSPB_GEN3	(0x15 << 8)
>  #define VI6_IP_VERSION_MODEL_VSPBC_GEN3	(0x16 << 8)
>  #define VI6_IP_VERSION_MODEL_VSPD_GEN3	(0x17 << 8)
>  #define VI6_IP_VERSION_MODEL_VSPD_V3	(0x18 << 8)

-- 
Regards,

Laurent Pinchart
