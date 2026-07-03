Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29337D121
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060056; cv=none; b=pnt9eCfCi9dez4hplSMvI87ZSyQtKJppEw30SLKXpko0RIuBGRv7FLtdaLl2Wj+g4DVIOsiEFUUn5fo3USql8NlcUKgQPHJ4Bz8Rou0sL6btDwojoiRPZ1cOblDRFhPuOE0QNhHsH2b/Ithhb/OqXTorJvozuJX8ZRlgpnaNNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060056; c=relaxed/simple;
	bh=EWc1b5nXZoq0OiHRf8WoqYanyHC84gIAhCmWZlWUj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9S/2FlFz/bAWdVSb2jWB9BmEzhMm4EY0S8EL5PiCXZLPWi3lidjgkwWnKbYVVAcPSVLzuqFxh3dapf+u8bVtGQV9L2E43tVF6qn4BO10IjeXXfO2WSwR6P2QiXHdkm+8LYuBnToGPWoG0bhTmV4kmzx8e7pxxl+hQ0xxUixfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iAxtkaHi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAxtkaHi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37fc01a7835so202025a91.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783060051; x=1783664851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aQ7ByzFqI/4JyRD3MlNQLQW2E98MhssCvFL4d65wbGM=;
        b=iAxtkaHi+DThfFTEqJ2a/XedULzsnKnAe7PSflJK3NoPPqNWuPHdmWBGR/uGEfmGMT
         JehvUqV6xWgbUP1rVkgP/WBYMasOa/3qk6tYg2AXx0SHT8JJk+3+JCsRLRn3plriw2jP
         eOwT/epTkMM3iy5RKJR0N8mFss2BtBS85X7VOd1tbyIFy7rSsCn40RrMA/ltZhwQFCmr
         dAY3YGh66TURjHWo4Hh0XUP78Uzr25MWtKmTiV7BJb0Vs2L1uXfq0dJn3+T5n6kC87Ko
         v17NK13If6a6aggWePfmpfa839KjYMtoVJhtMgYmudXvLKycNkapoHKJcRFF/Fj/juBt
         NbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060051; x=1783664851;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQ7ByzFqI/4JyRD3MlNQLQW2E98MhssCvFL4d65wbGM=;
        b=I4mbVImfBQuq4Kv6AxRboUAOrny1XWXDU1hs5hxpJOdweyutmddsxu29Z69P/DfmXO
         pm/Re4obrWN8lWgTz/t3ues6ZyyBMuGekq2prx1+Jh9BOac9FBJEtJFOI5FVF3T5Lwfj
         1YS7rfOiketXnVnHXZHhmnvPe7kpTANicgOcpB4VIoVPqFYUVQF4lxR5Tt4pbzR/6PJT
         qNyubqwaG5+CN7ZNltrRu/SbKA7jHd3hqBgHiDlK31CHMxzMh+kdQENDVE8QZYNndk3P
         WHM4p6FyofgNc4TRpBvI1YACyb2AWMT88u9//ZAPcs4YUmAzFIzApbUsH9XUR9zEIks3
         z5Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rp83WEUdTL8kpO4uV9lJorGMgLEXWeSY7lRLTqQTdndMhOQyw0p7LhB7XdOVIWeRNAFVRyi4wNJrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzllRQwx60hd2tJqh3d6ZYvjX7kmoTHdL8o4TmZVLX4cnra95dE
	julwUiqI7qJCmeqB4VZkrWfl3HDKpaHdzk4PX8G6sKXoEc2S8UxeKYLASDzvEWTSOA4=
X-Gm-Gg: AfdE7cktC5Hlh5gRaRs4+YYzE+MZqOIgeM/NhUS3MtRUPBeHL3hUN5u11xonuwQekhf
	lV9sxWFJHI5Ulg+JbLpf04dBr87/rAuWeWwbvqoxRg7uvbBINWTm0HXrXV5ddxIsT8wpHPVitiB
	3D659IE8dahyuQXg2n3Oj8I3uGfYEcHJ6j0iXcwBbbBGXSZ8ZZl5DBvHyyTmoKdZoYp/U2ibWo/
	RjKJCGzyCZXJqnC5+pVPmrsBb6fyWVtD2PAgRVDy8UHfl5lQJ/e8z7H/IJCb9MlN52SMBUYnaN7
	II+pXf1qlqQ36fnn18CNktq6ZRZunYy/6h1rcNjOMwoy6kpnCSC/YDUuXIl8cjKE7E5sVrpzQj9
	eT1eyaJHn/Q6/aTCuJ6W3R9ZVq4usxEiyCilM5aMp0rS71DWfX9+IGiM56a+tl5OAfYNnIvVXfq
	CU5HuGP+Ar5Pdi
X-Received: by 2002:a17:90b:3943:b0:37f:b447:def8 with SMTP id 98e67ed59e1d1-380baa8eaf9mr8701638a91.25.1783060050885;
        Thu, 02 Jul 2026 23:27:30 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm15733594eec.8.2026.07.02.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:27:29 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:57:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sven@kernel.org, j@jannau.net, neal@gompa.dev, rafael@kernel.org, 
	marcan@marcan.st, maz@kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: apple-soc: Fix OPP table cleanup
Message-ID: <ng7qv3vtfyhzklpbsghkiqezkq2foklddd6huusb5bfsd2xksd@u5hgcjtwnac4>
References: <20260703062049.1459175-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703062049.1459175-1-haoxiang_li2024@163.com>

On 03-07-26, 14:20, Haoxiang Li wrote:
> apple_soc_cpufreq_init() adds OPP tables from firmware, but
> some failure paths do not remove them. The driver also uses
> dev_pm_opp_remove_all_dynamic(), which is not the right cleanup
> helper for OPP tables loaded from firmware.
> 
> Use the cpumask OPP helper after the policy CPU mask has been
> populated. Pair it with the matching cpumask remove helper on
> failure paths and in apple_soc_cpufreq_exit(). This also removes
> the separate dev_pm_opp_set_sharing_cpus() call, as the cpumask
> helper loads the DT OPP tables for all CPUs in the policy.
> 
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>  - Remove unnecessary cleanup calls.
>  - Remove OPP table from apple_soc_cpufreq_exit(). Thanks, Viresh!
> Changes in v3:
>  - Add Fixes and Cc stable tags.
>  - Use cpumask OPP helpers.
>  - Reorder init and failure cleanup. Thanks, Viresh!
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 36 +++++++++++------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)

Applied. Thanks.

-- 
viresh
