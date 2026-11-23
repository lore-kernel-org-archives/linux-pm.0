Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432376;
	b=z12CWnjWJ5CIqRNhBwJLMFMh9WxZRqbNhUVQNVe12PdulEiMtvTixpdlA+IK6MKDauiv
	 zHfD9FlDyr1fw16XoYmUhLkvDE3BnWzt90gbBglY0B10IyXZqzAw1NF4XN5+85r6aC6Hk
	 9OWL3rKc2tL1uiAraDNlsPRV7g0B09cG5XmxMQ7W9vCa8BZ3+EctEm4ZDO+/GXZUhmxJR
	 oeQOLjP624lFwLTMN6w6Uu8TDgU68k4xzHnwGpEu+Nw+fu3qO+x7k+RXOklfgEuYoFxd+
	 jzEHqaS1dpi3rnSsG1R+n3CVyMtbhtefx/CDDNbK5y9vslP0bJXrabjGzH5tT8ORgIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432376;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Vh1LakTnS8qDnqTNZjFoXfkcl6LQaAAvrHhe/rYchqw=;
	b=nsTRIncuZf64SqAwwo24s0GgW9E4e9v5/DPSuwoDPlJE2sWuSkqHx7slw+b0Au5L5iLx
	 O4Ttksriz85OC5x5o4ukUzJe+MBTXm8kWRwI74Ot+E+B9ffcd3bNQNE9++H5ejYqTim5l
	 DpgJif5PlmyRv+3D1UyQt179SWpku+QnaHTD75RCLS8qjbVN2SRjbDFhmCsM+opZHdj2c
	 QaiMmxp4pX+Da26xaCnHBgp1F6HKi4VtGxGok/lGL1ImAonUPC9ingaYPaOwqRx5z7lx1
	 x1nzTMWuH2ornF/XcKt81jJjGtCY8j7AEdCmPyRJxaSXPRmFqjPiy0AgBlvpZWg+ISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=b8ohZFPH;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D46606A31A;
	Mon, 23 Nov 2026 11:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D46606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=b8ohZFPH
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9EF4473E;
	Mon, 23 Nov 2026 12:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795432221;
	bh=upJhjegpWDQfOzFhkF7sS1wywVD1477rg/cPt2EFbLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8ohZFPHnUSX4XJqicAsg661IvSd98c33Vb05UnAK9TiRMqcaPowe5BJrMrqgkqxf
	 j7hfnKq0i+4mJtwPW6B2jp3XORvuBW7hnrDVkDAcqO+jd13VPuTTNQVgnS6gCF22B0
	 x2MIbDW0Q6jhWRK0CK6Jysk0rD/2oZg61piQiK4A=
Date: Mon, 23 Nov 2026 13:12:52 +0200
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
Subject: Re: [PATCH v5 03/15] clk: renesas: r8a78000: Shrink IDs to 16 bits
Message-ID: <20261123111252.GE3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <066c0c074865c2a8684f541c3513b8851f3b09a9.1795029012.git.geert+renesas@glider.be>
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
In-Reply-To: <066c0c074865c2a8684f541c3513b8851f3b09a9.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:44:51PM +0100, Geert Uytterhoeven wrote:
> Reduce table size by shrinking DT and fixed-rate clock IDs from 32 to 16
> bits, which is still plenty.

Until the day someone decides to use clock IDs higher than 65535 in the
SCP firmware :-)

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v5:
>   - New.
> ---
>  drivers/clk/renesas/r8a78000-cpg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
> index 03fcd128d4293cfc..236c638834703f95 100644
> --- a/drivers/clk/renesas/r8a78000-cpg.c
> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> @@ -17,8 +17,8 @@
>  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
>  
>  struct clk_id_map_entry {
> -	u32 dt_id;		/* DT binding clock ID */
> -	u32 fw_id;		/* FIXED_CLK() ID */
> +	u16 dt_id;		/* DT binding clock ID */
> +	u16 fw_id;		/* FIXED_CLK() ID */
>  };
>  
>  struct clk_id_map {

-- 
Regards,

Laurent Pinchart
