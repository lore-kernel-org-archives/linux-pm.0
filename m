Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF054389445
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393744; cv=none; b=WM9CoDC+/yVV224jcdZYZ3pgkd0EnxFN9lMOOAb9HOnlLYOqQ7MtSeARmk5cwnGPTqhCEnD6J76P/z86UtgwotsmUltZWRGLu9HwpMFjITkp1vZFVRg3UhXzsYI7RocuSbwZ3i9SIYqd0KzxHARg8CQq9GJRXBaXqPg+yfNQ70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393744; c=relaxed/simple;
	bh=GHxQIPkXwLIn/Md+Gs3VKf3lRbNNPbPBOsWSmT5ZFPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEPk5z49BT0d3vwy4D21jKox6ZZQBArXXnTXYA71TspraQ1Nn1YMVBbAFACuK6SQVN6afvJ1prMuPuEHso1Y7XjwUdHeS2N89sRamR5ndAvsrTocjaY6lgV2zLzL6hWpfKvDH29hNOABucWXpPKqlElxPd9eEiWOsKg0hJddXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSHrIKVK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSHrIKVK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so24063155ad.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773393742; x=1773998542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw/nFNfRDhM1oNEIjaWrN2i22wrrq/+qcKdxDrkScN0=;
        b=vSHrIKVKTP8OX3z54DOB6v/3EtRyYfep5Fa6IAjMp6zZaiNcju3bYeAZjuVHZ4LrPF
         sFbWUokitgrsEpePLtlVxD/QZRYTLdZ1HK3oG6TLXRwbjdrTAI2eitAc+gp/sIiy7iLh
         GCszIcVbKzg8Gb9HNZiJh1jXk0ZJAoCKhjbo/8XHCpGZcDEsbflRa0On3sftoludtS29
         6jAJ3JVdW4RSoONa7HontxDoGKO/yFpL1pHsd1xgzq2RMCjmiDxFwLOe2SsxvBkoDZGE
         5EC8OCjIhNu1Pjg4JDaZqvNlSJ7iX7wAWDiKCZ9UDAWmtMfflfMOfXoYxsMciBA53PrR
         3oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393742; x=1773998542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw/nFNfRDhM1oNEIjaWrN2i22wrrq/+qcKdxDrkScN0=;
        b=ki9vjRQ1XM3tiL+UeUaBXuqF/P0/fGQo/a0BmrtO0ooqG+q+/DzFyz/D4iEhVoTSVi
         HATkmj3BQWJbUenE50O4A+Xs5peY7um0yoGyJ9W88AQfviKj+FAijvXghonV+X8eB2Jh
         x8d4HnJg4eJk/F/Nai1qw+dyEEaKVLb00q6pYfVzsC9pFPD56ODKlr7C5fE8btBYFiFk
         Ave0v0gfeVFnT2o8qVUFc5MnwlPVjQOZ8SHW+4SP1sKKZvO0oJy93dxZ7r672XyHVgEM
         iufQw1XnYXHxwrQsqQ+D/eoq/v5Zrj6UY4PcKoKp9ySrclZmFnv9z3mowDFp9C3m2w2n
         JRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVufd4xoCl653Y0FZyXQ4S7URB7nAV4HoPm74MDoHbdLsn7HUSL7O2nKTru+qzwfZggI0B2CCCFyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YykRM6MosCWCTB824wB9fLRaYSL4y84w6OTO+BznVLiuCC3MsHs
	a34yglUn9cPDnd1m9DLmll0rvPHZAqeoGU9cEbpID+lrdr8HJr8LG7rZKbIw21P5YbU=
X-Gm-Gg: ATEYQzyWAm3iywU/2kaXtL6Ux+f9sjwOrWZWnrIceX/JkRDHAPdkdx0bxMn6FZDI7ud
	9+EgsLQTi7J2nWYcQm2pMY3fN7+swaZIZbR07g+RnDtY+R+Y4dBVa8WkSBSozMuXZ8D7nWH06vp
	IBL5aQVNgJ3xj2YdQu0QqO5UdC5PPikxmU6EaDxjhjnIt3gAtVEdsjAN+/0Ah0wERjA4tDyZ/q6
	lTSaVOmOSPlrqVXuxkCAyX8iObW96mrwQO4F40js21KGfZHYAfjXa6GxNTw2qAo9IdsnPMd2bJJ
	byL17c/1w+Q6V0Idx5kfcQAkCm1UVPOcwnd2BwAu0FialH3vcmLtwWFET/tp2eekhUsiMEfaTz7
	TQXfJSfQwAPaA0K+oK4bnUNEyunIpsPEwKVN7kn5UF4GYXGone8CjLmLF/evy17VkIpf+4HCnxA
	a0k4ASwfNRTEC+16Ougn+yImCB
X-Received: by 2002:a17:903:32cf:b0:2ae:4948:f866 with SMTP id d9443c01a7336-2aeca9d13eemr27364135ad.22.1773393741808;
        Fri, 13 Mar 2026 02:22:21 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c733sm22232325ad.35.2026.03.13.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:22:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:52:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/6] cpufreq: Centralize boost freq QoS requests
Message-ID: <uggew5u2bjhgfxt5tlt3bjqg7aks7oab3iqnlayol2f26otchn@2xlt74ywbln4>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-4-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225084930.1692228-4-pierre.gondois@arm.com>

On 25-02-26, 09:49, Pierre Gondois wrote:
> policy_set_boost() calls the cpufreq set_boost callback.
> Update the newly added boost_freq_req request from there:
> - whenever boost is toggled
> - to cover all possible paths
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50467b938668a..42de32488f422 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -603,10 +603,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>  	policy->boost_enabled = enable;
>  
>  	ret = cpufreq_driver->set_boost(policy, enable);
> -	if (ret)
> +	if (ret) {
>  		policy->boost_enabled = !policy->boost_enabled;
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	if (ret < 0) {
> +		policy->boost_enabled = !policy->boost_enabled;
> +		cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +		return ret;
> +	}
> +
> +	return 0;

This can be:

        return ret;

and you can then drop 'return ret' from the if block.

And yes, merge with prev patch as Rafael suggested.

-- 
viresh
