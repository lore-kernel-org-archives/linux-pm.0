Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64137F8DC
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760523; cv=none; b=f4HZdn4QK3vMMNhVOFelXsC3jdjvKsIQtXLlRNyG4epWAXrkx6F8ZTH/fhLpsrSOU4W1DPy05ZcoRnz6lgCMYoYzet5R4j9bwtWmnJYpiW+qlkKcOr8wf7FzF29sKFuHdQLh+fIEHvtC5AIKOSEW0NxxFmb6fxkt3GcmJQbd7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760523; c=relaxed/simple;
	bh=TgqiDw5b5VQPj2Gfb7xm2gYBgCDZhtqTtCOxTAHstTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl7DQQRg+N2VYvk+p70u++L7Kfp39F7DXuZuep0B8gmYW1SENKCrL9JXke/h6LGkJkcT+B+Bw8309UznSIS9jfCsMdRHYToFo/Lpr0agHwZP9aIleRL2AoMSmlrlfldfLFlWPS0KNoT+uMQhXkfJCGdbum0CX5M29EpwAYRmnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JRUzUAiH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRUzUAiH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84347ad88edso412888b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781760521; x=1782365321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ7ZXggT1jvOznKKnf3hT4I4MdXGJIQvuFkuvRa45Xo=;
        b=JRUzUAiHNxDBBvyOrXh5a4Xa3O1S32Ie+Tcbymejrg0AHdoyZkTSfaOfQfl0WCmzLz
         T2z90cjHhE8/HxhS3GhqoBDUz2vPXRyNZMStXWfo0yXRNHc0F6DLVL52PlDpi6X+9DVs
         /vCUkYHHq7/TqMwxV6kQAPhTLZ5h5j6e/8+eweKYdS2PyKM0KLq0JaTkjL/hzSEmlcDq
         0kJRw8511dZheFUGsbSzrPr8/D1q6qR/KJu9nPPf77RzLHbeLJUDLBv+jo/R1qp6tnCb
         YTI+zMHEdgqMIa31nWEjHL7T8Eiqbk3UltBGlkBDKKdUEy4gaR5AwrUqUHFjRzQrzPtX
         Xhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781760521; x=1782365321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ7ZXggT1jvOznKKnf3hT4I4MdXGJIQvuFkuvRa45Xo=;
        b=b6D0ODSd+O+iflALrN0XdkXDZdRLX2Mhf3leZdEglks+CG83WHI4hD580906v+NejT
         xzJ/54bRM5rxJvLrc8veCp3GMGTDuUFwP/RMr7PpY4qeQWxBspkIPe8JgzSJbHEY4jXW
         gOUDO7b2KU2II2MQ2GnIXXGiSjmoVGELKSzjK1smRgpjz9eq/sxHVdrb/PocsaM4SZcN
         d7UFkVAZFJlbsMm1w0ipE44AH9XwPEaHCDhc3g04tk+V0UnkwfeE7WMqNBSlcMfLoDVA
         NOos52N7NZt5y7cuQmozx7SRsh4zuUv/5KfeW3SQif0IpfTjiS10aiAyg6hCMm06hrGO
         01dA==
X-Forwarded-Encrypted: i=1; AFNElJ9D0pn3ufjJ/VgzCJllf3oAisupynE8WTlNfPowav9CH46OSdzm4E+/WuJrabtnmoEjzU/bvmfXlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaILcPm9M6gbGOIUwNStRlclU8zKSX/5Ma3w0I4Ens+/LcvxVl
	bwYsguRVaC7GfTKJ/G8Y03MQztYU79Ef8/85ZBaKbvMkXP516KtCwPVQkUvPa1OON08=
X-Gm-Gg: Acq92OEp5K2UDtWywyJp1bf2xKVWnrk1GuDt+wUSYBCozskWBc1FKNJ6NbMlYRk47t3
	GuzMM1/NpUWlpyUF2tG3AkJlOnFnt5ZtA+uF0EOMzqYeD07Sevo7IZ5RESBwSJunbzHymMZJ9UT
	U5XAkxb6Z7sCGc6OlY3jOQHqk+YYP6+KMoRgGarBBzbub4hmqXtwM2teK1Is2HRKdrJVi+y+yzJ
	HMwm5/5csHseQUeF3F2OGsY6Cd8+7Es2WmaX4mLoT4UwL+ZUali3lL5noC8fGQFibyoObR/1WQG
	KxdygtiK5NwWT3ZDwA5lwdtiJF7SLsw4wlySAzSR9tw0DMrPQUBeHnKPkGkqjWv5CIKmM0+xTii
	/S86i80CMgeh1m9ZAai8MvQjI0jtwQ9hhdhnASsaSSYg9fh2Be/WVl0vLMMHABj2tZpowwjsM5i
	kLuxjEwkozgTgz
X-Received: by 2002:a05:6a00:298d:b0:82f:9407:d167 with SMTP id d2e1a72fcca58-8452457b4acmr7514220b3a.38.1781760521287;
        Wed, 17 Jun 2026 22:28:41 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b049120sm17827806b3a.55.2026.06.17.22.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:28:40 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:58:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, pierre.gondois@arm.com, ionela.voinescu@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, mario.limonciello@amd.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
Message-ID: <oxw5k2wad4vorehgmrduoxblequy3ynqufwy4sruclnh5d5wrb@awzmfafoucnn>
References: <20260527202550.206828-1-sumitg@nvidia.com>
 <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>

On 16-06-26, 18:22, Sumit Gupta wrote:
> The dependency it was waiting on, the "cpufreq: Set policy->min and
> max as real QoS constraints" series, is now in linux-pm (linux-next).
> I rebased on top and verified autonomous mode works as expected, and
> it applies cleanly on the current linux-next.
> 
> The [1] reference in patch 2/2 points to v2 of that series; the merged
> version is v3 [2].
> 
> If there are no further comments, please consider acking and queuing
> this for the next cycle.

I was waiting for CPPC reviewers to provide some feedback.i

Jie / Lifeng / Pierre ?

-- 
viresh
