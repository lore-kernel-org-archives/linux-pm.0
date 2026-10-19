Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423329;
	b=B9+wYzBstG1cV92eKZ1NCHq83RAqK/6nK0r47tRg4t4/AIYlR6NvWjgbEuVM8eLlw+BE
	 GfCKSsrMIwZTigPFRq8ejhB765eILrxjVGog/h4fIZPBwcnkSHLRxKLwTFmqa3KkQh29N
	 ZzdspqGxPjwT4aUS2zKUW168ttZwGA0XjFbO+/Yc4GCe0NDa8CPDDkChvkPykWNGMHtTx
	 U4dDsvECXleMsfdnFg7VIixbvWbPc0Edk4ivpP9dfZU38VCotS+E3nBnDzufeOsx5c5tn
	 HJQbEXgCt1U/F0sfrH4Gs+/I95wKm0WLMJQyAreK54DhxMaiqMsYEtCfERkt8VBH/OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423329;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=pZbrqHjelFF/ENF7fuSBHNbLORwYvUMJmsvdM/z2Rt0=;
	b=LhInLEkMCJFTs1J3cOctzPI8WH9ELxUPsor8nUL2vW90h3MCyKG97HWOOSpfV+xmwTKT
	 ri9pLMXaDE51ChZhMPWXh02R2Hc4ed7JM7/y4KVPNKNfGs88PHwgDH/2NVL3co3t4wPYn
	 HLby6D97a0H1N04JOexhGUhtRXOFDGLlA12Rb5gFoJMh5EjRL8Z+XDA6wGO72EzVW6FMq
	 FKoErtbhrBLhNSFWVOYWUosGXZXOzKrg7VxL0pkzbmAZFbWzXC+rS3ntnVVXwUeIApUwD
	 V4ISWrdpbQePJgN3VFkSBEDqBci25pUD30LR+47vovzQym1Tk5gtpsCyQ5rBGPuVz2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ohib2zJR;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A360AA0D5;
	Mon, 19 Oct 2026 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 820A360AA0D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ohib2zJR
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F5D256D;
	Mon, 19 Oct 2026 17:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792423198;
	bh=zi6O1bKKtP5fbmD4q6sVdFeYgcyHpPs0N69u6EW+gLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohib2zJRtXKw9eNeErrS5gIwTOKS0MYI24P9PbLxu4lAIn0BPaCU1H/3hS+SWNVuq
	 4WYOtzkIZlwM/nPtrFF+lsO6V4dKb8C8YvJLWmWBlCW6rAbpUBEAvpMsED9FvrbCtp
	 JvhR/eDQPd6F3F7/rdOKd5w7vp6A+yBRXnQ4l0go=
Date: Mon, 19 Oct 2026 18:22:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
Message-ID: <20261019152203.GA5830@killaraus.ideasonboard.com>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
 <20261019144256.GC763679@killaraus.ideasonboard.com>
 <CAMuHMdWkAvkxHkzRVviF_NkZHP7UeCBjebxciE6jFN_8ViM=aQ@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWkAvkxHkzRVviF_NkZHP7UeCBjebxciE6jFN_8ViM=aQ@mail.gmail.com>

