Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6633260E
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024595; cv=none; b=DWP8Q67hwlTb9IL0Q28MCfMv1gWDGHBSVpcQDHze+MZfLkeI7O91TTVCn4KNDWsN5NAvgkWarlV7Yh3hA7mOTR4oax/Kf2f1HMJnNimoYnQ9eG15m64X5emjgFQZn+5ekeifwi4BdhpqIk/MAkujAxadxmvSnVqy1KGEQB2j/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024595; c=relaxed/simple;
	bh=LeyqNpA5ssTPwsvKghroEuvcUmBk6n+tD8cQ8ghC0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVbY9mwcpXjr9Feoj9LPW1f8TuyYNOh7gAN+pz+7+tc0zYV59fB58uVW0iHR/dN5X4u2lRzesveSGr5K16R5rJevqHUPeeWHgo0CJ44EI9E0iyyNz2xoVAE/nG0tB0KrIZxo3WFgBmVrhBRGWrubLtMmx1f1DycE2eYwYM8S4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iafV/uxO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iafV/uxO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d932cc948so2628176a91.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775024593; x=1775629393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC+k6uIWVW8fAT/cjzx0lUKNsx6vDrO9typRxG9SNSQ=;
        b=iafV/uxONhR+X5W+Gqk09/rYFFS3fBwgEr6To7OBHzIRrCrhb/tOqx6hfCPq/niPLQ
         gC0XdumsJAqmfed64ZXQTS3LwwlIYf7mRDqeTmVxpEn6FhdxNLGurfsgEBPOwM/ar2RR
         nKq6BIqV3WNYcTrQ/I63KHdBmMFcU7jYHwJzzgekxe0zsFIB13IUxHkNjmbcmll1cWPS
         82cQXJMFGz315OzhtYdUjHe2cTkbGCQUgwhmChn/4QJrLEhgxvSWiuaKknMzl6rZfe3M
         fbT/ZkSvR/56TXSLWuYm4UANiLfZk+qrYG1gEiAmvkkJZ/cb19L62FWaK1Ef1fT4Iep+
         16lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024593; x=1775629393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC+k6uIWVW8fAT/cjzx0lUKNsx6vDrO9typRxG9SNSQ=;
        b=jAeDc6cR2C6ce9J6Ygu1rwP34IRmBUMkqok7NioV6gT4Ub73jpOdCOkLPa3IhO7L6I
         8JNXfLbhCiXLNrwRpOY0IAJvc7BjGfrHlgHSb57pSvryVEA4JZp9u5U54MbHuApjV7LB
         11rNEOfetFuLM9IxPg5zgESa6JrAbEDJOVDekvw3n5pi6DjUsTdxDRRVTGYMUXdqdY7I
         vq04XFLEQ159HjTGbHWx1jMrQApvQ44bVLinTwBqFURSIAA1etSSrIBzBgD33g/vfhDA
         2g++b80H3BV4IlWBv8fYorY/xEPF1uCYqyICfNSV5t6VJszftCAGOqFvU4J3Upbij+wr
         LMzg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ21P2OsSVrencwSyaXrWwZ186ehOeJ6ofqTmUo1WUqGdgg5M3guVmNTXnZy8WR4UgjrcPr1kCfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybeJlfTATxaOA1cZ1iRQ4z+kWBTAySygeINGWmeon3ezEIclEX
	U46wD1pBAvYryUqOM732BgmBpVJpTp3+Ec86+bgpVx4ajRXx3GLIiiHBQyRUxc35uQg=
X-Gm-Gg: ATEYQzz57gWSvHR7tCQFJT28VHYBsbGqG16Xi4oKWL/ezzQd2gADma76fU5fQjWd0Ps
	JXAZ7jaMe0G07+Bojga9uPbdMIqhwPoDFCU2HJUmgZewwD2pB2RHfWRfc3wTNYl9CUF1an4GNfH
	lIZu1srF1TDpt8/YYJl5l4hEijIjMhz1m503JMBespX+7G2rD4yzFAEOEJJBPxFYGbfe1JBqFbG
	KdfvSfHehuTktvkbjGtRtXCXFzkoqCv9WqWZ1TiW9IrFbBMGWGOoYyDr+gTcgrXZjGSWdstPAEN
	hDf2ER6bBORSAHbEiiihqstN6mNOFagESwD60DpEJchbDDutQmcYrhaMRTuV4BEevco7TISeEXR
	pEjQrkGtRXFMwh7PyELsM7JNg7k8eWI7qATuWJQVp/apJiJvWYHFID4IK08YeGzqhlLRKFkxuS6
	UigCkJ94E7PnORu4pLBoGWeWop
X-Received: by 2002:a17:90b:384e:b0:35b:929f:7e8f with SMTP id 98e67ed59e1d1-35dc6f1a0d9mr2202122a91.13.1775024593274;
        Tue, 31 Mar 2026 23:23:13 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dcafd004fsm920812a91.12.2026.03.31.23.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:23:12 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:53:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Tobin C. Harding" <tobin@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: fix double free in
 cpufreq_dbs_governor_init() error path
Message-ID: <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
References: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401024535.1395801-1-lgs201920130244@gmail.com>

On 01-04-26, 10:45, Guangshuo Li wrote:
> When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> kobject_put(&dbs_data->attr_set.kobj).
> 
> The kobject release callback cpufreq_dbs_data_release() calls
> gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> double free.
> 
> Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> after kobject_init_and_add() has been called, let kobject_put() handle
> the cleanup through cpufreq_dbs_data_release().
> 
> Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
