Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152510;
	b=QKLAKeWDnn9d5fr7BuYDYa6E3gqNtlVTmfQQpw8YebpNGyU5yMmRH73fhJvUs1/bdM6K
	 +isyub8zEmHmV1Vr4uVf6DIsdd3vGCWzoxH9eqVV01WkWwrCUlSyndnaLtAOQjQg2TUZe
	 kjFDig25azpwCu1DpWr1kxjkLsXHQ1hufvSJdLyenQq5Unj/GiHPATHUhGT9MfzqosAig
	 bVCl8vwcIjX4IaK16WyxRuaVuWrIqrCNeC5Zo1k2LzjEFgSJRsZ5nO9fAqDgFSRKSAG6U
	 xxUf1YR3UIuZYfgSPC2WXxxyOrykWq8b9beJpSzBUvg9kKCcmfX6Xo2VyGFXmuFD8Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152510;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=ktwA9f728ADGnZh0rHg/RvlUSt14br3A/RT6n9yqOtU=;
	b=f/KoG5zYmpNaHhn5GUy49xmNoWqNTlKLrxxs0Qe39YqlFC5qkuPxaAzFkHKw/zbMZtvd
	 fSvzdsKywEzgvNfOa93HNrKuLf9hzcZIesVbdnYiNO25MiYKRb5nT6U9JabDMCsK8jqsG
	 nr5v+k5ghIgqjGNCG3f0EDwU8ghmcjsVgPcQG5EQhIyRK1KjDOAT2gaHtClDJUFL0NfZn
	 l29YEL2jTowcOD3iLLiDtWFPSsIndXBKmgr4EQOmtdGUdAgtFoDUbZvQbLOASalyWProL
	 tpiLl+FieFhW5dLalvjtJJFvf48YeAA8FtV5UkTGL488kuoEyOARZJ7e0AdCsjiwX5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=d+cB7s5v;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFF60A2605;
	Fri, 20 Nov 2026 05:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BDFF60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=d+cB7s5v
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jW3lZ6Nm0zMm0t;
	Fri, 20 Nov 2026 06:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktwA9f728ADGnZh0rHg/RvlUSt14br3A/RT6n9yqOtU=;
	b=d+cB7s5vSc0Ju2BUhKZw2EJQSvXt2DlJLe8AXuC8OEu/dGDLN8xRv+oEDqU1wcvsMltiyD
	yXWFXZSkcpJen5S/fC/0W4VI9OyS7mIEL41BhITrLrAbBM3+Lnp9a74orZElk2E+nuVxd1
	bN8dhXm9Phk2kh3hLIzE/nY1HXCqg/EDWjWyJjwDzlKUDPoS2uCQULpxs8dVU25hpXZBzb
	UlvpNF2nfBl5mRGHK6lo92kyCybSyecJiAY218ztQiUFHEt13rm5DBpc8uoGy1djMA1Ug4
	+Lvoz3hxi8fB9TvLMwg+JJNNQYNgLNLDS1vXFryiGSKjhJq/DcYfaYYB88rnSg==
Message-ID: <c6fdd13f-c6a4-4f1c-8ce7-67a9a9188880@mailbox.org>
Date: Fri, 20 Nov 2026 04:25:36 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/15] clk: renesas: r8a78000: Add clk_hw to clk_map
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Paul Elder <paul.elder+renesas@ideasonboard.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1795029012.git.geert+renesas@glider.be>
 <ea85d72ca37bc7abc59fda5aed4b8272578922c4.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ea85d72ca37bc7abc59fda5aed4b8272578922c4.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3039c6c76c8ba923bc6
X-MBO-RS-META: cxsu5st74xt97hx6y5nqass9aoeb547t

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> Prepare for mapping to other than fixed-rate clocks by adding an array
> of clk_hw pointers, indexed by the clock map entry index, and populating
> it up-front.
> 
> Move r8a78000_cpg_priv.fixed_hws into get_hws(), as it is no longer
> needed afterwards, and drop NUM_FIXED_CLKS.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
