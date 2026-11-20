Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152508;
	b=wAhQ8tyoQbySJLhal511VOk+qIW2owdeZG21kxfqm8fXbeRELCODDP0feNtTkb4wV/y+
	 yC9IFyFQDEI/h87oWVGyzdeJeJDA7HDGnEBlH5IGC4Gqi6F4m5bn4Ht7WIj/d1mMEGspg
	 ar79SRjOWuArbfdQHqA2V6JJkbL2SFIBK/BJVyTTUGyOtmHjdbHMwlmghPFR9lZUjeL7D
	 aGok19alch/kcGRg3bSUBIIPeOXVLUSpb0hlxGSI7Uq7YtshIp8aySs0zGvdaaSQ9U9QI
	 ZmLl62fyZ8J9WOjrcRRlZo7OvqVMCMmvXm3cjpNmSBzil976amMIZRglJ8If/2fiQRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152508;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=QiRKkDBvuknePqASdttvShwCcaJPDVp0cuJzJKewu58=;
	b=T70bgd/64UtfeSWrgY7w5bX8MWyimtfPJPAMhlgr6wsoLIn7uam1TPIO1dRkxA/7vKpo
	 A7BwYyH/bOEmsrZIVXcAl2JWbJCQtXYKPbs6Sbon4DH5/pbVxWiMwXhPmDkB9nQYfvpaI
	 rsvcUqjwIcTETQ+xqz6pfs3IfypLV0+GPNVrPuCdAtpvZ/N0IQmwbaoTP9GkLR6+8lrEe
	 4VPXAvRGNreKkH2hVV1GL2OL9RNeXZm9pzEAMD5rXBeZonEd2y3V7Zk3FLGv8zkfacJ7R
	 3S5KGIrG6/x3/gyZ12LOgRUm/wlfZ1KyvhsvJMAODZolav914y9aOSr2p5uWyPku85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=M1BWvhDx;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8303606A326;
	Fri, 20 Nov 2026 05:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8303606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=M1BWvhDx
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jW3lT0T85zMlw7;
	Fri, 20 Nov 2026 06:28:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiRKkDBvuknePqASdttvShwCcaJPDVp0cuJzJKewu58=;
	b=M1BWvhDxOIWzM6JJYzNapCITSinXxXVsB7lQ+r3am82uefmqgGe/Txe447mz8kY2lMU39m
	A8opXjH65Wl/ngQubi6HkNa0+b3hpoHn3TNzh4K9X9+UksBDGrb8ubsQESmupsUIYolFyS
	lc+1pdo2H7PyD4XXXdfhHzImN/AjVqqlWoANYe5a5oOuRafbj/3CN8HXURgmgYWe5CbeuE
	3m8rHnJGRb4AwKagCmpypPyAz3PGq3PZhcs21quSO5+3axsQw2eEIZRyIOK57STwhi7ZbM
	g97M9GFw/xWhbiSqy0FeqzrvvkdT6ypp9VYW5ot6KIp6piD/xqxL8L7NmfCf/w==
Message-ID: <5eef011d-6854-449b-b966-492845b076da@mailbox.org>
Date: Fri, 20 Nov 2026 04:02:31 +0100
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
Subject: Re: [PATCH v5 02/15] clk: renesas: r8a78000: Replace sentinel by
 explicit ID map size
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
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <bf9d3d694fc06f29819b6883610c0e86c2d0066e.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bf9d3d694fc06f29819b6883610c0e86c2d0066e.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e39709493eb8c2445c5
X-MBO-RS-META: 3a5to1sqiyban871qj7neoimkfzs6ycg

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> The use of a sentinel in the clock ID mapping array will become
> cumbersome when the need arises to find out the actual number of
> elements in the array.  Rework the mapping data structure to fix this,
> also improving naming.  Add a CLK_ID_MAP() initialization macro for
> brevity.
> 
> While at it, drop the check for "!map" in clk_id_map_find(), as that
> pointer can never be NULL.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

[...]

> -struct clk_map {
> -	int dt_id;		/* DT binding clock ID or -1 sentinel */
> +struct clk_id_map_entry {
> +	u32 dt_id;		/* DT binding clock ID */
>   	u32 fw_id;		/* FIXED_CLK() ID */
>   };
>   
> +struct clk_id_map {
> +	const struct clk_id_map_entry *entries;
> +	unsigned int size;
> +};
> +
> +#define CLK_ID_MAP(_entries) &(struct clk_id_map) {	\
> +	.entries = _entries,				\
> +	.size = ARRAY_SIZE(_entries),			\
> +}
I am surprised there is no generic ARRAY_AND_SIZE() macro for this already.
