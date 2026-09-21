Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F622D7A9;
	Mon, 21 Sep 2026 03:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961398; cv=none; b=nz9vX9MqNnPrA33+Eoyx+x4OaDQp/BBMOpU07cAkcKxsOJ75tg6N6TGi7fIcfMobVsPXFHyIEYd/2sB7fyYUruX4OxLia2F/B2wIdTY1LsJHOw8fmA3n/UTe/Bn5iDjlWPTVmLEyawcsUossRtKgOZkSp8+2RGmc78CO60ZNs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961398; c=relaxed/simple;
	bh=rn75iNrFLTwbbycSrtqtYnYCOk2j3GZ0FdeFPHqihug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjvIrHx2TyZnRNjV8ZZTE0T6quxWhz9opY9Esn4vMmXbwQbKK0rD+d//Jryms/kqW6ealdxVsczu7/dCtbaRB/sx4YzawrGY0EKER7omgV5bnOgY7mWEid1jHk0N86QmlPwsDcSSFVgGDYgP2Czhg/Pz7EeJ6FJEnY94rCn9xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcAn6caa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcAn6caa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E113E1F000FF;
	Mon, 21 Sep 2026 03:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789961397;
	bh=5EjlznZso6ilvD3xaUAuAr25DR38QrNXUtBdvR2wDJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FcAn6caanFFCpeGgly/feeazgIH4kJjApe4IzfYUYWG47ZqxTfLO10PL8+/zfeZz2
	 3iJ0UM/jgcxaO81ZxWhR+d2qJePGelF0OgQsJ53kHYoSuzngqAKwyCHY4aEV8i0NUQ
	 CIAlsLq0r5P91GiCR6Fccz6qIOngZ1n3ySewno8hJtaEE1Ar/+lO6XVDRS+SQcI7rU
	 AwcboLQTHXAgKZ4XQNbaM67KdRx7aK3e3qWJQeYvatihnEbKQKFJwf22XO52TwYXN0
	 GKyuoHJxCsA/dEyukln7Rdl8dj/hOg0eGbaVBcpX5l6YWOlGmMVfC2fooLSzAGWIsA
	 SJIuSOyk2l5Jg==
Date: Mon, 21 Sep 2026 04:29:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc:
 Document RZ/G3L ADC for TSU
Message-ID: <20260921042936.548630f3@jic23-hlaptop>
In-Reply-To: <TY3PR01MB113466E3B9C0DDFC619C2549186842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
	<20260918150730.122056-7-biju.das.jz@bp.renesas.com>
	<178992596604.706584.10451227613547984363.b4-review@b4>
	<TY3PR01MB113466E3B9C0DDFC619C2549186842@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 02:03:18 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Jonathan,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: 20 September 2026 18:39
> > Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
> >   
> > > Add renesas,r9a08g046-adc1 compatible string and its hardware
> > > parameters for the ADC1 IP on RZ/G3L, which is dedicated to the
> > > on-chip TSU (thermal sensor unit).
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > > index 408fbf8c29cc..35eaebfbdd77 100644
> > > --- a/drivers/iio/adc/rzg2l_adc.c
> > > +++ b/drivers/iio/adc/rzg2l_adc.c
> > > @@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
> > >  	.adint_inten_mask = GENMASK(11, 0),
> > >  };
> > >
> > > +static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
> > > +	.num_channels = 9,  
> > 
> > This maybe needs a comment that only channel 8 actually goes anywhere.  
> 
> Yes, it deserves a comment as it has only 1 channel and its channel number is 8.
> Or
> change the variable name from num_channels to max_channels to make it
> Clear. Shall I change the variable name? or still you prefer adding comment.
> Please let me know.

That makes sense.  So yes, please rename.

> 
> RZ/G3S ADC has 9 channels{ADC0..ADC8) and ADC8 is connected to thermal sensor unit.
> RZ/G3L ADC1 IP has 1 channel ADC8 and ADC8 is connected to thermal sensor unit.
> RZ/G3L ADC0 IP has 8 channels (ADC0..ADC7).
> 
> Note:
> Looks like copy paste mistake. You commented on binding patches for 
> Driver changes.
> 
> https://lore.kernel.org/all/20260918150730.122056-8-biju.das.jz@bp.renesas.com/

Don't think so. That was about the binding.  I was asking why io-channels is required
which is all about what channels exist and how useful a subset is.

> 
> Cheers,
> Biju
> 
> 

