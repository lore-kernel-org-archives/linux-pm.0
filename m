Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397953;
	b=x9uWp8SI9botKTSDW4m4v/9+w5C9JI5/rF6aNapqVUT7GuZdk77lqsIteAVa6xm7If8x
	 KebK/Ok5reubKbtsrVr5VcFv/jL7Xf/ZCYmvTlHJauJCXrWsPTYE+PYJ1rNxwa5VJhQVX
	 LNxGRLti4OgAyt3fLLVD5mZUEvZrOJZkBkEstlBE/KZ8Qd41ztZEdxaLu8tLaOfdmRson
	 0Wjr+gYm1zXr7MJVBXULYMJUaXO7YigEyKoUq6g9NGNJmwfKwuQ612oJzRwy3SvVeTu0I
	 NhWh+yJs4VgytUZyUDn+OUewUN9Lipo+LqtoY4vDoEMDD4+UNaO+wnTVSKeirSA/PYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397953;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vBJMC4GJvj0qjaTPwYTt5q30xb5b2ZksOkUaeaR7BVM=;
	b=pzwk2wau/gKX3Fj97chHI3lIy54lIa8ocD3rfOjQJE4Tl4TkWmV/oUogSA/J29Pfdhq3
	 cOf4m8DIoHt+EYiD7RjcfSeWZQWjenphwXseNk9vWwxwqi90odkB7IyoJIlLtrlU2g7cZ
	 /i5toORuTsPkCDMJmEKneTD+QacUqoMjFX6mqxXdDtUBUgb1/rf1cPPuU7udR6YtLPkYG
	 QheTmo1P2xS60dSCADtDKblcm2+WuoTW0vvptrabwMaX6bR7V6tCVXYmnuoqdT6jZPX4T
	 yzMxagWl9f7LM/0tAZIDBaSyN25pyn/p4uP4uippGrSTPstQvO4/JiRh3qIi4aks6tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YgPQIJJc;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECB606A31A;
	Fri, 30 Oct 2026 22:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9ECB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YgPQIJJc
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6323F447;
	Fri, 30 Oct 2026 23:03:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793397816;
	bh=X4vKdAe6tCIGUMBGk95lp3ykmxTWgC6GkF33THOI3As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgPQIJJcZCU7Qs0ZADaMzgFJVe0SzS1pAKe4q3A2qBJVEN//BmnybrCyMLOv3Iwjj
	 i/FnFPBj2jPdj47R+swC22zYL4x5wp62KWb1+WVe0DxcUm94c3JkwG/xfICyMLlXcc
	 MOdfVC6KaKYekw/iw+GuuC3e1lmSrBKqkNHfa0NY=
Date: Sat, 31 Oct 2026 00:05:49 +0200
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
Subject: Re: [PATCH DNI v3 03/15] pmdomain: renesas: r8a78000: Add maps for
 VIO for SCP FW SDKv4.36
Message-ID: <20261030220549.GH3178046@killaraus.ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
 <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-3-e052903a3832@ideasonboard.com>
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
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-3-e052903a3832@ideasonboard.com>

On Thu, Oct 15, 2026 at 04:51:43PM +0900, Paul Elder wrote:
> Add maps for VIO for the VSP and FCP power domains and reset domains.

s/reset domains/module control/ as its not just reset (and there's no
"reset domain") but also module control clock ?

> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> 
> ---
> Changes in v2:
> - add VSPD and FCPVD
> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 54 ++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> index a0d83f27735e7deacb060e4102e510726b34e62e..cabe6435ecd791e358fd6987ce9394898d8c87f8 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -861,6 +861,56 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_28_0[] = {
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
> +	{ 0x70, 26 },	/* VSPD0 */
> +	{ 0x71, 27 },	/* VSPD1 */
> +	{ 0x72, 28 },	/* VSPD2 */
> +	{ 0x73, 29 },	/* VSPD3 */
> +	{ 0x74, 30 },	/* VSPD4 */
> +	{ 0x75, 31 },	/* VSPDB0 */
> +	{ 0x76, 32 },	/* VSPDB1 */
> +	{ 0x77, 33 },	/* VSPDB2 */
> +	{ 0x78, 34 },	/* VSPDB3 */
> +	{ 0x79, 35 },	/* VSPDB4 */
> +	{ 0x7e, 40 },	/* FCPVD0 */
> +	{ 0x7f, 41 },	/* FCPVD1 */
> +	{ 0x80, 42 },	/* FCPVD2 */
> +	{ 0x81, 43 },	/* FCPVD3 */
> +	{ 0x82, 44 },	/* FCPVD4 */
> +	{ 0x83, 45 },	/* FCPVD5 */
> +	{ 0x84, 46 },	/* FCPVD6 */
> +	{ 0x85, 47 },	/* FCPVD7 */
> +	{ 0x86, 48 },	/* FCPVD8 */
> +	{ 0x87, 49 },	/* FCPVD9 */
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

The values look fine. After rebasing the MDLC v4 from Geert,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +	{ -1 }
> +};
> +
>  static const struct mod_map_in r8a78000_mdlc_pere_mod_fw_4_31_0[] = {
>  	{ 0x30, 193 },	/* PERE_GPIODM0 */
>  	// No CLOCK_ATTRIBUTES { 0x31, 194 },	/* PERE_GPIODM1 */
> @@ -997,8 +1047,8 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_31_0[] = {
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

-- 
Regards,

Laurent Pinchart
