Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690510;
	b=2FHt3Qy+UdxOME9PsL5VFNrnW4VvSq7QaYMCoJdcffA17+mY1ArHqIMS3IcCgQSDPCyY
	 R/lcyJqpOgq0wJb4SR7wFamL9MipOOTS5f5rfJtq7str6mIt7jMr0wHcDDp3tSTGyZMSi
	 fyBqLkDaRANI1wh8HDpukLDVAwVTJ2FU9/dJyrqJESzSLkFOykPO0/LDBb1nwyZ+fqZQd
	 EMdM5/8zKSjJ36SyWT4qmdJFcYewZrQRJPArLFBNTEURFqSJQ5lgSngfkqz9wPXiRUMug
	 WVrZcR5P0Q34Ew9M+RKPsfTFxdpxX+nWHcvKYHB/k+/eeXREPdKnUY0ak4JF0Ep1O3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f/KnB4zhJgMl+hFjknvmtRA3SG022rMHPfbeZGqIblc=;
	b=avrNEvXz8HbnqXHxiF/iG6pgyMVB9KZA7oESg0MVfXcfeRTrm9w3/ROOVXljZt6OD2Gz
	 6ggBDNfehZQFnQXjDXCHxi4qUa0zqVVPAWksNM5gtKPRz2c7nhjoQgRyDNNvU8jjdZ5bS
	 Q3CCQu38R1ZTHAbVqFyG0aEbV0gSc8hgc5Y/1y2qqq60UeDO91skBXGdLPlokecM+JI3o
	 DOOkn8fej0U4MET4qubicUCNVgizgLVdb1Oc5VDBMSEjD/fc/dzD+GdcODYhrT2xTk5D4
	 moK7H/1FfkGoqZYu7YjyUG6H5uJiuzGkCw2SZ3hCSSOSBQ2xJSzgDyHxaB/9AjmZqvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAc5e13a;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE58606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 07:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE58606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAc5e13a
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso17167475e9.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 23:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690508; x=1794295308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/KnB4zhJgMl+hFjknvmtRA3SG022rMHPfbeZGqIblc=;
        b=rAc5e13ajULG1v3AnfLLIAD5cCrCxGudDlVWRdaYveV05iOKHOtx6s3SmbzF4RgQfc
         ngE1LrUGF5rKL7pwoGri8s2Eb+TzsZqa77WH1ekA3cC5qiw2YKUL/BS9YypQOQDuXdL3
         wo6Z/vHxOPrO5n1kkXCTOwIi8CrIlZe4NAL4OX9ZJHC0nYOodQZu6+62QUwfYYIDmSqJ
         35pvTa60Z+HScl3f/0Aj9abXG84txnSzRtOon3j8uk13JMeC7tiyTAHQKkzdZOAl6Vzd
         okqBPoNoZDwcJaffKKCNPlMTg0H3K43ZIrK4FG91Z3h2QYGhUSVo6MXDO9WjLlMSr3Kp
         wVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690508; x=1794295308;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/KnB4zhJgMl+hFjknvmtRA3SG022rMHPfbeZGqIblc=;
        b=AwdI1/m0R+qcT9tKjkhN+QlXsJdd05KJfdDxG4m1DAtJd0cQmtE8PA0LCgBs7VqU3k
         NVZA35+VHKZu7XOcs9/ZX0pQvEYn/JUSmOAa5BlBeJ7IJ/Df7Zx3H5H2QOUOsUNj4Q42
         r+ndyV9P0TRcsH3No/RqR29EFmcndrszLvWi+7DaHi2EOG3Cn/4/hYqlpJvrKq3MeEG3
         DIprsgwIvIkar5mCOXjxFMKDK3rClalIBJEfKnutu/OIatDb/gICLWQoN61EsGByZ+9J
         4H+YWbwjXhNvzFVcGcvRo8EIRjk627IkAkq1EQZnfRUDgQPxmFkZgEjKrLrPmYc7sBaF
         6C1w==
X-Gm-Message-State: APuU4Z/sWOf6VmegzhtT9TsYp2+bi3764Q4yz+koNS33uL11hp5grhUi
	+vh5pm0JBCOA5zA7kcW8ilNOQzKUA17rp0S16O5Qc2RgbiMooRqmlIBNt1DYPw==
