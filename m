Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427859;
	b=oB8/+R5IlUmzj7ExhNEaae8cHdu3hY2BRcC0/Fb1w6pgyUokeCZTInv9hkycm0BcE9lG
	 SBycvHKeVIlEbl3gB7f95X/zoGtqFrhcGNh4vnHSyC3mch9hDjDaiGoJpqJd9nZfZu4dP
	 gcSke3Z6ruNVQ88Qqink2WRYN/wNu/KIuibv5doD4WGb4VStacQDZ0zbtox3r5/e2OncW
	 IttNnKIHbApNF0R6pGQ0x47zjgCDopL9YoKYoCIWSt2Ms+2ikJzjAnCZSvgRrLjGIFeEI
	 PYvw63Bgg9FPVxpJ67Njv5Zuwkpn/B6MbCeJRLvQ3fdy9esCiov/yKkfFTDHi/B2tNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427859;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Nql6qrrofIbpZdBZgH5BWbnDX891MVZZ/HtdpF2Gl2w=;
	b=kBnuHtSAYNuHaAQKSSn5uOw6cBv+xbhaXaBX2CFMammWXqs5tVclePdKfndoR7sreLBi
	 7gEa88Ne5TonAdu6Qxqh2GVH5DPwXjYCyRVQJbSDMaUoEgO3veIJEHnDcyji+PJdQMPro
	 KqKRWeWxUdzByyNLFmizijUWCJMBNnxweMIAhCpIdPZ+4tfYrQ9mBC2K2lIceBqn7ZLWj
	 TtiDNqZIzaYbxQWadtI6ZtsNpVMXe4corDUHnBuDpJyDnrZURYZT7xmsHzEfFhurzj4Gv
	 wUeWzJH2UeUqKtJaFfDeHkFGezt1rXAqG58vhXtkU306Y9qa9lFEIhlbIEwGM9nNREw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=movRfAxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF6606A31A;
	Mon, 19 Oct 2026 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=movRfAxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADBA1F000C4;
	Mon, 19 Oct 2026 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427858;
	bh=Nql6qrrofIbpZdBZgH5BWbnDX891MVZZ/HtdpF2Gl2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=movRfAxmSrdAuEp5xO0qSwY9VzDKKmEzk7KV3EHZ4Tz6s/+ASeyR+ibSSI2ZTy+Jj
	 kq9fq+8lQt9pviy5Szi6RM0CotUOSSvN5EUuU42dDtytbQnQViMt2jTtYU2STAz7HG
	 ceRm96u/wFCu8uoSHAknxpYqJd4swIR/pCbGu1sts++yzGtfztWXId81vZ85UQtFg2
	 CmXvDWeiujNYkbiJTyQCX1PiSKTlPgQIzAyChh/lySy37cha9QyHvglQ8sswin+wk4
	 TxiKShN0Vn4kgVcPGyFVjrGF3t/B7jrOisqJ5PhUWiLdS5t3k0A+S6R/sWrpxEdn6n
	 sQiejzpGrP5fA==
Date: Mon, 19 Oct 2026 17:37:32 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dmaengine@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 04/18] dt-bindings: mfd: db8500-prcmu:
 Deprecate EPOD regulators
Message-ID: <20261019163732.GH2663669@google.com>
References: <20260921-ux500-power-domains-v7-1-v3-4-9352be6b86b1@kernel.org>
 <179242679515.1178810.16625867453853597322.b4-ty@b4>
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
In-Reply-To: <179242679515.1178810.16625867453853597322.b4-ty@b4>

On Mon, 19 Oct 2026, Lee Jones wrote:

> On Mon, 21 Sep 2026 00:48:10 +0200, Linus Walleij wrote:
> > Deprecate the db8500-prcmu-regulators node and make it optional as EPOD
> > control moves to generic power domains. External consumers of VAPE and
> > VSMPS2 now use the actual AB8500 or AB8505 buck regulators.
> > 
> > Stop requiring the individual regulator child nodes while retaining
> > their definitions for existing device trees.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [04/18] dt-bindings: mfd: db8500-prcmu: Deprecate EPOD regulators
>         commit: c8132247fe4df52e9982d74c986bb199d792b85b

Hmm ... or would you prefer for the set to go in together?

If so, how far off are you?  How many more Acks to collect?

-- 
Lee Jones
