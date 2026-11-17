Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915019;
	b=N+MpkEYSdJJ5CIRjrzwItvGzz/BIBamigqFbJFczzY4yT/yp54a0HzJCb2wz/kdajnCe
	 G/TKbJV6bOtHoi77/Le+nLzvR2IBx4IzRmcwr0ZDd3vNPPGyC1fZ+mlChT97ttML4BLhs
	 D6B5C+Cypk9iVUP43m88l7GffASLqsRf8EfE1QrDkkXf0uQOuQuwMJRf5sXGtiYl1eBF3
	 VD4JupXaFSNwo8B0P0V10fmh+ERa+a5HkkQmdk6kitwru5ToNgrhdFLbtRGVflhEH3M+3
	 rR2I5P0Hj/OcTD4K3hkP1eHtzbgMkpTtIm6o3CskC3FvCC4pIYXPwFPsS4G9vmO8XCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915019;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zJAwjzj8A6UyZL9292pQYGGLxeGp4pMjNVMToHHKfLc=;
	b=ZJna/lWxPCBamNbpDmqO2NSqyEMkT1Uya4/HStUhffF1b1W7gqDDc9jva0/Lp3wDz3Ys
	 adyKFcYRAIvwc33VNAXytU40NqY+EXaRRU+aNEsXRqN20fpIkqh3ehZtokwL7JuRDxxDY
	 hTPoHgCEa/c0Sj8+h9DIyqDXmdSqxZFCBPPZOycEtJzmmzsyup6IrgIKHWZ4OFeZbmEHI
	 c8N4u5m2pGUltEHNUZnlZx8qGrMMXs3G4X3vscw+FQOJy1HWIiseeLSjv5AQvdWi/Ehy/
	 VuiTeQWR3P1+tn0JS/AckIf70v85Wf1SF+kdLZNduFdLrpWfo0a/ankp9AEAxIpvv/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Jchot9U+;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6C606A32A;
	Tue, 17 Nov 2026 11:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC6C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Jchot9U+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794915016;
	bh=4rrJaKwJlg6MCmlVQX/KfOrKxAoT2XQ7pGHqjYwrJ6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jchot9U+o4RxaCIJ27FWcHx524gFRsaWj1/nzyCl1f+pLc6+ayS+9z1bguMKusUOI
	 lLbstW+OBVMsvgsdJbgAkeOho4YQ4Sq9gAxWaRR1op/G3rhSHiif+KPlp9RLfFe2XV
	 byR5R47CF08xaTYCAZuA3BUVHXAfzC3pFjj3709ghVCFneMQsuZbXeRBfz0ubejYig
	 WMFGk4Tu4JccCLiAdjYbEzlR1ZCDb4mHCeeeEv3RNlEG/dX8Y3ODoJlPLTQkEDcg7s
	 WG/OTHaQub4ChOcGgTtM770xBZFFutX82kSISyfpW0yvAdIaL5++fnEYf5xx1mKD94
	 x7heECPfjn75Q==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3CFC17E00E8;
	Tue, 17 Nov 2026 12:30:15 +0100 (CET)
Message-ID: <fc0bb114-8781-43d2-bdfe-45135259a548@collabora.com>
Date: Tue, 17 Nov 2026 12:30:15 +0100
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
Subject: Re: [PATCH v3 0/2] rtc: mt6397: provide the RTC's 32 kHz output as a
 clock
To: Ryan Brue <ryanbrue.dev@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rtc@vger.kernel.org
References: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/26 19:46, Ryan Brue wrote:
> The MT6397 RTC drives a 32 kHz clock out of the PMIC, which boards use as
> the sleep clock of a Wi-Fi/Bluetooth combo chip. RTC_CON.F32KOB gates it,
> and mainline never touches that bit, so the chip only works if the
> bootloader happened to turn the output on.
> 

Not just mt6397, but way more than that - upstream never touches this one
because the main targets have always been platforms both without any modem
and without any *tight* power optimization (historically, chromebooks, and
Genio IoT boards, where the first are equipped with big batteries, and the
latter is typically powered with an AC-DC brick until it gets thunderstruck).

Nice to see this getting upstreamed.

Both patches of this series are

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> On the Amazon Fire HD 10 (2017), which can boot through U-Boot instead of
> the vendor's LK, nothing sets it in the former - LK sets the bit at every
> boot, and the MT6630 combo chip's Wi-Fi and Bluetooth never come up.
> Letting the RTC provide the output as a clock lets the chip's
> mmc-pwrseq-simple enable it. With the clock wired up both came up on that
> board in two boots out of two, and in none of three without it.
> 
> The driver registers the clock only when the RTC node has #clock-cells,
> so no existing board changes. The MT6323 shares the MT6397's driver data
> and gets it too; every MediaTek PMIC RTC whose registers I could read has
> F32KOB at bit 5 of RTC_CON, but for the MT6323 that is inferred from the
> shared driver data rather than read from a datasheet.
> 
> Lee has applied the binding to mfd [1], so v3 is the driver part only:
> patch 1 gives the existing write trigger member a name that says what it
> is, as Lee asked for the new one, and patch 2 adds the clock. Both are
> for rtc.
> 
> The board's devicetree that uses the clock is not upstream yet and follows
> separately.
> 
> This series was developed with the help of an LLM.
> 
> [1] https://lore.kernel.org/all/179459615032.87488.12726056214378307165.b4-ty@b4/
> 
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> Changes in v3:
> - rtc: name the new struct mtk_rtc_data member control_reg, rename wrtgr
>    to write_trigger_reg in a patch of its own, and the local con to
>    control (Lee)
> - dt-bindings: dropped, applied by Lee
> - rebased onto v7.4-rc2
> - Link to v2: https://lore.kernel.org/r/20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com
> 
> Changes in v2:
> - rtc: check for #clock-cells before reading the driver data, which is
>    NULL when the PMIC has no RTC node, as on mt8173-evb (Sashiko)
> - dt-bindings: add Krzysztof's Reviewed-by
> - Link to v1: https://lore.kernel.org/r/20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com
> 
> ---
> Ryan Brue (2):
>        rtc: mt6397: rename the write trigger register offset
>        rtc: mt6397: provide the 32 kHz output as a clock
> 
>   drivers/rtc/rtc-mt6397.c       | 95 ++++++++++++++++++++++++++++++++++++++++--
>   include/linux/mfd/mt6397/rtc.h |  8 +++-
>   2 files changed, 99 insertions(+), 4 deletions(-)
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261024-rbrue-suez-upstreaming-mt6397-rtc-32k-0a1c16f63383
> 
> Best regards,

