Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803908;
	b=Au6nIWpd1kt6fo4uEdawCGuVjF1I/OQWVqcEMdv/DP02WMaKP05EK4upiVBdZZSLinWb
	 breUo3yXuYmbx536rcL5AWoaGEmAScWGwPJmIB2UlvWmJg54debuaVG3K6HfZv5OYXC6v
	 vwDJyzjXYgsSMobXOX3FriBHlQy5tutcYynpZp5qW4jmnBnKcRYbFefZEpllr+zmV4EzW
	 krK7vbIWM289ZOqdKvJNy79c80NUtv10Yk+izhTsmaY+l+asBuQrfxKO2DKRDvrZH36Jz
	 QShd2S9/WU0IBF0JUby/l7Rw8JXq1G2SkVsQEBNOINoafuMAde9onca3NJIKE0jv+7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803908;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=nhYYKORTR+/BNUYkaM3WAO4aIQzSPeOEyfSMlfBv7+k=;
	b=eZmnKiKfgvALBKifPzuymRVbhoKec+7QRIrCIc+0U7OuIJpNV+/k0+Cby4LKE2q1/gU+
	 4SsXipincuBEaLWSji+ntdUopHvj3VlFZwDjs5Xhm//6+HH1YuQhx9d03cW5p79/m7SuV
	 JiD6T59DRpjI1MUpJgBmq1r1+ztGqF11K6KI1hN4l0f72BqM9Xz0jxvp/YkvVmElSJflq
	 3qlNFYEcP9GiS7GLkaES1vuCdmR8NifI4wg98CpRNDlPIGSTzPl619C63OabsXhS17dIP
	 GYHjeZC2mMU5BKYmHYwC17WyXnJhVExDUVwGQcl00OcW3YPBx8QYPXmGgR2i4BJhhIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rp0o4cZg;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0195606A321;
	Fri, 27 Nov 2026 18:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0195606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rp0o4cZg
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jbhfR0W8sz8vb0;
	Fri, 27 Nov 2026 19:25:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795803903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhYYKORTR+/BNUYkaM3WAO4aIQzSPeOEyfSMlfBv7+k=;
	b=rp0o4cZg/2LoIO1Q3s2bGCHl0Aon823Hf088RxGd6yK0MGZt0OcgEHQyZ8sPv/bU9JRYhC
	qfnbtzyR0NSsKumv1eWkS6y22w/gphMewwv47R1gJk07iLtsp/FHrbmnTm3wsmGibl6682
	AB7m/c/rSdKsxCj7EVhQXuOcTdBL1Jg4NCfVCTSsOZDMnx6lWDFEKpjljbhE/RQ7/+YMeV
	nr6R4OO+cgd8IDbsU8hyAuExijEq1D+zcY7LVNMGKNH5hKOT4UQ3VCqaH9K+dES520+O0c
	zv/tXwq6+iJm2zJFx6THtVHP7g/ytNNUCEcX72NJX4FNmrF5vBCiD/1CP6LXFQ==
Message-ID: <0e44d7dd-eb49-4c47-a43c-11ed90c96bb0@mailbox.org>
Date: Fri, 27 Nov 2026 19:24:58 +0100
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
Subject: Re: [PATCH v6 01/14] clk: renesas: r8a78000: Merge debug prints in
 r8a78000_clk_get()
To: Geert Uytterhoeven <geert@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
 <7abac4b033081657e2a9870182bc06f5a5a02c0c.1795796064.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7abac4b033081657e2a9870182bc06f5a5a02c0c.1795796064.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cepmxa9jpmdz5zarare85p9sm4r8pee9
X-MBO-RS-ID: feb1e7b3c69ed64ac80

On 11/27/26 5:26 PM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The two debug prints in r8a78000_clk_get() are very similar.
> Merge them into a single debug print.
> 
> Note that the clock's name is still printed, but its ID no longer is, as
> that is purely internal.  The printing of real firmware IDs will be
> readded when their handling is added.
> 
> While at it, unwrap the (wrongly-indented) continuation of the
> r8a78000_clk_get() function header, as it fits on a single line.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
