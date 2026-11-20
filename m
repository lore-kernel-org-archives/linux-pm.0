Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152525;
	b=J3nDBxk/nNsKwEAOtwni9L2NuoBwcMB9s9I3tA/Iid/3EmStE3ei9sZhHfdr7PAxreD0
	 Irk0SSvAkW6jrCy+ZFF2yMq/mUmtwlTvCyyYESy/en4+40WC4TMcnaD3sztp3CTTc6bfX
	 dThmFqLPTraRHr44nUZ2hduohbvBeYyfSy45kOB4fT/CvkRsq8xgy+q+Bx75aI1Q/bBA2
	 3rL6ck6CI5abpG+VPL6nnZqVB4LO8QJSKspQcMwv6gcUBjeMuaHyjSHPNyWood/9ZBwGZ
	 ibu28Pq4A8VIqeYfCP0YXfr5ambqLI2tzagMU0oCIf7w9Nu9ZMD2YZfyE8HGuFxOLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152525;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=PIuTf7+5J56AFyd3crErUpwtWiPoWrqwXFljock3NxY=;
	b=WuYhrzdsWuvT0C6O+WtBG4n5CulskAX55m8m87UlBdw7doqS9RqbM3naBJUgUWBmgqRn
	 KUEGVbRUrmWGbKDWSAArQGXieDkzKpUiAYEIhkTN+MbPFWg0SoaHZWL+KhqYVJZaCy0AQ
	 e11KcECyS6KB7Jk1Uoh3mLsHHZk7qGKD6YLx8qVPgxLRP5z7y/jBQ77jqyaor+NoBoQkG
	 7mkZDKXnsCwTqEOKOSev2+wypFMKOTvqDV3ZMTc5uoton+rR2wUB2cEAZLhEQQbtZZi+v
	 giXgUS9KFvBdi0+J6ug1XIYy5LIFj7I2CLUWKKW4a3wwMxxWuTqy2ytCqIJoTmI1fdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Rbwjew9v;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF9606A326;
	Fri, 20 Nov 2026 05:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Rbwjew9v
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jW3lp2GZdzKvdn;
	Fri, 20 Nov 2026 06:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIuTf7+5J56AFyd3crErUpwtWiPoWrqwXFljock3NxY=;
	b=Rbwjew9voIpJdh/2NTOoq0OwqAZVDxc0VVGu2Vw2Tm4MgTBoj9xAp3Ml1QqGp7rGxN/p/4
	D6hd0TYK/8aqOZKIctFRr84tZuoe+M6d2dCF4lhRGg49cUWMM37YRWYaDoNrsRQmwHe7Xu
	g71Hm2LRkE3Sd+DkLNNh7FaiY6Q9cBzTbMM0ICk9ss+zwxxDVA1NpDUtCkcb03haXL29m1
	ijSJR3F4OXKMdnh8J5N3Ph2qosR0r4VpPZQTRkxIcYwEX87RdLa37B4VkuirK2DC3IKpgN
	Yy4hNCfG4a6+hP1nNb8K2SQhMMcfkygCRyCW1atolJS2Vg810wR+lWUBB2mhpA==
Message-ID: <4b1976d0-888b-498d-9145-5b40816c95db@mailbox.org>
Date: Fri, 20 Nov 2026 04:45:10 +0100
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
Subject: Re: [PATCH v5 05/15] clk: renesas: r8a78000: Add SCMI remapping
 support
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
 <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e01baebc546ed6f1b71a0487a59cda73239ea7f1.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: x1dd3wxhc8pm454tbutqegr9a86gf3uf
X-MBO-RS-ID: ec5c21a69e7f313cee6

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
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
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>    - Add Tested-by,
>    - Rebase,
>    - Shrink firmware clock IDs to 16 bits,

This technically did happen in 3/15 already .

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
