Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152509;
	b=yHKRcHWeCRlN2x34/M6E2gwTjYyIqRCs1EkOayiQLhpAmOemtsXklq4l75fMYZvzXXau
	 g09u7WRKQRuTmy/GkgxsOu5rj8tWJkeNWIyuh+nlJSX6mmTYxbVRvuHUTo+NI+Tob4fXb
	 ZBwl3uDmicOG+4GPLwdqCkGQwKE+xzKPCwEik2VAPEbXHOfWLzEAdD44UcOIxj4QuNRwe
	 hX4zs/jonNVVJjf8pOIBfTQ4ttOG1uNkeVc1HiNkDp3Bevhzh8j7BDRq3rocm5vZZJER/
	 NJN0e4a2vfmCoDemR0F/413IZ11bn37Az9wS/P7Wv0ZrieFweEWm89rSvFbE5Pa5iqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152509;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=Hh8ZsRy7aultI846HqBBVUUDKElnSvBqrBJ+TAncoeM=;
	b=iCis2+CMB0zMnZaeyFHhLgRcBTOrhGNDXLaWC8LQkv8USZMh6+UPIGkMLH4xaL1kaoNn
	 hhEr5u+krJWEzGuigZFh7/tN5dcosXy1CUV4R9/cly1a66KPuUWk5IOZjq2Y/nJciL8bq
	 UX0wj6h+NFYZL9Z2TrkwJszBakTTmTVlSsfVcQErmtLEjXW9/qkWRdATlSuuuKzQRSQm1
	 k7COwRK20veJjq4BR7aNVtVhVdcKLY1rvNkunLyNMyFUVfigzAyLjn/T7cGMXygYmPIQ4
	 FYVSlJUH9iAmtBaBJjVNBPqo0qN2SF/pM0gUK/ugm3FsfNF72qVa4DYonsmy1jOjsFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="S//Nbgre";
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F160A2605;
	Fri, 20 Nov 2026 05:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60F160A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=S//Nbgre
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jW3lW5rczzKr66;
	Fri, 20 Nov 2026 06:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh8ZsRy7aultI846HqBBVUUDKElnSvBqrBJ+TAncoeM=;
	b=S//Nbgrek1uyJWrTIgdRvCsvQcafie+GUiWG8cWq0rojWnBa3EDNk0XIoGzFoMccVlX5QQ
	Pkdv8Tt+ns7aXp1ZT0LoH0jpX8syV09b09wxarJuZrQQVWZfrv0f9IapfEKppQ1Bfus4z2
	vZW1btP994ZYm/XLqtcxbhgZIFrFGubt9cRmUjoRewg/xOHOep0XfvVl0DIawEwMlVsETW
	LsjcsKFtwh9h3ET42AudatgGom3FVFAzC9WdOJhU8JParwSJksIS7KBC7/j327vbFzp4/b
	mJ/nQy4djczNMqK9EdEET3mKVTCeqObyhHTfDXyODol2t0Cn6M+iNHPD7RhWjA==
Message-ID: <49708c93-6a47-46e8-aecd-2f3062ebeefe@mailbox.org>
Date: Fri, 20 Nov 2026 04:04:07 +0100
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
Subject: Re: [PATCH v5 03/15] clk: renesas: r8a78000: Shrink IDs to 16 bits
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
 <066c0c074865c2a8684f541c3513b8851f3b09a9.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <066c0c074865c2a8684f541c3513b8851f3b09a9.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2dcd620831a64272c32
X-MBO-RS-META: usna9c4sctagpaokyi69t3odxukkp1r8

On 11/18/26 8:44 PM, Geert Uytterhoeven wrote:
> Reduce table size by shrinking DT and fixed-rate clock IDs from 32 to 16
> bits, which is still plenty.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
