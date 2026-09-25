Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5D353A63;
	Fri, 25 Sep 2026 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304928; cv=none; b=Z4A7ADkvVpF5vP8jeGFolYmERkzlj0SQHYvsk3Mc215KP418cGAZA3IdnuKvnc1kQxYNpP4e5wenSOdd7Gb550SeUpCMl27fJIwY8pRTbRUwdbYkX2RvZnlTndSJSufhxeGoIApY3oS8S0SmJmigtDLfQWe7mRWULEpR0psizYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304928; c=relaxed/simple;
	bh=rSR7Qtw2D6BPCg1lIf+mXXhQNT9xB8O4bjtoDnHB/tE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpRGHJwZWdFAFBUFomXdUMe6RtFzMr2Hi5B4MHKa1FUITklLL7TERqb37aW8dW9HxmGJqZ2CTb1/Hz5sLBrjzoOdcLgNQ6vzN8mC4y5d5RcHhhnu5EO7QafjutfvPY9Dz3zpk28NhISjcS1evZOYPym9NQyekWzwvdjIEwb4wNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LslccSOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LslccSOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A277F1F000FF;
	Fri, 25 Sep 2026 02:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304927;
	bh=PttGAIZa7IJgHn8YsZRmLhAOFrz4Tyk/oDL7gzR3avE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LslccSOGtp2rHlPTeBsQa873Ie9ulKUTfOtbmxPWeed6oJSjS7oawShjfe9YjttvN
	 so4771aHBPJ9t8IZH7pCBuQBEp7lCYgTZDG6jpV/RgZIT8h2cWI5o/yjfji7rta2sQ
	 gNauWdrboZPSY3XrQu4AQetLSui7eOK8LNeoAUushV0yioR34mvQDJIXVwdYuAbUm5
	 dtyYdsFvjK0vXBx4qJpj10eBDh50sa+hYa6Ro6O3gaK2qchwxmiqTouMMl/Bg7jkVe
	 xPo79VyihAjMhpy928bwo/lwqkjr1iIxnQ62ilnnV7eh2VjCQfvPUeqOYtzim9lPi6
	 2EztjtJqigWGA==
Date: Fri, 25 Sep 2026 03:55:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: geert <geert@linux-m68k.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to
 max_channels
Message-ID: <20260925035522.08ab45c7@jic23-hlaptop>
In-Reply-To: <TY3PR01MB113468E77437603F4D230FD8386822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
	<20260922042707.116378-7-biju.das.jz@bp.renesas.com>
	<CAMuHMdVbyktVBAwBh=LoARWHHmb_FrF+omeDvNdR76uxus3mPA@mail.gmail.com>
	<TY3PR01MB113468E77437603F4D230FD8386822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 08:21:29 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Geert,
> 
> Thanks for the feedback.
FWIW other than fixing this up, the ADC parts of this series
look good to me.  I'm assuming they can go through IIO whilst
the rest goes through whatever tree makes sense?

Jonathan

