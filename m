Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568B3515D5;
	Wed, 19 Aug 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125281; cv=none; b=FVmRletwL26FuESc9wEC+OVW57IEZEDsWZTQn+ZqbeYaYRjsClLy/uMqsn/NFY2kYDqa9suJQ+43FshXpT/+ek3yKdFzCAVINiI01bCZX0r45P9din8RiFBl04ql+ahFsNH1krpc/sGNhpVLvDCP4btUzgh9mSw0Hh/ZBD0HIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125281; c=relaxed/simple;
	bh=L8oGbzvk2V4mXRjUq7cwdbEYnJjsfG23S7DPzRl86To=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HZxauktcepoeaxcZ9YxMYjBGk4CaPJCYAnc94zRekDqNUrd76IsJ58we15/y0hE/1M7wsx1Au/HJgkMykU51uGPHidinwxOYrsuPKJpkVZqAvjkjKYgU5857jq/jHG4b5G/Zm6333gWcp8sapctGpJjySXDHHa8ZDNw6lOGtPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=qKmMfScE; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="qKmMfScE"
Message-ID: <ef9ca9f8-6cb0-437e-b73d-976059dc6f82@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1787125277;
	bh=L8oGbzvk2V4mXRjUq7cwdbEYnJjsfG23S7DPzRl86To=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=qKmMfScE5JTlY4Eeq4wPokXB0h4AnwPIaDvDXAUMzt7Be4I6uiG35n7+JUe+kGXqP
	 Km/Uw9FDV759IrI86dJ5RG5sZR+ovUxraZkswtTiBytqB9feg4nSeAs4Uaf7xDt3cj
	 E6V2AqegDBzwimHL63vAJWItPSyptRfLCtAEan8U=
Date: Wed, 19 Aug 2026 09:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v9 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
 <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
 <64e146aa-4907-495d-b394-7cecb1727816@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <64e146aa-4907-495d-b394-7cecb1727816@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/26 4:34 AM, Daniel Lezcano wrote:
> On 8/5/26 10:06, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> Replace the hardcoded MAX_LEVEL constant and fan register
>> with values read from platform_data (fan_reg, levels[] and nlevels),
>> as new MCUs need different values.
>>
>> The cooling device's state is stored as an index into levels[],
>> and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
>> rather than writing the raw state value as before.
>>
>> Optionally acquire and enable a "fan" regulator supply
>> at probe time and on resume,
>> so boards that gate fan power through a regulator are handled.
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
> 
>  * Through which tree this patch should go ? (assuming there is a
> dependency on other patches)
> 

I think this patch should go through MFD as this patch depends on it.

>  * How this will behave with 100 levels with the step wise governor ?
> For a 100ms passive delay and 100 states, it will take 10s before
> reaching the full speed

Yes the VIM4 MCU accept values from 0 to 100, but here I'm giving a list
which is (0, 30, 40, 55, 75, 100), so 5 steps to full speed.

-- 
Best regards,
Ronald
