Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213F3C6A4A
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228028; cv=none; b=KfRDFwqYvYon7var9YZQ4S3+1PDRnLB/sbuh5T1kg3nJfokjQWu1WtKQW5t8YLo289AQzDRyYoG9C1kUxx2iRH7jo4Ysuh9hL+kwYDRZCsFzVB+x+IG8Z35fesnqNiaCc02r9kSVRX+0gxLN/4ZkOFyMZXfaIT7X4BA56oVwUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228028; c=relaxed/simple;
	bh=ne70ucsZwaszEpPz21eEwyg9qhaY3KQE8B3fi/F6ero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOST1BKvGsRMQFeWBXlTLZ/18pATlavDVhaP7u5evH7/hdVgtGkiSrYTNavBC57sqjWulwhms1pYo61OOq0zzmuD2572jb/iY06Sr4IhFr5vt9Bqb1XSFmYwdrO62NOQNgbIpm3BamLlKUTCtzGKfBAb6bd6fyfaz0QrpwkqvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TalprS8E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TalprS8E"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 15AFA4E428D1;
	Fri,  3 Apr 2026 14:53:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D55D6603C1;
	Fri,  3 Apr 2026 14:53:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A26710450008;
	Fri,  3 Apr 2026 16:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775228016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KWvfunppyIOvyGREm1xxzLD+klThqSaXmNASBIweIZU=;
	b=TalprS8EMCX1+Y62VESHZ3Ux69z+51F0COOk7t4e7pOL1qSxmTgSZNcJleEZfeDEcnuLsC
	z51ekYC2GVCVr2mauP3cMIkV1xHyInx8xQ0QVQp2Q/WpNdo6HwvfHy18SdKtIfNUraKHhq
	gf1AVqyci3T0QF868NZaFm9zYnvQk3Q2YeBP64kvOhIcijrsd/P2MpdJdcZMDlJPYmxKzT
	tiCEAyGtFyc6osXe6EBLDqqXstWqZlGmbLPjpUseS6/acAknGu1ZRXREDdwWQib1Bkf6zm
	i0mod5Vd6QmKekJFQ5B4bwzfEPuUhz2qbGB2afai+cQVH9LBqhK6qLQUB7wQoQ==
Date: Fri, 3 Apr 2026 16:53:28 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/5] dt-bindings: rtc: sc2731: Add compatible
 for SC2730
Message-ID: <177522795589.1505278.15029729729753708134.b4-ty@b4>
References: <20260329-sc27xx-mfd-cells-v3-1-9158dee41f74@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260329-sc27xx-mfd-cells-v3-1-9158dee41f74@abscue.de>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 29 Mar 2026 09:27:45 +0200, Otto Pflüger wrote:
> The RTC block found in the SC2730 PMIC is compatible with the one found
> in the SC2731 PMIC.

Applied, thanks!

[1/5] dt-bindings: rtc: sc2731: Add compatible for SC2730
      https://git.kernel.org/abelloni/c/b2b0dcaa28d2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
