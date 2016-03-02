From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/5] PM / AVS: rockchip-io: make io-domains a child of the GRF
Date: Wed, 02 Mar 2016 22:16:35 +0100
Message-ID: <3201731.IRj8F3jnGs@diego>
References: <1454707218-23676-1-git-send-email-heiko@sntech.de> <1454707218-23676-2-git-send-email-heiko@sntech.de> <7hio22bwr7.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:32804 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbcCBVQo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Mar 2016 16:16:44 -0500
In-Reply-To: <7hio22bwr7.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sjoerd.simons@collabora.co.uk, dianders@chromium.org, david.wu@rock-chips.com

Hi Rafael,

Am Freitag, 5. Februar 2016, 14:47:08 schrieb Kevin Hilman:
> Heiko Stuebner <heiko@sntech.de> writes:
> > IO-domain handling is part of the general register files, so should live
> > under the grf directly. This change allows the grf to be a simple-mfd and
> > the io-domains fetching the syscon regmap from that parent-node.
> > 
> > The old binding is of course preserved, though deprecated.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>

As before, I guess that means you could apply that patch directly, as nothing 
else is pending from Kevin's side.


Thanks
Heiko

> > ---
> > 
> >  Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  4 +++-
> >  drivers/power/avs/rockchip-io-domain.c                         | 10
> >  +++++++++- 2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> > b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt index
> > b8627e7..7ed5518 100644
> > --- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> > +++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
> > 
> > @@ -35,8 +35,10 @@ Required properties:
> >    - "rockchip,rk3288-io-voltage-domain" for rk3288
> >    - "rockchip,rk3368-io-voltage-domain" for rk3368
> >    - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
> > 
> > -- rockchip,grf: phandle to the syscon managing the "general register
> > files"
> > 
> > +Deprecated properties:
> > +- rockchip,grf: phandle to the syscon managing the "general register
> > files" +    Systems should move the io-domains to a sub-node of the grf
> > simple-mfd.> 
> >  You specify supplies using the standard regulator bindings by including
> >  a phandle the relevant regulator.  All specified supplies must be able
> > 
> > diff --git a/drivers/power/avs/rockchip-io-domain.c
> > b/drivers/power/avs/rockchip-io-domain.c index 8099456..a5a07d8 100644
> > --- a/drivers/power/avs/rockchip-io-domain.c
> > +++ b/drivers/power/avs/rockchip-io-domain.c
> > @@ -278,6 +278,7 @@ static int rockchip_iodomain_probe(struct
> > platform_device *pdev)> 
> >  	struct device_node *np = pdev->dev.of_node;
> >  	const struct of_device_id *match;
> >  	struct rockchip_iodomain *iod;
> > 
> > +	struct device *parent;
> > 
> >  	int i, ret = 0;
> >  	
> >  	if (!np)
> > 
> > @@ -293,7 +294,14 @@ static int rockchip_iodomain_probe(struct
> > platform_device *pdev)> 
> >  	match = of_match_node(rockchip_iodomain_match, np);
> >  	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
> > 
> > -	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> > +	parent = pdev->dev.parent;
> > +	if (parent && parent->of_node) {
> > +		iod->grf = syscon_node_to_regmap(parent->of_node);
> > +	} else {
> > +		dev_dbg(&pdev->dev, "falling back to old binding\n");
> > +		iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> > +	}
> > +
> > 
> >  	if (IS_ERR(iod->grf)) {
> >  	
> >  		dev_err(&pdev->dev, "couldn't find grf regmap\n");
> >  		return PTR_ERR(iod->grf);

