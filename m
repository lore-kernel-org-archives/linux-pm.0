Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAE400962;
	Thu, 13 Aug 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614281; cv=none; b=R/3LM3g/u1vTNHNJTAKkL1+Y2dcIe58sNh3Gpah7FUdT4wU0xYPbFw+W3eqv3eFnIUHzIkdZM9GlhjcbHaTJY0bMXhmly6lBBT/W1x/4WMQWbLugJ1HyOWqIKhJfNPensvVu3VLy8M9d9weGV2iUe+7PqHeUHYzBmfxNj/2A2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614281; c=relaxed/simple;
	bh=8kWS9h160LrSlRPUdJ1x/BCm9vn7jCDHrx/pmEKKml4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX+2rcMvaFVK9nYV1wqlv9SG2Lbqc3xLxL77jHTRzEx8WIzEklcojnu0LPYlPlZ6pX+xYDPvKb8CF45L3VvlMUar/RdCovrdask6EqRYmGv0mYC0i7hYV7dwph6qk5BavCpSwvSmvg5TVpK3np27p7QBxNBPFSECP7xIorrj/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqQfAbB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqQfAbB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D71F000E9;
	Thu, 13 Aug 2026 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614279;
	bh=ujVjRG5NW4KCrLiN6Zo+PUWphS4oTQQkc08hwzGqblY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OqQfAbB18Vpv8VnWeyl8yNUIkMe6cJSsmkaioH4LGDfWZr0uTcX8VJUrX6BToU3V5
	 zWw6j4mgRamaq2k1lt/qo5sCM4tPeW8CEBhGC4NoYzj7/LHCE6S5BKML1HOCHK17WA
	 xWe8G+VST6zKcRy1FXsSgr71V1B9AQDERDchvMPp+fczCrmd7udhMiqFXV2UiWeATa
	 8h2P9VkPwJjbAi+pvbKwiybo2MXrOrvVNKaEDqkJYJHVTB4Jy/OsjRkeIdg4Zz85Cu
	 6c+KiVV97+398pYDdYNdakH2dYg4/XAc8t541K+4xVJOlzHtvPjmqueVQzJFijZc67
	 Rfxxim8NEvF4A==
Date: Thu, 13 Aug 2026 11:44:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
Message-ID: <20260813-generous-romantic-asp-be92e8@quoll>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
 <wjzyvt7q4vpirxclbwexrhsmcoi23hmsqbjjpfto26ofci23t7@uufz7ilar4qk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <wjzyvt7q4vpirxclbwexrhsmcoi23hmsqbjjpfto26ofci23t7@uufz7ilar4qk>

On Tue, Aug 11, 2026 at 04:13:40AM +0300, Dmitry Baryshkov wrote:
> On Sun, Aug 09, 2026 at 12:57:14PM +0530, Hardeep Sharma wrote:
> > Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
> > (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
> > 
> > Peripherals included in this initial set:
> >   - Single Cortex-A7 CPU with PSCI idle states
> >   - RPMh RSC with clock controller, power domains, and BCM voter
> >   - GCC (Global Clock Controller)
> >   - TLMM pin controller (110 GPIOs)
> >   - Interconnect (aggre-noc, cnoc-main)
> >   - GENI UART console (QUP SE3)
> >   - SMEM, hardware spinlocks (TCSR mutex)
> 
> This is pretty limited without any storage. Does it NAND?

It has serial connection. this is enough for a start. At least one
communication interface is needed for early upstreaming.

Best regards,
Krzysztof

