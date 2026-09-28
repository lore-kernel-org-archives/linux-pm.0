Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7938655E;
	Mon, 28 Sep 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620467; cv=none; b=ZztTkYpbU52rpRLjQY5nSMs4/UrR9GANWe73E8XxMe01qZMiwfXVarXQAOfL263PUB+rnkQpuOCdLfM0De4aaaCGM+E0TcaU5t/fLfDwxzCtVeS8oKa9wpfo0zw7vtaDXbHqM8cu289NGgYMs9G/Kobopio5d1t/4F9VgNxEfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620467; c=relaxed/simple;
	bh=RsrbB7A33DweiuoktsJlq8u9wyRVrZZJsx1ivqyX7v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv0khOmstziiTZrW8NAbiYEUjNbiJngK0ffoFv2HcO6uBJhf8dGxgubXz4fdEW2r1wo5pxjpE9IzEWUS7uPSjNF2loHbpd0BpPRxdQyIf0pxDMPs+kCAHOwScOnxLh0kiNlWjnEtHO00ReEaCaJjunQfvZDYHj6lKxw5E2DDBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HddpuUAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HddpuUAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A5C1F000FF;
	Mon, 28 Sep 2026 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620465;
	bh=XKHR+SJFFASvBta04CRZYYpREuzHifi5SVWuCQ0YQps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HddpuUAIJy8c5vSGRQw0mfQi6dkV1NhSW7orkilOjlUGTw2o8nKc7M5WmbUMueKuj
	 qZfUbByg5FV1rkLSR/R+8ZmIG7gJ4I9ecDn3mO8WWRaBnUZelIuyA0mHdVUeF6Wzle
	 XmOh9Z/MHItk7ql5bIDMtJkh5KUdB6c0PWSWP3vihRFKo2DsBOnYnwlRznGe56S4GG
	 RuIBTiFLpJW2I1TAEyjsPNcnekmEAnlhMqs1rqf0XxZsr0Y58U3K2rLDxUwkUXj5DJ
	 a3+u180KWuosyDNOk3kh3GJbxh54P1UE+Q0+/es5OvhUYpntT7x7Va2DqRXfcWjCIM
	 YYGU8nTzmMrqA==
Date: Mon, 28 Sep 2026 13:34:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, mfd@lists.linux.dev,
	linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-mediatek@lists.infradead.org, Sen Chu <sen.chu@mediatek.com>,
	devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's nvmem layout
Message-ID: <179062046209.229646.883172989324987113.robh@kernel.org>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
 <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>


On Thu, 17 Sep 2026 23:57:46 -0500, Ryan Brue wrote:
> Four of the MT6397 RTC's alarm registers use only their low bits; the
> high byte of each is storage the clock and the alarm don't touch.
> MediaTek's documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and
> assigns the first to a fuel gauge, which is what a battery driver reads
> at boot so that the reported capacity does not jump across a reboot.
> 
> They sit in the RTC's always-on domain, so the driver can offer them as
> a battery-backed nvmem provider. Allow a board to lay cells out over
> them.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

