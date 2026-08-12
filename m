Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD17417BFE
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527477; cv=none; b=h0NPHp9Ayo4xY95SEAArEM5GI7L+BRxoNVPfE+T33GO3PUBTnHSPy/UpirSFTL6tRzLOllouqY0LknDNg2+/8vxtz5/LbM4cSCki2shjP2wphq3eWL0UKggbyCfl8n9Bn4TdX6n816vCXiao75PcKsD9N2IcpKfbfmyx5bN/3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527477; c=relaxed/simple;
	bh=C4bLTv/UPCm0japeSDoAsmgVMN4qRsfv5NjzdOOwTlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sj/XxrmRZ3XVkAuMSYBcJTB/qLLxPh9sTpCXfWnrOeFQbLNTewSPOWb+wAaO9oEC2dw7KqwwvevdodVF3NuAz7In6Yc4tJvwhhDKojt2w8kFb8O+lu0sfa77FqeGkVIX9/klxDyqVH1cZae+lwOCy3GsTTqfO7bZ64nsDLei7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhQAHPMN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhQAHPMN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so1115747e87.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527473; x=1787132273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNGwzxIrMIyKUBt3XOMxgyJ2pmwmO345QAh3WZlmZrk=;
        b=IhQAHPMNqR5d/hHhb+hBW/9FioblUF/QrIRzhiV81l2UvNbnXEJ9eRT5a7f3bcl4cW
         NXy4N/6inoAdpgwQFBB09WMnCroNBL78X6+XhtfJWD5kL6yrh+Wviv52daJVsH46QogG
         tgKar0EODH9zGloNGh1ELEKqmodYO5TM4RmZyyZibb69i1n+x1iaIH0VsetO+OksEP5i
         nK14TXWD97pXSfYzZswOTdX4mcuW1qNmub9srkJ6EIxnWv1k87FvNRqHoN49J3N4C6aX
         3pMbs16yXiPbgofJBKNtGaBvd1vL2UOg9tyH0qHZwcKm+eN6ckZ+IdoLdqTHIajHgghm
         aQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527473; x=1787132273;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNGwzxIrMIyKUBt3XOMxgyJ2pmwmO345QAh3WZlmZrk=;
        b=nMjBv1U/3cY/BnxYG3QtjmQ4vlS7VjuSSVRZnT2xikHZ0d1ZrSQf8WdzCpYYdFqPpO
         WOrLsB8wkPiMrANsZAwjFkvWYshOrnVKDZrpxWDlP/unnJl8x8H1rUVZeNQ5aLvc1xQo
         fPMwIfUWs5Vkqkw7dlQ8esTG2kXpBHBpg8lRB+vsT2xm40g1f9VM4sPLo8PbPCAXZ8Os
         C6nvTxM6hp2uxxd0U1mEAZnDhxSq3J7QKGha0uC+ku+jz1j2pvJ9lqD4k/rUmDPzOjau
         kCxfvY9JyqQui02qhAI0DUZettX3pgZkWssXqew0jpRjJiGZF+J64j1IkMGyvCN2/hEN
         YptQ==
X-Forwarded-Encrypted: i=1; AHgh+Ros1WhgwgBEAsn/bqorjfzy3NQHQXonTU0uCn8ZRu1dkFLY3OUb4RxmLdDMNwTisPLKjA4z6fe+cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEASNyX9P9CHotr33eSXPVc/YgT9mG3HTWCuBru7FHzNmvKqO
	4bDHt5mWx2w9w6qANkRyERvnLZT3ufuL3vMHhmkNyT+MxRshZq2//keM6zeW5lYg
X-Gm-Gg: AR+sD11qNPFP4HnIskhtFtEvUkpLQlqCDWi/odVd4MXDIFNl7Th5CsQAZF4RBIWattt
	cdM5nh01a0Jgf9XyfiwYHNmUL1Y2+GEcpOVZ/stdteyy3ZfuKVIJlJckgLHFQIteI/qXlyIudVP
	IQs0wZ9OPC8EEP+h7g+P8KkimCQd3UBYoBLVY6TlDugTA8P8vEyva8cek2v97iRIFP3fnOSGoN5
	E4qzJYhap+I7TwAJhGfGDxO5/U7ieqW6FQC6RVkGTNn6A4yQGZyLCQNxojum0dV+xk28bjL565W
	TZCnkLZW/MygtD5GRFyXWFxW21POv1EVKWt1/UhcwNfkijGC/RcRijFeI0fHJKPp+q98R20Ydj8
	mFiuzvjlFfdoEZn+nNP5AZRYoh4SGuQWhQ/dXB9NPx5zGtHErvIyJ1+KYlJf4Lne8+wd60sWOmJ
	fpjJyL83onq/MAHuS9LMEUa9SL6gII8c9bFy9+V3ZsG0EritITx12vdbZSUASGJx7e6xXX
X-Received: by 2002:ac2:5dd0:0:b0:5b4:478a:df0d with SMTP id 2adb3069b0e04-5b44e32a0c7mr373319e87.44.1786527473300;
        Wed, 12 Aug 2026 02:37:53 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d0353ddsm375580e87.60.2026.08.12.02.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:37:51 -0700 (PDT)
Message-ID: <d35618a1-9806-43ec-895c-79c45218cfed@gmail.com>
Date: Wed, 12 Aug 2026 12:37:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andreas Kemnade <andreas@kemnade.info>
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
 <20260812102536.63579b89@kemnade.info> <anw9KgvL1Yj-XdZc@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anw9KgvL1Yj-XdZc@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 12:30, Andy Shevchenko wrote:
> On Wed, Aug 12, 2026 at 10:25:36AM +0200, Andreas Kemnade wrote:
>> On Wed, 12 Aug 2026 11:17:36 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>> On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:
>>>> On Mon, 10 Aug 2026 13:09:07 +0300
>>>> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
> ...
> 
>>>> That code is complicated. What about a generic 16bit non_2complemented sign
>>>> to 2-complemented sign function/macro. Such would have prevented the error
>>>> in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor
>>>
>>> Do you mean existing sign_extend32() from bitops.h?
>>>
>>
>> I don't think it does what is needed. Here we have
>>
>> 0000 0000 0000 0001 -> 1
>> Usually we have
>>
>> 1111 1111 1111 1111 -> -1
>>
>> but here
>>
>> 1000 0000 0000 0001 -> -1
> 
> I see, wouldn't this be then as simple as
> 
> 	sign = $REGVAL & BIT(15 /* sign bit */);
> 	if (sign)
> 		$REGVAL = sign - $REGVAL;

I find this more confusing than the current idea, which effectively is:

if (sign)
    val = val_without_sign * -1;
else
    val = val_without_sign (* 1);

(I can't straight away say if "$REGVAL = sign - $REGVAL;" yields same 
result.)

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
