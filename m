Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595E3546C2;
	Sat, 19 Sep 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841499; cv=none; b=kX44nzV2KOuw44EtTMihX7GuUh35CIxQ2aGtxiCvjWw37UQflIND1eSJpFztrr9z/oQnLU8u77IdOGKaHLY2CT/wev1QOY9lpE1K2FpQnpmirindx9gaNJG02KguCxNo3J4TyZ/fY3r3M1jsdWEmjtGrI6ycaQAEcSYwi++tiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841499; c=relaxed/simple;
	bh=juRcElsuKHGTVIIhdWymsPWLTCa2llbcM+acLYSoikc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3ShCdpDbSbcJCsbgQaHXsAYgqQKu2MrMGWjAPIuMuzXyg955IZLJESzt8ggejBvCF9P2B12FOXiNA6VCPttd7ziyjOizscrXWXTe55pF57ADX+8bLXpl7l9ev/TCTANLNSpDGGEkmVUL6IzL2jNVImVzMPq5yNvH56ktM+5Mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KblOEAm7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KblOEAm7"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 12215C36;
	Sat, 19 Sep 2026 20:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789841391;
	bh=juRcElsuKHGTVIIhdWymsPWLTCa2llbcM+acLYSoikc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KblOEAm7LXbZ3HvOpz336eDVbR1LraAQpNdb3ued8nBGMDpUab5jJMCpCEacfH7Co
	 TZjksmq2RzZTd7lkWvHD7oBA2rSOE5eKd9u89SOMY7fMGZWxci7rpQv6U57oRxUqvB
	 o5Y2sTwPUKD6ttJ7i610jV11EcrR4v3TpIt7AZFw=
Date: Sat, 19 Sep 2026 21:11:33 +0300
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
Subject: Re: [PATCH v2 09/11] media: vsp1: Add device info entries for VSPD
 on X5H
Message-ID: <20260919181133.GJ1124359@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
 <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-9-dbe9236bfd22@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-9-dbe9236bfd22@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Sat, Sep 19, 2026 at 02:07:06AM +0900, Paul Elder wrote:
> Add device info entries for the VSPD so that the driver can match on the
> VSPD on the X5H and handle it slightly different hardware configuration.

s/it/its/

> 
> On the X5H there are two variants, the VSPD (a) and VSPD (b). As the (b)
> version has a separate version number, add that as well.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> ---
>  drivers/media/platform/renesas/vsp1/vsp1_drv.c  | 22 ++++++++++++++++++++++
>  drivers/media/platform/renesas/vsp1/vsp1_regs.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> index 5597595414fe787413c7daa5a3142faa9ced8408..627771e3056617daa8e10d1fb68218435cde0a64 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> @@ -860,6 +860,17 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
>  		.uif_count = 2,
>  		.wpf_count = 2,
>  		.num_bru_inputs = 5,
> +	}, {
> +		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
> +		.model = "VSP2-D (a)",
> +		.soc = VI6_IP_VERSION_SOC_X5H,
> +		.gen = 4,
> +		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
> +		.lif_count = 1,
> +		.rpf_count = 5,
> +		.uif_count = 2,

This is not quite correct, this VSP has 8 UIFs (from UIF0 to UIF7).
However, not only does the driver support at most two UIFs, it hardcodes
usage of one UIF per LIF, and starts at UIF4. Declaring two UIFs here is
fine for the time being, but a comment would be nice.

		/* TODO: The VSP has 8 UIFs, while the driver only support 2. */
		.uif_count = 2,

> +		.wpf_count = 1,
> +		.num_bru_inputs = 5,
>  	}, {
>  		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
>  		.model = "VSP2-D",
> @@ -870,6 +881,17 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
>  		.uif_count = 2,
>  		.wpf_count = 1,
>  		.num_bru_inputs = 5,
> +	}, {
> +		.version = VI6_IP_VERSION_MODEL_VSPDB_GEN4,

I think that should be VI6_IP_VERSION_MODEL_VSPDB_GEN5.

> +		.model = "VSP2-D (b)",
> +		.soc = VI6_IP_VERSION_SOC_X5H,

And you can drop the soc match for now, no other SoC uses the version
model ID 0x20.

With those small issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +		.gen = 4,
> +		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
> +		.lif_count = 1,
> +		.rpf_count = 5,
> +		.uif_count = 1,
> +		.wpf_count = 1,
> +		.num_bru_inputs = 5,
>  	}, {
>  		.version = VI6_IP_VERSION_MODEL_VSPX_GEN4,
>  		.model = "VSP2-X",
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> index 8abf39bac6c2f333696ebf55de87586d2df3bed0..489d88107d1c17530a74736c40563a93cc17e567 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
> @@ -800,6 +800,7 @@
>  #define VI6_IP_VERSION_MODEL_VSPBS_GEN3	(0x1a << 8)
>  #define VI6_IP_VERSION_MODEL_VSPD_GEN4	(0x1c << 8)
>  #define VI6_IP_VERSION_MODEL_VSPX_GEN4	(0x1d << 8)
> +#define VI6_IP_VERSION_MODEL_VSPDB_GEN4	(0x20 << 8)
>  /* RZ/G2L SoCs have no version register, So use 0x80 as the model version */
>  #define VI6_IP_VERSION_MODEL_VSPD_RZG2L	(0x80 << 8)

-- 
Regards,

Laurent Pinchart
