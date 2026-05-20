Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4133D348C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271417; cv=none; b=SA6SVT93XUHQdajHtotFjZfxzxe4dsUg7eJouK62alBj4OAPu0xM8gGSlAHk4mVLXwFdqJVwiMWIwv1TIL4MQA1LX8B21KF8B/N10huqkQDzEFGKad7ST7y4joIMU1pPY0ES/00v0OymmaDI3yPTtY05th+/r6pFRPpjDhIJfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271417; c=relaxed/simple;
	bh=s5McUWYOgOEZHXnOSdmZAt9SCtkvJ7QTUrnHapV5HX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l93SDKQ1qvfrQ5kAHwqbS1bzVUVM0asiLglv94FYtarmQmoTVJEHgwXmNy7w4UWqO2jlez/DXVm6W8HWb5jKsqvED0y4xtkJoPLFgAEw2d28WYjTS7ihoEE8SaaxBEvvMCLDagenbovuGsBnt28gQqkDNJg09Ulih7oeygsV/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vA94rOgQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA94rOgQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365eecc5885so4269896a91.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779271412; x=1779876212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFK+VIX63/Lj3V2FSQmTOiB37XpHBdZ9pdoCzsYziaQ=;
        b=vA94rOgQr6ttirgCzB3CsEp2xWWRP+dEzWK+64kz29cDLgHri8iuB1a7XAedib1bW6
         5ueKUchFSQrk5HORvGi31OP7rtlMzB3gK612NYCUUyucEpZkaOyNOgiHh152nrmL2tVt
         eeKyL6TxHW06oMTW4YAJMGTcMmamfa72G/XliNBC4ufQoBaDulI+qzbE7SmDTaQRRfw+
         BQ0y2Y2eZ2/UH5iUoNnjGq+vEN1lMqSxP79q6OD8+xXU/QjKNAjeo/YnUMkKXjo2Z0Fe
         3gRt93WTh4buNwWpvbdQ2C/OL5Y4/ZOXDS2wvhnjQV7zyBvsVWzjNJ/6IqQWXsghHQBK
         X0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271412; x=1779876212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFK+VIX63/Lj3V2FSQmTOiB37XpHBdZ9pdoCzsYziaQ=;
        b=Hymc2LbNz7M+2E/ptyV6/U1o3ijWv6C0RZbpMtCH0AoVIOQTKLIdRVWjvGf7V+P6Zw
         OW1cl84NREGUORSP0a9+Jf/E6ydVaVANfHCH+R1wS0bc4Qx7BYXgoX0FXKV/fekWHWHK
         XK7ah0nEcuh6A8Pepcv/nz24UovAf4/BlRxwNPO4lGBM9ISsDiwATimKWkN3bfACQAXq
         SvjoEhM4JiUjEmF2I3++k84rvNVhVO2zd1w1FAaAKKOU5jEji+HdfnHz+rTPUGRhxxiB
         Kpjwsn0BSxLNlJmTidZid9RXQ1hGcSAU0GNNiQBKMlLF02L7G07OQorwEk+XTzf9pOID
         nBpA==
X-Forwarded-Encrypted: i=1; AFNElJ+HIlop1xnKc1NvJwQCjTeA16ENdE+KEbXl+k+L8h9ZCACbiNc186/bpxJ9s7EeJPI6fgT8YYg4MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpSdrd1jXOYXQ2DW8NUfnKnSXV4n7cxQKwr5etAJ3CyNgVUQ6
	K2X5GJ0Eadb9Lc+vlMRCQi+Fu8Jho6DdHpNo/oqwT6PZcWSC+ZwnWmuYT2RZALRlmjc=
X-Gm-Gg: Acq92OERdKhiSWZcDSQ3CRNXX4oZPui+qdobOhS79fdmYWkHRT2xDj7zAFjyQ8N6exe
	0s2yBx2RgNcC5FpZY9bVxTPNNt0r9IvMudJBqS/duzKE9ytUEXtNouzcwhyhIT8ihFtGFaXu89a
	jTaugCHv5tBCEBftf4Rwu6DYsyiGbw0oCUuqpIOyy8fRvkOxe+8D7eBs+cLBUhNdYY4V+t5OXyt
	oJxdXOv/6IfJxqecWkwhJuprzOBBGWjdEKAizXi8yW0l4G2KhuQvTbfJBHqi1LFsVk7AKH3qWxf
	Ak1zt2heMiJmY6IpiJiBfjfxhuRIRFrefk5gvHGR5WrBNW2X0ux2/aW16rrALPPbRiSQnAsxasm
	72JgEJmmbzBNDhxHTclJn/U1e5OnYlg6QMDMvchjAvQkQ7dM0LvYHUKVn6h9WrRaYWj4hoKCVBH
	jfbuuXV88dnPNIrfIrHoSJzeWd8a79iAgi6Q==
X-Received: by 2002:a17:903:8c4:b0:2bd:8fc0:1198 with SMTP id d9443c01a7336-2bd8fc01303mr231463085ad.5.1779271412411;
        Wed, 20 May 2026 03:03:32 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8baesm217826775ad.47.2026.05.20.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:03:31 -0700 (PDT)
Date: Wed, 20 May 2026 15:33:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
Message-ID: <bflxwyho5epheovbjnzlsvgvoitaqjbiv7kxcwbnoiz2nlmuvv@dtunrpupeyie>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511135538.522653-5-pierre.gondois@arm.com>

On 11-05-26, 15:55, Pierre Gondois wrote:
> @@ -1399,8 +1399,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  
>  static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>  {
> +	unsigned int min_freq, max_freq;
>  	int ret;
>  
> +	/* Use policy->min/max set by the driver as QoS requests. */
> +	min_freq = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +	if (policy->max)
> +		max_freq = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +	else
> +		max_freq = FREQ_QOS_MAX_DEFAULT_VALUE;
> +

Why is this required to be done before setting policy->min/max ? And
so I don't think patch 1/4 is required at all.

>  	/*
>  	 * If the driver didn't set policy->min/max, set them as
>  	 * they are used to clamp frequency requests.
> @@ -1418,12 +1426,12 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
>  	}
>  
>  	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
> -				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
> +				   FREQ_QOS_MIN, min_freq);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
> -				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
> +				   FREQ_QOS_MAX, max_freq);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.43.0

-- 
viresh
