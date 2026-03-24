Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A83AC0DE
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390151; cv=none; b=rdt/2pMFE5Fq2c8RmPWnF41R2b0fNs4U5YjNfQxSa0Pq++c8Yo168F6vwBwd2QEajwoRjpj2Ebmjyh2+Z0dkNnl9C/FOb6USzUS4h6N6wwyTNFL9yRcAcbAjPYJ9j6M1lMvwTpIExj3qUE/Mp3nGAdCk3mC1BPEmMdwJ1B9Ctac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390151; c=relaxed/simple;
	bh=znhnoZwMqh2KUu9THEOlitsCGfXHji0ZsaxRo5uH7TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8RPa7lX+HkaxcN4uOQbQJbjathnF1WKaQosI7fLVYEssP6zVmCLDYKMbrH+ERZJ59i3lYn41TSBf53M3A41qYa7Bcb6GV6cjweHOl9NZ6qXzg4/3fjiCD7bhiGo0p9Zepi1zZt2EGOLfj8TjQ2oUFp3c/bfBnghGcoBJS9pIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dvi89RaC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dvi89RaC"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d9bba96f7dso1484150a34.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774390149; x=1774994949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYhGGAocKELax6LfeuDjv5XJo39vTUV0BOK6UtkNZIM=;
        b=Dvi89RaC5AWiFYirZ51pLyxBdgg0B8VFjO4Pk/P5Ip/+Rj3ZcMDpa5LhjvPvwp1Qhj
         AaUy9MS+6ESZFWIef2x9l5nKfr7hqeL1HP+zOAjbdAEopAzm7kLVK02AiU3h4zkiJ2IG
         pGJvjaLETZ1S/XX3JgfiMHmQSLIbAdpOkrEnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390149; x=1774994949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYhGGAocKELax6LfeuDjv5XJo39vTUV0BOK6UtkNZIM=;
        b=Qhl/hkqgKaa/01bZErjUpf44OGaQ1aVG3BtfhPkDYL3CWcF0wkbHYaA8bpqq+8HEMF
         I3RMcOwejMVW3LgeS0blyjpqe5B2Oz0kP9j4WWLgXA4VObj0KAiv1Jua84GVeFZgesTS
         HTphyeRDFrNrsCVj1RwbHa2DGyMfPUUa4gkiEzLU7E3Qpu/DlE9jNmvvO0OPn0lCf1Rf
         45Wy3iUgq0U5rar2uybacV/RDE2KVgxaKg2BebIXcYHmhuNlfaET+1qIjr8t87haq9QJ
         bM8jfzrKpLqrLer0/Lm0GVKq+XQdr+NOnvTG8dgUNE/RWUAm9fiZJ/bDQWJktOonyjWV
         HBTg==
X-Forwarded-Encrypted: i=1; AJvYcCWqNT1L04mXcySa1EaSl1vV8uTNmfzcUue7ENo513JBgCP5d+87/yDtAo/VEyLCaGxMfZcOHP/OCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIYEnE7f/5TAgOEAz6HEqg+QKky+BsS2LWToXy0PYY6jBJ3Pv
	zABBsPZmqJ7qIv6Hbbe9W2NF2XRJFujBw903Jepjy5SFByUFtgckP4F7qWAoNgu9vdjx1pwdq5N
	vcLJP0dE=
X-Gm-Gg: ATEYQzxSAyjQDgOyX1Q5kDzYTEbFT3TM9MvTmM7iy8nbKOhllHgOqaCBbBiK39u4QOn
	06sFY/x+bm8cYKDLjeD2Z4gdest3fcBcC8FSck5b2i7dfSbcaxa4JBLCJzXOTFxf/km63vBUOOJ
	jxms7/xB/mprKw55Erl1G3ZYzSYPVZ5pImphIxRkdQj8KykkhFX2rbWJ2b/q7Io/klazNixOixf
	xSFa1a9moXqffSKCucJQ4azbbDpkqr8cbaPzQINVOmk4mUwFSbhYn1WbKTOCmIHfNKoxnBw4j2J
	15aAfDeKrS4tZmEXqppkeY5HyUJi74T5Ww3T/52SSj/WlM7CHf7gw+4sIAGqigme1EhlLB7v6gX
	KvYKEE5RrGHSaJgJy/gDVzoghoITWP/jnvcrD3vG+7CRvLD0oprFG8NrxCS+wxYdyTqSBBiXSlJ
	2M0ZiRj+aXXJqBL7r+BSuk6GHEDG2RlQ7vMLA=
X-Received: by 2002:a05:6830:2655:b0:7d7:cc0f:4680 with SMTP id 46e09a7af769-7d9d6561e51mr571450a34.9.1774390149306;
        Tue, 24 Mar 2026 15:09:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadce96dsm12979426a34.18.2026.03.24.15.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 15:09:08 -0700 (PDT)
Message-ID: <58510baa-243c-429f-8ac7-7e917efdf525@linuxfoundation.org>
Date: Tue, 24 Mar 2026 16:09:07 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] cpupower-frequency-info.1: trim trailing
 whitespace
To: Roberto Ricci <io@r-ricci.it>
Cc: Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260324013543.4776-1-io@r-ricci.it>
 <20260324013543.4776-4-io@r-ricci.it>
 <f229ee71-4297-4fb8-995c-16e86be6e953@linuxfoundation.org>
 <acMKUXmN7BFDjfGu@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <acMKUXmN7BFDjfGu@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 16:04, Roberto Ricci wrote:
> On 2026-03-24 14:00 -0600, Shuah Khan wrote:
>> On 3/23/26 19:35, Roberto Ricci wrote:
>>> Remove useless spaces at the end of some lines in
>>> cpupower-frequency-info.1.
>>
>> Why are the spaces useless and what happens if you don't
>> remove them?
> 
> They seem to be both useless and harmless. With or without trailing
> spaces, the output is identical (tested with both mandoc and groff).
> Since I added the new options by copy-pasting the existing ones and
> changing the text, my patch added lines with trailing whitespace and
> checkpatch.pl complained about this. Removing these spaces from just the
> new lines fixes the error, but I decided to remove them from all the
> lines in the file for consistency.

Right - I ran these through mandoc - Since they don't change anything,
I would rather not take these whitespace removal patches.

Is there a dependency between the whitespace ones and the other patches?
Can you drop the whitespace ones and send me just the fix patches?

thanks,
-- Shuah
