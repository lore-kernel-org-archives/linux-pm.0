Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB713F823B
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016840; cv=none; b=dFnQZfBLdjY2Cu7aZhc4d3MRf53aDDQ59mOC1ENlhLt5SDBTmwJvRFRl8ob5TIEDxgOeFHNsCHkA7d6OUwVTVhrFFHZ+Hr3iw/bn5508cmjIlBoq0+g0lukyFDP5SHKnukMfDsswM55LAqIXjq398lAgN+14jvfBof4Jtrno0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016840; c=relaxed/simple;
	bh=gdCkP4sp22h60JxS0JoiANcjtVdzCVfRI611hqfC6+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV6Wud+im+KcXxh5oYn6aw0j0Q4AkOmWat/FkNG5PyVGGiLWqtzmFrrdS3ZoqYHF5uIbqVItkmXuWlwvSAi5tqDXj2XpeRGc6D0Y3tJrvH5oPErhcbB1fCef2N9hqS60ZKNuSFkQYkNqftP+Bx+k+pLdJNxSejFNkpa+0vsHOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vp839PYW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vp839PYW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cca0c5799eso8147665ad.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784016837; x=1784621637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qYzRXurSIHTikl55g1qeyMI97vm5PuCtoDlT6FhIA0g=;
        b=Vp839PYWRQwcGDs6Tz0DQ5PmZ/MZHRYlDmaojUL+HLW063mijLh9tXT0UKp7LsBegV
         ZJJTvqCShDiIO3RCHowkG4RWYRgganjNzp2muIAr98l909m6YuGTxnXrDUfsvCLZ2tJ7
         O05bcIoJueD+ppMGi0d1uppyjcwmAsk1IpJRRx1EpiceWSHGoWhknBDhntabyDQSQBi6
         0vE7VTchFo2MbO2Ji01K2JxwixWQ9EOaWgYh5SgcWABCtCbruYZ8h/x0AVihKaZxRA3R
         QKz77MJOZF/H9B1APgZO2cCLfkduFOx6ZTTdZ/Qu+U8yIGKz8ZnTr+IfkgxMwkB+blee
         uaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016837; x=1784621637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYzRXurSIHTikl55g1qeyMI97vm5PuCtoDlT6FhIA0g=;
        b=qdHjeOU2cUBOYnsRsELfJO/ARGOFVUL4XZ7XGC0AEhSLXlXQhVafoyr+YeIHJUYMzV
         7AXaRk93UsgAubY0WoJpWQJD8GwBC79HA4n9DoxO4fDOY3y8dMpGGFbiUeKExg3Wm4AN
         Xaz8ZX5JTb7PpckCP2JMTga86eJDa9c6p2OoIFqCNrfoNbxHnXv761gTchOUIw+gZR+3
         gP+PVynCxySbd/bbFJDdmt5+Hz4RdB8n+54ugA6upBeYSaWCxKTq/xZLEaHU0H/TCkSO
         ybr98j+tsx3PdzhBEQuAJDnmE9ia60It1ywrVTKRN5hBvdoeVK/r/YmtW4clY8D39AIr
         KVLA==
X-Forwarded-Encrypted: i=1; AHgh+RqxCm7jWkxhcq7RibsGZkHat/mhotSk+f0xijJVNbs5Ne/pvJBc/jSLXZ7FyYzmHPKJRkyO799/pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmR/AG0wuBVek2H+8hXdYNMSyRDVWmMeFYYdXvebPI6zGklBnr
	qOoWvfoCEDUO7cSAo9BLMYCcK5vyKT4fn/H4pntxvHfNRbfhJF9qCAIQ8oZTDwInJKM=
X-Gm-Gg: AfdE7ckUf6C8jM8l/MuFdqhfa/pIAazWR2wZ+dmZiqDo9YF2/7+ceRdg/hmbwm0mRSD
	R/7GYThKYhkO/upzRrJLedwL4yBG+lGHAzVwRYif7m4qtOUq/Dijk19PDj4Gnht2q+ciEou+zdh
	euDlNLWrWw7b/Xrfe4FYF9jdlNEnAm4QpIw8LYDs2h4aEqfQvxWeKLXY6ruv9cmALqwDI57IqZx
	k1WGyNAt81p6dGj8+tnCPpsUQUIQTtKhDYZqXfYpglwsYOiZL+EYXwjYSaA2g+u2wcOH2H70iTc
	BVsDbQsldbmgGXQr39mp/fe5zOCwR55xZ09mPAzVuth4XqQBtU5ID/VTxhBmOqppS1Jv3H3Hqfc
	cBGMcdp1PnX5CvoWr5E3UjsdXTat9Kc0QgSmJtLVaFVlcW0z0HMqpuAOqgh1gd3/UTkPEhvpEzM
	jzDWxyD1S7kYXf
X-Received: by 2002:a05:6a21:502:b0:3c0:9c1a:894c with SMTP id adf61e73a8af0-3c110b2f98bmr13998768637.68.1784016837292;
        Tue, 14 Jul 2026 01:13:57 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm135899247c88.14.2026.07.14.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:13:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:43:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianheng Peng <pengqh1@chinatelecom.cn>
Cc: ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, rafael@kernel.org, skhan@linuxfoundation.org, li.meng@amd.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxb12@chinatelecom.cn, 
	xiongl24@chinatelecom.cn, zhangar@chinatelecom.cn
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
Message-ID: <7fxgevkwbauh26jxm27x6yd3dcmi66znyqh4yud7vhm6cdwe4u@rskv6hd64pcp>
References: <1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn>

On 14-07-26, 15:59, Qianheng Peng wrote:
> The crash issue may occur when insmod amd_pstate_ut modules.
> 
>    amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>    amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>    BUG: kernel NULL pointer dereference, address: 0000000000000080
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] SMP NOPTI
>    CPU: 0 PID: 20300 Comm: modprobe
>    Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>    Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>    RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>    Call Trace:
>     <TASK>
>     amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>     ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>     do_one_initcall+0x42/0x2e0
>     ? kmalloc_trace+0x26/0x90
>     do_init_module+0x60/0x240
>     __se_sys_init_module+0x185/0x1c0
>     do_syscall_64+0x62/0x190
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     </TASK>
> 
> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
> 
> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 735b29f..3b24260 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>  		if (!policy)
>  			continue;
>  		cpudata = policy->driver_data;
> +		if (!cpudata) {
> +			pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);

You can use kobject_name(), but I wonder why print kobj name here ? Other
drivers just print policy->cpu normally and that is sufficient.

-- 
viresh
