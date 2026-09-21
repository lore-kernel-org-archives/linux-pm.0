Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2F23E324;
	Mon, 21 Sep 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961295; cv=none; b=sxry7dGZn4ODyNzm1Xg02lyTbx9XKOAbV3PrTJi5sroEJI2oP1j51woDS2v/tvsY7YofCbPEqE6N4Cq1EYKL1ciOMWBdI4X1riEpUY3AH5NmxLPDyzJrn9NJzwjxuY101XE8agreUhM0dr1Yp6qj0bEo2B4OZL8u5VjuyIv6YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961295; c=relaxed/simple;
	bh=PN2vNnNcziC4LmZ1wYoZspgtb1jYIybO8dsA1eqPe24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIOL+H1ksWfEshh55tiWDg0MMWX5GUBeBr37StNZ0eCY6M/XSYbEn1GjaeI/t1D0crd4jx7AntBd2u4XdcRRQxOh9FYY2IzEphJQT28GqvGaFw2TI1uoD8bHnm4B9ffj56xz4Ma7HcJB0RfnoqIkPUNirocCTYz5vEZvMPCoSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1locwYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1locwYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B4F1F000FF;
	Mon, 21 Sep 2026 03:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789961294;
	bh=5XkPe1zvFK0LCsBxsuXMawH81DqxURK2aXN09dffCkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n1locwYhkjbsNWKpT/2Ef28Yv7NiJ5wsgboeiWX3AvUcb1+udaDRF8oBQAPdmjol9
	 dmUMr9KO5ycBLBkLtk/rktsEvXpJwS6v/mPvZ/yYERDe1poWnAUHHtvPzMuhiaYg8V
	 OdF58HRQkGjxM7MqkLUoWRqJBp+kFDYKWeBLLxTzNR9FT1/hb/uLdKiyJ5X0eM17U9
	 DBXKOq6RCwroKcepMbxwqMaNHc7O1XtB8U2luNsuZN/9bm6q21jINqk4SLWHeThO9A
	 W7yunQXVojHZ8JArGWbrhxyrRvHU0QX5ltcfFpKXvD+YRhYfZ7k0h0+6bKWtNnvcHS
	 63QgzsBC6JP9Q==
Date: Mon, 21 Sep 2026 04:28:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
 <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Chris Paterson
 <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU
 support
Message-ID: <20260921042809.4eb4b952@jic23-hlaptop>
In-Reply-To: <TY3PR01MB11346ED0D17722AB3821E3F4D86842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
	<20260918150730.122056-5-biju.das.jz@bp.renesas.com>
	<178992596603.706584.10389874816454714845.b4-review@b4>
	<TY3PR01MB11346ED0D17722AB3821E3F4D86842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 01:44:20 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Jonathan,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: 20 September 2026 18:39
> > Subject: Re: [PATCH v2 4/8] thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
> >   
> > > Add a conditional schema constraint so that '#io-channel-cells' is
> > > required when the compatible string is "renesas,r9a08g045-adc".
> > >
> > > This is required because the R9A08G045 ADC serves as an IIO provider,
> > > allowing external hardware consumer nodes (such as the TSU) to
> > > reference its individual channels. The '#io-channel-cells' property
> > > must be present so consumers can correctly specify the channel index in their 'io-channels'
> > > phandle property.
> > >
> > > Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document
> > > the TSU unit")
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>  
> > 
> > I think perhaps the description should include why this only applies to this part , and not more
> > generally but otherwise this is fine by me.  The connection would be more obvious if it were the 046 part
> > that you were specifying this for given that only has the one channel.  
> 
> I guess there is a copy paste issue as you commented on TSU driver patch
> ("thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support) instead of
> ("dt-bindings: iio: adc: renesas,rzg2l-adc: Make '#io-channel-cells' required for R9A08G045")??
> 
> RZ/G3S ADC has total 9 channels out of which channel 8 is 'io-channels' provider.
> I will add this information in commit message to make it clear.
So if only one channel is used as io-channels provider, the device sounds pretty
useful without that.  Hence my question on whether it should be 'required'.

Where there is just one channel the argument is simpler.

I'll fully admit I've lost track of which part is which!

Jonathan
> 
> Cheers,
> Biju

