Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8723C0626
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146440; cv=none; b=liYAkURmupXeNB4S/B9pgN5LXATBSAiR/AbCOUwprbsFL056DfcYtiPdeuUt43KcKOd0aenXJFirKtgdsdDFJ57LsgnnDQ1eECjsr01gfub5FIVpTKne3C40EKAz+mj+AV5+3lmm0IkCUFreWK/EKAmCOEeL06z9KnnnL2P2bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146440; c=relaxed/simple;
	bh=qh1b1DntBR8vgEb7sobQipJumFORx6XpN+BZ59aDNw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3ghQqD4HCkGCgwnhfnKhC+ufjiBe1ztU9lefz/7SKKeOJtrroJL4BB4WCelUFadnjPPwLx7fwi6oglRlCDu5SYDYF1nYZpVTNA3+qviArJXdiDSCMjy4NDRHKYdZXotEcbACW+1UinszUIGg3o6FPjuxe9c3ZvbZi9mjJaiF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yt1l4vXF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yt1l4vXF"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-837dfccd950so256835b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778146438; x=1778751238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TUH4heo7UGgXRDVu3I9tnDQBaSI+KpzraloipB313A=;
        b=yt1l4vXFu7aHllrvSGdI76L57RL92z2y4NqS4VlcFy4spni4GNiyV0EV0tQlgTLlPb
         uGoA2zG9FFh7AVcnh31Vte4nLf3LewVHLWBNvN6+ompypOKhx8667QwDAF2hyVDAGHjj
         KD3jJL/Pl4tTxqZXUqn1DBjIH2cFd8NcE8APLYOzYNZlT9bKyJx/hr+Bii5mo8vz56dQ
         opF95IWTshsWJ5xr6OTY+H6Vx7GYTzUCaE+CqXstKqLSK6zCTj0nQOZhTHYUTS+jH2LW
         tt94dhkQfsb8HWy5m7qggSeXXb/u5j3e/bwgEe41uV8d8BS2lG6nTz9srX/s8Vhb65LR
         3ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146438; x=1778751238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TUH4heo7UGgXRDVu3I9tnDQBaSI+KpzraloipB313A=;
        b=oYr99DJjoPQaPdjtNOl1FgUgkPm4Rrx4k7uG8NAW4GAjiEULlUFC7bxFnb1Cmi71am
         bVDGUz9PYrKoTe44mm8rWPf1bgAk/qI8RxsDtqbmHXv+NiDsbZbV7SNiotwZ5Jau7qDC
         oscZkucbIVrbo2py22Alc4orfPpHJAKDTWo6qD5cVjs8vBRhscYY8z0Q9Eb0N9lpNuDC
         uFpsbMy2r2ZUFIwkYlz/eok2bP5LMK6YD6/nF3cou1lxb48xiZ3R1IMNHqh/I3q90Y6d
         FxzObHYoczb3eCvzpv+sj1dNyOMmYykePmkobPlVhRPD+7cu+lJWjd9Xhq0Y3rEkiE6N
         DEHg==
X-Forwarded-Encrypted: i=1; AFNElJ/x2VdJ0WphWl9Gmaadw+qGSYCLby/0neoZlSXgDVc6VsiOf/ojXvztjSDQ+RCfaknwuft5/i4/gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxatCnUNCpoUArxk3cmYGlsWrmBYtf2i0f58lKR6XsK2jmkiRqE
	k4fMFRWZfNsTcd57EcS/mq0HQ4FTwwq7cP4C2to9kp6ELPo6vttsjsH5qpJgkzt7jcQ=
X-Gm-Gg: AeBDievt7Wmw3KSXUJigwITQSe65TCyHQV5OvRUkXCjrNTZQzXTXS7CvcfJ396WMa3J
	0ETKFgcJlhbZoyC1vphbwCcdCtK5sonBIpuiTNfK/YRxBVwAkdcWP33hw3ZP5jvcU5oznDzWk+Y
	w777CTCPe8gTMHHqWr5fuadrVIYNag2lU65etbye3kHN+kXDGoi6qWJqkUOf/zvopiWOYmD0qZY
	7eYh/D60lZ2f1QmPN7CruHcrWXTikOhVrhVIUbPh1QZMlGBoR8dXoSVA8OC5MlMkZd9pSTrDlGZ
	7VY08WnCsqbRaa49arCleL3Je3s4JJJY9qHtJNvO5msDg2K694uQA4OOMSywUZhqQHclb2blwzS
	G4xS9tdvsTl2q4BHRj2SXojq2EKjeKOSnrKkvAK/X1K3ngxz3SXkFZVw7xQCsefU7cM0kIYZLzQ
	Q388K+0eAISIDUUIG8KB+SEz1Q+8WP13lf4QedBYe3xz1r
X-Received: by 2002:a05:6a00:12e4:b0:82c:f035:6748 with SMTP id d2e1a72fcca58-83a5dd560e6mr6924714b3a.42.1778146437930;
        Thu, 07 May 2026 02:33:57 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm10477878b3a.46.2026.05.07.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:33:57 -0700 (PDT)
Date: Thu, 7 May 2026 15:03:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org, 
	stratosk@semaphore.gr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>

On 23-04-26, 15:12, zhenglifeng (A) wrote:
> Yes, I think you are right. The behaviors are not the same. I modified this
> just in order to keep it consistent with the case exceeding down_threshold.
> I'm not sure if this change of behavior is reasonable. Perhaps Rafael or
> Viresh could give us some advice.

> >> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> >> @@ -104,7 +104,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> >>           dbs_info->down_skip = 0;
> >>             /* if we are already at full speed then break out early */
> >> -        if (requested_freq == policy->max)
> >> +        if (dbs_info->requested_freq == policy->max)
> >>               goto out;

> >> -        if (requested_freq == policy->min)
> >> +        if (dbs_info->requested_freq == policy->min)

What about dropping these `if` blocks completely ? i.e. always call
__cpufreq_driver_target().

__cpufreq_driver_target() already have similar checks in place to optimize
unnecessary freq changes. We don't really need callers to do the same.

-- 
viresh
