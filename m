Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823035;
	b=okjUXAWbI5kWEdpIdv0MxkRA8WY7TeOy2rS2G8h+o8qlEhcS3L/8zQD12zC3+B/z/0Bj
	 XcYemc3dEuPZmBs1kbyTUXtrbeRCt55eKdGCQ1t+PC5bHjUr2Wlbp3sDHIju4u0FNuVYJ
	 sTidNyU3oPHJUTrI2yjwrx8wDvW7W1CrB8Zz5YSehC+yt1eniEKGvMHPcK99dLHTesxH5
	 gePWNaueUlENHJuTBQVX8IHtUwq5dw8C6ADEz/r3yIosMPPIhea1wT7aqVI/kzRHf1Txw
	 aTiixuJzgXCBS1ywS7V/7P84swDsXSUVQ01fb/lgt9MyXS10m54A8CgF3wFe3XcfxcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823035;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=BKwH/iPsGpBgdjotukbv47/XMRavn61B5PvO9PeiRxY=;
	b=q4sxxGboYwA4uikzlqA4T+DzQDFo7Zzz2sG/K9ClRkSz78N8VvVETwmP6yjN4HhfBSoP
	 8+vuFuPhzKUYkj65a/BIgBAK8hPsJcnMg4KN1ITGXuOQr5IJQe2gWJncKPfSPLUwJ3UUg
	 6oqYp6R0NhmNHljA1nBYSYgAAAzAzUIU1xZpuV/YwjfJU10awmfyemi6cwlIiItaFjS01
	 LfoMvKtBV3pAXb7RanfvZHAyABfxpbjdSJ8Lw86sN8wRCdc6c6fJ8UE1bA5EJ5YmY4bRY
	 Q1Gm6X40WRi+eOueHYJtgzumSGgeU/dfp7Z6KKNcwfIn3xfbJa+bQMr14JSOvS0MEoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=e77DMDMx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94934606A33D;
	Mon, 16 Nov 2026 09:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94934606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=e77DMDMx
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C930720059B;
	Mon, 16 Nov 2026 10:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794823032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKwH/iPsGpBgdjotukbv47/XMRavn61B5PvO9PeiRxY=;
	b=e77DMDMxYre+lT0XsCkBPm6hniRa/0AKlIuy3d+048vtiK7EOeN76xZGEXQV1xWz/LsEpd
	+Oq4JRLLrMpOXGo9Kay5U6gtFdYh4/MbSoL+uT/R8dBcQ4omhoWI04Uc0rxHrfxjgOvsGA
	MYDII28WbWKFPbgqpsmtF+ruObzviCmsJmyHManqwfsZbjxqzQZfsz+Qdxbixn+C6tgpsE
	nm/tY+hGooOvQV9Ib0TrB57BdQdMafeqeBr2DxEBZpX+iMMPSpWlg/z4HoaZuSGWvn4RBZ
	p1yO8mUBhURyaMmuXUo6rOj66b1oYq/kYCo1tEehZQXBugBW/JsE4l1S2QuOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794823032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKwH/iPsGpBgdjotukbv47/XMRavn61B5PvO9PeiRxY=;
	b=ZUruFCBkOh5XjH83QYSicDz/2wzBRnfd7CBdbuBGh03CddG9P4OMOam+bFujPXK1aUv/59
	0qcxKSIq1rSWr3KEms3Mhvx5F9K8lq96lnovSKWJVzgTbFbvcQeP0y6FiqUTjTU42wPdiu
	iozyjJ2zUgyfNfHgloQgH5DW1Y95yKdJy6HLNVkt060faWQoAx3iNj7AxWq9a+sU9Xut8i
	blQsULChDYFSfe52iuHM6GpfpZ83vhV9aNXf0LfzJk9NpT6NWGYuj9R8Qy5DO3JATSNVuM
	yHHPgoifue+MhG14SkNOV921ONcYGIaha7D/2uFgiUlIpz1wZY6SsUyR1bgUvg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794823032; a=rsa-sha256;
	cv=none;
	b=Sh4oh/QqUDxHSdEQodkdsbc4tb0Wo9LbXyM4Wgk32fnwZiAha1ikyFBqAhePPO9lDvN1kC
	AOUR2KKCfaS4lsd70Ss/g0NuEymuJlBuyeXaULg4S0IJCGSHa78xqRO+CrsL12FR6I4NzZ
	EYehOABDF594URR48QRRv6TIMkziWwjvHIBd+ldUqBwB2Md6ArbxNdImPEiwYp+aXi9tjT
	T8rIieD4Tkv56eOyd1gIeRmTykg26BzV4P5Ha2NzN5PRpTynmMLcrLymGO1i9JWzWdOtJq
	w4fZrI9USOQqyUBYy4JAkWVdC/pV+DeujrCMA99faBOZ2MWFX6KXaAwiW2ilLQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <2bf193a0353fe74cd2d2faf48528e40df00d36bc.camel@pengutronix.de>
Subject: Re: [PATCH v4 5/7] reset: Add BCMBCA block resets through the PMB
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, William Zhang <william.zhang@broadcom.com>,
 Anand Gore	 <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Guenter Roeck	 <linux@roeck-us.net>, Jonathan
 Corbet <corbet@lwn.net>, Randy Dunlap	 <rdunlap@infradead.org>, Ulf Hansson
 <ulfh@kernel.org>, Benjamin Larsson	 <benjamin.larsson@genexis.eu>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
Date: Mon, 16 Nov 2026 10:57:12 +0100
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-5-17035a5e8ad2@kernel.org>
References: 
	<20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
	 <20261111-xg6846b-bcmbca-xrdp-reset-v4-5-17035a5e8ad2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mi, 2026-11-11 at 12:00 +0100, Linus Walleij wrote:
> Implement the BCM6846 XRDP reset group through the shared PMB regmap.
> Assert all blocks before releasing any of them, preserving the vendor
> reset masks and ordering. Provide the independent PVTMON acquisition
> reset as well. Serialize complete sequences and hold blocks in reset
> on failure.
>=20
> Consumers must enable their power domains before triggering a reset
> pulse (i.e. the cycle of asserting/deasserting reset).
>=20
> Suppress bind attributes: it's not good to be able to unbind the
> reset driver for the SoC manually.
>=20
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
