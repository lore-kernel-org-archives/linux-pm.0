Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7082377AA9;
	Thu, 15 Oct 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075534; cv=none; b=BJJFfH9aeBXaHXDvcT67fAmu7pMfg7mwnu+CoDmhoLQL6tuWO3r1TixgAaQYY27bLEmODV4qYK12McuNZRnCOZs974P0Luc7rGOT8GP2yOsT3P32NqgutXzrOCUAPNF4OxFdhMfk4WPxNwoW0Pz5orgmd+S/ijz1lIURUHq5W28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075534; c=relaxed/simple;
	bh=FDTIni0nAGSEh/v9BBRLBV8oZV1hvR8iqdW+Swhxej0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NtEezku40LoAXlWv2pjUB6VLLe7jHfnQek98KHuDA2Xp6JIMZf51uNCEB3Rmedj33bdXo3xNNj8UONtA1RB8ArGmfCNzVvQgU+sakg1thGe/2SY+1JEAUKI80NmGA0VwEJBoT89+ILfa+5jrOZpJqVob4by50r5L4bA+fvbj3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8KDxOcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8KDxOcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304AC1F000C4;
	Thu, 15 Oct 2026 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075533;
	bh=Cu+kqaxp2LTtL66kVYg1eFWIE3LmRxniGoxkUb1pV6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=A8KDxOcVlxsVPVeUTb9z6c3kNCv2Dr1lrWDr9l40cOoWUXL1Aa9evg1lXL0HZO/Zz
	 WJ4G1FmtHGdIq/yYXMZfJZqNjbt9NMUpVkN/vtR4Mzvfp5GKzKyrwAvEA453Qd7RpW
	 wP99QRrUSELooIlXaxd1eJvNM5QC1IenKNGjpIg+zB2LT2WeunlLmM1UJXSCo5WA7b
	 tyATQpPi99r6EB7JJg8bBX4cwJ1lBgWXeHKfDPeFIj7696IzdLwoN8rt3vtje0v0Gd
	 +YNvLWNOlpLLsoSztfgUpWU3yPeS6wL7TT0rhUUVmx10YQEsGxxMH8vU7g+oNU15gg
	 PK543lonFLSyA==
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
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397:
 describe the RTC's nvmem layout
Message-Id: <179207552993.2025354.8082190784295988343.b4-ty@b4>
Date: Thu, 15 Oct 2026 15:45:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

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
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's nvmem layout
      commit: 3606288af5e8c09a14ab5b19e121feec75296354

--
Lee Jones [李琼斯]

