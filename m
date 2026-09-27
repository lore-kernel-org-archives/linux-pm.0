Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1632F6920;
	Sun, 27 Sep 2026 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533337; cv=none; b=ZiBhkErrd1zUmSPvKn8Ia9bAYraGDAPEbDjsNIJVxU889AYvDd8TXgLHBn9lqaTJvcIMw6tfDMn09vJEd5xKC+8hT7MWYJ1guJuCGr4ZpVyQx3x5MUNApWU915X0aagV7szSetRWFJRkLGkaHegSsM5vuCIemfvcQ8LZPTtKT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533337; c=relaxed/simple;
	bh=LcibjBPP6VbofJDx12LxvHxpuVoxkzI8k9nSDUGLz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBZXoArZlQMllYnC4dZ4mTNzfOlicGOz9R23+ce691AG62mT7AbiJyxUs9W2C7OS2cLv8tfuKZJi7Nbf6IqD2+aIVshq0SAqq/F232cMQhwJMSZZexLwXu4uPwwwJgfp5PA2t1vqEE1cNtvBplwheVkncGTNb67qHOIbK25dvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I57Osc6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I57Osc6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFAE1F000FF;
	Sun, 27 Sep 2026 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533335;
	bh=bY3jOCg5ioTozBEBo/T8vK2x5sI+OIe3yUJpHmcuHaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I57Osc6SOaXrl24j9rwKkR03WA8J2xd80vsvt9ISleyr5H+mGM8IvqVvk1MP9T264
	 KkbjMjrwLgYqxKZAgwkcU/yY36HPBU0glBu627zd5ZWnu9b9AlVYz51ShoCIbVxupg
	 XLHvp3btuaKGM3grWQSf84R4mbQfbO7Qc3fwaPFFX/8lUBEaSa+XPMPuBhBSeUke/t
	 ORcU8rzvrirRpagXl4CBRaFIYk5k5NGDKkQRj3XT7uybvQfV/Z1kiur3hZWh9se6AS
	 SlWO6XwaV+2srh6v1zQxx4eyuSQaKqt0NezEIgftuKuPkMfw2Wy4oZK+c/79s1kztZ
	 D7LHZ20q0LO0A==
Date: Sun, 27 Sep 2026 19:22:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Chris Paterson
 <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 0/7] Add Renesas RZ/G3L TSU support
Message-ID: <20260927192211.03ebd188@jic23-hlaptop>
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 07:15:58 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> The Thermal sensor unit (a.k.a TSU) IP found on the RZ/G3L SoC is similar
> to the RZ/G3S, but it has different calibration constants. Moreover, the
> TSU is connected to A/D converter of TSU (a.k.a ADC1) on the RZ/G3L,
> whereas it is connected to ADC0 on the RZ/G3S.
> 
> Compared to ADC0, there are no A/D conversion result registers(ADCR0 to
> ADCR7) on the RZ/G3L, and the INTEN bits in the A/D converter interrupt
> control register(a.k.a ADINT)  are also different.
> 
> This patch series aims to add support for TSU along with ADC1.
> 
> Merge strategy:
>   * patch #1-#3 thermal subsystem
>   * patch #4-#6 iio subsystem
Applied these to the testing branch of iio.git.  That will show
up in linux-next once 0-day has taken a first look at it.

Thanks,

Jonathan

>   * patch #7 SoC subsystem
> 
> v3->v4:
>  * Dropped clk patch as it is accepted.
>  * Collected tag.
>  * Updated commit description for patch#5.
>  * Updated kernel doc comment for max_channels.
> v2->v3:
>  * Collected tags
>  * Dropped required property '#io-channel-cells' from bindings.
>  * Renamed num_channels to max_channels in struct rzg2l_adc_hw_params
> v1->v2:
>  * Merged TSU and ADC1 series together.
>  * Moved the clk patch.
> 
> Biju Das (7):
>   dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
>   thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC
>     match data
>   thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
>   dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
>   iio: adc: rzg2l_adc: Rename num_channels to max_channels
>   iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
>   arm64: dts: renesas: r9a08g046: Enable TSU
> 
>  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 17 ++++-
>  .../thermal/renesas,r9a08g045-tsu.yaml        |  4 +-
>  arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 66 +++++++++++++++++++
>  drivers/iio/adc/rzg2l_adc.c                   | 29 +++++---
>  drivers/thermal/renesas/rzg3s_thermal.c       | 38 ++++++++---
>  5 files changed, 133 insertions(+), 21 deletions(-)
> 

