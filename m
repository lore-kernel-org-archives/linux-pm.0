Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491915;
	b=NlMuMQTlpAYZYGH3OoJ1cJQi88YOa2Mn0k1oms9jRaX/NWFCIFDOn86TrRt7NWihHZHt
	 3l0k19M0umB7vABr632WghATNR/wc+b9QAtTDUJda5C+0ZqOtV9q+b0QH8eXQ5+iOof3l
	 BczRZmCyhgg2m+5xSI9yFmNctYxJkeINto3QkmQPUAx0lbd/Bg3VFPfhbDI8Mnu7Ot3Lh
	 snoi/WDRKo0ISxoXw3QP7pIpWQeDUy/PRZY3zlrH2uRukqWFEkytaLor2BjhKd8aTEQlk
	 ACbcl1er+y7ZofcQsfEw5ZJvsfGSu5u/2cKeeshoAgTisqmWg3jmvS0NXpoXlAMiBew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491915;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3qK75ks52nk2OhdqDIRGQrGiq6Cnz7HxfpZQKI/KNAQ=;
	b=gaZSWGLlloEfp9tPW3ZNRQcxqLiDvEZjsE4clQK3IOPzh3xp6L3tlSIN4eFl7PFOwOeS
	 exiKbh+hqUzWyw/ld+diiW5s7pQpuaM/SZV4bhrhG4RxHRRGis7AjO5BeYbSCqX6RkGP1
	 edTC985KNcNilHZjfHoWkZZhAZGB5RkcYiw7eSAj5TxkZV7UwniyEascLv1Hw3hrib4MC
	 52tb+DJpmdIipi4VCCuHY04CATaEjf9qIBrBxbat0T3YO14c3cLNSKaZ4zWsW9xPki5rL
	 YbT1dZOMX9Emg7t8y+nb1FQn/V0sVHLCOddQJCoQbnmDE9CCsa3KuGDxsf33RBdk2uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uIJDmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3B606A330;
	Thu, 12 Nov 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3uIJDmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52581F00A0A;
	Thu, 12 Nov 2026 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491915;
	bh=3qK75ks52nk2OhdqDIRGQrGiq6Cnz7HxfpZQKI/KNAQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Y3uIJDmVvCDh5voNMl19wu28hbwD1rXp14sZthY/q01Zk2uaF6DFEd131ALHyzC10
	 DihF5Xt+moRHhZjRQvA41Jeiprq3ljUHjeWx+M8cZcf5aWXewYNtmPpf64pHxXJZWl
	 ltOok2ej+oXTHLidcpZMc+aSo9rvEUipi2AKiJ+iMQkJK06QjYA5BYPi0qDzlOpE/I
	 JaLV7L4MdFVAKtT1LhMcebQOhegcEBgnGeprqhRgON13eEyfVI1gk5GcC14i+qDAch
	 YSnR9Jdjf5crPsROHeV0FuplwrFVCTsZsbdrqCVLXbC5BJAg1JaSIb0nT/p0P24kwb
	 EXopyZ/myjaKA==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 6/7] clk: bcm: Add BCMBCA PMB clocks
From: Brian Masney <masneyb@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-6-17035a5e8ad2@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
 <20261111-xg6846b-bcmbca-xrdp-reset-v4-6-17035a5e8ad2@kernel.org>
Date: Thu, 12 Nov 2026 08:58:26 -0500
Message-Id: <179449190684.1220086.2034099469330026473.b4-review@b4>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=7vI5ainOfrrxAECdVE4Ka6p8NFP0cAJd1sALUJmEwV4=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK+HmPJy+0ydnl+an6y7JIgz5tKZQ9NwnRFHHb/5smab
 O+zQd6zo5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgIm8zGH4H6fCddeBw/vGjX+/
 RfbXlS/XrPaVW2Uc67zr90SHQ9xvSxkZvh2/yrfn26z34k92CNyqP+1mJDft3ObnPxdcN578OJ8
 jgAsA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Linus,

> Add a BCM6846 clock provider for the Power Management Bus (PMB) MFD
> cell. Expose six outputs from each of the RDP and BIU PLLs, the Runner
> clock divided from RDP PLL channel 1, the crystal output, PVTMON and
> block-zone clock gates.
> 
> PVTMON and zone clocks provide gate control only.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I missed that you sent a v4 yesterday and I left comments and a question
on the v3 that are still relevant.

https://lore.kernel.org/linux-clk/179440936574.1126566.13988760065429157595.b4-review@b4/

Brian

-- 
Brian Masney <masneyb@kernel.org>
