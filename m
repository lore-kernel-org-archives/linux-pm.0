Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2220364E97;
	Mon,  2 Feb 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033732; cv=none; b=KNPMg5PFAxUdRsBTHB6XPJW3CVblCHV83ObpzchmlQLXehz+DtjwVnUCjVvSIPoOF0rDqEJofpvt/8wyPV8Q2UwpYWJ+vP2/x+DgLxQUCB3g0piMlZvwQQGIbm9xYv2lWFd3yBCr60rLTHsOYwoNMjLsUlPr5fAvjMBvgnTT+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033732; c=relaxed/simple;
	bh=U6clwAJ8Kdmzgl6drGO6FUVsAU8rJ6AUKqT9+P6Tsrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7uNj+sDRxq9Cziik/oeMnu7Oowc1pjZ6YTPnY0i/bTDyRBwpv5VsB2YDGl6RyT/I1Vlhf34jtPFy6k+/zwb9Q+Kw/XadQV7YdBjdMyvtFiH3BUTih7aUAoj4u8Lu8aBDwoCTdcRnuB4fxemwkfAFFybKnJYJ6Hq1LrYtVo26co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CgSP6MqU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CgSP6MqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770033729;
	bh=U6clwAJ8Kdmzgl6drGO6FUVsAU8rJ6AUKqT9+P6Tsrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgSP6MqUEfgZJikRAxnDluuWlCNKmRM4/23TXQKxm1RyHv/MkZeVqBYPqAqGgrJ5n
	 qOnIcpF37DtzqPElDVZ4OXQqyKUeLbOX4x5zfw4UEF17pJ/tVvw54YQBWLIOhos3+b
	 ww9ZOQMeIFS/2P9PF5cXcqaWekF27Txl/rS/tIt0KmQMqUnlE0Ue7S/+RlFlE8TjGj
	 9wD/3cPFs7rNbWaAt/EOrQIFcyb5UYMCKynWDddeNejI6U835MXwP9fKtlmQ35+87Q
	 rsgzypDjxZhaRXRcASAGMvQjCzgd4JFcTvC8ih1ic5ZR47i/+aH3hFaOcdldz4qoNO
	 /v2bMydJkOzUQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5796C17E12E5;
	Mon,  2 Feb 2026 13:02:08 +0100 (CET)
Message-ID: <7727490a-16bf-4774-84a0-4fcf3b34f393@collabora.com>
Date: Mon, 2 Feb 2026 13:02:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add MediaTek MT8189 power domain
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
 <20260202064820.347550-2-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260202064820.347550-2-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/02/26 07:48, irving.ch.lin ha scritto:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add dt schema and IDs for the power domain of MediaTek MT8189 SoC.
> The MT8189 power domain IP provide power domains control function
> for subsys (eg. MFG, audio, venc/vdec ...).
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


