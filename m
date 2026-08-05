Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E22EA732
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898845; cv=none; b=ij50+nwihVN7hVtrHlN6oOY5VjB1Eyp6Fz+KNxm09gfxKidFnUyzADqP+7TNiYWzkIwGDMMYvt49ouHlgtMeLmM16srvIX5JR7dkzQNfC3vpkjIJJRfEblqtccxInmEFBUbTBxb73km0bPWM5egPcj4o9ydm+myPVVgrIEutlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898845; c=relaxed/simple;
	bh=+VuQhcSer8nWg4SZeZ0n/RjT/bBZXVsj/z9GVDtu0dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHnaoB0SjFggdHbAE50T9xEp4kRyCLaLPlZQ3YNcGnyxmLnfnDSAD7DZsgXFfqV8eJaCLgVQMcTdHCeKEgy9/bc6U7NXLYxJ5LyH6HC345Cz5YNpQ4RVV46UUcXbLWU1eJHQBW5IGgsviy0O0y1xNNQQwnsVomRW9FZw2+0aFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2kCrdGK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2kCrdGK"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e041ea211so557695a91.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785898843; x=1786503643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4040ksGrhA9/cRKrc6XpBcuZBsxi1FmWIRVWqRAOF0=;
        b=K2kCrdGKQ3JwAXsNy7cX6wfCYUZapIGBqzW1o+2tSXwQlB7m9zWN9ndML6qYP7aKvH
         H31KSBHEcCRVQw7saiDZx7C5rc2SSeXaIELiw6ezIIW0k9RfixaH46h9y3PjPqvCwyIt
         fAUtc4n8VWQYJlkk122x/0yRzvzIJ29PuFO1qr6aKJ23GSwkdwaTWLI2EHus9wDU/txo
         R8FMFXFBxVFwe5L9a6O0Mh01mc8Ipsxm0tZ9zk3hCI3jRmfvUhnueNK1h4fczCcA1S6o
         dr1Arku4QQwAVk4honJ7AwBI5Q8Xwg1SrqE4SeK1HRgomV+E/lc6W9at3WxRwAn9wMXs
         ac2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785898843; x=1786503643;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n4040ksGrhA9/cRKrc6XpBcuZBsxi1FmWIRVWqRAOF0=;
        b=LVJ/dM8RjnuoqiGp+CPZSuZ2Xiezf2ePB15INdqSDnybjigHoyxhJ+BSzQDWTvgtUc
         +6CiRA9zcgUzaf8A1sfKYzWgMmZZ6Vb3yduoJ+HWzbly9LeAxAKh3XCDXv3ntrd8GjLc
         QLa3tgZ/CtZOPsAkt4WmRcRuHH9qMhmsOBveqlmPhjMZ5CftRYRkXIcdVMKY2nruKbB+
         65wpzf1XMfARaRsYXiz9H7cRfESNQVjjDAOwyKn83P4wXBsZx5GdGcEOZsZdKcm3jzQ6
         x67ZMpzzoudOx502OsQi/2L4xLEYEwIkfJrh2ABx2vfBo1lKd2+0i6zqa5J/4NBNF/yt
         5urg==
X-Forwarded-Encrypted: i=1; AHgh+RprLlTzrasqWUptohDXP8E/olRb1raHWHB2t53YEZp1EFOXBrTPOIRb3BfM/uwgTx+hrJFD/zf64Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3A2ocYtNbD/p9Ny+fpXdsoCBfUoAco6ftlnAhL4P23u4t3WR
	UW9XOPNgOSZQFSZSngSdZgIlOlU2vEHRmYxIrb7Fxl0WDtGv0Siengeq
X-Gm-Gg: AR+sD11Z0L8aUUK6+vDr7iLwRSWJEBp27BBvTm/t1sp+aQBnB95kafoFeG9as4FCf/E
	l5MpiRmdKGXXVnfr26IHv4iH510WaLX+Q4FCpSdkGD995oWEo7JLkygyPrOkIL/Ly6/VcjGmTqk
	zYRgt5z2Yaw9g0Bzc9HIk0qiLCAx2h05/ztrEyeZds6WVo2A4knghKimMqM+OEZkYKftbW6onjz
	vJXhF9KiJT38RvPUSYybLUXlzrcqJksjshsqAG8xRmFtUfg/XROe7UhwFOSJ/4iXEEgmadsufLt
	hCLns0YCwxYydxokY/tbWogO8YwA/BRWOTS3J3X1l1ext1fpM3Cn2M7OuwYBsGiNhnU162dn4Er
	JM7yWiZ5aUz04vUeUKqHjh0LSs2A6wQGbgvLIqkWZpL+NwF0wsOY9hcWxKOffQ9Csv6XsACyEO2
	Tqm/2bEJaOEBuQdfxka5Po3SWzny2590oC9AKv9ofS1ch9g26+EiqzpXDsr49K6th/uvv75oN+X
	NmyPrG7DSLavkd7ZgkNR3YDIkuUv+ywL4Hd3w==
X-Received: by 2002:a17:90b:264c:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3903c598e8amr3509484a91.4.1785898840828;
        Tue, 04 Aug 2026 20:00:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda512fesm2887722a91.9.2026.08.04.20.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 20:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04a58bd8-df9e-4c66-ae19-8473d6ab9c41@roeck-us.net>
Date: Tue, 4 Aug 2026 20:00:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: wm8350: propagate ADC read timeout instead of
 returning 0
To: Ivy Lopez <skunkolee@gmail.com>, lee@kernel.org, sre@kernel.org
Cc: patches@opensource.cirrus.com, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20260805014221.16412-1-skunkolee@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260805014221.16412-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 18:42, Ivy Lopez wrote:
> wm8350_read_auxadc() logs an error via dev_err() when the AUX ADC
> read times out, but then falls through to return the masked value
> of `result`, which was left at its initial value of 0. Callers have
> no way to distinguish a genuine 0V reading from a failed read.
> 
> Return -ETIMEDOUT on timeout instead, and update the wm8350 hwmon
> and power_supply drivers, which call this function directly, to
> check for a negative return and propagate the error rather than
> using it as a voltage value.
> 

I am not sure if this warrants fixing in a 17+ year old driver,
unless it is observed to be a real problem. It appears to me that the
error handling was likely not implemented on purpose.

On top of that, as is seen a lot lately, this fixes a rare issue
that is likely never going to be seen in the real world while not
addressing the many real problems in the driver (as reported by Sashiko).

Guenter

