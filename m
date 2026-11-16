Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817343;
	b=OzUx6QkOLetdFMMunVVtn93n0FqS7oMolkJ9QzAalxc2a6AuP9Y7HsbGVeAAS6XGrzOR
	 44TIidV3Tillt84u8Ex20fDv/U66PExpyhMVwiZaMUa+vinfduVbgb4IDo6KXmvoTSGc7
	 WVBDXs/c8U6X0JlPR/s69fuWVkpeOtK2fht1ptZjDnd2DLrGAh/hJLctgMMAUWyQsvrDZ
	 ANtMLW5SBe7buamCjmFoTC636YfacWpNBygH1Wx8N4zRorFCzkGLyXsDOyT+2TufD/zTg
	 2k88cOPtQVt1B5dc3F1yh12IzSHahWMOXLEv96gZ2aoinFzK3abFEieXiLLKwFoU+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=32AAHIWK9+nySJMB0j3qfZjXIrfpuRX6GBrpsnTt5Jg=;
	b=rKhyXaLR/jFTV7u/O+IDNqON5iiG7mx77wJ3HO34ByMMoLxBFajRzyKVvxiFUQfwJLsP
	 BotzL2YjQzif4XvqEjLVTb5ZRnPaZ23aBB2fV2astlU94VW+sNHA/ib7TzbaOWgUs7PPU
	 fBeOkKZkwZ7VB56gJ0isl081ZWZReWbNKvGN062zEcFvUHh9hlk/y9rvrGxkbXiBpuzcn
	 SO2u2col0ID5SYhCXGKhVQ/colrDAgjg4GbDItNwkBbb84Yr0+TDcizbW/Pwr6deMwhKa
	 cKE+nidWLcs3mx+KsRWBGFrb1/mBJxpJN2lnnssHzdzbMmxktw5fET9AAojTPASINNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=eRzLgCj+;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A4606A331
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A33A4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=eRzLgCj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=32AA
	HIWK9+nySJMB0j3qfZjXIrfpuRX6GBrpsnTt5Jg=; b=eRzLgCj+1P9TNWlQv6+U
	a+HIghOb2IwHqxqYJv2ZQHGfn0SF4pYehbmUrvheYiIOMbhh/DhYIwvLwcydweRj
	4EVAJh0+3QYe9ncHpgtYpV1kXoJMefuq5/LE5xNBDDJp633A13hviVR5m0wCikAu
	vgGiwOvV3t7KBG63Qlt8I+FmHBzn2QOzek+kn/MlXjLEDZn/6jcAK86jDqZkuj4p
	L4di1uWturUWdAj588oi7pFCFtJshRRK7GE4rHbXI97mLoCel0bZ0i5fqk1CaKVF
	FPcstvvCup77Z57XCiN+RtLGtNSol074MCruuZ/NT1K9+zD4CwBE5+mcmZegdSh3
	8Q==
Received: (qmail 1194596 invoked from network); 16 Nov 2026 09:22:18 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:18 +0100
X-UD-Smtp-Session: l3s3148p1@qn/ieWBgjp0ujnv5
Date: Mon, 16 Nov 2026 09:22:18 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
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
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/8] clk: renesas: r8a78000: Add SCMI remapping support
Message-ID: <avq9OvLAHgxoQdp0@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:41PM +0200, Geert Uytterhoeven wrote:
> Extend the Clock Pulse Generator driver for R-Car X5H with SCMI support,
> to remap DT clock IDs to abstractions (clocks) offered by the SCMI
> firmware when running on a system with SCMI, and SCMI support is
> enabled.  Take into account some peculiarities of the current SCMI
> firmware implementations, and fall-back to fixed-rate clocks as
> replacements for SCMI clocks that are not available.
> Support for bus clocks used by serial, I2C, and SPI devices is included.
> 
> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> hardware description in SoC DTS for systems with and without SCMI
> firmware.
> 
> For now, it is assumed SCMI clock IDs are stable, and match SCP FW
> SDKv4.31.0 and later.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

