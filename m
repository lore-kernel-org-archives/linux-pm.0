Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A53C3450;
	Wed, 15 Jul 2026 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109543; cv=none; b=LgHDd6hfMPWfJIXFWz9nLr66GJuly/wNve4D7g45l+QTjtICTkxoDivdNYCyefEYMF7ljQGrafG7moL4tpSngHdeZDXU/vlfgZET+CwhdxIqqpETzu9azWaaDr8ws9IkyLmznLe1oTrK6IiE2L/rvqvUx4AvmdnDeTdgLzuIYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109543; c=relaxed/simple;
	bh=A0P83uQz8I3cpMmpwBvFRnuqr2Xe0F0qmqvYylHFg6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPDI38bu6YI3V9KNx4qeeanCA0/zfCs5qbYjv9GI95DUkDCuX/ZQ2PMpUEZRyw0tPBfkD3TNhpJydQMFxC1iTFoHgsv6HGdyWC9xcxw/SzBL1z7esq98FoInSXPkZltnACQCsy5TrPsxsA4MpTaUYu4sDgwrqBtIgB8u8SnSt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IRPqg0sA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IRPqg0sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784109540;
	bh=A0P83uQz8I3cpMmpwBvFRnuqr2Xe0F0qmqvYylHFg6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IRPqg0sA1xSsSZQ8f7VHmUKzJdLsuS1PyKjMse96nXIdRp+/5rkSL+JYaLUXUNnOs
	 7dJ0EhAafV594ZrIYCgF7rwy/jnpcWA1i2FG0rb6DLrb6LWMpi2Zy5qQdughkMSeZr
	 NoLGP/uNCYzTkgIHVQZbiWaLIHqWPClFPfr6T8gwslmJZPtiERX+xWflsmSAAKAAfr
	 RyLoS5Hx0J1YysadOlI/tWOOCIygUIBMxrLiuGCsYw8L/xrgdoqDbWpwNOjNSXOZcw
	 v7UbfSfz9sLztcOqAmc8oRFXVZUwOdoTMISVyBk+RGsrHo3Siwu+VX4NVyAADujK6e
	 aEY11kbp7bgQQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 834EF17E0928;
	Wed, 15 Jul 2026 11:58:59 +0200 (CEST)
Message-ID: <d3932209-04cc-40bc-9bb1-f31c365e93ca@collabora.com>
Date: Wed, 15 Jul 2026 11:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: power: Add MediaTek MT6858 power domain
 controller
To: nikolai.burov@jolla.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Nikolai Burov <nikolai.burov+review@abscue.de>
References: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
 <20260714-mt6858-pmdomain-v1-1-4f09bbb822e0@jolla.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260714-mt6858-pmdomain-v1-1-4f09bbb822e0@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 15:43, Nikolai Burov via B4 Relay wrote:
> From: Nikolai Burov <nikolai.burov@jolla.com>
> 
> Add a new compatible and document bindings for the power domain
> controller of the MT6858 SoC.
> 
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

