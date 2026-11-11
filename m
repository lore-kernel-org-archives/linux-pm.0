Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416734;
	b=DSSnfoc6SEyT1hl/V7J8KO+orlZySlBJwtSIJ1m3LwmIMWdCaj5DqTQFmQW4HtVj4iq1
	 kKQRSzzszFygVHDYIzVJqkg+uGBIpom1VWJMx0iIlxXAl/lPSVB17dCvtW0MBePlI70c+
	 leleMjjZ2G3DQ77xDoyRd+2d6N/xDX7XROGQ3wJNwvwp7ni41BikiRkCJWNuYGfl8crSV
	 EcRGcyplD7aTiA9KpWfQ3DmiQ735dRMpX4BZdzB6LEQph1LB+//w6JQ/0Qtv6DgOXA2B+
	 CLO7QGbihugxFSn/j6GAEC7BJeLT/UMdsgSTimBSPQtuVxmVaBOrZ56FiQzZCfs75eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BIjsyfCAMtV7iYJZyUQnR/qSWRidGT61sCTUErFE8Y0=;
	b=1zOX1qmL8b6u3f+fxfiyASfpjNkJSRGt2jUobWLcOsrOQ1RL+LnlMnhNsOfMxhfpe23K
	 bBnvnEqxrnBeRqdm3DXzI8YpfEqrIJSQ+UjHH2VIveShCWE+v8AuguuDxHqjJ93gILIx8
	 g5tKBq6LiemoEQ7st4x5SxgdiaN2MAYy8UClo+V0E5LYaXMISM+P5SVOGPsaKIgfP4qZf
	 OBSJoaOj3OLTT65ke1MvziQHjUT+lvbtE6yd1ycjXQdm7iz7Bq8tGb+4OfryM/HeLW06b
	 gX3CCJZmMxWgfEMp2OMszzXZw2H71449WTlVEjK4RuUp32F/N1cG/blGEyMcs6PstqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8NDL01K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084660A2600;
	Wed, 11 Nov 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8NDL01K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C233A1F00A07;
	Wed, 11 Nov 2026 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416734;
	bh=BIjsyfCAMtV7iYJZyUQnR/qSWRidGT61sCTUErFE8Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8NDL01KzKueCRrzIThmTcCU88ocXYyn4+kkLuTyba7c3VtJ14dFSHV8Fh1TqJVAU
	 FnEf3wgOPWM65xQN8GRR3PwDt5YApemSB1gz97EsPmL57pyi8zpjf3fJD+V+2PrzV2
	 PIVbUCJBFHML12Wozi5frrxK58PL/CPqMvJAzWiOixfvza7MrqYJRB/vRYkW+LBnb9
	 Pt2p4ITMbclSYQl4lleawgEnm5AdyBkvOW34tu8RR7b+wGPVO4dRywdX6yk/Z0VgSL
	 GFMyhxHgDiq+7QEeTAfQkhgTXutpxLur+Yye1yTuTLQfkIOvN0Q/eO3j7XCQIPxrqE
	 +JL7oz0bTFKaA==
Date: Wed, 11 Nov 2026 11:05:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anand Gore <anand.gore@broadcom.com>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Brian Masney <bmasney+clk@redhat.com>,
	William Zhang <william.zhang@broadcom.com>, mfd@lists.linux.dev,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Kursad Oney <kursad.oney@broadcom.com>, linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 1/7] dt-bindings: soc: Describe the BCM6846 Power
 Management Bus
Message-ID: <179441673078.3717632.4630154111518612765.robh@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
 <20261111-xg6846b-bcmbca-xrdp-reset-v4-1-17035a5e8ad2@kernel.org>
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
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-1-17035a5e8ad2@kernel.org>


On Wed, 11 Nov 2026 12:00:42 +0100, Linus Walleij wrote:
> The third generation Power Management Controller (PMC3) accesses SoC
> block control and reset registers through the Power Management Bus
> (PMB). Describe the BCM6846 PMB and its child controllers.
> 
> Add bindings for the power, clock, reset and PVTMON child controllers,
> and headers defining their clock, reset and power-domain IDs. Include
> the combined XRDP, Runner and WAN power domain and the zero-cell PVTMON
> thermal sensor.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> I considered even just using the PMB but the PMC has more stuff and
> it seems natural to let it live in a simple-mfd node.
> ---
>  .../bindings/clock/brcm,bcm6846-pmb-clock.yaml     | 39 ++++++++++
>  .../bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml    | 42 ++++++++++
>  .../bindings/power/brcm,bcm6846-pmb-power.yaml     | 44 +++++++++++
>  .../bindings/reset/brcm,bcm6846-pmb-reset.yaml     | 31 ++++++++
>  .../bindings/soc/bcm/brcm,bcm6846-pmb.yaml         | 90 ++++++++++++++++++++++
>  MAINTAINERS                                        | 12 +++
>  include/dt-bindings/clock/brcm,bcm6846-pmb.h       | 42 ++++++++++
>  include/dt-bindings/power/brcm,bcm6846-pmb.h       | 12 +++
>  include/dt-bindings/reset/brcm,bcm6846-pmb.h       | 11 +++
>  9 files changed, 323 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

