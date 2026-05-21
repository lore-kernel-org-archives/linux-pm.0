Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AB3126C2
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373994; cv=none; b=C6GpItYb9nuYfKSnRgAOkjmLAiCM2FwhKMMOHA0C1R8+gYnkWygJxzaOajynexVCBD0qx8/5hOIY77hy6I2SP5SXbd2aseCW3c6n7A3asvYAw3SLy9UUqxR5DnfvqDlwQUOORyeEmE+FuHlIlASfM7ui6l1jS9FY6j2OBXIoPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373994; c=relaxed/simple;
	bh=VYwdSVqPSInNrw6KMxUqj1vQQpmkiT+o2nsFT5EFyX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5d3ga//STuIaO8QJJuV5nuuCKFWQK9pIwyHgBCFgxjbu62CA8MC8h4ZOiJeKwKeO6PST+LpaH6FQM0ixIiGlkbLzdSRiwk6eD9UY3bbsitbEIq43gr6yCWV8vDJdZF2o/UFfbFh2DdHOAow6WbtUvYTzfJ+98R3IPfRJB2blV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Env+mz7i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Env+mz7i"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2baca4df358so36927105ad.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779373992; x=1779978792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3YtKY0LYmXrvk3RGMocovCqKAP/yteUqxtZ9VWqvIk=;
        b=Env+mz7iTdmPOwf4S7R2ah2nlIUWzX6lQt7uk0CmJTt4ZvoEqozeGJGEV2ra2tMKCp
         hRy9GL3gS3gq/I967SeyLQagMHC+YFTIzIgBAHG0B/RniT4AMTyKYwYErHm8534Lzybw
         jGTGYduMBjFcx5RYoQjIGvurIKc6IiZizSx7/nLcZn5bRRvJek613kRGBLcAqGhdx4Ab
         NhQL2z5pSs92Cs66gDN92mD44vWQRQp0/30ibqhqIgygw9uQqiOHw4Tm+tKLoGwQz9NT
         Q5pDWn06LonU6fKVR4+EZv0sdf/w9n5Rc7prR9l2N9oRBud0UNAx9UDtHxBCLGKOQMQj
         vuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373992; x=1779978792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3YtKY0LYmXrvk3RGMocovCqKAP/yteUqxtZ9VWqvIk=;
        b=rXU41dUzaUFe6fk89x0D9Ru+teiHyUrjwBwSpBMil/9ic3bHMrFChKqZLZsQSHlFqR
         S2kY9DFh1ZNY30XEWIeqvf7J2FAXdMh6DWu8JeMcwe6RrLwaixuhtZ9vxv3c23fHdTvJ
         bBDWcmUh+mhugXa6BWUK88m50IRWsNp6Vqr35O60cUkxpAeM6VvDbf5EAhAQE2aOfG8G
         xNHvN/WIXjCThnSSJXtYf+NCV8QjKW3SYJyJvWjvWDG6eGIMgJkQalbCy60JS6GeNM74
         Cx9O5pdpM4wYfctaGksjg4rHSSCu9XCPq8DbssXJY1GHxQ2+uZCLTG2Yg+IUSHNN2CaS
         Og6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/YsD4OQ8qSC+S40PoYcNozb0h+ECyqjlZ5vs4JVxuNCmtE5zvv7kGC+bu2TjUtKOgXu38RrlDJoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vNsgozVnkZsh/fc1TuZjlCNDlQMpc4MJCxCdBLO7U4c9aplW
	930PBdGv1L5AyNw4zkvRKtzRPPWBdrwuY8UVjkWRo5C3cNLzLam2ZgJTvJB8GO/X724=
X-Gm-Gg: Acq92OH8FadY7gnZs4EV7b2kJnwlxwIBxBvTZa2Aw/fOziv9//EZnmRsBVOUS56HJ40
	hBDslvAUArIh4mYQKv0SXOKkJYkYhbALlQh+XBvqo7q8CO0EV/Mp2BZIO0m+Y5U71LgXL+MH3y8
	GplnVF2k+nYuJx+uRRRYus+v9eN5f+PjzvRFL84N8V2nSmZQqWz/jA4Yn1fdN8OhStMX5RtmFAl
	yVHZJtcEzx1QqVcrXSLCjUtSsSfS36m9u6Vt6eQ+qIN8Pp6y522Z6n05oTFzGF+50mW6i1GHjgK
	ckwlcUU6txniFaHsiBYw3/3qPGr0/OaL4X3jvQCX5T7NF2LNU5ydd6FZd8iW8WbKTDQX9s4bl9P
	Q+m3RdfGMhfm0++XNwVhe46Ka623hOoLNGLPbe2x+gcD1nDGU6r2uLiw3VQfL5xixLi0zpqxxNv
	X6bpkD+vGVwcm/Wg7dAABRsoY=
X-Received: by 2002:a17:903:2305:b0:2b2:4260:109 with SMTP id d9443c01a7336-2bea330182cmr34793355ad.23.1779373992321;
        Thu, 21 May 2026 07:33:12 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea92a2571sm16988185ad.34.2026.05.21.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:33:11 -0700 (PDT)
Date: Thu, 21 May 2026 20:03:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: Avoid redundant target() calls for
 unchanged limits
Message-ID: <2l2wp32sms7vkr6brhdpi2jlcschagdrhrb5n7dimnqz4czpwo@3agems2d7qkc>
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
 <4c0a951bc57b7fd5cacb6211a96770e5791b1fbc.1779360823.git.viresh.kumar@linaro.org>
 <0078ab64-05a9-428c-a8ea-ae5a2df4c1e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0078ab64-05a9-428c-a8ea-ae5a2df4c1e1@oss.qualcomm.com>

On 21-05-26, 21:58, Zhongqiu Han wrote:
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 1292da53e5fc..7f19ec6b70ba 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2942,6 +2942,7 @@ static void intel_pstate_adjust_policy_max(struct cpudata *cpu,
> >   	    policy->max > cpu->pstate.max_freq) {
> >   		pr_debug("policy->max > max non turbo frequency\n");
> >   		policy->max = policy->cpuinfo.max_freq;
> > +		policy->update_limits = true;
> 
> 
> Could this be redundant?

Yeah, this won't even compile I think. In my first attempt I tried to
make the update_limits change from within verify in cpufreq.h and that
caused a build failure and then I moved to cpufreq_set_policy() and
forgot to fix this one. And my arm64 build didn't cover this file.
Sorry about that.

> It seems that intel_pstate_adjust_policy_max() is only triggered when
> !hwp_active, whereas CPUFREQ_NEED_UPDATE_LIMITS is set when
> hwp_active is enabled. If so, the update_limits flag set here may not
> actually be consumed, as __cpufreq_driver_target() would skip the
> update_limits check for drivers without CPUFREQ_NEED_UPDATE_LIMITS.

Good catch.

Rafael, is the understanding correct ? I can drop the intel_pstate
change in that case.

-- 
viresh
