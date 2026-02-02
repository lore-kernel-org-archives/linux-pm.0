Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA679364E97;
	Mon,  2 Feb 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033730; cv=none; b=rF3MyffAud0MgIQDMK6EqS+S/VH1zg/JuzgEitv/aaJeqV4n9fC3zhtfOzpV9tZljwKpNP7N2hB9LaFZVUooycvFsyhqSqTncN0OkdsglVzH2GZpVpV6xHQHJpPZowTnl7uSk7RoR+4/Mq4hV5hW12xyqZkzuJU70oj3l2TSXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033730; c=relaxed/simple;
	bh=Q0A8zblGmQhiY1aUgiC5T2dZuCpHQ9u58iJxqwdJMtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArPHwHHtKloemaS1Nhmz9lerKeBJMSa8mkbSpqZ+OZIlREPRaOZ7kFMf9TcEXUjAd06TYhBM0G4pzkbjXt8UHVtb4qLuOu5psr+1U/1mb6WlvofkKdPjTFKuyAnsTT51foSVv7lYrvp2+LCN1MnFN198qOAaUUVgUMBj/Wh//qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IZGB/OYI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IZGB/OYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770033727;
	bh=Q0A8zblGmQhiY1aUgiC5T2dZuCpHQ9u58iJxqwdJMtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IZGB/OYIV54RYNBbI+miFt+Yd89ADqWLCilI1zYyjc+JbXAECLLytRU5nJ0HKz9Rj
	 LWs78w+J15UZaH4PMnhbgS4adOsDv7I0v11h8MzKJgqlwboK4+jHho74kQHclCjy28
	 cHLWaVFLCFJqtwqt3fAxTt6IQDnP1Kk6zPXiCZvs3G57+IwTr/W8rbH2g0q46h5OHg
	 e1P9LsicOwVyOiQbKNy+aX6OBEuiFocGNR1L1tHFT5Z1Kb9Nr3q4JVYjfDitRgSFCU
	 rBQelpwsuo8ELz8G3TB7J+uQUBHWEuNGW6ESunjoK5S56xUv59NHDoknwpxLuB9MIA
	 YXcGZowGNuKpQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B294E17E14F2;
	Mon,  2 Feb 2026 13:02:06 +0100 (CET)
Message-ID: <5742bfd3-d08d-4d45-968d-5cef9ec060f4@collabora.com>
Date: Mon, 2 Feb 2026 13:02:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pmdomain: mediatek: Add bus protect control flow for
 MT8189
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
 <20260202064820.347550-3-irving-ch.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260202064820.347550-3-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/02/26 07:48, irving.ch.lin ha scritto:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> In MT8189 mminfra power domain, the bus protect policy separates
> into two parts, one is set before subsys clocks enabled, and another
> need to enable after subsys clocks enable.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

