Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433844;
	b=a3PdrY1usXiUwvyvNkBW9TLNwyLjYixjOdKX/VyMHomktQ3Q8gMhXP0w6zCYyA6CErKt
	 AITWL2aWUtB1cHBiJxEDlHCKMUrBCJrEaLGyjWulRSU0pn5QNU4v3gS5Vh/I0mOTRpVxk
	 wqXwSQ6WnLLLwpmdH5KfhmkEWgwrywQ4g2d05RVf4eaZmHmX7/UsJq4WS59wmtuAt1uVg
	 VjqQv/9IQH0S21K0zkRdWS4yKIuwb33uwR1I+CrM3LThSKCfpP5lFQSXYiql8EtK5DjBt
	 ZWbYoA2QD6bDFJvnMSAdy9usuTW94Bb+z5h0y4WNP2BirRSYpGY75h/cp0k0hcWN7TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433844;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QjXQMNryhuvAvTuJVIUvtiTRHIcheq2l+6vCggwxoWY=;
	b=K2stsX860EqXLAYffeDG4+MIsaTW+sI+PcUDgXrJDBZ1UuI3l77pdcotEHUQ4NRdN5xI
	 VUv6ZvpP4ugfu18KygjqZeN+/0lSHxZ1gQ9H/T2u1lMCsE6X0wXBjKlB6S5g5B5NyNIDY
	 ZWd8JPrjo+dBWY80XhuYwIepBIKgy6vqpQn7JykWNKXt7KyXBi0YhFMuKGdSxpukfGptJ
	 IsqnRg+Hgo2pOLcVY+nWKr5KPJg8a5EfEM0gqqZ/Mw+TD5X8ftXqB5Ngv+p5Wwcf4u95U
	 y2LxkT//VsXX2VNw3ffhn+W8h3NRcvc3GxDYcEMhUqPuO+JvAMzir2e0bMAvEXkikdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OGx4r+fe;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52047606A31A;
	Mon, 23 Nov 2026 11:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52047606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=OGx4r+fe
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C1F3177;
	Mon, 23 Nov 2026 12:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795433690;
	bh=efBUn+KMT7fQIEAsOONhxg/wXG2a/zfIvlMf5DPX1Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGx4r+fetQOlAWhbjarDIbVCklN3ZQXCUPUp4J2gVVno0l61nyedpk7I0KDPbnkJm
	 R/gxt64WDJ4ZnR8bxORwWx5eT+vxd/pkC5IV4QbNh6K1YINcol42KR0qLQ1dX3ljlC
	 S3xQBleXSIPu/WQR0KlYfNx4Hhezjjf/O1uGD8mE=
Date: Mon, 23 Nov 2026 13:37:21 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 11/15] pmdomain: renesas: r8a78000: Drop MDLC name
 comment
Message-ID: <20261123113721.GH3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <11c375d15b5073212ca79e11330e422539eae4b5.1795029012.git.geert+renesas@glider.be>
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
In-Reply-To: <11c375d15b5073212ca79e11330e422539eae4b5.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:44:59PM +0100, Geert Uytterhoeven wrote:
> There is no need to document Module Controller base addresses in
> mdlc_info tables, as a mod_map initializer already contains the Module
> Controller's name.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v5:
>   - New.
> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> index 75de869872de9e82..1ace1fb10870f646 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -299,7 +299,7 @@ static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
>  
>  static const struct mdlc_info r8a78000_mdlc_default[] = {
>  	{
> -		.base = 0xc05d0000 /* mdlc_perw */,
> +		.base = 0xc05d0000,
>  		.mod_map = r8a78000_mdlc_perw_mod_default,
>  	},
>  	{ /* sentinel */ }

-- 
Regards,

Laurent Pinchart
