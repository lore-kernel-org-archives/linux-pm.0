Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023D438FF6
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835927; cv=none; b=at80nZAY2tXe0e6xpsCSB8EbtyGGwTJ5PA3ClSgjngkTLffcSaHZUgam0K5BY0Oc0eaheSYRO8Cyn+9my57aT42V0BNExnLodFMVK2Z1+56ChP6VejMD/4guws2BxB8qr7KMOv/e10MDnNunsnX7ARb4Dx7/WqAn8UeXhp9mvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835927; c=relaxed/simple;
	bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnsnAZWVU5nQg8i6UW4TgR2Bunk/Ay+tGp8/yI6YVfo74r25HPtWo8GCcJPAWeQvGv69fGLaK4WOqy+qCO9jdLDCEL5vV79A7WaByu/XbsWKxI3s7HQ1qVCZWdUrgisgySavXzvM3HT8smwi6ccHCe9BevmEimS9XmFfd6vNfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHyyCsJe; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHyyCsJe"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39380e79936so105687931fa.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778835920; x=1779440720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
        b=kHyyCsJe2muVQQwvt5wzTDwFbOnpO8COGH0q1Pdfoium2jscGMdGqfANjXUVrUE3C9
         VnMimtm9+Z4/jWxsOwkxKqH06B7crDANToskrImuzZZmyEDQI5LkBfXmHgCnCjeIMt/F
         vglNcNGR0xahOFJallcd6yaIwYmzRlRgtyLXajTCN7l9vdELtSdSRAJ2M1UTqDHapTjH
         +Yz4pvf0EtoJ7o8/ZfKeQJmhUTokJQ63FCH4yHaaMdA7oIeG4SlNGyE7tTwahzxeRMxW
         6zcIjq4E3xbTjJ/O61qgrcXbwE2hBicr9E9UmN9PXmM0RVnfFy4BmejiKV8+3gRLe3n5
         hg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835920; x=1779440720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
        b=kGX0/I3XcLss44N3qzCirjheT9/7D8rYLOvTGtHD5bf3X7W7z9hMq+8TOO1hD9Ail7
         80iXORfH6hq1ZTVolNjFJqW8ZLnULSP+ARpD3aL2l2BLr6sp2j/5WcfBIcJ8fVpnb6SD
         GWXlARTNWFOdhb9FyomjiGyeu9w3GVwFtqqL78QolZzm6TS/Qex/PAhU4f+kZ/bUxB/+
         KE0cwZmpKmolIGZMMYCx1tRGwAjrkaEt63CgGD8fhwCSopBHK9CnJDJgvEu0454WQiQR
         /UDohV8oykzaZhXDECsfSIhGofiS1ay5CK57RyAavpCQ27lizud8hyCT/Ke0w0kiHgor
         vjKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kPPrWszX2mINBqbWkYL09NuDYbxgOUh4Mh/FHvt6VMel+kSun/6889R4noro4qMMksFU7VGbE4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBSl9+EB5Yw9Dj8w4SsAyi7+DA1Bf+dhaLpmIvw3Zz8dT09jQ
	0g4hg45+0zmCNFf9+ApJpm22ymQtFqRTNHhPlO4CBIT6ff0HC5mh95ebeuAw48epYV4=
X-Gm-Gg: Acq92OHvlgungW7vSn7D2f3xrJRjN+du7p5XT0chLfm0QHUZwB/kjytsdx78o9ym2V7
	p6oGryCLGw41PX6T44r2omR6Q9gu7Dg4tGsI4deMYZLVADyxJrdktrnEzSvIE69u8Nnky/vjq9K
	1lLrRTcsNTih1/PDIsa8wp8G864fcshjfhzjn1aBJ92tpEt5dbca7SuSci9hWbbHDHr1NRsvzsV
	oyiRMuH9s20ixV36Kd4GFavbp4yC3JyYpIvEfJOF7o+0nzrCcmpNwmDDbREgCnwJ8Jk2L859TH1
	O+qO5QlWJLEroWbrFje3jYgbX0eGPeNJtjJooQrLWZmcn/iR8m55fRNVjQsmCcwoWmt6mKm2UTF
	CH57pzEMJjFJ1Lwre0ehWxduAKVwu/a5XD6yC2HQMPgKiWqY3fXOcKywLJp7euV4s2hg2Ixfl2A
	ZTo+SqSXVOq9MdHJ97doWJ6CGY+wclnr1b
X-Received: by 2002:a05:6512:3ba4:b0:5a8:6cbc:60f3 with SMTP id 2adb3069b0e04-5aa0e769d53mr851416e87.34.1778835919654;
        Fri, 15 May 2026 02:05:19 -0700 (PDT)
Received: from [10.11.12.109] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm13447979f8f.33.2026.05.15.02.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:05:19 -0700 (PDT)
Message-ID: <e91af899-9ff2-456a-a54f-613b859260e7@linaro.org>
Date: Fri, 15 May 2026 12:05:15 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] firmware: samsung: acpm: Drop redundant _ops
 suffix in acpm_ops members
To: Lee Jones <lee@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, willmcvicker@google.com, jyescas@google.com,
 shin.son@samsung.com, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
 <20260420-acpm-tmu-v3-3-3dc8e93f0b26@linaro.org>
 <20260507120003.GG305027@google.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260507120003.GG305027@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/7/26 3:00 PM, Lee Jones wrote:
> Acked-by: Lee Jones <lee@kernel.org>
Thanks, Lee!

The set evolved [1], but this particular patch was not changed.
I'm going to carry your Acked-by in the resend I'm going to do.

Cheers,
ta

Link: https://lore.kernel.org/linux-samsung-soc/CADrjBPqzKpcd9vuCmNUptCUPyPpPbHcc19-7kN-1c0RpW1e5DQ@mail.gmail.com/T/#mcce154a7e0c6cd1ca6cd5a1e37541ed7a85a84d4 [1]


