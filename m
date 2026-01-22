Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741F4657EA
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058899; cv=none; b=EDoi8jxHdPk0xfUmTjZnnSYFs5Ww7KUuW3pu8quz2FermfuO7W4cqVqz9b2MBkc0fvH/VlU1SwIC5+ahsyvTQBEaPgam3lMvQeM7c8LXQeyb2kxFgS3JwozycvxxFNYv0cnX7eFVDG05ielKo9qfPEGsj7s5x0GG2oGSF9zPP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058899; c=relaxed/simple;
	bh=+5CgNU+lYomLNElkoVOPBVon25ECkJmzZFugRgC24Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Htqxh+/KKtE1/nfICHUzY5NzT6NR0BxG3Cvdu9380Wv/emMdu1SNpecDhuvFxzlGj9FrcWNCcJO6h8A8Cvf/yNtk+lM65Xz0nSmoIEpWOsUxKMux5c7h+UxkwyCwdIa39ldfCB3Y5Y7ZwJrR0sawPZSEXMpc8xFP4xg4tykYgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQXa8+bg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQXa8+bg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823081bb15fso146167b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 21:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769058897; x=1769663697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDSH9T22AnGw42Msn1988FOkNE4f4GpObhLMn2Rva0M=;
        b=MQXa8+bg5x8QSpcAd5xUNfn7rGWW41hWkuz61jzTo8t23Y6uALiZ1VyU7A8WWWFjcV
         R6FzOKtWvnhqdN3y7tW9j3YbhZx3DQ1cX+CoWBXC3CD/MaQRJrZPUEtCf501jrNPVKFV
         1vz+TDIB7XGuemSKJOeK9U9JhZ40off02MbSCZIhnIxCcCLpJqYK36ei66QnrWjZomvm
         OgIKBOVSRs84FsNEkemAwhsaHM4wwEFxREugf8ye6E3o9JPYki+olGWjfeZ/gIQ3mN7Q
         +utYvQWWFqF92f/WtGuvOutZ4Ym82EPk3XEY/Hfkr4/2BjutRBXzpfmYT6KJKhgGGfZ7
         7QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769058897; x=1769663697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDSH9T22AnGw42Msn1988FOkNE4f4GpObhLMn2Rva0M=;
        b=qmnV5/GP2pqsBJ9tS+PDvAIYApB2aWkP6h5GCfjczbkWvRHgEy8a8UY8uvkpWduNgA
         ywzLrngojLT1K1PRTuCtbu3t0zCZtYA/WdFKJZYk4N0ykVTPfBpzJx7WFQnLE2sP2yJt
         9n0U1uZXPDmjCuq9t0tGSL38+PmmQH1L2o58Y32jSfAtwwgrTzvW30BbqvZRzQl95cPm
         aaMHMJv+lUNjCdlJY38QFrs9e8PXUgbw2nc5bWzJjn23l/uJoFxjBF2eyjIq/lc9lPBz
         UWHX+O+sXMsuU9KcvC+rA6fEPsQ8mgHAv1SgD7SwBEy3XMltRg/BctFo3W99eTOOerLO
         TGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkW+5u++Gw0q0gCTXhvh0OjH4+qE3tQXsxPcj59RklJ6Df2GFsXbfhgMCh1hoOwlIHoP/EM/3Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59do2FjJhx10mSb12yRtsC8Yk4c3oMjUIPrqgMgZ5xS0qtPXz
	blbTppofJc8AmRPQwlSN7hsOxyzAx/EusUqsh2+LXQoGuNglfycOEN6pp6+rsD4ORyw=
X-Gm-Gg: AZuq6aKOX7RZVhvrZqPw1d12TTFEWqnmQkim7y+kDRpQHWoLkJG/JjMTGDAwoaYDVFb
	Spz/9VKcGnZoA8neHmUgASZpRcijE3gVmX/AUHy7dugXMwFTURlM0qANLekmaO+7QBzoh3GK3iC
	uhGSppCVBObq2njcVgQIP4ONouWlzOxyjUZ5SeCn0uzbYpLPBxMuFL3RaBJpd/eZAF/roftPBcL
	XT9G0Iv5yoMvjUuFxOzT+HPUX3DHvQ55rUflsiIyxz91hwUm5uuax/70YGQPKZcoCMLJKOK08sz
	HW8raigl/UaiodJXwjxjJU75CD6JvEi4w/BHB/CtPtOrai6lsYCLdAI2bHpKv5iYcJmlgCinBBs
	Kc9lQ6WyyHMfYdCghsSttAaofG2S1kXpGJMHX48W5XwLxV5+O21KaxYa/+82WtKwM6FeMvhlK4s
	PtqHy9NL3/Uo0=
X-Received: by 2002:a05:6a00:3926:b0:81f:b97:14a with SMTP id d2e1a72fcca58-81fa189099fmr17209182b3a.61.1769058896603;
        Wed, 21 Jan 2026 21:14:56 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdafdsm16573033b3a.15.2026.01.21.21.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 21:14:55 -0800 (PST)
Date: Thu, 22 Jan 2026 10:44:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix device_node reference leak in
 scmi_cpu_domain_id()
Message-ID: <yjiuqamotpwvojo6hhj6w4nqwkq4i3ynhzemkwughyxmtlyrnj@wdhojg2m344b>
References: <20260121-b4-scmi-cpufreq-v1-1-b0547210feac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-scmi-cpufreq-v1-1-b0547210feac@gmail.com>

On 21-01-26, 23:32, Felix Gu wrote:
> When calling of_parse_phandle_with_args(), the caller is responsible
> to call of_node_put() to release the reference of device node.
> In scmi_cpu_domain_id(), it does not release the reference.
> 
> Fixes: e336baa4193e ("cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index e0e1756180b0..c7a3b038385b 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -101,6 +101,7 @@ static int scmi_cpu_domain_id(struct device *cpu_dev)
>  			return -EINVAL;
>  	}
>  
> +	of_node_put(domain_id.np);
>  	return domain_id.args[0];
>  }

Applied. Thanks.

-- 
viresh
