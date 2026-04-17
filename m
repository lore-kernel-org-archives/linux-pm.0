Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B612264C0
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431182; cv=none; b=odsMc0CFLqT+oHNvjn5tTUmcyFLMPRXm+IB2MYqzHr/U4jmW/km0pB92NLC0+TwRFo9V3VUGvejR+U1P1aKrAGvusz9eyFkbnQbL9cMblgbX+kQK9e+3sNMVn0UPPLkpAullkRkdtftWtx3iasHAgLqfbE0l7WoJYt6/l/sifzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431182; c=relaxed/simple;
	bh=ArPcEjtZ9SivxH550C9rk73iUbB8go/eI9x6T8uYRDs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UtDUZeHMXGVlzK2pqVezbnaF+bZdd99Ctc2i+J2mjzqGfhuQEuyFqT8F6WdjjdfS0muJrVqlS+kr6ODcICyJOkgtiu14ozBThaGbmX9m3ybDWN+3MhG0sEFz0sHmGdiCsPffBwK2VQT6018oBgMu9+s3xgpnqJEydsEBREA2xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNM71OER; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNM71OER"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d75312379so1148764f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776431179; x=1777035979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ArPcEjtZ9SivxH550C9rk73iUbB8go/eI9x6T8uYRDs=;
        b=oNM71OERX4KhOiKjcbBD4pV5dVL4SdouB5WISWYHk2dYkwPSUdV2Z3e6ZG+ovXx8b6
         MHkjHw8UkV1KqhC8MbkxqC9+0N2npozrkyh6sHDm+TaC+AVkB8nWEMqVB+K2O6eLJR1T
         tJPl2exDX4Tr9/Py12mOxNLtG69wJy6cOdLx+lFqmuQL2jjQ1YnJOH3qCQmuiMTDuuok
         AHoDhBCOU9MLdpAE5mYL4RQxzu1nn4tj9XK/cwa0Ky95afRGLKtle/e3bViA6X203luN
         tiktKkPVFbjw+osnIgutB5VtoEoyOFqnpKPmDyfBZekI2NeC44StG/SdC77P/g9runqt
         nlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431179; x=1777035979;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArPcEjtZ9SivxH550C9rk73iUbB8go/eI9x6T8uYRDs=;
        b=pbFIDfZYSDLV5nU8PCFozqcCkHAcyCs+HdapB7wuaJbnW1YNhZirtLHmmmBeynfBUI
         tDsJCGv7hbmFWBTG84Yu8g0kdYrlCkw6h//tacYI9i53Re1cmcLMJHOA9NPbugr2+LEx
         D9OlwKd8D91ByQhJLyE+mbhLSD4NFnUE73c6bi9RSHfW8QdOOA1wE5DygEX0MhzHeCNz
         UlqYPc4tZxLoF1DlGftAN7sTbGG4wfVT7umxcvB238o5qKNO8xaGpm4+ZHrAKMLqvchb
         aRetM/SpqaLNL1FXWsDdyTBCcUs+hyNnUaWYtd2sKNjSb4OvOTl9T6PQzzbg7JgoTG30
         +PNA==
X-Forwarded-Encrypted: i=1; AFNElJ+ivU6tpN8jCdxat4/gpGF2WhvzASEsbvTOZfkgrkBFghhwH0hER3USbAdnIOCGKQnM/lodqgclhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uPMgHnqTptEK+NcZmLJUnXuFpxujpqJJ3Ru7ucb2kIb9OHoE
	H4qxKRQ5htIZ9NQQVuT1W3ejAkI1w9JwtjckW3xtzkxAa8pD7LgThi3TfuBj1OB+cTs=
X-Gm-Gg: AeBDiesr+MHVHX7REsoIzW4lO8odJewvn6go0nUIgJ2pWcCEMCm89UL6Z5U/ZUkl6Hf
	RBO3fqhevvyC764xSvmcSjQjXvCD4phJcxobW2Y84F8+JGXFYiu9nuALXVBTJXTfRAN17Q1YzmH
	Z94rjr1HbbNqhc8nvicEddc/5GjzDJMQqxulFS6GERGwAZVJB47iNxmZiTZfKDWr13L4LPKNMS7
	p0lpih4qkyhJ/le8wmFbuY/vDh4sPB+3cSWNx4q/oYkSqFMQYNHOvoXZqGVS7Yna/aVNCt+boTr
	37vrftsveKE/6gZ6Lk18s65ptqvdhUekLwZSB9fXgUFKja/h6R155krZnfFhmExVWWWj106VHS+
	IXqKBQxkhtlts4jCFi/GN+prCkYvKv0Tp1ahAMN3cOZbMOlcMBN8Cqp+tQSe3zOfGrZeEFhEtUm
	E6N2GqyiPcNzg4jesl50uUZ2ZzLMpNPVZLjHICDBoCrw==
X-Received: by 2002:a05:6000:210d:b0:43f:df55:fe5e with SMTP id ffacd0b85a97d-43fe3de41demr2740203f8f.0.1776431179277;
        Fri, 17 Apr 2026 06:06:19 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm4687367f8f.9.2026.04.17.06.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 06:06:17 -0700 (PDT)
Message-ID: <976440e5-f433-424f-8ff6-c7553799f1d1@linaro.org>
Date: Fri, 17 Apr 2026 16:06:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>, daniel.lezcano@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
 <63087cad-a8d1-4ff0-870a-6e1a738ff8b8@linaro.org>
Content-Language: en-US
In-Reply-To: <63087cad-a8d1-4ff0-870a-6e1a738ff8b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/26 3:22 PM, Tudor Ambarus wrote:
> No, it's more than that. When I talked with Daniel about this driver, he
> suggested I shall really focus on using the .set_trips callback instead of
> .set_trip_temp. I'm not sure if it's possible given the static nature of
> the ACPM interface. So it needs a bit of investigation, which I couldn't
> do lately.

FYI, I switched to .set_trips and testing went fine. I'll recheck the
review feedback and resubmit.

Cheers,
ta
