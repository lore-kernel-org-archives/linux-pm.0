Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438454;
	b=C24pPrf6IXGVQDyJKstaxdBF3dARcfpCOVfksWHH4o03/d8FuvZFuj3Tvj2wRfKJYEXl
	 z68QiKplCg1ETwHX+0v08pe8i7MsXzsbkPvrcvp4oWCf/y90DPwaM63A4YomDwEOP5G5Q
	 H+145qkJD0eLZOIvGJI7h+fYfGGgX/r6Nbo8bwMTqCLN9gjZb0XHNFkb2Isq6uvpspmNR
	 9NKkvBObwPszLVxHnbQxzC7oVMul52uTLDD98y86eLrwHfizcW0iCdB5He4KhsOf4lqYG
	 I0UUG6BBmIwwGn06Re0TI7+fbcunYRsz9j3sKoJwNQHA5SQ7oA3VfOynPSS0ImZNZpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438454;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AK9gZq1mzNYYir8TNaIUe4uUnYICwkK2Y+EuWc7ckdM=;
	b=Vi1ldyKcVMsvylTVDEwzRegejsri8FbXuVi6XXhyVu25a8EwImGTzv2H0xK0t48X6zym
	 hSDXytEwy36fgzQtuTKSL7QbC2UbqAL864TAzqFlY9xAooMJQMGsuCz/VvyLTOpjon6zd
	 4QiseuF4DOmqWLTawHa06o8TNGmLz7ugVyZGHLNoV59X6VjqNHow0ReeEuznwBogdeRgf
	 8nb0cWOXduZ0chxzEty5hImRGduPtFsTCakkwclBPbfqOztWDLniLF3Si41xa/MVS9pPe
	 cUsU5hF+xmmRAyLqEa8gt1CK/FiZId3izMe8xTW31vFpKH10ZX6byHOH3O8F6oAneTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=AZIGKtbJ;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24300606A31A;
	Mon, 23 Nov 2026 12:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24300606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=AZIGKtbJ
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31A5E177;
	Mon, 23 Nov 2026 13:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795438299;
	bh=WRMJuqFdJHPeKGISVHJw8r4oTogveJ42OLFSdKyGCc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZIGKtbJR6NkLXRom8BW/EhsnsC1Qtzflabo8Bbcd6MJhGpnl0G7O9/Nfw94CZnoM
	 KK2Frc1pLjhhlJe1YrWwhiM0MzcAEmKh73qx4i+5jLEyo05m07KyNw26uLNjEdzMnt
	 6U/AC2OPCb7Ic8d01t0cFQ49muIHRDjCsjQmSzZI=
Date: Mon, 23 Nov 2026 14:54:10 +0200
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
Subject: Re: [PATCH v5 05/15] clk: renesas: r8a78000: Add SCMI remapping
 support
Message-ID: <20261123125410.GK3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
 <20261123113619.GG3010398@killaraus.ideasonboard.com>
 <23ab561a-c5c5-41ff-a0f4-87a3f5ca2e49@app.fastmail.com>
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
In-Reply-To: <23ab561a-c5c5-41ff-a0f4-87a3f5ca2e49@app.fastmail.com>

On Mon, Nov 23, 2026 at 01:34:06PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 23, 2026, at 12:36, Laurent Pinchart wrote:
> > On Wed, Nov 18, 2026 at 08:44:53PM +0100, Geert Uytterhoeven wrote:
> >> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
> >> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
> >> firmware when running on a system with SCMI, and SCMI support is
> >> enabled.  Take into account some peculiarities of the current SCMI
> >> firmware implementations, and fall-back to fixed-rate clocks as
> >> replacements for SCMI clocks that are not available.
> >> Support for bus clocks used by serial, I2C, and SPI devices is included.
> >> 
> >> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> >> hardware description in SoC DTS for systems with and without SCMI
> >> firmware.
> >> 
> >> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
> >> SDKv4.31.0 and later.
> >> 
> >> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> >> --- a/drivers/clk/renesas/r8a78000-cpg.c
> >> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> 
> >> @@ -140,7 +182,35 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
> >>  
> >>  	for (unsigned int i = 0; i < map->size; i++) {
> >>  		fw_id = map->entries[i].fw_id;
> >> -		hws[i] = fixed_hws[fw_id];
> >> +		if (fw_id >= FIXED_CLK_OFFSET) {
> >> +			hws[i] = fixed_hws[fw_id - FIXED_CLK_OFFSET];
> >> +			continue;
> >> +		}
> >> +
> >> +		scmi_spec.np = scmi_clk_np;
> >> +		scmi_spec.args_count = 1;
> >> +		scmi_spec.args[0] = fw_id;
> >> +
> >> +		clk = of_clk_get_from_provider(&scmi_spec);
> >> +		if (IS_ERR(clk))
> >> +			return dev_err_cast_probe(dev, clk,
> >> +				"Failed to get SCMI clock %u\n", fw_id);
> >> +
> >> +		hw = __clk_get_hw(clk);
> >> +		clk_put(clk);
> >
> > Doesn't that leave the hw pointer possibly dangling, shouldn't you keep
> > the reference to the clock ?
> 
> Only struct clk is reference-counted; struct clk_hw is not, and exists as
> long as the clock provider hasn't unregistered it.

That's what I meant, what prevents clk_hw from being destroyed while you
still hold a pointer ?

-- 
Regards,

Laurent Pinchart
