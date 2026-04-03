Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD83921D1;
	Fri,  3 Apr 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221413; cv=none; b=ESDAezU+WPxCe2TdIaLME499iK8Q4vhVBN0dvP854kTNvS/nGmxkRTgPmWyg4oYYHud8fbpg+32+/aDzPGYmNMR5sNoa0NBZ0csIcfk59l2vSRcN2fCHLaxUxF876iT8/5aDF/hQjVym9nLz3WXtV7wxgpAAcCepBNd3AZoXCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221413; c=relaxed/simple;
	bh=+9FACoYqa7lh5gsKw23xvcRykRBv/FQQ5JtfDVe7hfM=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:From:Subject:
	 Content-Type; b=j8uFS6GO5NPGQCoYPcx+yj4sFtHjd+Ij4JP8eDp11/7HP25fXiIdUT9KhKFpoiUwu33FiDxZ6cgSsSH+teIWoZhnbFoIfhc2glXyxGLz7hESe/AvM+Rf/gltkJx++IBPqgt3etBhOqNkmYv5wPW+7HYkLlTVKZwiz7aV7YfBmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 190E5834762;
	Fri,  3 Apr 2026 14:57:59 +0200 (CEST)
Received: from [10.0.0.2] (unknown [82.65.243.93])
	(Authenticated sender: legoll@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 8B5F36014E;
	Fri,  3 Apr 2026 14:57:26 +0200 (CEST)
Message-ID: <36cca49c-0cb4-42b9-87ae-702df825a4a4@online.fr>
Date: Fri, 3 Apr 2026 14:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
To: alex@ghiti.fr, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org, dlan@gentoo.org,
 krzk+dt@kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, lukasz.luba@arm.com,
 p.zabel@pengutronix.de, palmer@dabbelt.com, pjw@kernel.org,
 rafael@kernel.org, robh@kernel.org, rui.zhang@intel.com,
 spacemit@lists.linux.dev, gsh517025@gmail.com
From: Vincent Legoll <legoll@online.fr>
Subject: Re: [PATCH v3 0/3] thermal: spacemit: Add support for SpacemiT K1 SoC
 thermal sensor
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I applied this series on top of:

- next-20260402

- 
https://patchwork.kernel.org/project/linux-riscv/patch/20260330-orangepi-sd-card-uhs-v5-9-bd853604322d@gmail.com/

I need the the SD card series to boot from SD card.


I'm also seeing the same "it works" state as Gong Shuai.

So you can add another:

Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2

Regards

Thanks

