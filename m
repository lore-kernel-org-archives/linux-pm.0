Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600213;
	b=vtisXNJobWrD4KtBpYNpJ97x1uMEPzBQvlSyDKhziRrDQmVBekzaI8WU+0n2vxokVI4J
	 tA60LKE8z9YySG4F2SIuyzJv8RV3wu4mx+XepbZPJGLzoNIH7mFyODLmA+VFN3ovFl/yV
	 26220SWJ6DIokrx54R7SYk39iJXO7PQdshEbG2FmxxAYT4I85VxdTkOZ6owo7g9TJBVo7
	 ZfL4h4TprWmCCy2L1w/t0UE98YQmQi8VOGBba9supO0YNBoAQwTqlcyQbsFnVghuvjk1R
	 17BQEG0b/Niax3Nx2bHwhyXpoyxKzLqfsfZHhwZE6iVTR4evmD4vpDo7m/Ch07rSwWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
	b=IqFTbbCXbl/VHWYD2x6MFCCxcwsQmwkhBx4CvfBAdG6YH4/M7YWVBSVLavVToWdxn2I2
	 LaXayJF/v/wOmHKFcD9iU5fi+o/yoWdCKKmc+/a951+PQgZRw6KX3WHF/O4kPCFAZKAaF
	 nnWYnxlJV6Xmyz3nxUxOhXRmkH9lANkMmR5mpz5LZqxiyYaGIPbkeSKpHKN55znpgiBIe
	 5vGAzQpkb2uULGlJfFW+O8Az0oz6BTrlb3Mja96RU0UI7kOb7GdjMCPeI4bCfm1Hj/rTa
	 N6gv126/c+J8RjL1XrCoWgydv1F2JAZEy6FbK2Uj2usNz+sZvrkPYN3Ruu8uqOtFVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z9P/LEaz";
	arc=none smtp.remote-ip=74.125.231.137
Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3374606A327
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 20:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3374606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9P/LEaz
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-717028b412bso511888eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794600212; x=1795205012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
        b=Z9P/LEazFr6KVed6bhtpiLAGhPrXtfYhM2lV6DlzRTRiqS7mbJew5QySGoG1DM5DBg
         w/Qb+/GpGCjNrQHB8Bc3EIuAAxGD3zwav8las1IxrGyj5VzP1iW7ZAhBN1QRSZQkPxyD
         yeioWvEr5SI4P3Vq4TSb1WYol3vNnYv9cUW7YFHwShUpU6KqQIsl2AJxNiA2iaEqv29I
         wGAR5gThxr1VOyq5sfocJ4qmcx3g7NKpIcUi1cyujjclHNzEbhFA5CWvNFkgXOupYv/3
         WY8gMlrYVWAdAQ2/57OJ+l5D3YANZ/sL/zsFE1SpwiFdmO3DWke+LLQoS/jzS2JOFDa9
         SKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600212; x=1795205012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oLkgc4LESe1RA5rsRbAFuQhuNZ8h5rAeMBrxjfEeoU=;
        b=fuVgAKXuwM/ELBJ+bSzTfjy43jAiovgUCxJvXA4poq8d03p3mzYWvCIUpLx9Y1L1FZ
         o3K3xKLUHY+l8Fb4Nh+T46ptZe7G7aT3qfnkbvKRWSvPylem+PsW2S40BRDZPsrp0hXV
         CgVZu2F5dmQ6fqtrwOR6jfITSvm4GtXNaoka0gVYlnCxboYpm2RXhIvNoMiCQKRsVbrN
         gLjRIBZEQpSAh8NPBviNyLnjqk9eXqOfE5/ytb75ZyVcFdACkzr4HTOSbx2mz8dOu6+5
         56tc40OvHvRW5zoqv4hv77N9UVQ3xcbxxAzqsx1NQzgLwNftptl5MaQKxAjr8zYvkLN0
         t08A==
X-Forwarded-Encrypted: i=1; AL+hErEfbbFzFAT2fM609Kx91ZmXQtMeK8NWLJQwFhF00KjBX+oiV4Dt/W82ZgvU31rM4tPEJRKMJt0meQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qZeGQGdLI2UBZeTW6EACTTX38US5LDAdwnS6fAyMcS3fHx/PJ
	7+DC05WO2XIlevjoypN10fYzpckPYK1GJ6bRbENpauOT0JSNfCiMuz4E
X-Gm-Gg: AYBFou34vQ5A9VnZub8T8g39b0460DAELCkUfrcKA8Iz+A9EXjUMZXN7HUSZGEhOvWJ
	/npqcklElkEQPIznZKUoLPWLeRNSD+ixbULIdcxXDWyCjADUuxYDtGZixJLrdbYuerpsnP64p1n
	xoYyQoJLlLykvyL3GIEkLA6bHGBZ6kVZU7qiHWvvRYrlWAH4QvNQ4GSspOsOSRJhynRzE3AuL1X
	QLJwQlr80eLooKEXJ/G6pAAonlwn6YqIL4z7XsHlk6s3INpDSILRcSWwEimzGeK35MFg56KkzMn
	dqyPLa/qnyt2uoLXSUmEPeVPtTjuR9c0QOIz7oD7EEIV6NI7/sL+9iegEOOFkWC8g0FA43OOkHy
	oVIF7v65hFAuIpm3QVt5x9gqHTPMpLY2hfLG7DOMOwEIbkZWv2Uq3m7o81kAD2UbazwBTwmuuHc
	cl7TdPkO4cj07EvOB74f2owccAqJVovRZcbCKOqhT6qP1jNGpP7zXstiC0vfJOflgaFFsiQMEgd
	/QgNDAsMH2aAv4UODZIMn5FAtP/jqCh7nmzJh5ervy4WmX4QnG+HHQecWh1VRBfS9CxUBwjcQlF
	O9RkAuaVfsEk8jSe3u8zNXZpc8vlAwHsv8IWbJqPe5Qu1xwZrQbQoUeZAqncVftA4m8QFL3J0LR
	0Fc2d/g1rM1WDbOyanBPeshHhvVjmmCgDOPlhCpFJ
X-Received: by 2002:a05:6820:f025:b0:71a:ce4f:4a86 with SMTP id 006d021491bc7-71ace4f7613mr375277eaf.56.1794600211873;
        Fri, 13 Nov 2026 12:03:31 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4335912sm2485972eaf.13.2026.11.13.12.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:03:31 -0800 (PST)
Message-ID: <a6bc9228-8e81-4f16-bd26-2d9c72e9998b@gmail.com>
Date: Fri, 13 Nov 2026 14:03:29 -0600
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
To: Lee Jones <lee@kernel.org>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pm@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
 <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 12:50 PM, Lee Jones wrote:
> On Sun, 01 Nov 2026, Ryan Brue wrote:
>
>>   
>>   struct mtk_rtc_data {
>>   	u32                     wrtgr;
>> +	u32                     con;
> These are terrible variable names.
>
> The nomenclature should be self-describing.

Hi Lee, two things:

1. I have a v2 out [1] from early November that fixed a null pointer 
dereference that Sashiko found. I can spin a v3 or resend v2 depending 
on the response to (2).

2. would you like me to update wrtgr as well? I can add a patch to a v3 
that changes that name in addition to con.

[1] 
https://lore.kernel.org/all/20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com/

Thanks for the review,
Ryan Brue