On Mon, Oct 19, 2026 at 04:56:28PM +0200, Geert Uytterhoeven wrote:
> On Mon, 19 Oct 2026 at 16:42, Laurent Pinchart wrote:
> > On Fri, Oct 16, 2026 at 05:55:40PM +0200, Geert Uytterhoeven wrote:
> > > Prepare for mapping to other than fixed-rate clocks by adding a clk_hw
> > > pointer to the clk_map structure, and populating it up-front.
> > >
> > > Move r8a78000_cpg_priv.fixed_hws into fill_clk_map(), as it is no longer
> > > needed afterwards, and drop NUM_FIXED_CLKS.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/clk/renesas/r8a78000-cpg.c
> > > +++ b/drivers/clk/renesas/r8a78000-cpg.c
> > > @@ -16,19 +16,24 @@
> > >
> > >  #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
> > >
> > > +struct clk_map_in {
> >
> > The "_in" suffix isn't very explicit.
> 
> I can add a comment...

How about calling it clk_id_map ?

> > > +     int dt_id;              /* DT binding clock ID or -1 sentinel */
> > > +     u32 fw_id;              /* FIXED_CLK() ID */
> > > +};
> > > +
> > >  struct clk_map {
> > >       int dt_id;              /* DT binding clock ID or -1 sentinel */
> > >       u32 fw_id;              /* FIXED_CLK() ID */
> 
> BTW, do you think it would be worthwhile to reuse clk_map_in here?

Possibly. I was about to recommend just using a single structure and
leaving the clk_hw pointer NULL and unused in .rodata, but the memory
waste isn't very nice, especially if we end up with many entries :-(

> > > +     struct clk_hw *hw;
> > >  };
> 
> > > @@ -92,35 +94,69 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
> > >       return hw;
> > >  }
> > >
> > > -static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
> > > +static struct clk_hw **register_fixed_clks(struct device *dev)
> > >  {
> > > -     struct device *dev = priv->dev;
> > > +     unsigned int n = ARRAY_SIZE(fixed_clk_rates);
> > > +     struct clk_hw **hws, *hw;
> > >       unsigned long rate;
> > > -     struct clk_hw *hw;
> > >       const char *name;
> > >
> > > -     for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
> > > +     hws = devm_kcalloc(dev, n, sizeof(*hws), GFP_KERNEL);
> > > +     if (!hws)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     for (unsigned int i = 0; i < n; i++) {
> > >               rate = fixed_clk_rates[i];
> > >               name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
> > >               if (!name)
> > > -                     return -ENOMEM;
> > > +                     return ERR_PTR(-ENOMEM);
> > >
> > >               hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
> > >               if (IS_ERR(hw))
> > > -                     return PTR_ERR(hw);
> > > +                     return ERR_CAST(hw);
> > >
> > > -             priv->fixed_hws[i] = hw;
> > > +             hws[i] = hw;
> > >       }
> > >
> > > -     return 0;
> > > +     return hws;
> > > +}
> > > +
> > > +static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
> > > +                                       const struct clk_map_in *map_in)
> > > +{
> > > +     struct device *dev = priv->dev;
> > > +     struct clk_hw **fixed_hws;
> > > +     struct clk_map *map;
> > > +     unsigned int i;
> > > +
> > > +     fixed_hws = register_fixed_clks(dev);
> > > +     if (IS_ERR(fixed_hws))
> > > +             return ERR_CAST(fixed_hws);
> > > +
> > > +     for (i = 0; map_in[i].dt_id >= 0; i++) { }
> >
> > This is avoidable by passing { map, ARRAY_SIZE(map) } as match data
> > instead of just the map.
> 
> True, and I did consider this.
> The same mechanism is used in the MDLC driver, where using ARRAY_SIZE()
> would quickly became a bigger burden due to the presence of many
> more maps.  So for consistency, I kept it the same in both drivers.
> An initialization macro might make it more manageable, though.

Something along the line of the following ?

struct clk_map_in_entry {
	int dt_id;		/* DT binding clock ID or -1 sentinel */
	u32 fw_id;		/* SCMI firmware clock ID or FIXED_CLK() ID */
};

struct clk_map_in {
	const struct clk_map_in_entry *entries;
	unsigned int size;
};

#define CPG_MAP_INIT(_entries) {	\
	.entries = _entries,		\
	.size = ARRAY_SIZE(_entries),	\
}

struct cpg_data {
	const struct clk_map_in *default_map;
	const struct clk_map_in *fw_map;
};

...

static const struct clk_map_in_entries r8a78000_cpg_fw_entries[] = {
	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	1661 },
	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	1662 },
	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	1663 },
	{ R8A78000_CPG_MSO_SCP_MAIN,		1459 },
	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
};

static const clk_map_in r8a78000_cpg_fw = CPG_MAP_INIT(r8a78000_cpg_fw_entries);

static const struct cpg_data r8a78000_cpg_data = {
	.default_map = r8a78000_cpg_default,
	.fw_map = r8a78000_cpg_fw,
};

> > > +
> > > +     map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
> > > +     if (!map)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     for (i = 0; ; i++) {
> > > +             map[i].dt_id = map_in[i].dt_id;
> > > +             if (map[i].dt_id < 0)
> > > +                     break;
> > > +
> > > +             map[i].fw_id = map_in[i].fw_id;
> > > +             map[i].hw = fixed_hws[map[i].fw_id];
> > > +     }
> > > +
> > > +     devm_kfree(dev, fixed_hws);
> >
> > Why not plain kcalloc/kfree ?
> 
> To avoid having to free it manually at multiple (three) locations,
> both in the error paths and the success path?

Isn't __free() your friend ?

> >
> > > +     return map;
> > >  }

-- 
Regards,

Laurent Pinchart
