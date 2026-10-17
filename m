Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E373C0A03;
	Sat, 17 Oct 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258447; cv=none; b=e4Uwz6PXNJmhKhvGT5EA0ZiQM4hLV8K1xblfRVgyttb2N9fK5YE7AQojh27aCrql44sHtlPHAnHiT9x5CFWCdsNAwgGDzrPqgp/U4PU+BoavhuPwjTtTOymTPgn35wrNBljaHjrp3FcxtxO/dJBJT57qnB4O/yEsVgxzysj3c5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258447; c=relaxed/simple;
	bh=TV5zdFiWq79YVW8YRJIsDSfsy5MxTfr/dcP3g07JtKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSxeZ4mLSyIw94NazeyVNc7Q5eINbG9qrgOjrTNaUR2qixB6rkEccIpxtseHe94hBfmzlfO+5thwFzKiknHcRFX5tJTxX6uGuFnG0nA/lisJpfst3uVim3FjDfuE6s3XmNUQnVNnDRJE8jKiQkxhQuZsL3E9PEYhDLLBq12rsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ef+FvwkV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ef+FvwkV"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TSV0mK2zKmy7;
	Sat, 17 Oct 2026 19:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flMBGY41EGoDAI7ETuBnT4GorZ4XpKflNGkIAnWjCZo=;
	b=Ef+FvwkVgR1R1J47Lb1BrSoIDlUiMg0nlJQy3kcjnzuFdESYRY8UPC9BXAIC9uRxpIoN0x
	xgJeIL1jUgnt/B1/fG8dXbzvJg3fanJlzRqMKJbHIbizCVkIbohYG6JLDD9W+RxZJ5XZ4T
	2bH6Pnex+Bzk4QprghZLsa9eUbDQUoDxqWqNJTPAVx1G5j6DFoXy7p1Lp9H3u4pv0AHn6y
	qR6RjY6RnXZwOpF2xT3E7aFwcZ6W1OzF2SCNEhavKrxLud/Z/V/4MarYfPPMK7SN3jVkkB
	42o/kFKnKkezR5P+SC2ReZfbEawiBMyi6NA/cmz4OdAgbPiHNgjQ76I3hPbvuw==
Message-ID: <51d8ba05-76e5-45ab-91da-3c6cb02505d7@mailbox.org>
Date: Sat, 17 Oct 2026 19:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
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
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1792163045.git.geert+renesas@glider.be>
 <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 19b5cfb291ce5ddd7a6
X-MBO-RS-META: rcst5wwoaupxhedzsu64aao9k3oaqo6b

On 10/16/26 5:55 PM, Geert Uytterhoeven wrote:

[...]

>   static int r8a78000_cpg_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct r8a78000_cpg_priv *priv;
> -	const struct clk_map *map;
> -	int ret;
> +	const struct clk_map_in *map;

Super-nitpick, use reverse xmas tree ordering here if there will be V5.

>   	map = of_device_get_match_data(dev);
>   	if (!map)
[...]
