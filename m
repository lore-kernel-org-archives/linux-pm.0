Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817372;
	b=Gs322xx2R4gkYa0GqNwJAYavlq1avvP/6w006qL6YUaXZ9uiuFwm4+W0KNE5icgaH9pF
	 Qi0Wxn31uWanjmmz5BFKkbh8en6g3lJMbZWgl989EBKZGLED3GsHgF1CZKSUmBOZ73n06
	 tpELZDDT2IynryPEhgkpK3kwhziL8/1lJ6DVoN46AyaWEEFS/FA1UfJGveOwEkyt0scgp
	 ehXyMhbV7xyE2r20NGW4KhAeERBEMEAkGg6xppAVnjFe1nzPfXiuzIc2UmCs3zzD6/ilA
	 kHNLJqYfOgxcx9lVAqh0deqPtH1nOqLYboJup2SwlG0AnD7wigcN4R0uIIDlNjkoP3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817372;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LhPPM3zT6vPGJYGyZWFJeeyKRU3pFACsJcPyj9KudI4=;
	b=MrupLylJiec+AfwaJElBeLUTEy19Jre9tDb5frErIIavW/j/T3SL2sHE7peGXfZjMAni
	 5hThfCpEI5D9vju3SKlyhE8k6P5twQ7+hJepiI9k8DbHfIq/l9UjkELjhqmBgOfTGvgh5
	 s09Z5gv6F0JHZVynDeXJyNQ2ejQf9QVDhrWFl2KHFIGwTGBDXWK85IT30WuLW/F5MBtXk
	 VvqFYh4Wo4+GANmIQu7BAdAyDeodvoiiwowjrlu+zb6hKBrYfExyYLLyQrCQFUEElZvTY
	 +HPZDN1k+Yt6pwyIzgfwt9GEDk+74BPd4QCCMMNx1TOeYGHPqnrAEiXeRP9Vz2fK52Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=gQ1VwnfB;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4548606A335
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4548606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=gQ1VwnfB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LhPP
	M3zT6vPGJYGyZWFJeeyKRU3pFACsJcPyj9KudI4=; b=gQ1VwnfB/C3G2TjaGW/u
	C5mnLKImza5xSvZ8/Y4rmPCPquRmolZ0dZDQO4CyyhE1Dkdp1UfEcC53mvU2M28n
	0EcIQ4W0OE2K7w/n0l5NO6Sc/sPjkwOGhIRmf9DRqTtFjHgg/4bLtcFUg755nQ0i
	iO+bHKlOv8AyMSVCdjTRPJd9gkYBwdSxR+8XPwvyOjraksJ4ERFaw/MthF2jIByl
	bzqK8/96ge1aZo7odRBwLUV5+EqbQyrJoIftzGDOBQWF2uTtHsmhkhL7l/bvj9Em
	Ptl3naiUw8J9GIwNpEaXaunDNU7asy5D9qrkuRmmCzSCH6acUui7lywY6i2sOvBC
	hw==
Received: (qmail 1195199 invoked from network); 16 Nov 2026 09:22:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:48 +0100
X-UD-Smtp-Session: l3s3148p1@BXSwe2Bgdt4ujnv5
Date: Mon, 16 Nov 2026 09:22:48 +0100
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
Subject: Re: [PATCH v4 7/8] pmdomain: renesas: r8a78000: Add SCMI remapping
 support
Message-ID: <avq9WBwBMtb5YeKx@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be>
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
In-Reply-To: <2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:46PM +0200, Geert Uytterhoeven wrote:
> Extend the Module Controller driver for R-Car X5H with SCMI support, to
> remap hardware power domain, module, and reset IDs to abstractions
> (power domains, clocks, and resets) offered by the SCMI firmware when
> running on a system with SCMI, and SCMI support is enabled.  Take into
> account some peculiarities of the current SCMI firmware implementations,
> like missing handling of gateable functional clock parents.
> Support for power domains, and module clocks and resets used by serial,
> I2C, and SPI devices is included.
> 
> Note that SCMI clocks representing hardware modules expose access to
> Module Standby control: they are fake clocks, with a zero clock rate,
> that can just be enabled and disabled.  Hence they are controlled from
> the clock domain's start/stop callbacks, together with gateable
> functional clock parents.
> 
> This lets us avoid putting SCMI IDs in DT, and allows us to use the same
> hardware description in SoC DTS for systems with and without SCMI
> firmware.
> 
> For now, it is assumed SCMI power domain, clock, and reset IDs are
> stable, and match SCP FW SDKv4.31.0 and later.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

