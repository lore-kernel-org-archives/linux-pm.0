Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EB36D512
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007450; cv=none; b=hfvlB1KzIFxibYtD6j6NF2uRdxT+nE0Nn10S7JmNewM94mIl9o3Q7fN8SjuPXBz7KzkdYRKH/mFFHSO3guZy15e7dl878WfGVr9tfrEQ8K8k4ElAbj52PpTWEB9LOJsZrE9vhN9YiG1aAMlQppTUIO4CRoRryQ9yFCVMUDP4KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007450; c=relaxed/simple;
	bh=7mY4ZLLEtPhXCIzYG6qT0auuWpAN+xsmJ6MePgj9U70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzWcw+mgETekKdCYsObZ9/XXNu8tqsudG0kDBNyNXHegZJXUIHZ0r38w87c9pSFgV7cgatzwlGKsaQCdyzc1cssFHkHUQY/aIEXn1Mptz+y8ukF5RHz9qJZ8fE9xDRd/mOs7pNsci4ExvA+LNhxWuD4uwb9lhZ67QKJFbMgWnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVQVXxTM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVQVXxTM"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso2564393f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781007446; x=1781612246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sf15Qn18zljQFqjYtY+ttqovVDRkyxEeVFCISge3H8=;
        b=PVQVXxTMsOamZccx0PR52rnSacwaUSO0Wr8g9gKplkHQsHXGFHmztBfWlAmYdrvIj1
         NQnlcqGUaSmWhMklqIUXg/8am1A5naQQroZJjRXXxGUkNNF9bNL9HqP0QAqGFRLsXG6u
         BP8Gj4goS8iZYmWkLfFlpqYu6sEaphoZKRQixRRxIfRvirMBcANrqa2sgOenQ1mH4GYQ
         aqwkrx9GznkR2vNunSOS324nJbdoseEnm8lwSxxyaX5lPMvOpDELaExK5Nx8h/q4O4Lz
         zG1kavv7BZoyoSggAFlBDWCBD2ceGj+Wifkc6jg4iYytXxbFp2YGNFcqr8jvWOFoWM30
         gAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007446; x=1781612246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sf15Qn18zljQFqjYtY+ttqovVDRkyxEeVFCISge3H8=;
        b=ZapSu40ifLc0nNis7ws40GSV44LIO+JB0puWpHyt20jMV7m4dzpWJD3Az63s3T04r7
         rll/erAh72BD+HvJxpUy2ESf1XvoJJrexpP0elgvKtFFDZwqN3LxzKPt+TrnCJ5pw8Xg
         xwuBW2pzlzqMqZJeCShy0Z+fZeXHMOxhIOC+qgwnd+kSHHL0eQop1F4/JLXoVUz6eNFN
         /RPzyethalb0/JW0yWH0zMRk5H8tJNVifCeQGt2qHAPNy5rW6uND9xHz6GCcQa54R88n
         uKeb9Umxc2THE1KASid1a3SsTDx8huiFRE/4ffYbLtVwv3L9bsnOZi4YZRAX9wdB6/T2
         n/mg==
X-Forwarded-Encrypted: i=1; AFNElJ+t3qp8mryiyGfXr2kRoPlOCbj8MkKFPyyeR6cdFB7AY7Kwz+Lo3eRZl4AmbN8R2SPauPclTW/cog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOp+LMUjh4CGEM71YgHPtxUJOAjzK2n39dQTBzZ13FyxNbsgDI
	xmoaXsNGp5jPv44BwDYKfGY1wHxwJivljjSEGIqpI6OIa6U6aB5hBenG3OSH4XIspvU=
X-Gm-Gg: Acq92OEKFmQ4AEkNqxW9F6/heqGF/d7eo5AndJY4hMmKgDQAMCufRZgMvS/2Qoj6xtr
	maS5P54G1Owyqeav6OLtAy1aoxjyD8FXTCGZ4RXCus/a1t17CxzEcF8en4d8BzCALyRiVbhO/5z
	Z5CVBJKi9eewNGXx0iggV0U6TOWTo3jyZjtGAUcyaxE/nGiYgsgP1+4XExIlm/f2VZVu/ABQlMz
	v1OyhGQSM8/6+xWTHGm493sLO0nJ4bvG81daNlQaTL1Djg5K7npFdxXNwTb+kOJiRyomn9z2g+P
	jlwjbXrxJtr8Sdt4a/ZqsUiO39xpw5fAFn7eaxBWkiVBWI3Zu+CdAHowosWjaXZiWqOagsXsIAV
	Fy2/5rboz81d2wMCmd6qN35tsqO1ujJlKAjCH+vTBoC4xradQksdfVGbafs+t0RKbA+a+xKoh2D
	qtm9pPcszi3sW2UbwdGKoKFjpfXNrAWZJvQEDExCZ8T6jjmyYZgBMz
X-Received: by 2002:a05:6000:25e7:b0:460:3233:beef with SMTP id ffacd0b85a97d-460566dc381mr3315017f8f.43.1781007445883;
        Tue, 09 Jun 2026 05:17:25 -0700 (PDT)
Received: from [10.11.12.110] ([82.76.215.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm110033645f8f.27.2026.06.09.05.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:17:25 -0700 (PDT)
Message-ID: <055b5f99-887d-473e-8211-aefb253cb549@linaro.org>
Date: Tue, 9 Jun 2026 15:17:21 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] arm64: dts: exynos: gs101: Add thermal management
 unit
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <20260603-acpm-tmu-v8-4-0f1810a356e6@linaro.org>
 <08d7299968e14e5fc07fa4791479abd9a2b11c2d.camel@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <08d7299968e14e5fc07fa4791479abd9a2b11c2d.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/9/26 2:44 PM, André Draszik wrote:
> Hi Tudor,
> 
Hi!

> On Wed, 2026-06-03 at 13:00 +0000, Tudor Ambarus wrote:
> 
>>
>> [...]
>>
>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> index 86933f22647b..b6866ef99fb3 100644
>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>
>> [...]
>>
>> @@ -639,6 +647,15 @@ watchdog_cl1: watchdog@10070000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		tmu_top: thermal-sensor@100a0000 {
>> +			compatible = "google,gs101-tmu-top";
>> +			reg = <0x100a0000 0x800>;
>> +			clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
>> +			interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			samsung,acpm-ipc = <&acpm_ipc>;
>> +			#thermal-sensor-cells = <1>;
> 
> Vendor-specific properties should always come after generic ones
> (samsung,... to move to end here).

Yes, thanks! I'll address this after I get some feedback on the driver
from the thermal maintainers.

Cheers,
ta 
