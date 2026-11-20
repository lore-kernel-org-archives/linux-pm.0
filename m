Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152525;
	b=TyIpnzwW4BJiMX4Z1O7Nxxy4y0bDUu2nHakAZqRBpDywmQo9qfjyZz4uOvS/OyviVzds
	 Pn5mxZA6HWP7guGL/Q5hluJco+ddnGAaSxaXm2MtEgy/3m7JPuAdOFBAzznbBGJsrWwj/
	 On/VaDdklRFWqjKvdWIjiC3Vh2Xk8NJCp3URrN1vwBYiRGgfIeVso0QGR41XSrCyA4E21
	 xypVg94Q/MndYhbT9AAoLPWsQoQgY5AoWuos74zoivZA6MN0jVNtp6Vy0KY/uGKZhFzDg
	 u7yVt7kX/DEJizD5zF3Wz9lOOWNE3NOkZ2UQB7J66YXxV4EJJXlLsl4CYL1GVvj8Drg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152525;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=J2OGnbZI2RyuSc7mFDxV7TFFnaltYUWFL9MIdYgF4mU=;
	b=XxhkGQME9r7/zGkOUPpMih5t8h/MNosuXxLkfAezD9kFgNqPS/lKy3S31jxbgLiyQEWo
	 Bx0JCyDpLe2d8VlQDezo0GhPHBxopXWodBHi7jm3RjXWTiC1Dy9/zDX8VyW2/r2X+nofU
	 AYfHDRFoQ29Ey7WWbamuPfdZx61nC3W4MUPucy9lZ0UmzCjevF4jpAji3ghKIVsacyN/S
	 y2RTq+JZplG/KKTw/8CUqr/oktNMwr2G6D6tzrcWk7c0RiY3umNPxV40ZnYtjZddyydGN
	 34/A6v9P1Nw0mmrvIVbrcZYVRM/NxJrA+ESMqOmj2iArJEsviAfRwcobaqZ1wP6jxkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=fSP1q1Gq;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AC606A330;
	Fri, 20 Nov 2026 05:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=fSP1q1Gq
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jW3lh5G1SzKnpn;
	Fri, 20 Nov 2026 06:28:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795152512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2OGnbZI2RyuSc7mFDxV7TFFnaltYUWFL9MIdYgF4mU=;
	b=fSP1q1GqB4YSd3yYZpZD7CoBk3OXGzxXXVYV5tFve6hGE1nuB4TZFnGKVErFNRvpVqNXR4
	WClS2aKJwimDXHWHKm0uW85Z339XgdeKzNQe26FiIW6N/jIUiL/BojSFiGZnEiScXnFzSW
	9UTA4caaPFqYl0qoppEQo3Oxhc+u5yrq1kDB1zxL4zkgocgjptjGh9OqkJx/C4CkbgD+WU
	aytnZl48P5hB9tI2k3TgwAoSyPNeKLOoeDU6xfrTGa9RGTgCRh2wAVW4mMWt44cWRQzcEM
	KWj/V6KANVEneIwSy4PNhFNGf0Q+FGPz43WnILOS0Et6nBPrKO/Lz73ZT2YCYQ==
Message-ID: <702afd88-3383-4f6f-9a54-78cd95a80c30@mailbox.org>
Date: Fri, 20 Nov 2026 04:36:14 +0100
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
Subject: Re: [PATCH v5 12/15] pmdomain: renesas: r8a78000: Replace sentinel by
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
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1795029012.git.geert+renesas@glider.be>
 <ee60a54c457af21277a13e8e1db36ce83209b3f5.1795029012.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ee60a54c457af21277a13e8e1db36ce83209b3f5.1795029012.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0eb81db9691d4bba056
X-MBO-RS-META: jtxh91mtydrj9pcr6axxbzggtj71f7wm

On 11/18/26 8:45 PM, Geert Uytterhoeven wrote:
> The use of a sentinel in the module ID mapping array will become
> cumbersome when the need arises to find out the actual number of
> elements in the array.  Rework the mapping data structure to fix this,
> also improving naming.  Let mod_id_map_find() return an index, to be
> used for indexing additional mapping target arrays later.
> Add a MOD_ID_MAP() initialization macro for brevity.
> 
> While at it, drop the check for "!map" in mod_id_map_find(), as that
> pointer can never be NULL.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
