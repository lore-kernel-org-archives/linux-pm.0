Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433983;
	b=reO4k3E18gVQh1HTkXr9EamM0vVMfKsDqYjl9h7rdXPLp08O5RQvSXmngQqnVPRM4h6w
	 ySxRhXhSk8hUD2y9KhHn1XrfE/kQV7XxZFzDUYlOmYGs+JOfAj86kMdFRoLn8al1Qwm39
	 kGxjG4+4+g+FaoofEKpzlnkngQSj3LxHFJk4bhiM08lAJ7VjJKy4YL4Xn34L4LwCKuxWB
	 nCatMLbfVHpic8metFw4sOxdIRX416tMoXqxoucKVbmM85uAawiqGMALW4qG93JYqlp/I
	 2AVbar1ismnuTV3/ekbI46CIGu0Z8Zuq04Q+R3p46ma5b+0Y/TIfuH9igBS1dv6rmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433983;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ERbB76zpet3DuApuKnLZM5P0t4NNQkDvueQ2YL5Mbns=;
	b=NedKeFpvj3htSve6oiZXUJKnSlYseEhy59sE2Y+u9VSVBs9egbdaDifLZc4XcXBl6msr
	 QEQTmgoz9JfRYENzv+UY1KXYVDhFdhEUSl8bjZ9UQOJ9aQL9PbRN5yXQAtAXrgOX167ot
	 5wCplmoYo2+Xl0ddD9/NoD3RnJMbcjTOiD0d9epbi710jL62DzsNOBLaXy4VSJx0+TuSM
	 fjqB8YO1magffDrmQlq5cbJ/mdR/gXDY8jl87mRAMGQZJOrI++tzMibnbkGMnozRXkIA8
	 DGS+j8rhROyG4dVjxy0IT3JaCKoPTA6XBNGNNbgoG8ScHx4kXhuGKEGxwieTvmoEFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=sAyxzm4R;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3405606A31A;
	Mon, 23 Nov 2026 11:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3405606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=sAyxzm4R
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38C3B34;
	Mon, 23 Nov 2026 12:37:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795433829;
	bh=d/fYOVW5pZ7TatqYKzHhPfuzuwLHZqwD4bIlohGjcyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAyxzm4R8p58eVBo/8lbZhtFx5M3sca61vhovfL37qG1VnayPd67mJfh4XuzgS+Rx
	 Db8HBACnacnBJYoQDIQKvSWB7ggObdmtWwXfxA6yE5sK64Y8kZJIeTBFlp7DIA7zdH
	 8L68N/UfI4413vqF5K4KxAzj4wdLKTFp2zfFCzKo=
Date: Mon, 23 Nov 2026 13:39:40 +0200
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
Subject: Re: [PATCH v5 13/15] pmdomain: renesas: r8a78000: Shrink IDs to 16
 bits
Message-ID: <20261123113940.GJ3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <72f8eae23faefaa169cff7a52cdbafce2cd50e1f.1795029012.git.geert+renesas@glider.be>
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
In-Reply-To: <72f8eae23faefaa169cff7a52cdbafce2cd50e1f.1795029012.git.geert+renesas@glider.be>

On Wed, Nov 18, 2026 at 08:45:01PM +0100, Geert Uytterhoeven wrote:
> Reduce table size by shrinking hardware module IDs from 32 to 16 bits,
> which is still plenty.
> 
> While at it, use u32 to store of_phandle_args.args[1] in
> r8a78000_mdlc_attach_dev().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v5:
>   - New.
> ---
>  drivers/pmdomain/renesas/r8a78000-mdlc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> index 6477abe64511e880..733bf68dab2ce6dc 100644
> --- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
> +++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
> @@ -17,7 +17,7 @@
>  #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
>  
>  struct mod_id_map_entry {
> -	u32 hw_id;		/* Hardware module ID */
> +	u16 hw_id;		/* Hardware module ID */
>  };
>  
>  struct mod_id_map {
> @@ -148,8 +148,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
>  	struct device_node *np = dev->of_node;
>  	struct r8a78000_mdlc_priv *priv;
>  	struct of_phandle_args pd_spec;
> -	unsigned int id;
>  	int ret, idx;
> +	u32 id;
>  
>  	ret = of_parse_phandle_with_args(np, "power-domains",
>  					 "#power-domain-cells", 0, &pd_spec);

-- 
Regards,

Laurent Pinchart
