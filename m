Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926640;
	b=AuZZO3B6t60CWdluK3Luhvy6xbs8/siE3uCoE/CyB9/fnykXGGoxnlMvoP6+XZJbFohZ
	 bq1wXrCPjd1F+NBF2VYhRq6IMvl8pmmJrXD+JinULCdhsI3SgBf5z+xllak90Os1qkCRF
	 m0lorlriZmVAR1U6t6FK8C726n57eNGqogH2+UCuQvs12cX3LNKZ20juDq3ubFFoUREGh
	 L7cOCY1h77sX0MOuQppaV6Mmfr1sYC9yiE9lB1X8yasMB4j3WF9rtVYbhgqhqFP47/P6d
	 epLE5SRMymKtyh6gvXwxJwyRZLdF/rhIeotIcDW8RfEJWgDeuCPSZLPT9tYtO0zA7xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926640;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=knN5k0t0huH/W+V1r2YAeIUG7lCZ9Z1adCqmN3gGZ2k=;
	b=oYU6ibXqh+8ntKCnFNHi3PvkbcrntLOzH2AQy3p3YIAQn8+LvhbMlFuoPbhIN1AIDMA9
	 xk+U0icqbDfL9zgAlPdfhtJZl097Y7IdURGb7tWvVV8meBUpdZpxt8WlFQHX0R+98/rqY
	 EY4+QlH79Lm0gDRV7HfdqwNze75qQ8fFQSGEI1jdp9RHms8Wc9V3VkO+pe2AW5rACn3yk
	 wfp1fNRQA6DleIDJyXZaCbeSHXXuFNtV3VtVPIXUhjYCi6WciOgsCyE6xoP0SQkKTvpsi
	 mJjXPM+F5dKonz+L8VwKnh7OwVQq8kzOZHuGFlUNTeapIKUPSV3aJ9VWGNj3L8iBNDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=EsYBJW2S;
	arc=none smtp.remote-ip=109.224.244.121
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688F606A323;
	Tue, 17 Nov 2026 14:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4688F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=EsYBJW2S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794926637; x=1795185837;
	bh=knN5k0t0huH/W+V1r2YAeIUG7lCZ9Z1adCqmN3gGZ2k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EsYBJW2Sm88Zu8IFWMCs2bL/W3yNkKIOw2po0Nudr2gzfOVV6uoABjReHAVp+tiGz
	 A/4INdb4KObGgD20HjThCTZX4dtcVXOaitixhmpIhLtAKWiZsu5B81R5AeqegkU1gs
	 bQqr6MBqjCnlpDixvy+T6IkXUABPspwRI7HJ8/LYldm/kJc8DsWQLm6kBXoiPHT9xJ
	 8yASBuFGP6JZpk6IeIZ5Hj/tMeAO6LT2gkxrtiTyoevca3THUu5PAqQ8++TQdCWADN
	 mBI6B1etcEvNCwnACDv8CHaU4eZR7UOshIqSE8lGQfe6HNV2DiMwJd/fxvZdfA6y7C
	 h8B8onFMwGjZw==
Date: Tue, 17 Nov 2026 14:43:52 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v5 3/3] ARM: dts: mediatek: mt6323: add EFUSE support
Message-ID: <hfElNICOLYWph6ayG04s_yQbkHLXmu6qzdWeR5ObRNxVsBtq86bjnERSJx427OwwrZYipLAOrUGBU8zvYtXEV1ixQ3YBzAZYQ3ypouA66T8=@protonmail.com>
In-Reply-To: <20260921-mt6323-nvmem-v5-3-2f5d308369f0@protonmail.com>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com> <20260921-mt6323-nvmem-v5-3-2f5d308369f0@protonmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: d6eab4eb4da4fb8cc3577e6a0760d480392e243a
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

Could you please take a look at this patch when you have some free time?
All other patches were applied by mfd and nvmem maintainers. This patch
will be required for enabling thermal on the mt6323 PMIC.

Thanks,
Roman
