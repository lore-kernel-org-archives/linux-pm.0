Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193880;
	b=dJLWshsJu4KutqP+eArM1HC5QEWi5B9Zt+FonAk68Q/SDLLi552wdt0WqHax9yT/u177
	 IXvcR+mS4fhSFnDiolhcEvBTDXKwfRBjZOTlFBIyAlX5AywgXinsFFbtBE6j/MrVRreZa
	 hS7boRUwEG4wtKtmhL/+qXP4TpR8CB1TlTA6c159oJ1trPDMyqqEmEWCB/mDIJs2cBY21
	 xfZKKYZx+PVK85Bvi7X+NmwF8RtnUUSDlS+B+wDt3WPoip/Ps5G8YKZt6wMDKYPgt//sA
	 T5RQlwy09zKn923qkjJ4fgm09SeHyF+GRNJzPn+XDS7f/qt2wLpPzKBEIgoSrhhqBcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zMyLVpl5SGn9LRVq3YemmUnIHNGskaGDXWx+m9anSm4=;
	b=BwfsyKNzc4gSlrDVr2XyD8gIl1b8etZc5dbAbJDxmCvFNYXgF3OvW2BtsZfh7vDHVFQo
	 uxfHKiQQsEuL37y4pzkxriBHEifQ3vV0ON6QvVndwyzMhxmI3rq8qFtULqJ5qLonepVcB
	 eB4lEk8fBEUcy79p+82+BCWPs24T4TjeZFl9zsn/qLIrIz0ZuCAzeijogbvyHczIbQlRX
	 i538B+L4Ay0o5+12zJDCVM+YPxG/m+ZfIWE9SA18iCV0Y5EkBiMwBI4wFthww3w1Nzu2M
	 ppOp6LYCvWOhli6q+P88Negu7QjQ/P7A8SXN+OZf8h+g27pUdo72tkWIFpfQPdW19zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kfegx7uj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22693606A31A;
	Wed, 28 Oct 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kfegx7uj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C641F01828;
	Wed, 28 Oct 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193879;
	bh=zMyLVpl5SGn9LRVq3YemmUnIHNGskaGDXWx+m9anSm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kfegx7ujlGk/2hjxiHA1Z+E7EMek3gRDyf0P7d57n0ymidZffq4rr3n644D7L2ioV
	 YCEclgT7D3hsJZMPAZAFLCqXa2LMGV/1UN9Q6wKApeFeTTdOnvoHNLxwa8/TH0GDbW
	 yy6vqqVxJGOX029sckv9QqIGbT2fkh08T3GleGZVgL1Nh5MJe9Dt2e0An1bDjJDHA8
	 4YY9xCP1jqrqcGml7YgPpSIrV4kr/7x5br8YkOmFc7DvRm6IIpu2MgkCD598kY75Fl
	 NDKZm50ZzVFa8oftaYRfgBEWvigM5Nn5Xa/iF1OR2l5I3uI8pabN4y+7U+32RbRvMA
	 Akd5Ea5WMoDRA==
Date: Wed, 28 Oct 2026 14:24:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, Mariano Marciello <mmarciello@google.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>
Subject: Re: [PATCH 0/9] google: Add support for Laguna CPM
Message-ID: <20261028-armored-glistening-cheetah-6f3070@quoll>
References: <20261026214359.3122870-1-briannorris@chromium.org>
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
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>

On Mon, Oct 26, 2026 at 02:43:38PM -0700, Brian Norris wrote:
> The Central Power Manager (CPM) is a co-processor on the Google Tensor
> SoCs, as used on Pixel phones. CPM supports power-management and a
> number of other features.
> 
> The Application Processor communicates with CPM over a pair of mailbox
> channels. CPM provides clock, power-domain, reset, and interrupt
> services.
> 
> This series adds device tree bindings, DTS, and drivers to support CPM,
> and several of the basic services provided by CPM. These services are a
> minimal set needed to bootstrap many other components on the SoC --
> e.g., I have a working proof-of-concept PCIe driver running on top of
> this series + pinctrl (not included here). CPM provides some other
> components not yet included in this series (e.g., PMIC, RTC).
> 
> This series depends on the bindings and mailbox-payload-definitions from
> this series:
> 
>   https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
>   [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver
> 
> So this series cannot be applied as-is yet. However, v1 of that series
> was under review for about 3 months, so I'd like to at least:
> 
>   1) demonstrate its clients (this came up at
>      https://lore.kernel.org/all/CAD=FV=VW2h1zWDYWQ6LknX3O+3=EY665jde35Ly+UQzuscXy=Q@mail.gmail.com/,
>      for one); and
> 
>   2) start review for anything that isn't significantly impacted by
>      potential changes in the above mailbox series.
> 
> With luck, the general design and DT bindings don't need to change, but
> even if so, I expect any changes should not significantly affect:
> 
>  (a) the CPM DT binding or DTS (apart from #mbox-cells)
> 
>  (b) the CPM interface (cpm_request_client(), cpm_send_message())
> 
>  (c) any of the CPM clients (irqchip, reset, clk, pmdomain)
> 
> Thus, I think this falls somewhere between "PATCH" and "RFC".

Either you expect review or not. RFC means no. If that's patch, then at
the top level of cover letter, as the most important thing, you explain
the dependency and merging proposal of this. You combined here like 5
different subsystens...

Best regards,
Krzysztof

