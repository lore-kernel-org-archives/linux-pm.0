Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596154;
	b=KAT9DyRWNDr92x7AppfnEwu/Td6s2g4k2zFac10cUX/LWHuF7rNyjrxFsDL64l4cmIdV
	 pkL5iLF68LTIG5M2jTzEKeXsg9bZj6eb78kt+iw11ONghSsP7/OS0qHmoj9ppX6wLjdcd
	 f2HsFAd5dq29gqRdQ693DwvgjZTR1LJ1Sd56xMbzO/cjBgduLdYQazGr/O+wXruic3kca
	 JvTD/xQ2CqH7yQy/vTtE1hael/QXp/qC39g/eGFtbt1kJmUn5RVECORne/gb0ny7Ea6ps
	 xf2YMwufxkfuzwKXobIRbJ7ugYjtKVhJ86WdRAirutLxBK9t1OEmpma05OjzqkFeoLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596154;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=fxZivtYImLr6Xqc2JRNdVpuAoDBsPDg2LZ9fTboQfSk=;
	b=hEA2farG8gI5cd0dvLcN4m6AihdpKvJarhCblQRq91MVtPF+bLuRCeo4CvTm49WlJBHx
	 R8/Adi0rjKOyyyP5LAEb8bfEucsVrjFGotpEhAxpJgimCGM59Ea2Nh4gEqYiBp8Z9s8AG
	 k/6w4KCPUZb+M4VP2MCdIkBpfZ1v4YjHRL16MOsqQ9Wi8QJu0NpBYksKuWkzPf1EcCBaP
	 bgv/vV/0CtVLHYEwwL4+kmFvRdgxvKlUGB7NxKYKK494aSLGM8bDu2vZ1wRyOmP6AykhT
	 MPHmE4WK9rq/ySPiWud0qBcGKxW6PuqWhNVfsI1DGqruiA5a24HPTaOam5jmgAvv6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETnR0EYS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3260A2604;
	Fri, 13 Nov 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETnR0EYS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975551F000C4;
	Fri, 13 Nov 2026 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596153;
	bh=fxZivtYImLr6Xqc2JRNdVpuAoDBsPDg2LZ9fTboQfSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ETnR0EYSHanmvts4Apaw29C4gph3To2NBD6sFEiBbcTsQWheycc+uYb/dY++sdp1A
	 ECxfckanNuqbhpUb901h7finwdSVXqd2UuSwmCly7SYG8RD2h+Kil8aDDdTwBRO4bq
	 AD6P4d0nncRlayyXXD8/5UjhW6k3l/xklDvPYdMPyexM9z4+cI705aFdfQil+eTSja
	 TfG2dLTXshnpQFfPjcNCLvourYR4coCrwLa5zYQX+5PaFpcMKAYh+8dJX08boweJCA
	 +y0KSX8VtyWPaWhEB/XouKFIVEe2jI60Q3U9VhHhYDh8sXtZIhtbiVJehwUz0QYuNV
	 kM+WYAcMtqXYA==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397:
 describe the RTC's 32 kHz output
Message-Id: <179459615032.87488.12726056214378307165.b4-ty@b4>
Date: Fri, 13 Nov 2026 18:55:50 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 01 Nov 2026 23:33:46 -0600, Ryan Brue wrote:
> The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
> use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
> is off unless something turns it on.
> 
> Let the RTC node provide it as a clock.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's 32 kHz output
      commit: e38ddb5cfa9f9dfa7feac202414d7a4192cc24ed

--
Lee Jones [李琼斯]

