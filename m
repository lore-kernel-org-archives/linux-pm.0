Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22B3806A8
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392231; cv=none; b=Y23HspJrI6Jryt1A/YTP3BmvIGqFanXcTa3E1pA3m73T3D7RL1sZf2gcIAadHSkxnQNEF7ycWcmDcSIQSn7s85iEIxUZC5PiVPKtBXL5xhlQPeb3VBZhUQ0TmFgngJhrRO7IHuA1vx7yCjlYEpWqtCeKkr79ve9tvwbDWnu8T7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392231; c=relaxed/simple;
	bh=6dn4cAHO/yXmZxpFM5c4psjVVqkXvY752uXcv7RaQSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p10Tpnx4tj72iEdTCdDAJnzeWDzpVbRtdaTY3kllkd8jv/5ZISHMDgjbKEQXKk7l3/ael2IhlISx3KiWAgRCk/yr70+PlwqTqwOtkynq6ikpQnh20KwrzgbzlDQr2dUakvl+Xo+ZvvgCJPijdqhgjpQ4V27A6F3h//eB+KvAEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLHMnLtB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLHMnLtB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1184674a91.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 01:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773392229; x=1773997029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKPt/jSAQLwfHBRlDOcffsjIzbFeEr03OW7aXc8s3aA=;
        b=YLHMnLtBBe1LDSTL3Xg6R71mLqsGB2wU7j2fLNE+zNgh9sLqK84XmGLbF9/mC4aioA
         E0WuXmL/0vLwYMbc76pijbyiNhmdvDvK/zoojCgaX/fxWu72h5ogHnT+7IKAzlHCQkMY
         bPRiNwFIVurVqUOGxF1JHvGiFTO5Yc9aLvkXUgdupbMcO8ScT9b/3b2JD6LL4W+jXDJq
         PekoTHnZtlg4wwShyHQ4Djrmw5kpQdmGSQ6P0xrYjwk5YMp3bYPSIo0AVAueBZf8iCOt
         0Bq1wH7qu/RAiplF6lKk1kNBJckhDsGcb3CYdY47TSvXJT05plV9qYEsZBDLCPrVZLZw
         7d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773392229; x=1773997029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKPt/jSAQLwfHBRlDOcffsjIzbFeEr03OW7aXc8s3aA=;
        b=IELuTz2Y+/UheHwdT0xkQSPIaqEJqApQsJVagjsSi8Jgto82qug1plKDtsRL/zaPws
         QjLBqI66+WHiMBtnKY3EkWEVDoGoSmVD0Dcv/rkI3WwZlxRxhliNfjmtmvCl+tDwT9ga
         wmn9d2rdmaRk/AbL/J9wH794f0kLwV09Iino6eZOPFZDw6px5/pLv5dutQCiRPxz4Jna
         huefBBPNoUqQ2AJkkaKAc3VUoTJmIn+kY6NvjdhOOlycsMbrIm+s+Yk4Y67S3hrTYoOX
         ZM0ZEevGVSp4rImkL+JhuEBa9ZSZOdtV2AMktHnlrb8exjUnueg1etYPjlPN7/q6H6ae
         dKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQQTM7dX3KoafFL3UiGGS+4z9NrY01yniuiaRzQXdoHawab2Xer8vqqQhg+v1qnZkPpbZgHPryAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCku/wNax3U0l5y/S8y6FHs76Fx+RGOb250cTi1SqizyWSykHL
	M6ne+C4KeuEdn1TmucRqiuNQFHrPBtNpSWGT3FRyZET2JtsjEBCQNwbLaugMXhoXmAE=
X-Gm-Gg: ATEYQzwY5l6joTv7j7/iOWXCniprnYuUHi6CkeadXncsgjG2kH2oJS4npoqLu1G8wgb
	LPCWhMgYF+Yy5CHWaj0tpqpz8Lz/vSuOc5XDts0D2epieNHHJanZPw2DgutQ9Og+OyzMpu2zVGT
	JQM5s+pHC8kJ/KiC6LYYsAdnT0vsVyuk5ZGj8vf0ryhPn85GwW/Ox3qA3tgKHQAq4tmoXYoHAnz
	trvsau5c+ZCh80a3zKiW3M6MaiI1cL0GyzRMkj5F7v/ZDmbJXZPp6kN8eOrppVXGUzBUSmrp+zm
	vM21109TQL0sK2r312ibdK+8iBKMkxhD7/hG8udTfDsODnm9hzqM9zw1Saog4ffjIl/nhMhJBbO
	17FQeCX8Zt9i4wQbrV6BasPWdbpsqS6tbo3S7O+woQ1N0MgZI/DKnySwjpR1bwEXRPBQHbjyyb8
	n0kbuGCEPF1jgd3wL4bMM29fv6gtwZ2s5NNVg=
X-Received: by 2002:a17:90b:3d4b:b0:35a:117:9521 with SMTP id 98e67ed59e1d1-35a21fdb67bmr1789917a91.10.1773392228595;
        Fri, 13 Mar 2026 01:57:08 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a17be605asm5850525a91.17.2026.03.13.01.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 01:57:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:27:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] cpufreq: Remove per-CPU QoS constraint
Message-ID: <zvk6qqwde535fiimjrtwhkyjnhymliv5acubtho3ge5hgj7y5g@3wolynnix3gz>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225084930.1692228-2-pierre.gondois@arm.com>

On 25-02-26, 09:49, Pierre Gondois wrote:
> policy->max_freq_req represents the maximum allowed frequency as
> requested by the policyX/scaling_max_freq sysfs file. This request
> applies to all CPUs of the policy. It is not possible to request
> a per-CPU maximum frequency.
> 
> Thus, the interaction between the policy boost and scaling_max_freq
> settings should be handled by adding a boost specific QoS constraint.
> This will be handled in the following patches.
> 
> This patch reverts of:
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4472bb1ec83c7..db414c052658b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> -	} else {
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			goto out_destroy_policy;
>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {

Even if this change is required, I don't think this should be applied
separately. Just reverting this will get the bug back, which was fixed by
commit 1608f0230510. Individual patches shouldn't break kernel (and bisect) as
much as possible.

-- 
viresh
