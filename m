Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC4351C3F
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001657; cv=none; b=Vjh7ezPAt/dtnrwD5cwrQVl6A6p29sTmlkF45/yWn2ZyZXUHdqwZtBH/RQF0fFoM+WhQJFGSJkIr4qk8ToeML3fnC2QVgC0RvMI/zfZNQDFYHoNMvxubx/D++L1NKp0VhTs7oL9pXPkKtjMoaUltSZQ9iI8XzUbDL3b55KGI0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001657; c=relaxed/simple;
	bh=yjYOfP7p2WuxssES6jNsAF/UvHGs6akrwHquMviTrEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaZlpm4zhsdl2NZwsj2lQh72oPW4/hvzzrXtnJg9tsod6XJxEqPywS0RhGMHoLdaLLXFuODtLZEmwX6uL4oEsmml4u8tY+heyjpbKLT1BxoImPnO6fdPbo5eB068mPAzZYUgTbVnbP9Fu3ffkTUwyrXvZVb2qtlmX3L1TsmU9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqgvTqfm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqgvTqfm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab077e3f32so2004355ad.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774001656; x=1774606456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASEQJGPtDHdOzCAQPV2zVlYlrOF+IFJ01C7xNdXm2i4=;
        b=sqgvTqfmv/SNi0G45Gme8dAbLQfgskMETF9zGY3re0vJb7B9qFe5R3dOiHaXdUoNCG
         kZIR+zCOo+Xu1gOyjYYjfGE6rypqy/w0GT72MI8Fb9Mx4c15h8QhdJNvulLx275cXvZf
         jAj2EbVZOxdti6zY+e0WgjpKnkTkFUYLBJJxjBbuDLXX5HiBzjYjNWOgzSbUiO3/1oZ3
         LfBZe+PJcX5vR8sg9yjm8e6xun21mUnUTvnkVUhVBoVvulTY3vGfngvK8JzioDqThei9
         wCQa5ZHTSckIwweHgpYkrqZWTCONfoI41cKXeLQH3IAd7HyDr35+Zp3TV7JvtfSpdOce
         T2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001656; x=1774606456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASEQJGPtDHdOzCAQPV2zVlYlrOF+IFJ01C7xNdXm2i4=;
        b=N4C/eLR7etJXoiSyd258ZY1DZo0CvnTHXWRB22YTqmI7skYB2irHuJ6d0jNi0gNutR
         mnUVWeEwm6hMne5uL5ZHSiY8vkQyEUcRDaVz+VKJncfOpBYt01iRh8WH7Dk9vs1nQ6XS
         wX8Bge8Rhw7ThXeR/hUU47Mhw0hmHigZ0CQcXpM8Hh7qE2EmBECLvW4Dyxtl82A0u4AN
         G9S3BKePXqGHmF2kXSLrlXuEPx6Necn1nn+MU/zdENgmKCVpI2ILpIHQhs9IELVi5yyJ
         OqQPHnDj0kdrUmeVzsd9UmR3JI6R5dcoRRz/CuKF7YfcpcFdvE/Pb+CKezZmL3sQNGLH
         czsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAf3NntUSZJtHe2dhUIry81friuzVXkFyvk4c8i/cbzp3cTmlZ0RNcGcZuAkLzxTPZ9A4tdgPIIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygTAXFe28qMCN7E29j7iJZG4i1PsdfWOMmu7KSHlTCqX22aWEw
	zm7TUGNa/OFKMW+XkecC3ZUFJW9fqPM/2uqefKkdw++tRKUPTjo7R7pE70GgX+QdCGI=
X-Gm-Gg: ATEYQzxvMoXAfv2ospHKKfclttcP9PSLTVjdPUnCNSbjPUR7xdj2c3JbRYQ/aUugP0g
	ueqBGILpW70FzRWGju7tlrXcvq8jpoVjaWM002R8hC61eqaGPR/3cBX/WwBzgLmzbgcrs55tS0U
	K+8tP0XQMAj4M/WB7iWryX4LkGKMSoyeSAGeYMK1WR5cYxKOcFo3gSzzqqbUCvlQoiTvRRFaFLf
	ckPkQjvZTonv3+vwCOTJxq5OuavKSr8Exxi0caz0gHje9AkNeEDCHRbNBPAp2W4mfO4bG+/S6w+
	swM7L5EPInU5bf1FX+HrbYso3LjRm6NGla6MIimKWAAK0FHL/CTaQXl9IrnissXRq8ymhnJbTml
	ZBWDOdzeRcp3yN/AJByuPPfmNoHQFLCG2XcxATSlOk+BJIiBd6Fy/6aEnLpIY5FlMdxARZ86LkG
	Hdk0xzNcigmPIa8qWTGH1S4xog
X-Received: by 2002:a17:903:2903:b0:2b0:62dd:3a87 with SMTP id d9443c01a7336-2b0826ffc2fmr15026045ad.10.1774001655983;
        Fri, 20 Mar 2026 03:14:15 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm23397215ad.60.2026.03.20.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:14:15 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:44:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/4] cpufreq: Set policy->min and max as real QoS
 constraints
Message-ID: <ukxdxr3xv7x6pqnwwafxgvhvfh5n7w67y3zwunhnk7b45tz3t6@d6ehl4vqac6t>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-4-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317101753.2284763-4-pierre.gondois@arm.com>

On 17-03-26, 11:17, Pierre Gondois wrote:
> cpufreq_set_policy() will ultimately override the policy min/max
> values written in the .init() callback through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>   \-cpufreq_set_policy()
>     \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.

I am not comfortable with this patch to be honest. policy->min/max are used at
so many places that it is really difficult to make sure if this patch will break
something or not.

For example:

cpufreq_set_policy()
 cpufreq_driver->verify()
  cpufreq_frequency_table_verify()

This uses min/max before it is set by the path you mentioned.

I would suggest dropping this change, or most of it and doing only what is
really required for this series.

-- 
viresh
