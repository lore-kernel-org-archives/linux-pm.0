Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746B406261;
	Mon, 20 Jul 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554036; cv=none; b=JaNQnk2+dAgRSD4148R3SAMAVBHzQe/TMCbVa377+4dcXjIUnI5vUgt3P3OW44g/s84J56aU/YwP5NEEEZczfOtXjtCup0q5QRBb4YoP16R5FURtP17tT0YAfYGesSL94WChfgHrqwi/LeMcLkbAssJfoKSF+fDqlAUHao1HWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554036; c=relaxed/simple;
	bh=5miUtceH7EkaTGDhqxpZugrO4o05sy5fiYaqxmWb1w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3L3GmZDeUXsIP7mbORHiuyCqHX10V0kQ1ItTMliQ2ZlvwTa/d8bXW4E5NPceONOmHXNujv3d5gdJ+3T43/LPIFbQyvOxjE+mi8BLB0EXolVzxVj4oepZFCjGh8gtzNgqYkrfs/v0Wvj/cYI7pdZuUiczrOk1t7GRUppqch5x8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HQM0sKz+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HQM0sKz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784554032;
	bh=5miUtceH7EkaTGDhqxpZugrO4o05sy5fiYaqxmWb1w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HQM0sKz+XYpSU/sZ6EC7nF8oDHXBiRNCpZPABC56U5ilYJAZ47sxxMfXIDdksNKWh
	 hJXV1ZE7O978ptTBR5m8cyRYOzbx8UuWKkNuTWN5w00XBTYyPwu7kQz93w4m4nQO2h
	 EnzCvTA1xDpsC/RMv9J+as/7B6LSWNuI4Jb6lZJTjtbpQ/q4E7VM3bc7KihwRTPq/J
	 2OmBXxvjGO7dlDLujPv3Lgym9YDi9IvvBUMs5cmAKP1CVDWfkva6B2MfM/ctdX14wh
	 k20kEZNcXkZqZLnqjuMFxBdGCkO4A+1C6oaelbY0qBuh27UCYxmQWBoDjxge+I/iOU
	 wn6o1504mPnjg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43D3C17E003B;
	Mon, 20 Jul 2026 15:27:12 +0200 (CEST)
Message-ID: <4fa4fb82-2118-4ddf-9b8c-510b58835b5f@collabora.com>
Date: Mon, 20 Jul 2026 15:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: Add compatible for
 MT6589 SoC
To: Akari Tsuyukusa <akkun11.open@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Cc: "open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>,
 "open list:MULTIFUNCTION DEVICES (MFD)" <mfd@lists.linux.dev>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20260716171733.300885-1-akkun11.open@gmail.com>
 <20260716171733.300885-2-akkun11.open@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260716171733.300885-2-akkun11.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 19:17, Akari Tsuyukusa wrote:
> Add compatible string for MediaTek MT6589 PWRAP.
> Also update the description since MT6589 has pwrap bridge.
> 
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>   .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml     | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> index e7c4a3984c60..a487ed39e6cb 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> @@ -19,8 +19,8 @@ description:
>   
>     IP Pairing
>   
> -  On MT8135 the pins of some SoC internal peripherals can be on the PMIC.
> -  The signals of these pins are routed over the SPI bus using the pwrap
> +  On MT6589 and MT8135, the pins of some SoC internal peripherals can be on the

Soon, this will become

"On MT6589, MT8135, MT1234, MT3456, MT...." :-)

So, perhaps, it's a better idea if we say:

"In some SoCs, some of the internal peripherals may be accessible only
through the PMIC.
The signals of these pins are routed (blahblah)"

Cheers,
Angelo