X-Gm-Gg: AYBFou1h02+VzbR5JJ0QJvmMifQixL2Hs1gl5n+W13MqoHseEOWQ/LFcY4sQNPTy9OQ
	PLhDMkcxzIZ29cn5Aszo8Vb89woi2zBIWRyWA6d6m/b2XymxuXvNYe+6LpWy4NrjZ5QBnMSCcmi
	U9NiMcpzN9vDQ+qb5OS+b8JNNr6GXffpw15I5AiHcryXxyOYwBHRcjooskjJTYNlXkgQhtc85qQ
	llPr9oU1y/++nx2+c5ew6bmv/kuXZEqPjtEPB1jXp4BK61cIt0ePwnuXERQo1AlX4xs+iPKZ7t3
	PCB2PjpFLrRMMaiAlNmn29kL7Y0v4vtCZPkgKjYg2p6qHfYvMDPXb3Y9w3QgAoDR70J8t9H9Per
	lgG+TgZHEtYg4LSnsvcNKMPnxJMLzm06fFft8GUW4lvk9G5KHcha2wl+Mqkz23HCy3MrRVkDVnE
	d1xVhmvS0er0NCzJ/RyRq+upDyiTqComMeJBskKBi+Q+0ObBzcoJ0fl6Ta3SABAybnv3oFLgpjd
	WakonTh9goaLOYhSVFvRNskLSdsAr0trZPrgWFhp1Ltr5hMcELwphZJ2ulzq3EeHxTsCScKRztl
	pCLGEKV43LpE07++YJJy2npm5OUTBAipml8oHEuSzfgLQWEqAeSM4rOftKTXLh4G6sjpPiBOQ8j
	h8K/Bae2rcpXUmvEr8uuir/qBF4b6ROXvWI4=
X-Received: by 2002:a05:600c:e548:20b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4ac86c9b146mr172730365e9.13.1793690508288;
        Mon, 02 Nov 2026 23:21:48 -0800 (PST)
Received: from [10.77.100.5] (ipservice-092-209-215-046.092.209.pools.vodafone-ip.de. [92.209.215.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e0fe6sm43172275e9.1.2026.11.02.23.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:21:47 -0800 (PST)
Message-ID: <cdf44987-3a3e-41f2-a067-8181aea08880@gmail.com>
Date: Tue, 3 Nov 2026 08:21:23 +0100
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
Subject: Re: [PATCH] power: supply: surface_battery: handle battery event 0x1a
To: =?UTF-8?B?UmFtw7NuIEplc8O6cyBNaXJhbmRh?= <ramonjesusmiranda@gmail.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261023173215.6233-1-ramonjesusmiranda@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20261023173215.6233-1-ramonjesusmiranda@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.10.2026 um 19:32 schrieb Ramón Jesús Miranda:
> On the Microsoft Surface Pro 11 (Snapdragon X Elite / X1E80100), the
> Surface Aggregator Module (SAM) emits battery target category (0x02) event
> CID 0x1a alongside standard battery status notifications. Because CID 0x1a
> is currently unhandled in spwr_battery_event(), surface_battery logs:
> 
>    surface_battery: unhandled battery event (cid = 0x1a)
> 
> Add SAM_EVENT_CID_BAT_0x1A (0x1a) and trigger a battery status recheck via
> spwr_battery_recheck_full(), matching the existing battery state events.
> 
> Assisted-by: Antigravity:gemini-2.5-pro
> Signed-off-by: Ramón Jesús Miranda <ramonjesusmiranda@gmail.com>
> ---
>   drivers/power/supply/surface_battery.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
> index c759add..a3fa899 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -26,6 +26,7 @@ enum sam_event_cid_bat {
>   	SAM_EVENT_CID_BAT_BST         = 0x16,
>   	SAM_EVENT_CID_BAT_ADP         = 0x17,
>   	SAM_EVENT_CID_BAT_PROT        = 0x18,
> +	SAM_EVENT_CID_BAT_0x1A        = 0x1a,

I don't particularly like it being named 0x1A. Do we know what exactly
triggers this event?

Best,
Max

>   	SAM_EVENT_CID_BAT_DPTF        = 0x53,
>   };
>   
> @@ -368,6 +369,7 @@ static u32 spwr_notify_bat(struct ssam_event_notifier *nf, const struct ssam_eve
>   		break;
>   
>   	case SAM_EVENT_CID_BAT_PROT:
> +	case SAM_EVENT_CID_BAT_0x1A:
>   		/*
>   		 * TODO: Implement support for battery protection status change
>   		 *       event.

