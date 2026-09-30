Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747F363089
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779295; cv=none; b=UcYRPWGbMg7zguR8IVEAhj0Kh8+aM3n4qtBwNPoN9TIx1lLA7Fkz4U6oRSmvPk0gugSyLrVkBMF44Av4836JfM7g7hjVBXSMeveDt8tzegbofjiv2K94sc3Ot9yG7TQ5IE8SwoHfWfkh2JfZgUwf2XoIFJiLTkBaRnFJS2u5HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779295; c=relaxed/simple;
	bh=9yqRRq23NwVKIqoGsC2Ia1qOKcGglHeQVUA6Im/RXrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9sZ9svzbQZJNM0eejRsuxMEkxqs0RlhkQSt9Qw/4k4qIxzI5ceqLwyULPfJBR47A11E+5+GA0CBLB6HkD8ImgacH2A4LQvIIdX/P0Wbcz/8I2qfL5yH2KPddP0Hbw/Q7hMq2l/HzG6HzegfsCK5oD0SSGbJpY5TYAy+Ck6LyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ChSwMplb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ChSwMplb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 588461A1088;
	Wed, 30 Sep 2026 14:41:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CCA560749;
	Wed, 30 Sep 2026 14:41:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D218010329695;
	Wed, 30 Sep 2026 16:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790779275; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LGRPZRz2qsm3tuIDtA+8pDXAURoo45DF4vA0Hjc0ty8=;
	b=ChSwMplbOA0jh3gZRg4sJXIc8pzoN66mFNZ0kTsmkGRvNO/y6gvWRNwa9PPGfzNghnossC
	pHKvP+x5xNBkKWdpIszb8m75hgWfXzOeKfDPDyliKrKbAyHVacH9CX5ltVwmW8d7ht6PQ3
	UzoHbe6ezxJV1E70LqTwBFYKmA2uV+vAQ8iAXmaIk19DZgavzQ111pgluC4by43U1bfCsu
	UF/jZ4l75Jtja7QIvaHUx+5GCl2PgIk/vXvp7LajrB/bpUu+LOWEF/Zt5Cme+Gf+DMYoUc
	CYbfpGgWM3veDFYJHrsDbSELrtmt25eg5PnvPIfKZzQ4n2yJo1PHiJX77s4zFQ==
Date: Wed, 30 Sep 2026 16:41:10 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/2] rtc: mt6397: expose the RTC's spare bytes as nvmem
Message-ID: <179077924632.411665.17496276815862670542.b4-ty@b4>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 17 Sep 2026 23:57:45 -0500, Ryan Brue wrote:
> Four of the MT6397 RTC's alarm registers use only their low bits. Each alarm
> field lives in the low byte of its own register and the driver masks its
> writes accordingly, so the high byte of four of them is storage the clock and
> the alarm never touch. MediaTek's documentation names them RTC_NEW_SPARE0 to
> RTC_NEW_SPARE3 and assigns the first to a fuel gauge, which is how its PMIC
> battery drivers carry a state of charge across a reboot.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's nvmem layout
      https://git.kernel.org/abelloni/c/8423c476ab2a
[2/2] rtc: mt6397: expose the spare bytes of the alarm registers as nvmem
      https://git.kernel.org/abelloni/c/1aaaf94a61ee

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
