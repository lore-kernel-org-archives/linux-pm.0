Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2840927A
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527654; cv=none; b=kksPJ410z5Zl5WiOO+NgA/xZ4Zx0TjkQOptSQpda1VrrGi0+0/SG0FQSZAWxNy6Gs9LzK9xH42v0O3r+cN8f6J9WV1/hoLGNbbNSgUcoBJGBaLGtcxlw24kuyDzP4/0wGLBTjsYc0u6jZjjCXsUvaPLH7cARn+JERJwBp6rgPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527654; c=relaxed/simple;
	bh=vEnWUoUaz+j1jutZ0x7mn3UZx68qpKOkRpdbj6GiR4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGgiKzISG+y3zpdBULUyNB82pEvUN9V51El4r/fhx9lt83IiIdPzU8gdJLjCu8W4JqxYRye08l8+yz6v9goxRgWHqof+wobIiKyb7iq/lngb8+if7LNifkkNP6sjGzlHA3WSkTR2c560jZN9hk4UnghL8b5MxGCfOQxwSkUnvmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFi6eUae; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFi6eUae"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c74722e27so10445131fa.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527649; x=1787132449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dz/gXZ21acjG3092zZMnoEfpN4U+nzeRDfy7pXv4tc=;
        b=bFi6eUaegxpFKCUdkGx55uamKhQFU5NhFgKu6SOXKPmz5dMu9QrHXQTj7gMOu8l6GA
         rKMEtyVxKcRSl2uUJwPCzSiYJjNh7WfRufyY4aF2H2HLHB29zUh6rFCGZYF1dWZZLqbz
         1hgHu8J/MeDAazc9FAGXkzm4ioBc9/wDCUw0zyzfGmY+LEHk5wOjgtHfX1cmNglcTVM1
         1+754oJrU9BUEUNnxzXrUiMBPm1byGG31+a/kqy9dLSsplFz7GKRcVlj0hOi8Ps7JvP7
         InaWJv/SlY1ocMKZfN1LfjF1vT8/xUTJmesTl0tW6D3hsUnLnAFjyth5kO1h/MnoEv4g
         mWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527649; x=1787132449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dz/gXZ21acjG3092zZMnoEfpN4U+nzeRDfy7pXv4tc=;
        b=pVD4QxJGAirGbKn4WOlNbkynpZJ1DK7zz0dlwpugjizkdvFAvZcpHQwxb0qWLONAAz
         o03WomLfkyb3xdGp1CBMWSOY/NV3n5IdcDplF1c4vZvhFZ9ZG+Zz2QqPn0AmQuOpxkca
         Ff/Lzyn5y7jF3+ruPEU9LhsjzP0dMXAID/FYMNAJyNIcX3lOpOR2lZq39L8lt8lFx3+m
         VX30Q63vweCrnBPEPPcz5fbJCHMPCDc0vhh8gNX67O0Gzd/sUM7lHC1M6Ke8oAhwFasj
         ADmyVU8ydPUF1vzQ+q8pLe/YaqhkdJXxX02gdiJlSeyJO+ZMMx9NoxoZLfdtjc0QmsBD
         waRg==
X-Forwarded-Encrypted: i=1; AHgh+RpegG49fd0F/uNjDTK9wEWUoRopkVFeAj96RuK0wFMr3dYL729q18lB77wXETTJol72dFy9LPwSHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS9AlfUAJMHulrFOBDTUhzNn5LjfNjmCfHhqu8djuq6bRvxLKR
	mvvIDU2zrJOatPZibFhaa9Q/6BLPKwgpJ/GrenOqkLUi8jmhakCspEk+
X-Gm-Gg: AR+sD12YQvCsWx3RCvpWS27IXh9mVQ+esn3SPcLHkhLeTz3hmxBJ1qiiuhtD45i8iqb
	fbeaaR6pUzE5p+gql5uJ3weIO3F/SYiLLtlqnKZE42F84ZMd1fdaJoVZByTIje2ae14KZSmOcPO
	IiTDT8JvjRjRbYrLaIesQXyg9iI5KM5t0SYwPsb3TE/chHlr2NohRdjUpX0nvdKogNSXfYMwlVk
	s52mDOFJCTQaM3KXM/M9APdtexfBQQuB8h4noCpaOzrp10Feg0HfFq51xzJspkiSuvUAhBEvnRQ
	hujH6a4WqPsylErNRSLeveRkE7ZgMeEIFUmwm6iOdutnnRQ7j0s2IjXpLptzPpOViONcg3GKnLG
	J/sHwnJR3Y+DGdFi+QSXUVGIV5Mks0lsM6akaXHd7f5HYyK9sQYmJKPLwPvy1SY2e5axaCe+vrj
	4gG+DmnxWQNpqFMM7L3i25xU9lw6uPBuN6EqFDfX0g8cpsVOhX/D06Uzko4tmXlsHBuT2W
X-Received: by 2002:a2e:a9a2:0:b0:39b:11f9:6132 with SMTP id 38308e7fff4ca-3a102a5d000mr8943151fa.1.1786527648997;
        Wed, 12 Aug 2026 02:40:48 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a107d20f1esm3277211fa.16.2026.08.12.02.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:40:48 -0700 (PDT)
Message-ID: <1b08ee53-5adf-4de1-afdc-4419797142d8@gmail.com>
Date: Wed, 12 Aug 2026 12:40:47 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
To: Andreas Kemnade <andreas@kemnade.info>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>,
 Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <20260812101050.575c9bfb@kemnade.info> <anwsIK9ITpcDkZos@ashevche-desk.local>
 <20260812102536.63579b89@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260812102536.63579b89@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 11:25, Andreas Kemnade wrote:
> On Wed, 12 Aug 2026 11:17:36 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
>>> On Mon, 10 Aug 2026 13:09:07 +0300
>>> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
>>
>> ...
>>
>>> That code is complicated. What about a generic 16bit non_2complemented sign
>>> to 2-complemented sign function/macro. Such would have prevented the error
>>> in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor
>>
>> Do you mean existing sign_extend32() from bitops.h?
>>
> 
> I don't think it does what is needed. Here we have
> 
> 0000 0000 0000 0001 -> 1
> Usually we have
> 
> 1111 1111 1111 1111 -> -1
> 
> but here
> 
> 1000 0000 0000 0001 -> -1
> 
> If I do understand things correctly. I not find something useful
> in bitops.h.
> 

Thanks for the review and testing Andreas! We share the same 
(mis?)understanding. ;)

I am not sure this is so widely used it'd warrant a generic macro. I am 
afraid that if someone encountered similar design, he would not expect a 
generic macro to exist. My gut feeling is that this is too marginal to 
be widely useful. I am not against it though, if someone wants to 
implement it.

What comes to complexity - I agree. The code is messy, but mostly 
because of "clever hacks" done so values are in arrays indexed by loop.

I, however, would like to see a minimal backportable fix, and 
potentially, larger clean-up which can then go in as a feature, without 
any rush.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
