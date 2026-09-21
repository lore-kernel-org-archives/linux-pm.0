Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C7435514;
	Mon, 21 Sep 2026 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987061; cv=none; b=BHyUGMXGTM2h2c3OGs+AkvWAfd8SyR0TjEYDvwLcNyFMIMGcJ4zwSP4T2YJkDjG/SWiB5otsyyEabY8nmrMx/E/mtZqKEQI4Ytj5YEJ7eGUom7NLnDgP1hdlLM/ir2PRy9+hSPE4mtzwRuUXA6XeGeJ+V4P8rkIvKZ1OWZ5K2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987061; c=relaxed/simple;
	bh=nJ25MVo0NGw9oiXZTAgE6pclgPjvVnOwEl7ePi56428=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRSrW4Dy4IaffmrehQAWwGxPQ0TvGWYtQ4EPpKLj6Vuypl/GZlkiuiyKMkjN8dPJ20v/4fJikANj5EdzQiS0U5tpKVZatrjQSRLX3qx3EMvU9+Zj5GySqpEgsJe1+q1xe62k1752cwQ8BOHgG3Qm/X1l5h8QXDSU/uklp94jynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H+ekNY7f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H+ekNY7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789987055;
	bh=nJ25MVo0NGw9oiXZTAgE6pclgPjvVnOwEl7ePi56428=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+ekNY7fV7oFE4VG7Txu3BCjGpCaDF/UZ7SxcomhIY1K16HQz9T9VNqF+n9UMZ7TY
	 /Iq5+9schdw8mgrT1S9yhJrqklfjSdeps+b40cmQ+UuYwv4LMnTfjde6fhxg52Ww99
	 uTD1SJOfkQHFOgY92A2DoMc9BRmDf4Obz49LAuXnO8j8pOoSpuFQOZk5sG0tH9NhU4
	 hBD1wRi8pPkIPb0GlitTHFx9qYfRlVi+skTqy4NuFEucGje8T9ZazsxuOrR3dtDFCr
	 CztICHoZ73lrai30xkbcGAU3uChsT8SrKRIVo1B55/K1HqjQVDm3/uLT4Scwr09xHt
	 NLHOdtxW5KAIA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CF9817E020C;
	Mon, 21 Sep 2026 12:37:35 +0200 (CEST)
Message-ID: <2d9a1df3-6cdf-4d82-b2c8-907964711104@collabora.com>
Date: Mon, 21 Sep 2026 12:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rtc: mt6397: expose the spare bytes of the alarm
 registers as nvmem
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
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
 <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-2-558b8f95cfbc@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-2-558b8f95cfbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 06:57, Ryan Brue wrote:
> Each alarm field lives in the low bits of its register and the driver
> masks its writes accordingly, so the high byte of four of them is storage
> the RTC never touches. MediaTek names these RTC_NEW_SPARE0 to
> RTC_NEW_SPARE3 and gives the first to a fuel gauge, which is how its PMIC
> battery drivers carry a state of charge over a reboot.
> 
> Offer all four as a battery-backed nvmem provider, so that a consumer does
> not have to reach into this block behind the driver's back. Doing it here
> is what makes it safe: a write lands under the same lock the alarm paths
> take, so it can neither be lost inside mtk_rtc_set_alarm()'s
> read-modify-write nor fire the write trigger in the middle of one.
> 
> The nvmem core does not range check a cell against the provider size, so
> the callbacks check the offset themselves.
> 
> Tested on an MT6397; MediaTek's spare map for mt6323 matches, and the
> alarm field masks are common to every compatible this driver binds.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

