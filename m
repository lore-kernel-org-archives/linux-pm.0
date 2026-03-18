Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CE34575F
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832443; cv=none; b=j67I6dn4oGHAht8cXRQztMzj7/vph5LCoH4C7IySHNF6xp0H5oKlZfs8xU9s1M6Cc206NuLlTBkHzbOr5Af2QZ/r631XggItRNUleqh3odMCeuyh1CjiKyhxLsET/3AYHSdVNCUKnMOFXb46rH+Tb/ZwXim5OTXQj3ymdr08N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832443; c=relaxed/simple;
	bh=L7bN9RclHKc3DGlu0Za1HlfQ+59EGdV7wktBsQhPdBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFtcyEQLVmuCxG9/X+yJEs4C7g1c7TGSP6LCcAh5nrBcDDswnE2RxBzPWKRqs74DM/pse3Buo7bNb1kWA2na2xOmUBc/QmjAVEJ+XEnwg4RA5DItakSsAPe8tWAZC5tAu8PGmS1ATDyEp0osp18pWh5XrO/31yPeUuVNcqoJxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2XlBFF+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2XlBFF+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adbfab4501so31574845ad.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773832442; x=1774437242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA5A7MTg3Gy5NBUe/2mZPpN43771nJWiw7jhZ7JR8ZM=;
        b=k2XlBFF+72k3VI8OJKCh9Z2XetlRHiS8ygrpu1xjvymQkPDZBKgAB5EWQCLWD3WQ91
         0h/twMeMnOcoDm2SBTXb5AQyo701anbitoo7Ac+v7BbVxUg0ZtsCfxGq22whVeggUVry
         8/dt2WBo8PzK8oJ3epF8UGaOWWi1qubrWCjoTRQWP9vu+Mrtew6pJbFMtuJemMperw8p
         3ShtxtROh7y46xX9XHJtu6t5AEuEYZUejGnTzgX+xVeaDORKPH639aPPtYMm/93o3b2u
         YnUHiDAiHZedRif1gt8wkkcw7i6WWQOIB8lM5MCsb2+E6OhGcV9Dd9/mwTDAVq1O98ay
         zfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773832442; x=1774437242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA5A7MTg3Gy5NBUe/2mZPpN43771nJWiw7jhZ7JR8ZM=;
        b=h55DAs2UBa6YaEXojNdni/H8isBtq3MG4u+dEG1ffgP9NnJ7kEw6j6vip6sPKPDDzE
         t4E0POVZB624DvT4H+6ffcqtGmxpPY7/klrM8Opl/0mDLoWZausUY9qhcNhLrgzCe015
         qx0kPtcS1HZrO1jI0u/v6r/HDqhvyDIgHJLc3/sxzbAVbKRdDsV1vyZloWqWIiyp3cOp
         3yafqhwRev7h4nVXPVfkBbU+2RwaytJ8nrV49aopM0edRqdHrSe/051woAUdBIGCp+SU
         FCrXG1beQld9ZjSC7x7VmSIbNjdpuJLuM5EPs+mhhQ3IOvNeVLN8pCvi/H7HLtFQBMfN
         8qBw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8ljANXQMzjCF2ZVnaL6pHWLfOawIxeQKaouDrPsN6P+cZqcaT79H1fTGRi23sk6MX/fVlB/npg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUN2jGr+xeQ17YRgUQemJhBT2HgYerhjUbvd3/yrXUDc0u7ei
	8QpM9LuiehXXn3Il3zzpIE5ETScymVHmk2JAcyQmpICANEdOphwyOluVI3XJbOVhtq4=
X-Gm-Gg: ATEYQzwMYqzny/Wa5VM3bnwK+NrjFfyVvzVl4ndutJSHVO5uTqQp+EcEJXwXsQm1C/D
	qPk0OhCeah0XGfN7H4KQyj0uSfY70zUPiEjIsLoZDQlpEMskKWl+XA+ND/r14+rQ5uzhplL39dz
	r961wUtPKHcm6Lcxc1pHaoh5YG3xesx32uN8oxD4Dp5VEsfk6Sp6evVWWD1NOIm4ihvxW5KvxuX
	6/bn1DjH4uVn0VLeOiGg3ufBMe4YKrx6lvZY9bzJ24VGjFB/0MMGVPwrHDywX37FteD5T1K5gdH
	CkAQi6omzL8TkIuKAA1JPF1cG2tWfMv+QUDKsNwY8QEhVCZZ2xb76LhFR6uVsJ5nrNZHJRnXXfw
	o1EaO8+FnfquyBLOSF7tekqvaUWz/ZoCG/xzEMqxGLd3jcKtwsHlho9h6sne8YMoHRuf/ZrfZPc
	CrlYf1R+2pYwnGYM2CNFiMTq097CSreECHQmw=
X-Received: by 2002:a17:903:230a:b0:2ae:aafa:ec95 with SMTP id d9443c01a7336-2b06e2fbf7cmr32705255ad.11.1773832441923;
        Wed, 18 Mar 2026 04:14:01 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e419a31sm31820305ad.4.2026.03.18.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:14:01 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:43:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
Message-ID: <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317101753.2284763-2-pierre.gondois@arm.com>

On 17-03-26, 11:17, Pierre Gondois wrote:
> policy->max_freq_req represents the maximum allowed frequency as
> requested by the policyX/scaling_max_freq sysfs file. This request
> applies to all CPUs of the policy. It is not possible to request
> a per-CPU maximum frequency.
> 
> Thus, the interaction between the policy boost and scaling_max_freq
> settings should be handled by adding a boost specific QoS constraint.
> This will be handled in the following patches.

I don't think the above is required anymore. This patch is removing stale code
now which isn't useful anymore. It has nothing to do with a boost specific QOS
constraint.

And it would be better to know for sure why this isn't required anymore and
which patch exactly fixed this issue.

-- 
viresh
