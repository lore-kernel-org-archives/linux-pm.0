Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792772265;
	b=wf3B5mPqkFclrh6cOubmz5DRt/vUenzk/fGIuNopMLdJKufQ0xgsK5nZo2iCPMFS5cjo
	 wO4NRFeZZ1/5Fa45tusiSQHeQ+o/Vsyd9J7BooJOBYdco2Nlc9AcJaVj0Kh/XNQCL66qE
	 BhzY+ASNAvcNYP/w7ypqhiXI4SBeGOm4RgTZta+f4H+VWkajjdq6agAWcGVl2YO2osjhI
	 pfc0Ait29CcR+xdo562nZxRJ12sJozjECGG53xPXJgbqgeG+g5cKiwzPksRO8ubpFKa+8
	 UYFyqXFK+nXxiGElnkww5gYUJtbowYMZz4p01GKo4aF7YxSGH+IHYy3TTTGVpCbXALQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
	b=wHEt3Bq/MMIumJL83Za+YWmgGMVyZFbfJpgDI72XpJO9zQDgFbjW3Bs66U6XyqVqkmqu
	 P6zxfWyWStZ9mR6mjDrChw37sAA5sLONlxoayClIgzRzh/wLO0cFiX49sEag5iPmjsBu2
	 yQWGZDaxwId45MCm+H2vBuVwol85/3UTqsNjKJuGtmmA+01P6gEtKedpRhIKzEyrBfnQ1
	 tHOuEcdTr6dm8i3NDUy+THnJhXIdG8794w/lHfBLPD/DXBGpBSNWWqXrLK5wcb578XcuJ
	 DE8jew628UP4dgYsJV9YDusmB8fNPoXl/r9t33Adusm+5rqn17aSzvAgyZ4lVYbLckQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5O9TycN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD6606A31A
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 16:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5O9TycN
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so451375b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792772264; cv=none;
        d=google.com; s=arc-20260327;
        b=IWTwX4kBxVc6CaVPDrMEJ2hDKerHMcJtmE6cJJXzntn01rWbwckFYCr/45XOVJjkYt
         kC1m9dAboLwMILa+8t+K4iYvAnVVmdo8/1SNQOaqjR1J1fXtAjzPGyTVSZyrQ+ma3SvA
         K2nNyTUs7KVoXXYQumIcWGlcsYhj55laTJh/Me6ZSkJ7EwiIz7rNkxaP6whseXNQUi6r
         KaE4UIGwqklSecInOyiG4ckRotScz1AZPUscCnLKnJayBnle0gsNrXxkYUxs+Hhri1z5
         sZWtHVp+8uB7sQKQKKRRx4oEf+5W/N3tPoQthJ5plpjzmbANBbq1vz/EJKYAtlBjc0GE
         wdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        fh=SYQmBtKwzmLWfF6YNQryafVZcT3Sr6pxzGA4TYaGuek=;
        b=lXg3no6TyRIgMTKH4wuooJWj+3VAIiGbi4K4sDSzY22LIl7ZP5wnay0oI4CMDEIun4
         csEJ7WrtYcEusC1Y7CbG4FOknb9K9unRIeA4wzq/wRZ2Ya/e1JH6Sm4rApsDjZIQsyQQ
         Stf7lJxpi4eRAa+S62rizZF8UlSVXmokofSMUvd6AuJiidClDkmlMeQLfXdlqS3Gxrgq
         sSo+KOq260DemOLgobmDdMs44n4YpLFk/7gpUJQGgtRriYZnTmEha4ZMbLgbU5uSP3sl
         QW2MqGCLH5/oEv6MfZPHr9XD5wb+YHULckB3EE6mbY0Uc6ridxsVHSnaM15B8qyIh8c+
         zQKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772264; x=1793377064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        b=i5O9TycNALY1BZIpkyHGSK/BZI5fq9bVLALXBv3dD2VtECWddPfjMtp7LO7uneJNwy
         mn6H9nCBgdBqqqqu0Hoat3ejWMwxIX1A1bFfcWBi5AL4ysuhIjPpjt4jtuK186WdQaAC
         ULvd7EsKZol7cG3OBT82lbsFK9HjLtbeCXGv09PJiUOANpo1IOVaRIA0YnGJPUqnfDD1
         lSvXZnRscDnfRUZIy28TO6WvaNCoT5utwzD410lAN3gmgbS7Gy8iCAyeKpk4GMzzGxq8
         fmAn9v56X2NqSHKuDNoX5kpWqTjBG2xfZMPO3XXmzvDjFvaWp1ATnee+fYobfauxr1pc
         ViFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772264; x=1793377064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        b=hUNNdfOqYb+Jcd3/HVMtp2dW77/x/Pomc3jMXwlys6v4Zm/XM5cViJM7kag45VqhZV
         uR+69h7vLOGj1BbOEBurXpsAM+MwjeFWp8zxCmS/az1wUM9NB4vJgxXceI729HBnH+8G
         XErMJOAMVEy1h9Dx0f38xVGauZzerzIkbuRJ2sH8Z1PDaO/SVZwO4Z+8djT2WXM9UpTD
         KTZQiAMLf5ien9+X+D3WxrIwotRT/587iPvn56qD/uYP6aSTsMa+jDiXNf5kJGxF0ZAZ
         /lyzT4buVAYoiFZ4o/CZkkloBVQqSBzQgQZDvfACi5HlBpGCf/9prsS0s82Oa+Q7HD94
         whpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgeQ32s94758+Q2+vK7FGNAVY4AK9UITzL4tOHNY1A3E6N1HkuulfzAnL+dsEAuDRxAZtOw212pA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIj58AsKNAJAqArtONS8fyOrLbZMMqM67dYt7gxwsnuFi3MfKCr
	liE6Gk0b7i7F101NSrQIgOVew4GKo7nlVjvj1flhtBHMiYnbaR0M0TnphBOzN75w9eCKiEbJgui
	lFzQP6LdbsmLDbmuifoLaXRMYGtSO2Y0=
