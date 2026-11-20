Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152507;
	b=4NCt1D1qMjLXK5h0DgJ6+z4ahzoGvBWmYNaD+RfEyfCfeLP3/dtdJvyeVTGex1yjKjUD
	 GxQTOFcOWWoTIQRMpuoWHDJksTlHK0XVNXcU4HeyOnUafCg7ACI4arRWAxfFscfzMQGtj
	 RnCIz466JjaFPmVyKDcju2X2ngLfnyQsGG3VbDX+8te58RsZm9jANSezqbJoQA6p18EsF
	 eQJJt1yga3xOOiizW6ti47SwnW5WjlgeNQ8rgiTeeGDZQr06yGhjK1hGWa/nedYbO2Xiw
	 D/5zyGHGuLsfw1Rdt/3klkPYw2kv61OwHOvj/81yDVFdawWJ+b6y1V/AIaZq2H1shSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152507;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=WEAQeDdttdbQETJGcnx9VoAq4ig2AwjGPCEda+gTOGQ=;
	b=OqTLEONIBZgC9wts5petQKDIDgzZgvBEfLX6KPVA8I+fz8XzrLMHOIovRfAp7iRKmOph
	 lFnGqWOA4cwcgQK22WHlFjWJj3+hRbNbx2S45Vn7x8qm0AqkuPskhERhRYmRRBp42EdRr
	 T3IL/LRIm3OZG4gz4Ct26fgrkh+Hn/tc2CZrwQGZVm+0cNHySs8dC3sQmCIEZXsutp2pe
	 Lrk39xWha1u/aC6REfVqIw+5ouJ1zsQNNTQtLxkK9Wc3bXXbuvyqnkFERB+gUppQQTGCe
	 ujWYGEnCB1sKan7P0fRvJsLp6Ll77fdQwnGfvnXCb2WjC1cUffTFVgm9ZP6EVVbjaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="sKxHoD/w";
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406E606A32A;
	Fri, 20 Nov 2026 05:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0406E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sKxHoD/w
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jW3lQ0xNpzMlPN;
	Fri, 20 Nov 2026 06:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEAQeDdttdbQETJGcnx9VoAq4ig2AwjGPCEda+gTOGQ=;
	b=sKxHoD/wkyhiKEJN2+3QmTb0qDvBrxW1HdvWzxofGKDRkx7niuPPgNjcczay04H6pg1lzo
	ol9cvS8Kbpl/5Pemf35AL9pgP29UzvKg4ll2tlOTTybkIP3vHuMSfgUPgzLb5AgVEg56SH
	7MtPaGCBEYLDbYk8Z5zBj1+oCNmU1sj09Zp3Eayom7UOsMdGmicEGxtCQWec4J++I3o1x9
	b+26X8fsDrfZ4QtYzawBYvHCbh4qwLwhxGOYXr57IMxStv/ap1R75vWahfo9RUq5DIsdWq
	x0QI8vk/9D6rS17cwmtPlSswW6cexjLm8mKetoqw7wz+5eMCm4MCetOwRg311w==
Message-ID: <57d2cc58-15ac-434e-ab40-7a8a54d93a1f@mailbox.org>
Date: Fri, 20 Nov 2026 03:57:12 +0100
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
Subject: Re: [PATCH v5 01/15] clk: renesas: r8a78000: Merge debug prints in
 r8a78000_clk_get()
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
 <cee843b319c9eceba2339f14a134e305a2b05d7e.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cee843b319c9eceba2339f14a134e305a2b05d7e.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: p1aubxpjti7wzrrdeoih94dcd5ndsxbz
X-MBO-RS-ID: b4229e44a0cdd305af8

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> The two debug prints in r8a78000_clk_get() are very similar.
> Merge them into a single debug print.
> 
> While at it, unwrap the (wrongly-indented) continuation of the
> r8a78000_clk_get() function header, as it fits on a single line.

It might be worth mentioning, that this now also uses 
clk_hw_get_name(hw) instead of map->fw_id .

[...]

> -	dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
> -
>   	hw = priv->fixed_hws[map->fw_id];
>   
> -	dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
> -		clk_hw_get_rate(hw));
> +	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
> +		clk_hw_get_name(hw), clk_hw_get_rate(hw));
[...]
