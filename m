Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817320;
	b=fZPrG6j+oBWMkubGFqRytYm/PUKMwzW5D0Lmo2Jde26akDGL1WyBPb5ntqdlv7hAWtmR
	 2S/VCn36N8Rdnoc2/IAiE3ZjHO49bx7JmVM67rzwcKZnGI5i6/uu+1De+F+ZnEl2MW/cW
	 ahifwrNqbTW1RoBE/SW5n8aqO/5bx3J6nRgfT1xVEetknjIrZR2QdBm0nuAjKzOR28qIz
	 hrW6r/QWBVx6RLUARFtJQ4kpFX+lS93tXPpvWF2AQ571rWsL+pd5uxDRCFEUAueeJm38J
	 OY7ZreFICE0sS9FXQe5hmZ7tradivcRCmH4npKHZOuxBBpud9nsX5t62jbhzchkH+Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hFHwL0dJHfEmg6WJ1ZYqq2RC1KHegZZ+9GEzz7lTf8g=;
	b=UI7hgzE2aP0d9xrfA8o7+dUvLWeclpDBuia8Ec6qpCKCJ88tzkJ5EklwulfP63ndHmoN
	 WwkSjW/alokvzX5rQ/lhntIfSGkY8J0aCW1CZUl8/Mquu2Ss8mkic+R+QprYKb9tV2cl5
	 lPaHZgZ5mIDzvho2siFXT+8+I3Ewr/Om+14HQZ5D3CjBF2zlhj/EnIdjJ1BUiZzXUf3Rq
	 YwTachB2qhYBdef9QoQJbSzmJKcasxhzvYAaTH41FbZTeGF7Td7emjYjOf7ZuDPO5VsW5
	 nQPOqHL/LHJ9dIplQB9q0iU9+nLne0k3FrLXPfHishVtRqedGnslSAnWDMRxpSUcoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=a6f7XXeI;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF02606A330
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF02606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=a6f7XXeI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=hFHw
	L0dJHfEmg6WJ1ZYqq2RC1KHegZZ+9GEzz7lTf8g=; b=a6f7XXeI4EbsDhCBF8mg
	EX6BluFyS6AAEdff0oZDzmNir0+tHKQfuoo9Ud2sFZnXmUqkaDEenLfPyMLoVwQt
	q9jxxpbDOp7Fe6Ie4a+IRFfewMG9IHTvnGVAgG0YFvkYVD02XuYl7bbFjToGH6VZ
	MC1T308y/oIwXKHChAX8Hvpo573ARyScH8pNA9GE+OEH433phKGPavS0PSlR2oCR
	lzl0YfbXf3+oV4J0oPwBp3EhjPWHkkfhATrc9Td5LkXy4YuegozzUle2gKLAaK9g
	aUD5estbCHMNCuTAydnLrBZb6ldUjle5Q+dYJ3771VHcZHXVtbO78xnP+5kAewtD
	kQ==
Received: (qmail 1194292 invoked from network); 16 Nov 2026 09:21:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:21:56 +0100
X-UD-Smtp-Session: l3s3148p1@dYeTeGBgHroujnv5
Date: Mon, 16 Nov 2026 09:21:56 +0100
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
Subject: Re: [PATCH v4 0/8] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
Message-ID: <avq9JH17YzYlO3Hk@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
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
In-Reply-To: <cover.1792163045.git.geert+renesas@glider.be>


>     Describe hardware in DT, and perform mapping to abstractions offered
>     by SCMI in Linux.

I used this series in multiple branches as a base to enable further IP
cores on the X5H SoC. Worked fine, so tags for testing are coming now.

