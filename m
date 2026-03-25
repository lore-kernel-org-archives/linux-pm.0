Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9F330D3B
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467589; cv=none; b=Pn+NZDq7qLrz3PwyPZSbtVAq1Ha3Bn6tQumU3jMKHyUY0IolDL77lw/8rBaHBisfvvalfOSkWtqQhYBHCpy7A0SM8LRlbhLvU7hVSEw/ChauBxf4s60d17F2/yeQMMOPFxXH5xkINH4LVhrPWqLpmF8QgXgQDR6PyMFtm924nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467589; c=relaxed/simple;
	bh=UejgbQ4oPnH6+ymrv8rivjErn9EvJ+rMYbDyOjB+u9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=lMNwi+Z8B5QPnfAfOylbt9goaXU2yeUbvsVIvmKIVQys41QgyAmoT1H8bXdi4Rcv9GpvbnsfkHUAB7E6RLDLb4CsgHw0k1RRdAhIn7qWKusCeWItmllmhvWxcmQ+mWJ6EAKMR7V5qDfppQ4BWSqI9l40fRdAFNoQu2W2UpiV6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dlTyzu/S; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dlTyzu/S"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4670676ba03so75645b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774467585; x=1775072385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdA7YEIQbn4IqK2utaHSTjB0NBbBTAIGsoWeUvKntyo=;
        b=dlTyzu/Sj/0KbP3EbZ2yc4BDQw7ZcnqHjPJmZVzB+9Gd9o9HiHKj29L4cr08PhzOrx
         2w4ZOtFn24ik8VFQVbNDAcR+BiYmIkS0a3PGKk2WFV0FKD6VEItExSpx52RgjiOLxCxe
         3CjVFJt4Sn1i6uEULM9Ws+Sr0PvEwZKHwuZnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467585; x=1775072385;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdA7YEIQbn4IqK2utaHSTjB0NBbBTAIGsoWeUvKntyo=;
        b=OLtiRteoYWvJQptsIAu9wc5yDlg9y68ENvHuNiEMKfycS2utU6yXBb2IvFPVAiXKpS
         zU23a8D//R3VB6FdiUTszdmM3TyKcQh5qwu4OvLWYDMfbXkFjVPSiDsgm6QS0iKv4wis
         WCPvt/VGxHQP12r2ObVIoOjA1NI8kBDf6SpcZNknOicv3wM8i1P+gCUuW+fpQjvmUUR7
         QyRiByI5AIenn3Uy0KXEqGzw4SZ224oRwiMcXit6QoTOVMgrhdnI/wUSZeQS46Cp0s9j
         aHXhl5539my+RdOhFYoYoebTVQKNHC+NT57CpDHIWp2NTvkk0D0XJ1WmGQ5X1UU3ql4l
         zaPA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhMTXDhsimOTPYCL55dijP784j4/HSmTFRagtSDF3ERJCj/BeRofj2IFPJZc58Q3ZPRLDVIEmww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcUZMMa3mPRG+DCr+9lC04yE7qo1vUjoQcs9HziS3Dx8KhKRo
	m0esqAhUwd6syP+SDZC51bIxTB1zkBASo0pzDr+D+ya1t6imNyiskWYXr2qY297QmrNdzJGsZKP
	SZn8n7Pw=
X-Gm-Gg: ATEYQzxl9buOqGZ/L60aW9qJiW7fKfkRIe4rCi8vuS5I2qxajYBxuY/PTrYy1+PDMvD
	0i8EP5k9LL4MJluCd5E0RnySFa17E9lLVJCeJoe09Loz7sWglKAlmqBM9TfLZ6SxVZ5Dg7sCHJG
	0caPdSMbzr2kXilOGRBS8VU0x11vW1VfM0PKWDXQmpjJhvWJbJo0IPOOyoAprjSj6Teni27sAWO
	eu2BIxUdAbb1zMxKpX3tC2int8HslyrWe9aa3OTfSl6vPY0sakv+OQkATZE+Y4Lx+h/U4pMJ1OJ
	RF/VYrnuunwJxYKA8X7AEURzVKha9qEaEPhkTehkE6n3Y0rg3q1WDJPKPudyvafu6r0G7UWn59k
	3MF4MyNQebZJe2+wR1+jM4obHxF+8EmKn7scJ9nTU7aLER3nl5XkEH6/tHJ/RdnsVOdh0yvHmbp
	3rlS7GMMy7TtrfTops2d9e7iRsQllortliLVo=
X-Received: by 2002:a05:6808:1710:b0:467:1cf5:7684 with SMTP id 5614622812f47-46a5c59dab4mr2167363b6e.6.1774467585630;
        Wed, 25 Mar 2026 12:39:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc775b12dsm420007fac.3.2026.03.25.12.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 12:39:45 -0700 (PDT)
Message-ID: <598409fd-73d3-473a-9e1c-65f47ef9d06b@linuxfoundation.org>
Date: Wed, 25 Mar 2026 13:39:44 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cpupower: fix various man pages issues
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
References: <20260324223921.14317-1-io@r-ricci.it>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260324223921.14317-1-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 16:39, Roberto Ricci wrote:
> This patch series fixes a few issues with the cpupower manual pages,
> such as missing or incorrect options and trailing whitespace.
> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> 
> ---
> Changes in v5:
> - Drop whitespace removal patches
>    Link to v4: https://lore.kernel.org/linux-pm/20260324013543.4776-1-io@r-ricci.it/
> 

Applied to my cpupower branch - I will send this my next pr to
PM maintainer.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah
