Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FF42049
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770480262; cv=none; b=cI9Q9dlgjL5h7sibKcuiUSNmyT1p8OUvc1Zy+fczXu+gu2s67OvLdS1akwFEEm1bYD68+ChQWb9aCIGyqdMC0hdU25SPc3Bn8pSqrE4gVewGcKeR2AMsNB1kvrPyR3nC/2xsi9nkHlxtf6DimjdNKwdxnRul69rKAmEap4Ii5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770480262; c=relaxed/simple;
	bh=NiF+hSze+uFtx4K1pSH97Qk0CJDDROC+3zDtnvHgYqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNwMa4V4QHgiV37wq6gHsF+QgzPA04N6HziLbjdttNHqipTTn4MStohGc67n9A6/n6BGJnvfRyP1rn7yvpo0w0la6aP17fz/YKYwH0fsX9TV5FHtlLLzxZfZH9QHTCdpRDPBe4jxpCyTPp7+drraUQA1zk3UKA9HxuE/xNWl1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UDxGxanI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDxGxanI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso249277a91.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770480261; x=1771085061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07AdAbiuuOL/VfNiqay8fs2J/Ey0wXoFVbLJZzRR6n0=;
        b=UDxGxanInQvZUaruIHvHjol/dAqvKcGxOIPAlLAR6q+igeEoUhgYkJVTnUlDgIQFiA
         ZqvEmk7VwEDjVUM2ijKDQpqO4PXw7LLq1cCOf8PiHzEWbQVvNCiXFMuu71f5FA76ycyw
         qe+LMBBoDsxmXT5bTlWFuSYCfn/EOS+K/dqzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770480261; x=1771085061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07AdAbiuuOL/VfNiqay8fs2J/Ey0wXoFVbLJZzRR6n0=;
        b=RthSLylBOhvyFqSIkPERgLSwvVh+jzKuLpDJOZ/R/cij/MXNmXS3QZjjHPEZ6Hcv8E
         TooihR7t4Ov7qgu5Hj8RP86HrLhZfcKCs/TpB/mGQA10EeKcr5uoqxjj4R+3NRVgYnVP
         zbOtL8IR4i0yAtaK2h5+BprWBKTG2AK1w0Nsxym7AhMPwXA2Fhp0PewKOMl5fB2cDdGH
         h1WNpL8NGBqjN9bk4ZqzHbkitq7cmLaBElhLKMz4VMiKQMnGI069eFVCa5VzUaKD9EyY
         IIkOJydnJ08dc6RRJmNYqWTMETOizr5Uy0dDxUyjr0a2hVxzNKkIZHQJVxUmswFVGizg
         WWtg==
X-Forwarded-Encrypted: i=1; AJvYcCXbFjEISMyso+TxpLKIuOT7wqN2bqCYrIhZHFzFmeOEJVMLUdpNIwTqdXLZ4ryuPhqgdnwMT0/ZsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/0iKdb+QZH0R+Pfm7hhQ1a1FX21/NDkkccIOhBj5Oy76bcMa
	7DH2enq3JQU8V5uUobVS9JMeDiCTyH5vLXgwnv6EVMbujifVhr/ot36vY5iyJ5OiQ3M=
X-Gm-Gg: AZuq6aI4KzF3QOMuQTZFDNvUzpLzES5NpevRTI2nX2ShRQP0894+7h+iDt83/o/u0i7
	ffSOhSV0nNzDn6xaKOuRg1w53S+yO9hADQCEjfjjM+78Xk3cSw5l4i0UHlkVnwbzGkuBpu5x6Hk
	YcCZv3Y8eNjNGHQBQ5nQKmGP5NCpBrf/sEDELxFi8mKGrRLq+roRTeHY0KucIfwXxq8hUwSMmYy
	tCfMd8wUpKJgNCrv7umT8IywdWscX9oGIxCZaM5nQZpmMzxc7/PeXZBJLCo5jowWjJGahKLN8gX
	17wI0QH7M1p8h5unLuPfhpokx9/mKXAaOoEjOgcdOBQvq0pT40W3DdIebhvxtvcvxvY9X7JIfKK
	KJmsdTA4b0VsxRYwLdwQ9GF4UBfEySL7Rn2DiYfuHwTk0tvcgMnczB+xdOVR3/CZvJEoQdbHBUE
	BAfqK0nDq2pwD4qT4RXFEPbsCZL0cid8juyUs=
X-Received: by 2002:a17:90b:3a0c:b0:354:c600:1a1 with SMTP id 98e67ed59e1d1-354c60003bbmr2416485a91.19.1770480261380;
        Sat, 07 Feb 2026 08:04:21 -0800 (PST)
Received: from [192.168.96.30] ([49.207.181.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b2253c70sm5866108a91.17.2026.02.07.08.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 08:04:20 -0800 (PST)
Message-ID: <e4107d75-4b69-4b7d-827c-af92b913d342@linuxfoundation.org>
Date: Sat, 7 Feb 2026 09:04:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Replace strcpy/strcat with snprintf
 in powercap.c
To: Sumeet Pawnikar <sumeet4linux@gmail.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260131164233.7924-1-sumeet4linux@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260131164233.7924-1-sumeet4linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/26 09:42, Sumeet Pawnikar wrote:
> Replace all unsafe strcpy() and strcat() calls with snprintf() in
> powercap.c to prevent potential buffer overflow vulnerabilities.
> The snprintf() function performs automatic bounds checking to ensure
> the destination buffer is not overflowed.

Why snprintf() - why not use strncpy() and strncat()

> 
> No functional change.

Why isn't this a functional change? You are changing the code to use
a different system call? How did you test this patch?

thanks,
-- Shuah
