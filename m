Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446436;
	b=yCj5KtSXD+ZozdfWcmFmv+P5zagYh+ej/741l3+NzKu7ajRPTHfO6t1W3riFX8O2TM5s
	 KxUhigoEgJeQiVgriKDjlhc23Yuo/qs8ww+bKvWmRHbY5IkbF6uvX+68XZdhUSxKqH6gW
	 548/TZz7vkEKTEKsqZIeRlyADLf3tALu0srhMZQzYawvRurVfFCukMNd3qiZWv1pGod0a
	 yZfvS08reJ3Ko8M5rb61kwfcNvBVJPaVg89VoEQUnzibufo18suhzoQo+AzwhU+/vkZax
	 z7w5CUfGoNC9DJE7m/MoiBdWPqBMswdV2KnklIG54oHXf/O6sEQGTxjCIV3UyDS/0Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446436;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QhwkeRsKW2eU1yR2DBn8OENZbsAgbpApGZdt64vMdFc=;
	b=5g1MtjCNFPYe1161tCelyDa5nnJO45O2mTgFNHFLSVEcwU7/J2pAk33T2VEUF5APNaAA
	 +2t9ku948TEMqs55sWBRMQ3hP5ohLGSGD2Oo14cipE6Xa1UYcuEV7Lu+ulmZVtxOEmb7E
	 5FQXQ9vXwrXo4f8rN6CGdS9l+G6ZxEy0JccSEgrOrdT3nfMO2Xd/aQLh71p9A91pdSJRB
	 XLuTqVSlnsysoImw4Xm2aWso9nDGmvPoQruIOdI5U4LyjTuVCt+zNX9WsB77/SbxdlcsQ
	 866NHaZCxYGpaxTDFRko8Xndemjv6oqlKbXMovd1O49jTIm+kSesLZqcBxeKPyLWCzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=tyx9iVUr;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106E606A31A;
	Mon, 23 Nov 2026 15:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9106E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=tyx9iVUr
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E20A0177;
	Mon, 23 Nov 2026 16:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795446280;
	bh=hWpll5jCWlb3p4P0FO1e+zezhAH+oosPgqeDUB2EaBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyx9iVUrmGY4LpCqE/MfiTNAFkDFvyz0SFmzDek+lY5RRd76Px++aSNSpfPLdXWKZ
	 TVcpqSiPaYUFQumgA4os9b+Hwh6xeZtVU0fEHDhmkvEN/vhwnbaJ89aOm/40l2m528
	 anHmd+DXrdgZC2kgRDJEfzq4FcSmfRw4NtfIiK4Q=
Date: Mon, 23 Nov 2026 17:07:10 +0200
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
Message-ID: <20261123150710.GL3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
 <20261123113619.GG3010398@killaraus.ideasonboard.com>
 <23ab561a-c5c5-41ff-a0f4-87a3f5ca2e49@app.fastmail.com>
 <20261123125410.GK3010398@killaraus.ideasonboard.com>
 <066fcf7c-e1f6-4186-9874-622dbce18f92@app.fastmail.com>
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
In-Reply-To: <066fcf7c-e1f6-4186-9874-622dbce18f92@app.fastmail.com>

On Mon, Nov 23, 2026 at 02:02:35PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 23, 2026, at 13:54, Laurent Pinchart wrote:
> > On Mon, Nov 23, 2026 at 01:34:06PM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Nov 23, 2026, at 12:36, Laurent Pinchart wrote:
> >> > On Wed, Nov 18, 2026 at 08:44:53PM +0100, Geert Uytterhoeven wrote:
> >> >> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
> >> >> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
> >> >> firmware when running on a system with SCMI, and SCMI support is
> >> >> enabled.  Take into account some peculiarities of the current SCMI
> >> >> firmware implementations, and fall-back to fixed-rate clocks as
> >> >> replacements for SCMI clocks that are not available.
> >> >> Support for bus clocks used by serial, I2C, and SPI devices is included.
> >> >> 
> >> >> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> >> >> hardware description in SoC DTS for systems with and without SCMI
> >> >> firmware.
> >> >> 
> >> >> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
> >> >> SDKv4.31.0 and later.
> >> >> 
> >> >> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> 
> >> >> --- a/drivers/clk/renesas/r8a78000-cpg.c
> >> >> +++ b/drivers/clk/renesas/r8a78000-cpg.c
> >> 
> >> >> @@ -140,7 +182,35 @@ static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
> >> >>  
> >> >>  	for (unsigned int i = 0; i < map->size; i++) {
> >> >>  		fw_id = map->entries[i].fw_id;
> >> >> -		hws[i] = fixed_hws[fw_id];
> >> >> +		if (fw_id >= FIXED_CLK_OFFSET) {
> >> >> +			hws[i] = fixed_hws[fw_id - FIXED_CLK_OFFSET];
> >> >> +			continue;
> >> >> +		}
> >> >> +
> >> >> +		scmi_spec.np = scmi_clk_np;
> >> >> +		scmi_spec.args_count = 1;
> >> >> +		scmi_spec.args[0] = fw_id;
> >> >> +
> >> >> +		clk = of_clk_get_from_provider(&scmi_spec);
> >> >> +		if (IS_ERR(clk))
> >> >> +			return dev_err_cast_probe(dev, clk,
> >> >> +				"Failed to get SCMI clock %u\n", fw_id);
> >> >> +
> >> >> +		hw = __clk_get_hw(clk);
> >> >> +		clk_put(clk);
> >> >
> >> > Doesn't that leave the hw pointer possibly dangling, shouldn't you keep
> >> > the reference to the clock ?
> >> 
> >> Only struct clk is reference-counted; struct clk_hw is not, and exists as
> >> long as the clock provider hasn't unregistered it.
> >
> > That's what I meant, what prevents clk_hw from being destroyed while you
> > still hold a pointer ?
> 
> If the SCMI clock provider goes away, we're indeed dead...
> 
> Note that __clk_get_hw() + clk_put() is a common pattern to avoid
> leaking the struct clk reference, and fixes were CCed to stable.

It's only leaked if you don't store it and release it at remove time. I
suppose that, in this case, we can rely on the SCMI clocks never going
away. Hopefully.

> "git grep -A1 __clk_get_hw | grep clk_put"

-- 
Regards,

Laurent Pinchart
