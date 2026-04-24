Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706C35F8B7
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024876; cv=none; b=RjODIwinJZvVAMAQcnzeOqiVdL4CDPREIIciu+hTLL/0gcCnIe65W9bGM6pKO4l/EIY92QbsIRE6mhZDcIIzxnydNisLF24RVWTLCQ3BVRAdBKnYLVhM4NZibyOo5KqQL/TUt/IelTEF1uc4nzFwNQip9pIHQ89v3jXiGyClNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024876; c=relaxed/simple;
	bh=i1XmD08sPVyfPetMqZOauvZ1ZD4xqB1oOz6geubur0Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DsYUUJ8rEp1okkDOvcZ55bkDFU00hqHBqVrpC8vNTMunnxYaGWQvfm/IIyCweDNDeJkxov4uEgduq60YM6f6O4D+MkinftM0iERR4c/IJto0sS950aciNdexbEn/hZKxZelom+0eyPFhpMEpoNVVMts+HfNKzw1UDt1xtMo6OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EDACZSUS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDACZSUS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so125138895e9.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024873; x=1777629673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsMn/6Mklq7GQLtU1u5HkQpW7v3yh2oa94aAy8k1B2Q=;
        b=EDACZSUSirW4+wDj/q+LI7M4bFpKMkITehz4y4HjEHR4Fs84qHr7uP5eDSef5dMNBl
         A1d22OyEqCbR52Tbc2pVAWPBLAjgrmXFBUPXR84zfpfs3MOyuZhE8+Sr8Cmcp3BUNmfW
         5GiW4i/bXcHgsW+7cOLUxAxZ1nyASWmEIsJ1ZakKb5Z+TDmNcdX8U1v1TiPlUPANCRsk
         LJhb9aTmttrgweiiKkL5JI5IwF5jpm/nbyFJmrbJMesSkQOr7LY6sFgfxaM86JDM56+a
         KnnCEdsw+Gs7NANRwQzGYn9czUAKbetaXMXN8tSPAXQiJD9zeKZZrH9E8T9CLRTxLR9Z
         BdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024873; x=1777629673;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsMn/6Mklq7GQLtU1u5HkQpW7v3yh2oa94aAy8k1B2Q=;
        b=fOfeeN1B+1KGwsZvYshFo7dO1R7xdCxla9SdCU18G5o6TdZOYNBnDY5WTT11N2fbcm
         USs84HHwwnGUD8O2YPQOJUDDYW/gdUEy3jCZTga1k1GNxkwM/rQO62ZQVJ4OxY2VvKbK
         iT5HhkphjFRMbrZjIhzpJ66H4Bs+ZXgXFzL5I9TeA7z3VorR+c4ozFDn0jNMoW5Lzgbq
         +GiMDDa2/TZkoQw7i9zcgwLn+N0FMf+bsUZCBvAGRp6f3C3JrgCD0WrvSBJ/URLpR25l
         xzgpoGFL+PGN5W1+ClgCyksu28enCn3PNeJSIM7osYmVrlOhY4KJ92sBU8VYj4owrmqO
         tXUA==
X-Forwarded-Encrypted: i=1; AFNElJ/RP3KI3ljH1Qrb0pwXiFaYxFV7etyBaUwnOwh7lKs0cWatL8isrwjcYJ/pMxZQTRIwU/lTDjyJGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCVBEK9zZN4zJoXhaXPtL4ocI64dQt4P8W4ZDyVmqf67SPhGI
	NpjxxlANrQN3fb8w4nxxjcTWp8l5kArd5ohqBwRJGiP5mvTb3GyQKf0lgaGXOMOZq9o=
X-Gm-Gg: AeBDietTvuB9pIzraqHqGfzCrhX6j+g+bXv+PuP7PbADGp9mc58EiGUYBFsveSs3aLG
	I2cZyZKfu92OP+BNNOx00Jd6NC5qXw7dLzfYCCTU6weI5/YPZ/8jmhHG5do+q2/eep68cK7x8H6
	YMuM5CqizPZyzGm7cO8DbppF0CpMuJU2WM/Olm4wxu3wBOqcuBhfVXd49l0QDf+E6fQWmnmS6lJ
	Et4DLKMPBLqDx+6x8rRAciUge1Xtnf9MSdcKzQn0cQLUGJt7uFTh+QOFP8JX5op0imGCn22x3lV
	pi3u1152sSJaKQmX1IAFXpfMECIFTcFKZA9XkxQyEyYLVR2U/hFeiyoWVuyHhXB86HCN8cpeZoP
	84wuwF8W45Gx6qwBXcHOWhiNyMLWrta74ES+y8ekXKa2NZUGyqF15FGRpuo2zeyD7E5tkW3Y/ni
	k43oUf7vQ/W5FbyTJBQmeEbaCd8w/RDnC0kvIC3JLnrwQvKtHOlnBbL+woPHZFR65BDj1zXzCVl
	OLXczPRgF3ZrgSdkQ==
X-Received: by 2002:a05:600c:350e:b0:488:a82f:bb95 with SMTP id 5b1f17b1804b1-488fb7861c0mr465740345e9.29.1777024870872;
        Fri, 24 Apr 2026 03:01:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6124d7e7sm136810305e9.5.2026.04.24.03.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 03:01:10 -0700 (PDT)
Message-ID: <f05e4ca0-1fd1-4900-9af8-6e402887bf09@linaro.org>
Date: Fri, 24 Apr 2026 12:01:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
To: linux-kernel-dev@aliel.fr, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
 <20260421-add-mcu-fan-khadas-vim4-v4-8-447114a28f2d@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-8-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Enable and configure i2c MCU node to get fan working on Khadas VIM4.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   .../boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts      | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index 69d6118ba57e7..5d7f5390f3a66 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -157,6 +157,19 @@ wifi32k: wifi32k {
>   	};
>   };
>   
> +&i2c_m_ao_a {
> +	status = "okay";
> +	pinctrl-0 = <&i2c0_ao_d_pins>;
> +	pinctrl-names = "default";
> +
> +	khadas_mcu: system-controller@18 {
> +		compatible = "khadas,vim4-mcu";
> +		reg = <0x18>;
> +		fan-supply = <&vcc5v>;
> +		#cooling-cells = <2>;
> +	};
> +};
> +
>   &pwm_ab {
>   	status = "okay";
>   	pinctrl-0 = <&pwm_a_pins>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
