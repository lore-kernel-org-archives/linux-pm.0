Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842343C078;
	Tue,  4 Aug 2026 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832835; cv=none; b=alUbFNAFoAKwtGUWSDSnuhrOw0OvyQVQaawLX/CP+xf+BHT6atZYuGSTd6ELPfx1LCicToFVayHF3brb4kcqf4/WgXCKsD9bG8k4Wfb97Jt/w8p4/hmCTkqhxxWqFMsxNdpkXBTpGY85h4CB0Fz8rjIF6Lw5qrob1amuXhPeGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832835; c=relaxed/simple;
	bh=p2hRbF6OR9u6soQD8uwd3KG20dyyAPFIEut3UyAAn20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eh9eMbTH4To492OEzAxBI5g9Ln1we+8RhFNshDis5o+tNhOeng2Gm4HBa/R82lYxb3ApfT4pChECuQNwY89EJ+pu4gAjos+7e7o7wj39ufgzzKACS1eTzqJUOaHX446ymZXTAxqdDrNWlFSjfWr+5imD4i55o6vC9xRa7Oo7FPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=TxqyMj3z; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="TxqyMj3z"
Message-ID: <42363af0-a2af-4f8b-8ad2-834539c979b0@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1785832273;
	bh=p2hRbF6OR9u6soQD8uwd3KG20dyyAPFIEut3UyAAn20=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TxqyMj3z1Lg2uE0F//7bjxqsXG1z7qyHSQ/66bPbAUtMFaPEBrytueMpUZpuZy/Qc
	 mRmdKvaYJ5Fvb1d8aVSO1M2Bct0I0AbM9nlq/Q7ynqP7UZAka/+kXnAxSBBf24+YpH
	 oJo6XkMgCCF0ivRjz7XUkw654IL4NXB8uGzEVmF8=
Date: Tue, 4 Aug 2026 10:30:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v8 0/8] Add VIM4 MCU/FAN support
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
 <713c728a-f68f-41fa-a64b-09ccecef9157@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <713c728a-f68f-41fa-a64b-09ccecef9157@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 3:42 PM, Daniel Lezcano wrote:
> On 7/2/26 11:55, Ronald Claveau via B4 Relay wrote:
>> The Khadas VIM4 board features a different MCU variant compared to
>> previous VIM boards.
>> While it shares the same I2C-based communication model,
>> it differs in some ways:
>>
>>    - A distinct register map with its own volatile/writeable register set
>>    - A fan control with 0–100 levels instead of the 0–3 levels previously
> 
> That means for a eg. 100 ms polling, the first one takes 10s to reach
> the max speed, while the second takes 300ms, right ?
> 

Sorry for the delay.
Yes I defined levels 30-100 in the DT as the MCU register description
stated that:
`Note: the parameter value of fan normally open is 0x1E~0x64`

I didn't find any issue with the stress test, but I will address your
concern with a smaller list.

>>    - A fan power supply gated through a regulator
>>
>> This series adds support for this new variant by:
>>
>>    1. Refactoring the khadas-mcu MFD driver to use per-variant data
>>       structures (regmap config, cells, fan platform data),
>>       and adding the khadas,vim4-mcu compatible string.
>>
>>    2. Extending the fan thermal driver to retrieve the fan register
>>       and maximum level from platform_data,
>>       and to optionally manage a power regulator for the fan supply.
> 
> Through which tree do you expect patch 5/8 to go ?
> 

MFD seems a good candidate as this patch depends on it.

-- 
Best regards,
Ronald
