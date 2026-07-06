Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F1376A08
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347085; cv=none; b=Hl4uQAaW7Aauk7SzF9TwgYPiSUFboKMvFxfiI39Cuoo5j6gcvKPVu/AOyvPz1VDRq/oKyQkKsT+Eo/FdvfgGkdBFcaRuxjTBX7hgZZm9gK7uZa/lJx3g8kJ6RE/YNONIp9uNHks8bMBUoWG6kP+pdpNt8WihcLai7hUu2WxwU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347085; c=relaxed/simple;
	bh=37+4q7COOhXJEW+gXuemdFa5O7sFCIJzgfNUlkoW+l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxO4M28lHbZQRvFk9WxY9TTzCmXl0kFrQFrcsesyAXVuEyF7EbP3rqpNMUn9ylJs2Jy5Gqng8JVGaV/vygsLSRqvsRRrjSKDsvaExE4RIyR2lO7lJ8S4vUVA8pcoTk0kovfh8g2Ood4njAXVRab1ot7mLHtb0mhDejSaEX+kuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LyHjOFnP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LyHjOFnP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36B1E4E409FE;
	Mon,  6 Jul 2026 14:11:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 093DD601A2;
	Mon,  6 Jul 2026 14:11:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 702DA11BBA4EC;
	Mon,  6 Jul 2026 16:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783347081; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=37+4q7COOhXJEW+gXuemdFa5O7sFCIJzgfNUlkoW+l8=;
	b=LyHjOFnP41JECW6ndU1QxZDuK/Xnq0yE+IfSIR9YL3JX3IkRw9d4z+Pf9+wWFBVVsBeZ89
	izKa/IfvGTxTrfNd9HUnUHJH8oWQfpV6qngk44s59M+9KyFQddMyxL7DXhixY43HbN5bbp
	PD9BatHpbG+b78I/ykLupTRjufQa4rSh3/W7KaPvQT+la+nqYxYHf8vzQlrYSb1aJeivBN
	PUQBNJyVLf77rPN2ijoHe2NpQ5BS24Ug+u+Dy2p8w1DtAl8nbBTezc5a87TXPiYVjI7uoJ
	MjjWmP+LKEbLM2VHl/N+6GmLq48cELxwckPzjqWI5aF4a7tuHmxNTSycFD/kUg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,  "Rafael J. Wysocki" <rafael@kernel.org>,
  Daniel Lezcano <daniel.lezcano@kernel.org>,  Zhang Rui
 <rui.zhang@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>,  Vasily
 Khoruzhick <anarsoul@gmail.com>,  Yangtao Li <tiny.windzz@gmail.com>,
  Chen-Yu Tsai <wens@kernel.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
  linux-pm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] thermal: remove unneeded 'fast_io' parameter in
 regmap_config
In-Reply-To: <20260705164311.2273-2-wsa+renesas@sang-engineering.com> (Wolfram
	Sang's message of "Sun, 5 Jul 2026 18:43:12 +0200")
References: <20260705164311.2273-2-wsa+renesas@sang-engineering.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 06 Jul 2026 16:11:18 +0200
Message-ID: <87o6gkky2h.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 05/07/2026 at 18:43:12 +02, Wolfram Sang <wsa+renesas@sang-engineering.c=
om> wrote:

> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
