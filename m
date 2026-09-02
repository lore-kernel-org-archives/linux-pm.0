Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3820D4F0
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323233; cv=none; b=lG3FRKWi2LyuEWlAIsLC5rxhgsEx/cBWb2cEcTPqKTaT09Fd+aPVhobJb6BixeGD4qVt2TcU3IocDrSpqJ8uB4K34xR3kUa6JZofA2+1bjSj5ROI3l0lyDcnTvED+Pw3iHH8waXcXrRVGcLsEWxaflS+gawtlUfywDsDyu63zCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323233; c=relaxed/simple;
	bh=/oGcSd7Y7Nz5jNpRmR1Y/39Pm+VKD2rEKV0PfmrNMks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTmcNRdxFSgvQlaS3x+/LU8lMwzGgw3eOSfmaztvFykFjGvKwFLSZbhC34hpDoRp4yvgBzOZuCYIjbaN0HYu/4rfS5VmwF9JFbpOp4nScaskJCFAElSJp9zg0QZ2nriQigRpk8TXlplp0nC24FkXMBIMLxDupbVeHdfawrDKsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAhE/kYB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAhE/kYB"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso484100a91.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788323231; x=1788928031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCb5pthu2o4M37AlowY4EfuVdlPIuSHyLISBEANaF0U=;
        b=CAhE/kYBK31sM1tkPP9E6WKzniQq8gSGYH+WNsYOgYiEwKMM+GIcI5kr4YEQZj9s/V
         fDEZRX4HdHFdkoxNio7nm2iaC+gfjKc4cnn6pOyGmrPrTT7nTN5GLE+NO/M17qFabQYo
         vNs4x4NhJHhrzodI9u8k31Qz7b8hjZ3P0MPGQqCpcA9+lCTRZBGFxS8i6RBQ2+ENvjmI
         lnYTB6JILkcxKGB47A6bRXCZPtpqgkm46UY8f8aZJgbDf/aT4fCtc4mqMoGBTDxWpfhJ
         UQK0f7urm3+LECBQqDWssdFWmoyggSZ63K0UeR8o/uPr/lx0TYpSuFGri0e08wSrW4ZE
         CX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323231; x=1788928031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCb5pthu2o4M37AlowY4EfuVdlPIuSHyLISBEANaF0U=;
        b=QeivFGo+bD5kiIrTIPqns5KhhSVCde9x97hXM4IzREjE9i6FiqZVu2waB+8OwQ9OvW
         AybaKrwgNsHFyTqT4SVdcpqpqN+Qi5UMvzDpC8wo7Iu5job5DYv8ZfCdlJJsWkqFaLgL
         k1eIfQnylyt8oNZ6xjiukS4kMkjDSfohP0plyk+2w/j2BFW1aBkkxJAvmx6DER3/4f/B
         6GqHMjbGGp2S9r9zyZ6AI+0sGrIlzd6zp0f+4jLpdBtbasjkY/bKcwwLS1kiYvhBVxhd
         AQpm3kU2o/giqAPMDWpcmUfGFTWVKtVHw5z347eAGJWK1xxM/otJpXc15SqwfMK3Mx4q
         pQyw==
X-Forwarded-Encrypted: i=1; AKwUvBxeTn/NVZdfIGfqOn+kSbUs+wVD0Gqt4+NgI/tFfoun7SMXfW4D1cgGBh3E3NbAOuW6X+bO6TB/kw==@vger.kernel.org
X-Gm-Message-State: AFuF++k4a6XVIZpUPfRta2+FdVFQTpHb9In+xXRangH4PXfC1POzh3mq
	zRnx8yn+xkumVQ5j7U4quNMaavB2n4u26oM2BxCUOYcV+Rb9a2ZilTO6d/MRhf3CZ48=
X-Gm-Gg: AYBFou0hPFXFS/8/WVZp1kWCTQdSs0pT7II4uGTfcXAfn8dK6O1jl3tGC9QESwTFp24
	RIDWAW9DdNWobjQa0tjTH+ABGBC3r1H22wJPjUqweWQacMcoUgscGhTLZXfE8vUjuZnVE6C80ws
	SjwWvEQkHHOqC0EZV0BWs4qEMK0e0xSvD2vNLCgyud7J/8K1EgiFqmxCxKjlDSRRqs7Z9YWP5rz
	ut412zTHFRgomrdoz7Ur7FTLFkXHNVgWeHgltvIE4BgmAIzl36pE9GM87HyZvwfXC05sAsiMv95
	h0h0Kv4wgRqkkjdPakkjx+P1d8lcxqOEMkPLfHiP77nAF+EYSroE20pp4HaaPE1Y8lNqi/wg0Az
	LgMz2yTbn1sSv0YCsj0yair/THIvlRClXa1Bj4GDJTyOaxQAaoq3DpcTdPLtmCtglLasOSBkC+d
	UR+Da56b424ilwT7uLpszh5Q0esLRW+7UxFeyOEmE7ss0KH0D5iJwASkk+tO0LVhI=
X-Received: by 2002:a17:90b:1d4c:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39aedf0956bmr2969675a91.6.1788323230970;
        Tue, 01 Sep 2026 21:27:10 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3578295eec.22.2026.09.01.21.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:27:09 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:57:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3] cpufreq: initialize policy rwsem before sysfs
 publication
Message-ID: <apelmtFEMcyXle8m@vireshk-B250M-D3H>
References: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
 <20260902041915.3453421-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902041915.3453421-1-runyu.xiao@seu.edu.cn>

On 02-09-26, 12:19, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@seu.edu.cn/
> Assisted-by: Codex:GPT-5
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
