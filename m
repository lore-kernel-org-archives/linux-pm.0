Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772261DB95E;
	Fri, 18 Sep 2026 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694154; cv=none; b=NGenIIIUWXMSCePTM43T9evPG+FzfbhP02rZ3xypvxtrsUU6Gf7nJzZvJ6GltKtjFcYKdj8A3jP8kFO0vWXPtuRi48Og5j+8GQ+SRN3fb10Zui6AgCNRQimfB2kcxJzQw7XqqogjXsGf1+k+othax6vr0+XRotBhobgbzAEGKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694154; c=relaxed/simple;
	bh=PuCXNT48M42iB1BmrH/YlMI47Kq6KsVM+HGSCpoeXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1+M0jf4f4G+34RidQ92fzc7SMcCn4Mx5sMG1fkziNcHQrxb8Gf9rnpFcFc0bDwpNBXEsTA49OnCZHs0zd5WJSpVItnO5BVSCUgxc2/VRFcvNG3qQByaJBxZ0Q6OFco6uIvIbhuu4PQNL2tpBJssZBv1aPZ/qx12wDaxnIzX7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Nq7DQ0pd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Nq7DQ0pd"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A557C1;
	Fri, 18 Sep 2026 03:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789694047;
	bh=PuCXNT48M42iB1BmrH/YlMI47Kq6KsVM+HGSCpoeXtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nq7DQ0pdBzkXV8YfCf1qs3q+0KPmTDk9Mz+68dvG2HGYn4P5XYBYA260ysefkl/vj
	 8fcuVh5yQAkBITGn0Ctx3gdEIXcf6mz+X8QOL4LL0o5Rx8mxm9Dim7KMasPGQzB8Ek
	 lqCvJWGozkzGslKjeHyNSkz1oiEF5AiehfUyIxkM=
Date: Fri, 18 Sep 2026 04:15:48 +0300
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
Subject: Re: [PATCH 03/10] pmdomain: renesas: r8a78000: Add maps for VIO for
 SCP FW SDKv4.36
Message-ID: <20260918011548.GC145152@killaraus.ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-3-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-3-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:42PM +0900, Paul Elder wrote:
> Add maps for VIO for the VSP and FCP power domains and reset domains.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

The driver in upstream is currently a barebone version so this patch can
be merged yet, but it looks good to me. I've successfully tested it on
X5H. We can carry it downstream for the time being.

> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 34 ++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> index a0d83f27735e7deacb060e4102e510726b34e62e..c8d34376800982000cfa1b1ae6c279edd749ec9c 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -861,6 +861,36 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_28_0[] = {
>  	{ /* sentinel */ }
>  };
>  
> +static const struct power_map_in r8a78000_mdlc_vio_power_fw_4_31_0[] = {
> +	{ 0, 4 },	/* PD_VIO0 */
> +	{ 1, 5 },	/* PD_VIO1 */
> +	{ 2, 6 },	/* PD_VIO2 */
> +	{ 3, 7 },	/* PD_VIO3 */
> +	{ 7, 11 },	/* PD_VIO4 */
> +	{ -1 }
> +};
> +static const struct mod_map_in r8a78000_mdlc_vio_mod_fw_4_31_0[] = {
> +	{ 0xf9, 163 },	/* VSPB0 */
> +	{ 0xfa, 164 },	/* VSPB1 */
> +	{ 0xfb, 165 },	/* VSPB2 */
> +	{ 0xfc, 166 },	/* VSPB3 */
> +	{ 0xfd, 167 },	/* VSPB4 */
> +	{ 0xfe, 168 },	/* VSPI0 */
> +	{ 0xff, 169 },	/* VSPI1 */
> +	{ 0x100, 170 },	/* VSPI2 */
> +	{ 0x101, 171 },	/* VSPI3 */
> +	{ 0x102, 172 },	/* FCPVB0 */
> +	{ 0x103, 173 },	/* FCPVB1 */
> +	{ 0x104, 174 },	/* FCPVB2 */
> +	{ 0x105, 175 },	/* FCPVB3 */
> +	{ 0x106, 176 },	/* FCPVB4 */
> +	{ 0x107, 177 },	/* FCPVI0 */
> +	{ 0x108, 178 },	/* FCPVI1 */
> +	{ 0x109, 179 },	/* FCPVI2 */
> +	{ 0x10a, 180 },	/* FCPVI3 */
> +	{ -1 }
> +};
> +
>  static const struct mod_map_in r8a78000_mdlc_pere_mod_fw_4_31_0[] = {
>  	{ 0x30, 193 },	/* PERE_GPIODM0 */
>  	// No CLOCK_ATTRIBUTES { 0x31, 194 },	/* PERE_GPIODM1 */
> @@ -997,8 +1027,8 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_31_0[] = {
>  		/* FIXME .mod_map = r8a78000_mdlc_vips_mod_fw_4_31_0, */
>  	}, {
>  		.base = 0xc5000000 /* mdlc_vio */,
> -		/* FIXME .power_map = r8a78000_mdlc_vio_power_fw_4_28_0, */
> -		/* FIXME .mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0, */
> +		.power_map = r8a78000_mdlc_vio_power_fw_4_31_0,
> +		.mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0,
>  	}, {
>  		.base = 0xc08f0000 /* mdlc_pere */,
>  		.power_map = r8a78000_mdlc_pere_power_fw_4_28_0,
> 

-- 
Regards,

Laurent Pinchart
