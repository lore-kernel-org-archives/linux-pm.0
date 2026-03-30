Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C518EFD1
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848048; cv=none; b=LUUTCjuvcoNTI28/V89wnubb5jBrz6WUiXoyNe7q16UhdeLo+sZ2Ly5dNVwU4rSH2ign5w+5BpJqe7mGW7IjNuCuHdmDLj0g4+C/y1wYVSvtSHzToFvWmKT6nv/viApm2aMNpV0JKYIeV39nVNI7nyCk03QbSdWNTv6jfEuefXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848048; c=relaxed/simple;
	bh=eepKRhXBZK9IXv0ZNMREH08U2gej3IDAxHc3OFJmNI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNq/uKyNKTDn4Q11KLB6LwAt54YlBj1y1wELY0rFfkv1FZ0Id36XR3DGxxSAYZrK6TYAzvX7WXqMPJHbNnauEKRk5dEJXJbpN/9oELA0b5eVGCNJt5GP7eajWackCphCA5CD8+3B6x2w2v8bapFdwCZ7v7NXCCY7rTeWxK9ddGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRMCc7pn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRMCc7pn"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1701098a12.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774848047; x=1775452847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUfXm6GT2gBa1RG0Lw+E86fEqSCqLQyi5IcLfsYkBBk=;
        b=DRMCc7pn+vrY9+Rw5n8BrKku7f1fRhq/JnrOwXSOfPqM1a4qMVP+DCGUdTgOoZ3hVR
         U/AK4gjaFU8yvv6r0WSl6me3MU53uiYrADaGg76tUuQ59x9srvd695qvutrDCck4BFmb
         WdxGJSNjxjCEC3bf2wrJIv99whHqrREmvLp7s4YJ6HLBGgSR0dCdkihT9ntmdxnans1C
         9+ntm2e2DIgc3HQzwuza9c3J0PIFNWLB79DbRWi1cH5uAgYLqLql8U2tcktY39Zt2sqd
         QgEaQ7VCR+Ht2cNLjpPYAP8iQ8U56bg641rX3OLUo9NBKqPcALoQXHS4oc/XCjYI9Ix2
         66vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848047; x=1775452847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUfXm6GT2gBa1RG0Lw+E86fEqSCqLQyi5IcLfsYkBBk=;
        b=Z7LhkLpPIglqfDsT5Sou5YPmkqCkd1w680JFCAf/5wFkvtjvR6i7Hypd7529GtN37y
         EjVkBUDRjMoNRM84UHDZ+e413iCsHIMmEQKRhsYFFvfZRa9KfB49rX+QjpcUQ28uFnmb
         uAREqxnlwAcebbH1FhiK/6fjITGbXnudn5B0zphxZlf/cUu7MPdkpoTqn4nysP1jNaZ1
         kqDy4SyVZ3VC19/TbP5kqe0ZVxeDnRW0MUSxhI+5USe4ikMs/XgnZKZLt5rAku1TUh7J
         9ieCCjcU4Yqs2ZIa/Cc4BQEnhd3uXxr6A6ZXpAeEA+THvafiuIQnkrpKaFW36ybuwKGX
         kpMw==
X-Forwarded-Encrypted: i=1; AJvYcCVkPPXmoH/mYLovrY47K3Zbki+LdvSlP2AhtQJkZIoPTRal0LCCvARokHS9PMWFFKOUeW4KZEe6hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvL7gXUNAmbLZQ2pmfzylJ1aud6dmPQtly9JlJhO5cw/TL/tgj
	4DVk9sVeR7ULPDs6Pv7jgtJvM/7DLAWvl5kI3P1WHGqiq0hhmZ+eaCPojOAJnlpFSzM=
X-Gm-Gg: ATEYQzyTSXvvD/KSlppn/CowLGWjl0Op9UWtN8na4iuH/ymUXBT3jurKPjS1AF2CEFY
	OvCnbeIRA0cYViGu0YH2JeX7OzjLex6DXx+NZeXuvHKlpmaCxgubl9jSOqMLdkLlo7SbcBv9L4A
	UIu87eNbe/CxEB83RYfxr5uPdRfTYweoDl5at163tSHDQmZVc9X7Zl5dhTdyWqO4A1aPMomLCc5
	JWHdwXhv0T8z3xzswz+i+Q0ITZHNBS8d0aM7h78x0Z4n8wWKhb3DJ20CcT7t+pzlPrYJkZMUuoo
	GMo5CkLqbdariq26m1NgkECLpqmgIR5tvDothRQp4vTyuzNYHiQ5vgZeB+01nAvZQMEw/W3FIPX
	lJHbvGRVTGD81dXvLGzPZjk0FQI7s6U0p3w6GFFpWtQcwL9kjdoGvpwiwTUTjP97k9DGzMv/bKf
	kf9POkUpwjzA2gHpwtptQatcCT
X-Received: by 2002:a05:6a20:a11c:b0:398:71f2:59b7 with SMTP id adf61e73a8af0-39c87a595cfmr11799378637.33.1774848046363;
        Sun, 29 Mar 2026 22:20:46 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf97abfesm4821898b3a.1.2026.03.29.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 22:20:45 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:50:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <5syn6lnv4vfd3gapmlczkpkfob4oxrvfu3sozet2fog22mj5mw@mfyspzeruph6>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>

On 29-03-26, 17:00, Zhongqiu Han wrote:
> Sorry for the late follow-up on v8. While re-reading the patch, I
> noticed a potential UAF issue on an error path — I might be missing
> something, so I'd appreciate a double-check.
> 
> min_freq_req, max_freq_req and boost_freq_req all point into the same
> contiguous kzalloc'd block:
> 
> slot0 (min_freq_req + 0) -> min_freq_req
> slot1 (min_freq_req + 1) -> max_freq_req
> slot2 (min_freq_req + 2) -> boost_freq_req
> 
> If boost_freq_req is successfully added to the QoS constraints list, but
> the subsequent freq_qos_add_request() for min_freq_req fails, the error
> path does:
> 
> kfree(policy->min_freq_req); /* frees the entire block, including slot2
> */
> policy->min_freq_req = NULL;
> goto out_destroy_policy;
> 
> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
> pointer into freed memory.

Nice catch.

The right solution to this I guess is to do kfree and setting min_freq_req to
NULL if boost_freq_req fails (just like what happens in min_freq_req failure
now) and then for later failures, don't do kfree at all but just set the failed
qos feature to NULL (like what is done for max_freq_req now).

-- 
viresh