X-Gm-Gg: AYBFou2WN6WIqkCv/sovbRw+Rd2s0hsZcMQYSXw/VlOBlZSwUhU3GhguKbkmYtHWtqc
	vwDIfxM87bY0at1R3tvp+BmSImXC4m5zyWVvo+WDDgA13/zK/yAIxx9odvFHGsoZjOPcrUQZhPy
	7qznswwYOdL4SVFsa+Do2lnp8KmTuxmBF/RvN6AJaTIceySmzsXRNCpzwVXMIACHWB1ljzovz3M
	R/z9rHnRgCXB+H0fDft3+fQaTPk9jsJuZqkCNdL3y3uqe3cCFdFsjAojwmspEhZ+8qiajGaC6ps
	Yf7MpsN71cVdD3fZtNhQ7R4qtuRHAZEPmMk5aZ5H75MZvjGi7hubDfzclqW0jgirDkzxfpSwUhT
	2tArUSaxwGFaMXTvnkMOEH/d8eHP1tmGfTYrzrB2ar2BVAKYTpggOZGY2XpHMxFBQdH2s1pk=
X-Received: by 2002:a05:6808:6d93:b0:4c3:4e34:c69e with SMTP id
 5614622812f47-55be82a0e7cmr1678472b6e.8.1792772264048; Fri, 23 Oct 2026
 09:17:44 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20240927101342.3240263-2-zouyipeng@huawei.com>
 <20261023083131.58291-1-dennylin0707@gmail.com> <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
In-Reply-To: <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 23 Oct 2026 09:17:33 -0700
X-Gm-Features: AclHuK8R8NIoDhHIJiBhNow1L18mAl-RHgwoXkj9e8ljaI7N0Dvj55tMdbdtOeg
Message-ID: <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: zouyipeng@huawei.com, zhoujinghao24b@gmail.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 23, 2026 at 9:04 AM Alexei Starovoitov wrote:
> drivers/cpufreq/cpufreq_ext.c doesn't exist.

I got the submission route wrong. This fix was based on the old,
unmerged cpufreq_ext RFC, and I should have coordinated with its
author before posting it to the lists.

I'm withdrawing this submission and will take it up with the
RFC author directly.

Sorry for the noise.

Hungyu
