Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795431460;
	b=OgAimWz1TO8kuVjwOr8l2leb1XcLQP7BSqkJfTXi+T96kRkqzNTGdy2ZiOeO6D+/jyUZ
	 QaYkKUhAANIs/rvkJw1c2tAPEFJEaQNgx/0YB/Ut9kPTE/E9kU0/LNqsnytiRfQDRxP56
	 GpVli/iL6y4d3YlGEWVv/pQXPhsSR9MM4Y8zIZzOx5i2BCpgxnoo4xLW+9DtBkmhAQBRn
	 d7ku6ccQMelic+fcVf2AdtyPnGyyMSB6Fmr+4XG7/pBvbFS6C3+EOvLx4lrDc13htDS3y
	 dF3GX7E3JxN7LReYqDeFFsGgK7tZVIWpUs4tPPzdUxJsWaM6LSeNsoq6yKIGcYSrxNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431460;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ivDTVAtvWv3uwend5cm17scjqn/tl8MG+Jy9Smv3hpg=;
	b=sVeCTfNr0D4yWNjsejikpwaWdwY05XgjqgRVMgc6KUoU/ds2XXf4I8pqArpSEK4ofkB1
	 zto4wtpINqta/XOEfxIISltkNRvZmIvk/9BjKaS7RHbJvnNveyja4Ra6nKi+3O6gossIj
	 CdeMGYgC0TdRp9wp8jMe7pd8hCTEZInaVdu9QUhaBdVjWN8hMnQFGiMfuuOSdI9c/Bolv
	 hfUaXcqTjYkSjV5FuexmdU/VRsB9Z0PSSE4CtCbJX9T33KQA/iGV7+ZSdH/Q9m8087ZDy
	 9heAi3o9rFxuB6gGHwaPXfVwPyT0t8laVJZXznvdXLdR8Yrh1BSdU2RmDpBN5JpdpeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=f7lUuUcJ;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4046606A31A;
	Mon, 23 Nov 2026 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4046606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=f7lUuUcJ
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F2F7177;
	Mon, 23 Nov 2026 11:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1795431305;
	bh=AvO1/maww9n+YB0rxCd6DEtZ440NZzTfyaS445kaBfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7lUuUcJy8Q8gJH5VYA7aaa3M4mV+ugeNvtqthpyxA3a4AgiBAKgrR8cfUcs7sB3R
	 Yu7p3IW3qVICHH0IWvcnE2HVpP2F17VVllH1jdcP3qTvia02bPS5BPrLlS/F4DlC/6
	 gwVVR6fFqqZQCgY++fQxDQBYg7PN7Ll+3GmNv//s=
Date: Mon, 23 Nov 2026 12:57:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v5 01/15] clk: renesas: r8a78000: Merge debug prints in
 r8a78000_clk_get()
Message-ID: <20261123105736.GB3010398@killaraus.ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <cee843b319c9eceba2339f14a134e305a2b05d7e.1795029012.git.geert+renesas@glider.be>
 <57d2cc58-15ac-434e-ab40-7a8a54d93a1f@mailbox.org>
 <CAMuHMdXXS4ZTxLBrZoNycHUzdUp9QsisfA7CcBPyAGw7zTuSoA@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXXS4ZTxLBrZoNycHUzdUp9QsisfA7CcBPyAGw7zTuSoA@mail.gmail.com>

On Fri, Nov 20, 2026 at 08:56:42AM +0100, Geert Uytterhoeven wrote:
> On Fri, 20 Nov 2026 at 06:28, Marek Vasut wrote:
> > On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> > > The two debug prints in r8a78000_clk_get() are very similar.
> > > Merge them into a single debug print.
> > >
> > > While at it, unwrap the (wrongly-indented) continuation of the
> > > r8a78000_clk_get() function header, as it fits on a single line.
> >
> > It might be worth mentioning, that this now also uses
> > clk_hw_get_name(hw) instead of map->fw_id .
> 
> clk_hw_get_name(hw) was printed before; fw_id will still be printed
> in get_hws() after PATCH 04/15.

That's worth mentioning in the commit message. With that, the patch
looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> > [...]
> >
> > > -     dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
> > > -
> > >       hw = priv->fixed_hws[map->fw_id];
> > >
> > > -     dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
> > > -             clk_hw_get_rate(hw));
> > > +     dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
> > > +             clk_hw_get_name(hw), clk_hw_get_rate(hw));
> > [...]

-- 
Regards,

Laurent Pinchart
